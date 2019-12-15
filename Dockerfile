FROM codercom/code-server:latest

# vscode extensions
RUN code-server --install-extension ms-python.python && \
    code-server --install-extension njpwerner.autodocstring

# ubuntu package installations (e.g. Python)
RUN sudo -E apt-get update && sudo -E apt-get install -y \
    python3.7 \
    python3-pip \
 && sudo rm -rf /var/lib/apt/lists/*

# python requirements
COPY requirements.txt /home/coder/
RUN python3.7 -m pip install --no-cache-dir -r ~/requirements.txt
ENTRYPOINT ["code-server"]
