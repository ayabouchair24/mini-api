# image de base
FROM python:3.12-slim

# répertoire de travail
WORKDIR /app

# copied requirements.txt avant le reste du code
COPY requirements.txt .

# les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# le reste du code
COPY . .

# exposer le port 5000
EXPOSE 5000

# app lancement
CMD ["python", "app.py"]