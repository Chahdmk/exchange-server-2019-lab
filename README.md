# Exchange Server 2019 — Installation et configuration

![Windows Server 2019](https://img.shields.io/badge/Windows%20Server-2019-0078D6?logo=windows&logoColor=white)
![Exchange 2019 CU14](https://img.shields.io/badge/Exchange%20Server-2019%20CU14-0078D4?logo=microsoftexchange&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-EMS-5391FE?logo=powershell&logoColor=white)
![Active Directory](https://img.shields.io/badge/Active%20Directory-AD%20DS%20%2B%20DNS-555)

Laboratoire réalisé dans le cadre de mon programme en réseautique et cybersécurité : déploiement complet d'un serveur de messagerie **Exchange Server 2019** dans un domaine Active Directory, de la préparation des prérequis jusqu'à la surveillance des services. Presque tout est fait en **PowerShell (Exchange Management Shell)**, avec vérification dans le centre d'administration (EAC), OWA et Outlook.

📄 **Rapport complet avec captures : [RAPPORT.md](RAPPORT.md)**
💻 **Commandes utilisées : [scripts/](scripts/)**

---

## Architecture

```
                 Domaine : entrepriseCM.local  (192.168.10.0/24)
 ┌──────────────────────┐   ┌──────────────────────┐   ┌──────────────────────┐
 │ DC01                 │   │ EXCHANGE01           │   │ CLIENT01             │
 │ 192.168.10.10        │   │ 192.168.10.20        │   │ 192.168.10.30        │
 │ Windows Server 2019  │◄──│ Windows Server 2019  │◄──│ Windows 11 + Outlook │
 │ AD DS + DNS          │   │ Exchange 2019 CU14   │   │ joint au domaine     │
 │                      │   │ rôle Mailbox         │   │                      │
 └──────────────────────┘   └──────────────────────┘   └──────────────────────┘
```

| Machine | IP | Rôle |
|---|---|---|
| DC01 | 192.168.10.10 | Contrôleur de domaine, AD DS + DNS |
| EXCHANGE01 | 192.168.10.20 | Exchange Server 2019 CU14, rôle Mailbox |
| CLIENT01 | 192.168.10.30 | Poste client Windows 11 avec Outlook |

## Ce que j'ai fait

| # | Étape | Points clés |
|---|---|---|
| 1 | [Prérequis](RAPPORT.md#1-prérequis) | Rôles IIS/RSAT, .NET 4.8, Visual C++ 2013, UCMA 4.0, URL Rewrite |
| 2 | [Préparation d'AD](RAPPORT.md#2-préparation-de-lactive-directory) | `/PrepareSchema`, `/PrepareAD`, vérification de `rangeUpper` (17003) |
| 3 | [Installation](RAPPORT.md#3-installation-dexchange) | Setup en ligne de commande, domaine accepté, lecture des logs |
| 4 | [Base de données](RAPPORT.md#4-configuration-des-bases-de-données) | `DB_ETUDIANTS` sur disque dédié, quotas 1,3 / 1,5 / 1,7 Go, rétention 12 jours |
| 5 | [Boîtes aux lettres](RAPPORT.md#5-création-des-boîtes-aux-lettres) | 3 utilisateurs créés en PowerShell |
| 6 | [Groupe de distribution](RAPPORT.md#6-groupe-de-distribution) | Groupe en adhésion ouverte, test d'envoi via OWA |
| 7 | [Salle de réunion](RAPPORT.md#7-salle-de-réunion) | Heures 8 h–18 h lun–ven, AutoAccept, test de refus un samedi |
| 8 | [Outlook](RAPPORT.md#8-configuration-doutlook) | Autodiscover, dépannage du certificat auto-signé |
| 9 | [OWA](RAPPORT.md#9-accès-web-owa) | Envoi avec pièce jointe, `Get-MessageTrackingLog` |
| 10 | [Surveillance](RAPPORT.md#10-surveillance-des-services) | `Test-ServiceHealth`, taille des bases, `Get-Volume`, `Get-Queue` |

## Problèmes rencontrés et solutions

| Problème | Cause | Solution |
|---|---|---|
| Setup refuse `/IAcceptExchangeServerLicenseTerms` | Depuis la CU11, le paramètre doit préciser le choix de diagnostic | `/IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF` |
| « The supplied credential is invalid » dans les logs | Session ouverte avec l'administrateur **local** au lieu du compte du domaine | Reconnexion avec un compte domaine |
| Lettre `E:` occupée par l'ISO | Le chemin `E:\ExchangeDB` était imposé | Ajout d'un disque virtuel de 40 Go en `E:` |
| Avertissement après `New-MailboxDatabase` | Le service Information Store doit prendre en compte la nouvelle base | `Restart-Service MSExchangeIS` puis `Mount-Database` |
| Courriel bloqué dans les brouillons d'OWA | Deux cartes réseau : le serveur résolvait mal son propre nom | Désactivation de la carte Internet |
| Outlook n'arrive pas à configurer le compte | Certificat auto-signé d'Exchange non approuvé par le client | Export du certificat et import dans les autorités racines de confiance de CLIENT01 |
| La salle accepterait jusqu'à 17 h seulement | `-ScheduleOnlyDuringWorkHours` ne définit pas les heures | `Set-MailboxCalendarConfiguration` pour fixer 8 h–18 h |

## Compétences démontrées

- Déploiement d'Exchange Server 2019 on-premise et de ses dépendances
- Extension du schéma et préparation d'une forêt Active Directory
- Administration en PowerShell (Exchange Management Shell) et via l'EAC
- Gestion des bases de données, quotas et rétention
- Destinataires : utilisateurs, groupes de distribution, boîtes de ressources
- Clients de messagerie : Autodiscover, Outlook, OWA, certificats
- Dépannage (logs de setup, suivi des messages, services, files d'attente)

## Structure du dépôt

```
exchange-server-2019-lab/
├── README.md        # Vue d'ensemble
├── RAPPORT.md       # Rapport détaillé, étape par étape, avec captures
├── scripts/         # Commandes PowerShell regroupées par étape
└── images/          # Captures d'écran (qXX = numéro de l'étape)
```

> ⚠️ Environnement de laboratoire isolé. Le mot de passe présent dans les scripts est un mot de passe de test, à ne jamais réutiliser en production.

---

**Chahd Merzaki** — étudiante en réseautique et cybersécurité
