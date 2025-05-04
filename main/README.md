Avec plaisir ! Voici une version soignée, propre et professionnelle de ton README, en markdown bien structuré, avec une table des matières cliquable, des titres uniformes et une présentation agréable :  

---

# 🌳 Arbre de Vie

Un bot Discord alimenté par une IA locale via **Ollama**, conçu pour répondre aux questions des utilisateurs tout en respectant l'univers du **Royaume d'Ildoria**.

---

## 📑 Sommaire

- [🫵 Utilisateurs](#-utilisateurs)
- [⚠️ Règles d'utilisation](#️-règles-dutilisation)
- [👨‍💻 Développeurs](#-développeurs)
- [📋 Dépendances](#-dépendances)
- [🚀 Installation et Utilisation](#-installation-et-utilisation)
- [⚙️ Fonctionnement](#-fonctionnement)
- [📜 Fonctionnalités principales](#-fonctionnalités-principales)
- [💡 Améliorations possibles](#-améliorations-possibles)
- [🔄 Mises à jour et contributions](#-mises-à-jour-et-contributions)
- [🏆 Employé du mois](#-employé-du-mois)
- [🆘 Besoin d'aide ?](#-besoin-daide)

---

## 🫵 Utilisateurs

Il est **FORTEMENT RECOMMANDÉ** d’utiliser le script de release pour installer toutes les dépendances proprement.

Si vous choisissez une installation manuelle, suivez la section [🚀 Installation et Utilisation](#-installation-et-utilisation) et installez les dépendances à la main.

👉 Pour l’utilisation détaillée du bot, consultez [⚙️ Fonctionnement](#-fonctionnement).

---

## ⚠️ Règles d'utilisation

1. 🚫 **Ne modifiez pas l'IA dans le but de la publier pour un usage public ou inapproprié.**
2. 🚫 **Ne posez pas de questions inappropriées**  
(érotisme, sexualité, contenu offensant ou hors sujet par rapport au Royaume d’Ildoria).
3. 🛡️ Des **barrières contre les débordements** sont intégrées. En cas d’abus, des sanctions automatiques seront appliquées par une IA supervisant les conversations.
4. 🐞 Signalez toute **imprécision dans les réponses** dans `bug-report-public`.
5. ⛔ Je me réserve le droit de **sanctionner sans préavis** toute conversation jugée inappropriée.
6. 🔁 Les règles sont susceptibles d’évoluer, pensez à consulter cette section régulièrement.

---

## 👨‍💻 Développeurs

### Structure du projet

| Fichier                | Description                                                              |
|-------------------------|---------------------------------------------------------------------------|
| `arbre-de-vie.py`       | Gère la transition des messages et l'auto-modération.                    |
| `Modelfile`             | Contient le caractère, les règles et les connaissances de l’IA.          |
| `cache_reponse.json`    | Système de cache des questions-réponses pour éviter les doublons.         |
| `log.txt`               | Historique complet des logs du bot et serveur (**NE PAS COMMIT !**)      |
| `README.md`             | La documentation que vous êtes en train de lire.                         |

---

## 📋 Dépendances

### 🔧 Outils requis

- [**Ollama**](https://ollama.com/) : exécute le modèle IA local.

```bash
ollama create michalex37/arbre-de-vie -f Modelfile
ollama run michalex37/arbre-de-vie
```

- **nemotron-mini** : modèle IA utilisé pour générer les réponses. (Téléchargement automatique via script ou compilation manuelle.)
- **Python 3** : Langage de programmation du bot.

---

### 📦 Modules Python

Installez les dépendances suivantes avec `pip` :  

```bash
pip install discord requests python-dotenv
```

| Module                  | Utilité                                                   |
|--------------------------|-----------------------------------------------------------|
| `discord`                | Interaction avec l'API Discord.                           |
| `discord.ext.commands`   | Système de commandes du bot.                              |
| `subprocess`             | Exécute des commandes système.                            |
| `logging`                | Gère les logs.                                            |
| `requests`               | Requêtes HTTP vers Ollama.                                |
| `json`                   | Manipule les fichiers JSON.                               |
| `os`                     | Interactions système.                                     |

---

## 🚀 Installation et Utilisation

1. Installez **Ollama** :  
   ➡️ [Guide officiel](https://ollama.com/)

2. Téléchargez le modèle `nemotron-mini` :  

```bash
ollama pull michalex37/arbre_de_vie
```

3. Clonez ce repository :  

```bash
git clone https://github.com/Michalex37220/arbre-de-vie.git
cd arbre-de-vie
```

4. Lancez le bot :  

```bash
python3 arbre_de_vie.py
```

---

## ⚙️ Fonctionnement

Le bot fonctionne avec **Ollama** pour traiter les questions des utilisateurs.

Utilisation sur Discord :

```bash
.question <texte>
```

Le bot enverra la question à Ollama, récupérera la réponse et la publiera.

---

## 📜 Fonctionnalités principales

- 🤖 Répond aux questions des utilisateurs.
- 💾 Gestion des messages envoyés, modifiés et supprimés.
- 👥 Suivi des membres (arrivées et départs).
- 🪵 Enregistrement des logs pour un débogage simplifié.
- 🔒 Système d’auto-modération (à venir) :
  - Détection de langage inapproprié (regex y compris contournements).
  - Sanctions graduées :  
    `Avertissement ➡️ 1h ➡️ 1 jour ➡️ 1 semaine ➡️ Permanent.`

---

## 💡 Améliorations possibles

- Gérer les erreurs API sans bloquer le fonctionnement.
- Renforcer les barrières de sécurité pour :
  - Limiter les discussions hors sujet (**hors Royaume d’Ildoria**).
  - Empêcher toute injection de prompt malveillant.
- Améliorer la gestion des logs.

---

## 🔄 Mises à jour et contributions

Pensez à maintenir votre version à jour (particulièrement si vous compilez manuellement) :

```bash
git pull origin main
```

### Contribuer :

```bash
git add .
git commit -m "Mise à jour du contexte et améliorations"
git push origin main
```

💡 Vous pouvez également utiliser l’interface [GitHub](https://github.com/Michalex37220/arbre-de-vie.git) pour vos commits.

---

### ⚠️ Note importante

**Faites un `commit` — pas un `fork` !**  
Tout abus de notifications via des commits non constructifs entraînera :

- Bannissement immédiat.
- Suppression des droits.
- Interdiction d’utilisation du projet, même en usage personnel.

## 📜 Licence

Projet sous licence [Apache 2.0](https://opensource.org/license/apache-2-0).

✔️ Publication, diffusion et modification autorisées,  
⚠️ **Obligation de mentionner l’auteur** en cas de réutilisation, partielle ou complète.

## 🏆 Employé du mois

**ard48**  
💪 Pour son beta-testing de qualité, qui a permis la détection de nombreux bugs.  
Rôle obtenu : **Légende**.

## 🆘 Besoin d'aide ?

📬 Contactez-moi directement sur **Discord** ! 🚀

