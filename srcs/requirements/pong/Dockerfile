FROM python:3

ARG PORT=8765
ENV PORT=${PORT}

EXPOSE ${PONG_PORT}

WORKDIR /usr/src/app

COPY ./pong /usr/src/app

RUN pip install --no-cache-dir -r requirements.txt
RUN env

ENTRYPOINT ["python", "./pong.py"]
