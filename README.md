# 🌳 Arbre de Vie

## 📋 Dépendances
Avant d'utiliser ce projet, assurez-vous d'avoir installé les dépendances suivantes :

### 🔧 Outils requis
- **Ollama** : Nécessaire pour exécuter le modèle d'IA local ([Installation ici](https://ollama.com/)). Ensuite, utilisez la commande :
    ```sh
    ollama create arbre-de-vie -f Modelfile
    ```
    Puis, vérifiez si l'arbre a bien été créé avec :
    ```sh
    ollama run arbre-de-vie
    ```
    Si une erreur s'affiche, contactez-moi. Si un chat apparaît, c'est que tout fonctionne correctement.
- **nemotron-mini** : Modèle utilisé pour générer les réponses.
- **Python 3** : Langage de programmation utilisé.

### 📦 Modules Python
Installez les bibliothèques suivantes avec `pip` :
```sh
pip install discord requests python-dotenv
```
- **discord** : Permet d'interagir avec l'API Discord.
- **discord.ext.commands** : Fournit un système de commandes pour les bots Discord.
- **subprocess** : Utilisé pour exécuter des commandes système (ici pour lancer Ollama).
- **logging** : Gère la journalisation des événements du bot.
- **requests** : Effectue des requêtes HTTP (ici pour interagir avec Ollama via une API locale).
- **json** : Manipule les fichiers JSON (chargement et sauvegarde du cache).
- **os** : Gère les opérations système (comme vérifier l'existence d'un fichier).

## 🚀 Installation et Utilisation

1. **Installer Ollama** en suivant les instructions sur [https://ollama.com](https://ollama.com/).
2. **Télécharger le modèle Llama 3.1** avec la commande :
   ```sh
   ollama pull llama3.1:latest
   ```
3. **Cloner ce repository** (optionnel mais recommandé) :
   ```sh
   git clone https://github.com/Michalex37220/arbre-de-vie.git
   cd arbre-de-vie
   ```
4. **Exécuter le bot** :
   ```sh
   python3 arbre_de_vie.py
   ```

## ⚙️ Fonctionnement

Ce script est un bot Discord permettant aux utilisateurs de poser des questions à un modèle d'IA local via l'API d'**Ollama**. Il utilise un système de **cache JSON** pour éviter de refaire les mêmes requêtes. Lorsqu'un utilisateur envoie la commande :
```sh
.question <texte>
```
Le bot envoie la question à **Ollama**, récupère la réponse et la poste sur Discord.

### 📜 Fonctionnalités principales
- Gestion et enregistrement des messages envoyés, modifiés ou supprimés.
- Suivi des réactions et des membres rejoignant/quittant le serveur.
- **Logging** des événements et erreurs pour un meilleur débogage.

## 🔄 Mises à jour et contributions
Pensez à **mettre régulièrement à jour votre version** du projet en récupérant les dernières modifications via :
```sh
git pull origin main
```
Votre participation est essentielle pour améliorer continuellement le projet ! 🚀

💡 **Besoin d'aide ?** Contactez-moi sur GitHub ! 🚀


