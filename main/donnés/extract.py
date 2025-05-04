import zipfile
import os
import shutil

# Fonction pour extraire les images d'un fichier ODT
def extraire_images_odt(odt_file, output_dir):
    # Vérifier si le fichier ODT existe
    if not os.path.isfile(odt_file):
        print(f"Le fichier {odt_file} n'existe pas.")
        return
    
    # Créer le répertoire de sortie si il n'existe pas
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    # Ouvrir le fichier ODT comme un fichier zip
    with zipfile.ZipFile(odt_file, 'r') as zip_ref:
        # Lister tous les fichiers dans l'archive
        files = zip_ref.namelist()
        
        # Chercher les fichiers dans le dossier 'Pictures' du ODT
        for file in files:
            if file.startswith('Pictures/'):
                # Extraire les images et les stocker dans le répertoire de sortie
                zip_ref.extract(file, output_dir)
                
                # Déplacer les images de leur emplacement dans le dossier 'Pictures' vers le répertoire final
                image_name = file.split('/')[-1]
                image_path = os.path.join(output_dir, file)
                final_path = os.path.join(output_dir, image_name)
                
                shutil.move(image_path, final_path)
                print(f"Image extraite : {final_path}")

# Spécifiez le chemin du fichier ODT et du répertoire de sortie
odt_file = 'Bestiaire 7.odt'
output_dir = '/home/kali/Bureau/arbre de vie/beta/donnés/images'

# Appeler la fonction pour extraire les images
extraire_images_odt(odt_file, output_dir)
