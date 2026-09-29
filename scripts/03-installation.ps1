# Étape 3 — Installation d'Exchange (rôle Mailbox), puis redémarrer
Set-Location E:\
.\Setup.exe /Mode:Install /Roles:Mailbox /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF

# --- Dans l'Exchange Management Shell ---
Get-ExchangeServer
Get-AcceptedDomain
Get-EmailAddressPolicy | Format-List Name, EnabledPrimarySMTPAddressTemplate

# Journaux d'installation
Get-Content C:\ExchangeSetupLogs\ExchangeSetup.log -Tail 30
Select-String -Path C:\ExchangeSetupLogs\ExchangeSetup.log -Pattern "\[ERROR\]"
