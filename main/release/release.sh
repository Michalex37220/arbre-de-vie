#!/bin/bash

# Sécurité
set -euo pipefail

# Couleurs
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo -e "${GREEN}=== Installation des dépendances Python ===${RESET}"
if command -v python3 >/dev/null 2>&1; then
    python3 -m pip install --upgrade pip
    python3 -m pip install discord requests python-dotenv
    echo -e "${GREEN}Dépendances Python installées.${RESET}"
else
    echo -e "${RED}Python3 est introuvable. Installez-le avant de continuer.${RESET}"
    exit 1
fi

echo -e "${GREEN}=== Vérification de Ollama ===${RESET}"
if command -v ollama >/dev/null 2>&1; then
    echo -e "${GREEN}Ollama est déjà installé.${RESET}"
else
    echo -e "${YELLOW}Ollama non détecté. Installation en cours...${RESET}"
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL https://ollama.com/install.sh | sh
        echo -e "${GREEN}Ollama installé avec succès.${RESET}"
    else
        echo -e "${RED}Erreur : 'curl' est requis pour installer Ollama.${RESET}"
        exit 1
    fi
fi

echo -e "${GREEN}=== Clonage du dépôt Git ===${RESET}"
REPO_URL="https://github.com/Michalex37220/arbre-de-vie.git"
TARGET_DIR="arbre-de-vie"

if [ -d "$TARGET_DIR" ]; then
    echo -e "${RED}Le dossier '$TARGET_DIR' existe déjà.${RESET}"
    echo -e "${YELLOW}Voulez-vous le supprimer et re-cloner ? (o/n)${RESET}"
    read -r confirm
    if [[ "$confirm" =~ ^[Oo]$ ]]; then
        rm -rf "$TARGET_DIR"
        echo "Ancien dossier supprimé."
    else
        echo "Opération annulée."
        exit 1
    fi
fi

git clone "$REPO_URL"
echo -e "${GREEN}Dépôt cloné avec succès.${RESET}"

cd "$TARGET_DIR" || { echo -e "${RED}Impossible d'accéder à $TARGET_DIR.${RESET}"; exit 1; }

echo -e "${GREEN}=== Création du modèle Ollama ===${RESET}"
ollama create michalex37/arbre_de_vie
echo -e "${GREEN}Modèle Ollama créé.${RESET}"

echo -e "${GREEN}=== Vérification du token Discord dans arbre_de_vie.py===${RESET}"

if grep -q 'TOKEN\s*=\s*["'\''].*["'\'']' arbre_de_vie.py; then
    TOKEN_VALUE=$(grep -oP 'TOKEN\s*=\s*["'\'']\K[^"'\'']+' arbre_de_vie.py| head -n 1)

    if [ -z "$TOKEN_VALUE" ] || [ "$TOKEN_VALUE" == "Votre_Token" ]; then
        echo -e "${RED}Le token Discord est vide ou défini par défaut ('Votre_Token').${RESET}"
        echo -e "${RED}Veuillez modifier la ligne dans arbre_de_vie.py avec votre vrai token :${RESET}"
        echo -e "${YELLOW}TOKEN = \"votre_token_discord_ici\"${RESET}"
        exit 1
    else
        echo -e "${GREEN}Token valide détecté dans arbre-de-vie.py.${RESET}"
    fi
else
    echo -e "${RED}Aucune variable TOKEN trouvée dans arbre-de-vie.py.${RESET}"
    echo -e "${RED}Ajoutez une ligne comme : TOKEN = \"votre_token_discord\"${RESET}"
    exit 1
fi

echo -e "${GREEN}=== Voulez-vous lancer le bot maintenant ? (oui/non) ===${RESET}"
read -r reponse

if [[ "$reponse" =~ ^[Oo]([Uu][Ii])?$ ]]; then
    echo -e "${GREEN}Lancement de 'arbre-de-vie.py'...${RESET}"
    python3 arbre_de_vie.py
else
    echo -e "${GREEN}Pour lancer manuellement :${RESET}"
    echo "python3 arbre_de_vie.py"
fi
