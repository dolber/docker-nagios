FROM jasonrivers/nagios:latest

RUN apt-get update && apt-get install -y    \
    python3-requests                        \
    apt-utils                               \
    python3-pycurl                          \
    python3-pip                             \
    apt-utils                               \
    && apt-get clean                        \
    && rm -Rf /var/lib/apt/lists/*          \
    && pip3 install --upgrade pip           \
    && hash -r pip                          \
    && pip3 install twx.botapi

