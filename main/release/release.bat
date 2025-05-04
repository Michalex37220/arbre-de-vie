@echo off
setlocal ENABLEEXTENSIONS
color 0A

echo === Verification des pre-requis ===

:: Vérification Python
where python >nul 2>&1
if errorlevel 1 (
    color 0C
    echo Python3 n'est pas installe ou pas dans le PATH.
    exit /b 1
)

:: Vérification Git
where git >nul 2>&1
if errorlevel 1 (
    color 0C
    echo Git n'est pas installe ou pas dans le PATH.
    exit /b 1
)

:: Vérification Curl
where curl >nul 2>&1
if errorlevel 1 (
    color 0C
    echo curl n'est pas installe ou pas dans le PATH.
    exit /b 1
)

:: Vérification Ollama
where ollama >nul 2>&1
if errorlevel 1 (
    color 0E
    echo Ollama n'est pas detecte sur votre machine.
    echo Telechargez-le ici : https://ollama.com
    echo Puis installez-le avant de poursuivre.
    pause
    exit /b 1
)

echo.
echo === Verification des dependances Python ===

:: Vérification via pip list
python -m pip show discord >nul 2>&1 || (
    echo discord manquant. Installation...
    python -m pip install discord
)

python -m pip show requests >nul 2>&1 || (
    echo requests manquant. Installation...
    python -m pip install requests
)

python -m pip show python-dotenv >nul 2>&1 || (
    echo python-dotenv manquant. Installation...
    python -m pip install python-dotenv
)

echo Toutes les dependances Python sont installees.
echo.

:: Clonage du projet
set REPO_URL=https://github.com/Michalex37220/arbre-de-vie.git
set TARGET_DIR=arbre-de-vie

if exist "%TARGET_DIR%" (
    color 0C
    echo Le dossier "%TARGET_DIR%" existe deja.
    set /p confirm=Voulez-vous le supprimer et re-cloner ? (o/n) : 
    if /I "%confirm%"=="o" (
        rmdir /s /q "%TARGET_DIR%"
        echo Ancien dossier supprime.
    ) else (
        echo Operation annulee.
        exit /b 1
    )
)

git clone "%REPO_URL%"
if errorlevel 1 (
    color 0C
    echo Echec du clonage Git.
    exit /b 1
)
echo Depot clone avec succes.

cd "%TARGET_DIR%" || (
    color 0C
    echo Impossible d'entrer dans %TARGET_DIR%.
    exit /b 1
)

:: Creation du modele Ollama
echo.
echo === Creation du modele Ollama ===
ollama create michalex37/arbre_de_vie
if errorlevel 1 (
    color 0C
    echo Echec lors de la creation du modele Ollama.
    exit /b 1
)

:: Verification du TOKEN
echo.
echo === Verification du TOKEN dans arbre-de-vie.py ===

findstr /R /C:"TOKEN\s*=\s*['\"].*['\"]" arbre-de-vie.py >nul 2>&1
if errorlevel 1 (
    color 0C
    echo Le token Discord est introuvable dans arbre-de-vie.py.
    echo Veuillez ajouter : TOKEN = "Votre_Vrai_Token"
    exit /b 1
)

for /f "tokens=2 delims== " %%A in ('findstr /R /C:"TOKEN\s*=\s*['\"]" arbre-de-vie.py') do (
    set "TOKEN=%%~A"
)

set TOKEN=%TOKEN:"=%
set TOKEN=%TOKEN:'=%

if "%TOKEN%"=="Votre_Token" (
    color 0C
    echo Le TOKEN est encore defini sur "Votre_Token" !
    echo Remplacez-le dans arbre-de-vie.py avant de lancer.
    exit /b 1
)

echo Token valide detecte : %TOKEN%

:: Demande lancement
echo.
set /p reponse=Voulez-vous lancer le bot maintenant ? (oui/non) : 

if /I "%reponse%"=="oui" (
    python arbre-de-vie.py
) else (
    echo Pour lancer manuellement : python arbre-de-vie.py
)

endlocal

