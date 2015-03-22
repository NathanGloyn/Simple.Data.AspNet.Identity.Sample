param($installPath, $toolsPath, $package, $project)

# Script is combination of 3 separate snippets
# For creating db - http://bi-bigdata.com/2013/02/19/powershell-for-creating-a-database/
# For dropping existing db - http://bi-bigdata.com/2013/03/05/powershell-for-droping-database/
# For passing parameter to Sql Script http://thefirstsql.com/2010/06/09/using-sqlcmd-from-powershell/

#Import SQL Server Module called SQLPS
Import-Module SQLPS -DisableNameChecking
 
#SQL Server Instance Name
$Instance = "(localdb)\v11.0"
$Server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $Instance

$database = $project.Name + "_Test_Identity" 

#create SMO handle to your database
$DBObject = $Server.Databases[$database]
 
#check database exists on server
if ($DBObject)
{
	#instead of drop we will use KillDatabase
	#KillDatabase drops all active connections before dropping the database.
	$Server.KillDatabase($database)
}

$db = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database($Server, $database)
$db.Create()

$DBParam = "DBName=" + $database 
$scriptPath = Join-Path $toolsPath "IdentityDb.sql"
# Run the script to create the tables
invoke-sqlcmd -ServerInstance "(localdb)\v11.0" -inputFile  $scriptPath -Variable $DBParam
