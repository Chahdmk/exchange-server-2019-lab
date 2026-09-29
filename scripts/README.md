# Scripts

Commandes PowerShell du laboratoire, regroupées par étape. Elles sont documentées dans le [rapport](../RAPPORT.md) ; ce ne sont pas des scripts à lancer d'un bloc (redémarrages et installations manuelles entre les étapes).

| Fichier | Étape | Où |
|---|---|---|
| `01-prerequis.ps1` | Rôles Windows, .NET, services | EXCHANGE01 |
| `02-preparation-ad.ps1` | PrepareSchema / PrepareAD | EXCHANGE01 + DC01 |
| `03-installation.ps1` | Setup Exchange, domaine accepté, logs | EXCHANGE01 |
| `04-base-de-donnees.ps1` | DB_ETUDIANTS, quotas, rétention | EMS |
| `05-destinataires.ps1` | Boîtes, groupe, salle de réunion | EMS |
| `06-surveillance.ps1` | Suivi des messages, services, disque, files | EMS |
