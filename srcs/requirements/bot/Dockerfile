FROM python:3

ARG PORT=8765
ENV PORT=${PORT}

ARG HOSTNAME=localhost
ENV HOSTNAME=${HOSTNAME}

EXPOSE ${PONG_PORT}

WORKDIR /usr/src/app

COPY ./bot /usr/src/app

RUN pip install --no-cache-dir -r requirements.txt

ENTRYPOINT ["python", "./gameAI.py"]
