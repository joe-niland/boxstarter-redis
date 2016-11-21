# boxstarter-redis
A BoxStarter package to install and configure Redis caching service.

# Current Limitations

* Redis service binds to 127.0.0.1 only

Building
-------------------

If you change anything in tools\ChocolateyInstall.ps1 or Provision-Redis.nuspec you will need to build a new BoxStarter package.

Open a PowerShell console and run the following command from the directory containing Provision-Redis.nuspec:

```
Import-Moodule Boxstarter.Chocolatey
Invoke-BoxStarterBuild -name Provision-Redis
```

This will build the package and save it in your LocalRepo directory as per your BoxStarter configuration:

```
(Get-BoxStarterConfig).LocalRepo
```

You will need BoxStarter installed, which can be done with [Chocolatey](https://chocolatey.org/install):

```
cinst Boxstarter -y
```

If you are using Sublime Text, I've created a [Sublime Build System for BoxStarter](https://github.com/joe-niland/boxstarter-sublime-build) which automates the above.

Usage
-------------------

Once you have a package built you can run it remotely with the following command (from PowerShell console):

```
# Get your domain or machine credentials
$cred = Get-Credential domain\username
# Inlcude Boxstarter modules for remote deployment
Import-Module Boxstarter.Chocolatey
# Remove -DisableReboots if you want any pending reboots to be executed
Install-BoxstarterPackage -ComputerName ServerName -PackageName Provision-Redis -Credential $cred -DisableReboots
```