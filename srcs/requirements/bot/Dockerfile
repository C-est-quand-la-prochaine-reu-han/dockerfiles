FROM python:3

ARG PORT=8765
ENV PORT=${PORT}

ARG PROXY=reverse-proxy
ENV PROXY=${PROXY}

EXPOSE ${PORT}

WORKDIR /usr/src/app

COPY ./bot /usr/src/app

RUN pip install --no-cache-dir -r requirements.txt

ENTRYPOINT ["python", "./bot.py"]
