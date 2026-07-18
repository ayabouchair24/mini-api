# Rapport de TP - Conteneurisation d'une Mini API Flask

Ce dépôt contient les fichiers de configuration et le code source nécessaires.

## Fichiers inclus
* app.py : Script principal de l'API Flask exposant un point de terminaison de santé.
* requirements.txt : Dépendances Python nécessaires (Flask).
* Dockerfile : Fichier de configuration décrivant les étapes de build de l'image Docker.

## Étapes de configuration et exécution

### 1. Construction de l'image Docker
L'image a été initialement construite à l'aide de la commande suivante :
```bash
docker build -t mini-api:1.0 .
```
### 2. Erreurs au lancement 
J'ai copié la commande incluant le texte du sujet ce qui a généré une erreur de syntaxe :
```
docker ps — le conteneur api doit apparaître avec le statut Up...
```
L'interpréteur a retourné le message suivant : docker: 'docker ps' accepts no arguments. Je l'ai corrigée.

### 3. Lancement et vérification du conteneur
Le conteneur s'est correctement exécuté avec le statut "Up".
```
docker run -d -p 5000:5000 --name api mini-api:1.0
docker ps
```

### 4. Tests d'interrogation et de logs
La disponibilité de l'API a été validée via un appel curl local, qui a retourné le statut attendu :
```
curl http://localhost:5000/health
```
Retour de l'API : {"hostname":"7d9e816a574c","status":"ok"}
Les logs internes du conteneur ont ensuite été consultés pour confirmer l'enregistrement de la requête réseau :
```
docker logs api
```
### 5. Inspection interne du conteneur
En utilisant:
```docker exec -it api bash
ls /app
exit
```

Les fichiers Dockerfile, app.py, et requirements.txt ont été correctement localisés sous /app.
### 6. Analyse de la modification de code
J'ai lancé deux builds consécutifs pour tester la gestion des couches de Docker :

Lors du premier build (sans modifications), la commande a affiché la mention CACHED pour l'intégralité des étapes de 2 à 5.

Lors du second build (après modification et sauvegarde du fichier app.py), Docker a réutilisé les couches de cache pour les étapes d'installation (2 à 4), mais a invalidé et reconstruit l'étape [5/5] COPY . . car il a détecté le changement de contenu. 
### 7. Nettoyage de l'environnement
Pour finaliser l'exercice, le conteneur en cours d'exécution a été arrêté, supprimé, et l'image locale a été nettoyée du disque :
```
docker stop api && docker rm api && docker rmi mini-api:1.0
```