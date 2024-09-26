FROM django

WORKDIR /var/www/html

COPY ./api/mysite .
COPY ./api/requirements.txt .

RUN ["pip", "install", "--no-cache-dir", "--break-system-packages", "-r", "requirements.txt"]
