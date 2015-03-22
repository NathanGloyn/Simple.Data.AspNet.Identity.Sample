param($installPath, $toolsPath, $package, $project)

# Script for dropping existing db - http://bi-bigdata.com/2013/03/05/powershell-for-droping-database/

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

