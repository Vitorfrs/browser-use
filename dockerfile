FROM python:3.10-slim

# Atualizações e dependências básicas
RUN apt-get update && apt-get install -y \
    curl gnupg unzip wget git \
    libglib2.0-0 libnss3 libgconf-2-4 libfontconfig1 libxss1 libxtst6 libasound2 libatk1.0-0 libatk-bridge2.0-0 libcups2 \
    && apt-get clean

# Diretório de trabalho
WORKDIR /app

# Copiar os arquivos
COPY . /app

# Instalar dependências Python
RUN pip install --upgrade pip
RUN pip install fastapi uvicorn playwright
RUN playwright install

# Expor a porta padrão do FastAPI
EXPOSE 8000

# Start com Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
