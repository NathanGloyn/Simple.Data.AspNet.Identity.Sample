# Simple.Date Asp.Net Identity Provider MVC 5 Standard sample

This is the equivalent of the basic MVC5 sln that is created from the File -> New Project dialog
in Visual Studio.

The only difference is that instead of using EF for database access it uses Simple.Data

## Source
If you clone this repo you will need to create the database yourself by running the IdentityDb.sql file
(which can be found under Build\Nuget\tools) against your localdb

If you don't have automatic package restore active then you will need to ensure that you update the
projects Nuget packages to ensure all the necessary dependencies are installed.

## Nuget
The easiest way to get this sample is via Nuget with the following command:

Install-Package Simple.Data.AspNet.Identity.MVC5.Standard.Sample

Doing this will create the database for you as well as installing all the necessary dependencies

###Licence
This software is licensed under the MIT license which basically means you can do what you want
with the software (read the license.txt for full details).