# Étape 1 — Prérequis (sur EXCHANGE01)
# Exécuter dans PowerShell en administrateur, puis redémarrer.

Install-WindowsFeature RPC-over-HTTP-proxy, RSAT-Clustering, RSAT-Clustering-CmdInterface, `
  RSAT-Clustering-Mgmt, RSAT-Clustering-PowerShell, Web-Mgmt-Console, WAS-Process-Model, `
  Web-Asp-Net45, Web-Basic-Auth, Web-Client-Auth, Web-Digest-Auth, Web-Dir-Browsing, `
  Web-Dyn-Compression, Web-Http-Errors, Web-Http-Logging, Web-Http-Redirect, Web-Http-Tracing, `
  Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Lgcy-Mgmt-Console, Web-Metabase, Web-Mgmt-Service, `
  Web-Net-Ext45, Web-Request-Monitor, Web-Server, Web-Stat-Compression, Web-Static-Content, `
  Web-Windows-Auth, Web-WMI, Windows-Identity-Foundation, NET-WCF-HTTP-Activation45

Add-WindowsFeature RSAT-ADDS-tools

# Installer ensuite (manuellement) : .NET 4.8 (ndp48-web), Visual C++ 2013 (vcredist_x64),
# UCMA 4.0 (UcmaRuntimeSetup), IIS URL Rewrite (rewrite_amd64_en-US). Redémarrer.

# Vérifier .NET : 528040 ou plus = .NET 4.8
(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full").Release

# Vérifier les services requis
Get-Service W3SVC, WAS, WinRM | Select-Object Name, Status, StartType
