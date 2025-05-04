import subprocess
import logging
import requests
import json
import os

LOG_FILE = "logs.txt"
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s", handlers=[
    logging.FileHandler(LOG_FILE, encoding="utf-8"),
    logging.StreamHandler()
])

CACHE_FILE = "cache_reponses.json"
cache_reponses = {}

def charger_cache():
    if os.path.exists(CACHE_FILE):
        try:
            with open(CACHE_FILE, 'r', encoding='utf-8') as f:
                return json.load(f)
        except json.JSONDecodeError:
            logging.error("Le fichier de cache est corrompu, création d'un nouveau cache.")
    return {}

def sauvegarder_cache():
    try:
        with open(CACHE_FILE, 'w', encoding='utf-8') as f:
            json.dump(cache_reponses, f, ensure_ascii=False, indent=4)
    except Exception as e:
        logging.error(f"Erreur lors de la sauvegarde du cache : {e}")

def reponse_par_llama(question):
    global cache_reponses
    if not cache_reponses:
        cache_reponses = charger_cache()

    if question in cache_reponses:
        logging.info(f"Réponse trouvée dans le cache pour : {question}")
        return cache_reponses[question]

    url = "http://localhost:11434/api/generate"
    data = {
        "model": "michalex37/arbre_de_vie",
        "prompt": f"Question : {question}\nRéponse :",
        "stream": False,
    }

    try:
        response = requests.post(url, json=data)
        response.raise_for_status()
        result = response.json()
        reponse = result.get("response", "Erreur dans la réponse du modèle.")
        cache_reponses[question] = reponse
        sauvegarder_cache()
        return reponse
    except requests.RequestException as e:
        logging.error(f"Erreur API Ollama : {e}")
        return "Erreur avec le modèle."

def lancer_ollama():
    try:
        logging.info("Lancement d'Ollama...")
        subprocess.Popen(["ollama", "serve"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    except Exception as e:
        logging.error(f"Erreur lancement Ollama : {e}")

