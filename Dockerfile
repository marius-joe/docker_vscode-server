FROM codercom/code-server:latest

# vscode extensions
RUN code-server --install-extension ms-python.python

# ubuntu package installations (e.g. Python)
RUN sudo -E apt-get update && sudo -E apt-get install -y \
    python3.7 \
    python3-pip \
 && sudo rm -rf /var/lib/apt/lists/*

# python requirements
COPY python/packages.txt /home/coder/python/
RUN python3.7 -m pip install --no-cache-dir -r ~/python/packages.txt
ENTRYPOINT ["code-server"]
