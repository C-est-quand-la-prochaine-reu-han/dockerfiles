FROM python:3

EXPOSE 8765

WORKDIR /usr/src/app

ARG PONG_ROOT_DIRECTORY="./pong"
COPY ${PONG_ROOT_DIRECTORY} /usr/src/app

RUN pip install --no-cache-dir -r requirements.txt

CMD [ "python", "./pong.py" ]
