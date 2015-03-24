# Simple.Date Asp.Net Identity Provider MVC 5 sample

This is similar to the standard MVC solution that is created via File -> New Project -> Web -> MVC

There are two differences, the first is using Simple.Data instead of EF the second is that it uses
Roles in the solution to secure an Admin area

## Source
If you clone this repo you will need to create the database yourself by running the IdentityDb.sql file
(which can be found under Build\Nuget\tools) against your localdb

If you don't have automatic package restore active then you will need to ensure that you update the
projects Nuget packages to ensure all the necessary dependencies are installed.

## Nuget
The easiest way to get this sample is to create an empty Web Project and then install the following Nuget pkg:

Install-Package Simple.Data.AspNet.Identity.MVC5.Sample

Doing this will create the database as well as installing all the necessary dependencies

The database comes pre-populated with 2 user - an admin and a user:

 * Admin user - login as admin@test.com with password Testing1?
 * User - login as bob@test.com with password Testing1?

###Licence
This software is licensed under the MIT license which basically means you can do what you want
with the software (read the license.txt for full details).