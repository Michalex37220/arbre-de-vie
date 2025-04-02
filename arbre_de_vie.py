import discord
from discord.ext import commands
import subprocess
import logging
import requests
import json
import os

# Configuration du logging dans un fichier texte
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
    if question in cache_reponses:
        logging.info(f"Réponse trouvée dans le cache pour : {question}")
        return cache_reponses[question]

    url = "http://localhost:11434/api/generate"
    data = {
        "model": "arbre-de-vie",
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
        process = subprocess.Popen(["ollama", "serve"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return process
    except Exception as e:
        logging.error(f"Erreur lancement Ollama : {e}")
        return None

intents = discord.Intents.all()
bot = commands.Bot(command_prefix=".", intents=intents)

@bot.event
async def on_ready():
    logging.info(f"{bot.user} connecté !")
    global cache_reponses
    cache_reponses = charger_cache()
    global ollama_process
    ollama_process = lancer_ollama()

@bot.event
async def on_message(message):
    if message.author == bot.user:
        return
    logging.info(f"Message reçu de {message.author} : {message.content}")
    await bot.process_commands(message)

@bot.command()
async def question(ctx, *, demande):
    logging.info(f"Question posée : {demande}")
    reponse = reponse_par_llama(demande)
    await ctx.send(reponse)

TOKEN = "Votre_token"
if not TOKEN:
    raise ValueError("Le token du bot Discord n'est pas défini !")

bot.run(TOKEN)
