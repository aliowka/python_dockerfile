FROM python:2
WORKDIR /app
ONBUILD COPY . /app
ONBUILD RUN pip install --upgrade pip && export PATH=$PATH:/usr/local/bin
ONBUILD RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt precise-security main restricted universe multiverse" | tee -a /etc/apt/sources.list
ONBUILD RUN apt-get update && apt-get -y install $(grep -vE "^\s*#" /app/apt-requirements.txt | tr "\n" " ") && rm -rf /var/lib/apt/lists/*
ONBUILD RUN apt-get -y install vim
ONBUILD RUN /usr/local/bin/pip install --process-dependency-links -r /app/requirements.txt
CMD ["/usr/local/bin/python", "main.py"]

