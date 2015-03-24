:: Remove folders to ensure clean slate
rmdir Nuget\Package /q /s
rmdir Nuget\content /q /s

:: Create the directories needed
mkdir Nuget\Package
mkdir Nuget\content\App_Start
mkdir Nuget\content\Content
mkdir Nuget\content\Controllers
mkdir Nuget\content\Models
mkdir Nuget\content\Views
mkdir Nuget\content\Views\Admin
mkdir Nuget\content\Views\Account
mkdir Nuget\content\Views\Home
mkdir Nuget\content\Views\Manage
mkdir Nuget\content\Views\Shared

:: Copy files 
Copy "..\MVC5 Standard\Startup.cs" Nuget\content\Startup.cs.pp
Copy "..\MVC5 Standard\Global.asax" Nuget\content\Global.asax.pp
Copy "..\MVC5 Standard\Global.asax.cs" Nuget\content\Global.asax.cs.pp
Copy "..\MVC5 Standard\favicon.ico" Nuget\content\favicon.ico
Copy "..\MVC5 Standard\App_Start\*.*" Nuget\content\App_Start\*.*.pp
Copy "..\MVC5\Content\Site.css" Nuget\content\Content\Site.css
Copy "..\MVC5\Controllers\*.*" Nuget\content\Controllers\*.*.pp
Copy "..\MVC5\Models\*.*" Nuget\content\Models\*.*.pp
Copy "..\MVC5\Views\*.*" Nuget\content\Views\*.*
Copy "..\MVC5\Views\Admin\*.*" Nuget\content\Views\Admin\*.*.pp
Copy "..\MVC5\Views\Account\*.*" Nuget\content\Views\Account\*.*.pp
Copy "..\MVC5\Views\Home\*.*" Nuget\content\Views\Home\*.*.pp
Copy "..\MVC5\Views\Manage\*.*" Nuget\content\Views\Manage\*.*.pp
Copy "..\MVC5\Views\Shared\*.*" Nuget\content\Views\Shared\*.*.pp

Copy Nuget\*.xdt Nuget\content\*.xdt

:: Need to rename the views web.config so it gets transformed
ren Nuget\content\Views\web.config web.config.pp

:: Run script to go through files and replace the namespace with $rootnamespace$ so
:: it will be transformed when installed
Powershell.exe -executionpolicy Bypass -File .\RenameNamespace.ps1 -w MVC5

:: Call nuget to create the package
nuget pack  Nuget\Simple.Data.AspNet.Identity.MVC5.Sample.nuspec -OutputDirectory Nuget\Package