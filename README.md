# arbre-de-vie
dépendances :
ollama
llama 3.1
python 3
discord : Permet d'interagir avec l'API Discord.
discord.ext.commands : Fournit un système de commandes pour les bots Discord.
subprocess : Utilisé pour exécuter des commandes système (ici pour lancer Ollama).
logging : Gère la journalisation des événements du bot.
requests : Effectue des requêtes HTTP (ici pour interagir avec Ollama via une API locale).
json : Manipule les fichiers JSON (chargement et sauvegarde du cache).
os : Gère les opérations système (comme vérifier l'existence d'un fichier).

pour utiliser l'arbre de vie veuillez installer ollama présent ici -> https://ollama.com/ puis installer llama3.1 afin d'éxécuter l'ia associé
ensuite cloner le repository et executer le script arbre_de_vie.py dans un environnement adapté afin de se connecter au bot discord associé

fonctionnement :
Ce script est un bot Discord utilisant la bibliothèque `discord.py` pour interagir avec les utilisateurs et répondre à leurs questions en appelant un modèle d'IA local via l'API d'**Ollama**. Il démarre en initialisant un système de **cache JSON** pour stocker les réponses et éviter de refaire les mêmes requêtes. Lorsqu'un utilisateur envoie une commande `.question <texte>`, le bot envoie la question à **Ollama** et récupère la réponse, qu'il affiche ensuite sur Discord. Le bot logge également les messages envoyés, modifiés ou supprimés, ainsi que les réactions et les entrées/sorties des membres sur le serveur. Il inclut aussi un **système de logging** pour suivre les erreurs et les événements importants. Enfin, un problème de sécurité majeur est la présence du **token du bot en clair dans le code**, ce qui peut compromettre l'accès au bot s'il est exposé publiquement.
