FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho no container
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# O Docker só irá reinstalar as dependências se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências
# --no-cache-dir: Desabilita o cache do pip para manter a imagem menor.
# --upgrade pip: Garante que a versão mais recente do pip seja usada.
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação com Uvicorn
# --host 0.0.0.0: Torna a aplicação acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]