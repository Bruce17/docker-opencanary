FROM python:3-alpine

ARG VERSION

# Error building cryptography:
# "[...] 5) If you are experiencing issues with Rust for *this release only* you may set the environment variable `CRYPTOGRAPHY_DONT_BUILD_RUST=1`."
ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1

RUN mkdir -p /opt/opencanary /opt/opencanary/scripts && \
    apk update && \
    apk add --no-cache bash sudo openssl libffi libpcap && \
    # Add build dependencies
    apk add --no-cache gcc g++ && \
    # Add build dependencies which can be removed later
    apk add --no-cache --virtual .build-deps  python3-dev libffi-dev musl-dev openssl-dev libpcap-dev && \
    # Upgrade pip first
    pip install --upgrade pip && \
    # Prepare virtualenv
    pip install virtualenv && \
    virtualenv /opt/opencanary/virtualenv/ && \
    . /opt/opencanary/virtualenv/bin/activate && \
    # Avoid error "cannot import name 'Feature' from 'setuptools'" caused by setuptools, see: https://github.com/pypa/setuptools/issues/2017#issuecomment-605354361
    pip install setuptools==45 && \
    # Install OpenCanary and tools
    pip install opencanary==${VERSION} && \
    pip install scapy pcapy && \
    # Install RDP
    pip install rdpy && \
    # Cleanup build by removing build tools
    apk del --no-network .build-deps && \
    rm -rf /var/cache/apk/* /root/.cache/


COPY conf/opencanary.conf /root/.opencanary.conf
COPY scripts/daemon.sh /opt/opencanary/scripts/daemon.sh

RUN chmod +x /opt/opencanary/scripts/daemon.sh

CMD [ "/opt/opencanary/scripts/daemon.sh" ]
