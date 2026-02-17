FROM python:3.11.3-slim

#Definiendo variables
ARG APP_DIR=/app
ARG APP_USER=devsu_user
ARG APP_GROUP=devsu_group

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    APP_PORT=8000
WORKDIR ${APP_DIR}

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

#Preparando el usuario no root
RUN addgroup --system ${APP_GROUP} && adduser --system --group ${APP_USER}

COPY requirements.txt ${APP_DIR}/
RUN pip install --no-cache-dir -r requirements.txt
COPY . ${APP_DIR}/
RUN chown -R ${APP_USER}:${APP_GROUP} ${APP_DIR}

#Ejecutando tareas con el usuario no root
USER ${APP_USER}

EXPOSE ${APP_PORT}

HEALTHCHECK --interval=30s --timeout=10s --start-period=1s --retries=3  \
    CMD curl -f http://localhost:${APP_PORT}/api/users/ || exit 1

CMD [ "sh", "-c", "python manage.py makemigrations && python manage.py migrate && python manage.py runserver 0.0.0.0:${APP_PORT}" ] 