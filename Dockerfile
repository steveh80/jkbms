FROM python:3

WORKDIR /app

RUN apt update && apt install bluetooth -y

RUN pip install bluepy mppsolar


CMD [ "/bin/bash", "-c", "while true; do jkbms -C /etc/jkbms.conf ; sleep 5; done;" ]
