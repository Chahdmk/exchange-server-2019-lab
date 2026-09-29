# Étapes 5 à 7 — Boîtes aux lettres, groupe de distribution, salle de réunion (EMS)
# Mot de passe de LABORATOIRE uniquement. Guillemets simples obligatoires (sinon $$ est interprété).
$pwd = ConvertTo-SecureString -String 'Pa$$w0rd123' -AsPlainText -Force

New-Mailbox -UserPrincipalName etudiant1@entrepriseCM.local -Alias etudiant1 -Database "DB_ETUDIANTS" `
  -Name "Etudiant1" -FirstName "Jean" -LastName "Dupont" -Password $pwd
New-Mailbox -UserPrincipalName etudiant2@entrepriseCM.local -Alias etudiant2 -Database "DB_ETUDIANTS" `
  -Name "Etudiant2" -FirstName "Marie" -LastName "Tremblay" -Password $pwd
New-Mailbox -UserPrincipalName professeur@entrepriseCM.local -Alias professeur -Database "DB_ETUDIANTS" `
  -Name "Professeur" -FirstName "Paul" -LastName "Gagnon" -Password $pwd
Get-Mailbox

# Groupe de distribution en adhésion ouverte
New-DistributionGroup -Name "Etudiants_Promotion2024" -Alias "Etudiants2024" `
  -MemberJoinRestriction Open -ManagedBy "professeur"
Add-DistributionGroupMember -Identity "Etudiants_Promotion2024" -Member "etudiant1"
Add-DistributionGroupMember -Identity "Etudiants_Promotion2024" -Member "etudiant2"
Get-DistributionGroup "Etudiants_Promotion2024" | Format-List Name, PrimarySmtpAddress, MemberJoinRestriction, ManagedBy
Get-DistributionGroupMember "Etudiants_Promotion2024"

# Salle de réunion : 8 h – 18 h, lundi au vendredi, acceptation automatique
New-Mailbox -Room -Name "Salle_Formation_CM" -Alias "salle_formation_cm"
Set-MailboxCalendarConfiguration -Identity "Salle_Formation_CM" -WorkDays Weekdays `
  -WorkingHoursStartTime 08:00:00 -WorkingHoursEndTime 18:00:00 -WorkingHoursTimeZone "Eastern Standard Time"
Set-CalendarProcessing -Identity "Salle_Formation_CM" -AutomateProcessing AutoAccept -ScheduleOnlyDuringWorkHours $true

Get-MailboxCalendarConfiguration "Salle_Formation_CM" | Format-List WorkDays, WorkingHoursStartTime, WorkingHoursEndTime, WorkingHoursTimeZone
Get-CalendarProcessing "Salle_Formation_CM" | Format-List AutomateProcessing, ScheduleOnlyDuringWorkHours, AllowConflicts
