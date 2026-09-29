# Étape 4 — Base de données DB_ETUDIANTS (EMS)
New-Item -Path "E:\ExchangeDB\DB_ETUDIANTS" -ItemType Directory

New-MailboxDatabase -Name "DB_ETUDIANTS" -Server EXCHANGE01 `
  -EdbFilePath "E:\ExchangeDB\DB_ETUDIANTS\DB_ETUDIANTS.edb" `
  -LogFolderPath "E:\ExchangeDB\DB_ETUDIANTS\Logs"

Restart-Service MSExchangeIS
Mount-Database "DB_ETUDIANTS"

# Quotas et rétention de 12 jours
Set-MailboxDatabase "DB_ETUDIANTS" -IssueWarningQuota 1.3GB -ProhibitSendQuota 1.5GB `
  -ProhibitSendReceiveQuota 1.7GB -DeletedItemRetention 12.00:00:00

Get-MailboxDatabase "DB_ETUDIANTS" -Status | Format-List Name, Server, Mounted, EdbFilePath, `
  LogFolderPath, IssueWarningQuota, ProhibitSendQuota, ProhibitSendReceiveQuota, DeletedItemRetention
