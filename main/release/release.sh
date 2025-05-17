#!/bin/bash

# Sécurité
set -euo pipefail

# Couleurs
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# Fonction d'affichage de messages
function print_msg {
    local color="$1"
    local msg="$2"
    echo -e "${color}${msg}${RESET}"
}

# Installation des dépendances Python
print_msg "$GREEN" "=== Installation des dépendances Python ==="
if command -v python3 >/dev/null 2>&1; then
    python3 -m pip install --upgrade pip
    python3 -m pip install discord requests python-dotenv
    print_msg "$GREEN" "Dépendances Python installées."
else
    print_msg "$RED" "Python3 est introuvable. Installez-le avant de continuer."
    exit 1
fi

# Vérification de Ollama
print_msg "$GREEN" "=== Vérification de Ollama ==="
if command -v ollama >/dev/null 2>&1; then
    print_msg "$GREEN" "Ollama est déjà installé."
else
    print_msg "$YELLOW" "Ollama non détecté. Installation en cours..."
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL https://ollama.com/install.sh | sh
        print_msg "$GREEN" "Ollama installé avec succès."
    else
        print_msg "$RED" "Erreur : 'curl' est requis pour installer Ollama."
        exit 1
    fi
fi

# Clonage du dépôt Git
print_msg "$GREEN" "=== Clonage du dépôt Git ==="
REPO_URL="https://github.com/Michalex37220/arbre-de-vie.git"
TARGET_DIR="arbre-de-vie"

# Vérification si le dossier cible existe et n'est pas vide
if [ -d "$TARGET_DIR" ] && [ "$(ls -A "$TARGET_DIR")" ]; then
    print_msg "$RED" "Le dossier '$TARGET_DIR' existe déjà et n'est pas vide."
    print_msg "$YELLOW" "Voulez-vous supprimer le répertoire existant et re-cloner ? (o/n)"
    read -r confirm
    if [[ "$confirm" =~ ^[Oo]$ ]]; then
        rm -rf "$TARGET_DIR"
        print_msg "$GREEN" "Ancien dossier supprimé."
    else
        print_msg "$YELLOW" "Opération annulée."
        exit 1
    fi
fi

git clone "$REPO_URL"
print_msg "$GREEN" "Dépôt cloné avec succès."

cd "$TARGET_DIR" || { print_msg "$RED" "Impossible d'accéder à $TARGET_DIR."; exit 1; }

# Aller dans le répertoire de release pour utiliser le Modefile
cd "arbre-de-vie/main/abre-de-vie" || { print_msg "$RED" "Impossible d'accéder à main/arbre-de-vie."; exit 1; }

# Vérification et utilisation du Modefile
MODEFILE_PATH="Modefile"
if [ -f "$MODEFILE_PATH" ]; then
    print_msg "$GREEN" "Le fichier 'Modefile' a été trouvé dans 'main/release', exécution..."
    # Exécution du Modefile si nécessaire (par exemple, si c'est un script shell)
    ./$MODEFILE_PATH
else
    print_msg "$RED" "Le fichier 'Modefile' est introuvable dans le répertoire 'main/release'."
    exit 1
fi

# Retour au répertoire principal
cd ../..

# Vérification du token Discord dans main/arbre-de-vie/arbre_de_vie.py
print_msg "$GREEN" "=== Vérification du token Discord dans arbre_de_vie.py ==="
if [ ! -f "main/arbre-de-vie/arbre_de_vie.py" ]; then
    print_msg "$RED" "Le fichier 'arbre_de_vie.py' est introuvable dans 'main/arbre-de-vie'."
    exit 1
fi

if grep -q 'TOKEN\s*=\s*["'\''].*["'\'']' "main/arbre-de-vie/arbre_de_vie.py"; then
    TOKEN_VALUE=$(grep -oP 'TOKEN\s*=\s*["'\'']\K[^"'\'']+' "main/arbre-de-vie/arbre_de_vie.py" | head -n 1)

    if [ -z "$TOKEN_VALUE" ] || [ "$TOKEN_VALUE" == "Votre_Token" ]; then
        print_msg "$RED" "Le token Discord est vide ou défini par défaut ('Votre_Token')."
        print_msg "$RED" "Veuillez modifier la ligne dans 'main/arbre-de-vie/arbre_de_vie.py' avec votre vrai token :"
        print_msg "$YELLOW" 'TOKEN = "votre_token_discord_ici"'
        exit 1
    else
        print_msg "$GREEN" "Token valide détecté dans 'main/arbre-de-vie/arbre_de_vie.py'."
    fi
else
    print_msg "$RED" "Aucune variable TOKEN trouvée dans 'main/arbre-de-vie/arbre_de_vie.py'."
    print_msg "$RED" 'Ajoutez une ligne comme : TOKEN = "votre_token_discord"'
    exit 1
fi

