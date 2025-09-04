FROM jupyter/base-notebook

USER root

# Instalar Docker CLI
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-20.10.9.tgz | \
  tar -xz -C /tmp && \
  mv /tmp/docker/docker /usr/local/bin/ && \
  rm -rf /tmp/docker && \
  pip install docker

# Configurar permissões
RUN chown -R jovyan:users /home/jovyan

USER jovyan

WORKDIR /home/jovyan/work
