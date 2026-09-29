# Étape 2 — Préparation d'Active Directory
# Sur EXCHANGE01 (joint au domaine), connecté avec un compte du DOMAINE, ISO monté sur E:

Set-Location E:\
.\Setup.exe /PrepareSchema /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF
.\Setup.exe /PrepareAD /OrganizationName:"ENTREPRISECM" /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF

# Vérification sur DC01 : rangeUpper = 17003 pour Exchange 2019 CU14
Get-ADObject "CN=ms-Exch-Schema-Version-Pt,CN=Schema,CN=Configuration,DC=entrepriseCM,DC=local" -Properties rangeUpper
