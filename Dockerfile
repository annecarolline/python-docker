# Etapa 1: Usar uma imagem base oficial e estável do Python.
# A imagem 'slim' é uma boa escolha por ser menor que a padrão.
FROM python:3.13.5-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner.
# Isso evita espalhar os arquivos da aplicação no diretório raiz.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências para o diretório de trabalho.
# Copiamos este arquivo primeiro para aproveitar o cache de camadas do Docker.
# A instalação das dependências só será executada novamente se este arquivo mudar.
COPY requirements.txt .

# Etapa 4: Instalar as dependências.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação.
COPY . .

# Etapa 6: Expor a porta em que o Uvicorn será executado.
EXPOSE 8000

# Etapa 7: Comando para iniciar a aplicação FastAPI com Uvicorn.
# O host '0.0.0.0' é necessário para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]