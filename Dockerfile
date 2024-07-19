FROM jupyter/datascience-notebook:latest

USER root

# Install code-server
RUN mkdir -p /opt/code-server && \
    cd /opt/code-server && \
    wget -qO- https://github.com/cdr/code-server/releases/download/2.1698/code-server2.1698-vsc1.41.1-linux-x86_64.tar.gz | tar zxvf - --strip-components=1

# Add code-server to PATH
ENV PATH=/opt/code-server:$PATH

# Install jupyter-codeserver-proxy
RUN $CONDA_DIR/bin/pip install --index-url https://test.pypi.org/simple/ \
    --extra-index-url https://pypi.org/simple jupyter-codeserver-proxy==1.0b3

# Set up Jupyter configuration
RUN mkdir -p /home/$NB_USER/.jupyter && \
    echo "c.ServerProxy.servers = { \
        'vscode': { \
            'command': ['code-server', '--auth', 'none', '--disable-telemetry', '--port', '{port}'], \
            'timeout': 20, \
            'launcher_entry': { \
                'title': 'VS Code' \
            } \
        } \
    }" > /home/$NB_USER/.jupyter/jupyter_notebook_config.py

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

# Start Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
