FROM python:2
WORKDIR /app
ONBUILD COPY . /app
ONBUILD RUN pip install --upgrade pip && export PATH=$PATH:/usr/local/bin
ONBUILD RUN apt-get update && apt-get -y install $(grep -vE "^\s*#" /app/apt-requirements.txt | tr "\n" " ") && rm -rf /var/lib/apt/lists/*
ONBUILD RUN /usr/local/bin/pip install --process-dependency-links -r /app/requirements.txt
CMD ["/usr/local/bin/python", "main.py"]

