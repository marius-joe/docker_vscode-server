FROM codercom/code-server:latest

# ubuntu package installations (e.g. Python)
RUN sudo -E apt-get update && sudo -E apt-get install -y \
    python3.7 \
    python3-pip \
 && sudo rm -rf /var/lib/apt/lists/*

# vscode extensions
RUN code-server --install-extension ms-python.python

# python packages
COPY python/packages.txt /home/coder/python/
RUN python3.7 -m pip install --no-cache-dir -r ~/python/packages.txt
ENTRYPOINT ["code-server"]
