# Étapes 9 et 10 — Suivi des messages et surveillance (EMS)
Get-MessageTrackingLog -Sender etudiant2@entrepriseCM.local

Get-Service | Where-Object {$_.Name -like "*MSExchange*"}
Test-ServiceHealth

Get-MailboxDatabase -Status | Select-Object Name, DatabaseSize, AvailableNewMailboxSpace
Get-Volume

Get-Queue
