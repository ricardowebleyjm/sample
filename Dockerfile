FROM python:3.10

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y \
    libsasl2-dev \
    python-dev \
    libssl-dev \
    uwsgi-plugin-python3 

RUN pip install --upgrade pip
RUN pip install uwsgi
RUN mkdir -p /src
WORKDIR /src
COPY requirements.txt /src
COPY entrypoint.sh /src/
RUN pip install -r requirements.txt
COPY . /src

EXPOSE 9005
ENTRYPOINT ["sh", "entrypoint.sh"]