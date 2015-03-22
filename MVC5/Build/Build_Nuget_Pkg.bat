rmdir Nuget\Package /q /s
rmdir Nuget\content /q /s

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

Copy "..\MVC5\App_Start\*.*" Nuget\content\App_Start\*.*
Copy "..\MVC5\Content\Site.css" Nuget\content\Content\Site.css
Copy "..\MVC5\Controllers\*.*" Nuget\content\Controllers\*.*
Copy "..\MVC5\Models\*.*" Nuget\content\Models\*.*
Copy "..\MVC5\Views\*.*" Nuget\content\Views\*.*
Copy "..\MVC5\Views\Admin\*.*" Nuget\content\Views\Admin\*.*
Copy "..\MVC5\Views\Account\*.*" Nuget\content\Views\Account\*.*
Copy "..\MVC5\Views\Home\*.*" Nuget\content\Views\Home\*.*
Copy "..\MVC5\Views\Manage\*.*" Nuget\content\Views\Manage\*.*
Copy "..\MVC5\Views\Shared\*.*" Nuget\content\Views\Shared\*.*

nuget pack  Nuget\Simple.Data.AspNet.Identity.MVC5.Sample.nuspec -OutputDirectory Nuget\Package