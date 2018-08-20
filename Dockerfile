# Copyright (c) EDINA Development Team.
# Distributed under the terms of the Modified BSD License.
# This is a specific python2 kernel.
FROM oboberg/maf:180720

LABEL MAINTAINER="Derived from the Notebook as a Service Project <edina@ed.ac.uk>"

USER root

RUN mkdir /home/jovyan && usermod -d /home/jovyan -l jovyan docmaf && chown jovyan:docmaf /home/jovyan

RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.18.0/tini && \
    echo "12d20136605531b09a2c2dac02ccee85e1b874eb322ef6baf7561cd93f93c855 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

ENV NB_USER=jovyan \
    PATH=/home/docmaf/stack/python/miniconda3-4.5.4/bin:$PATH

USER $NB_USER

RUN conda config --add channels conda-forge && \
    conda install --quiet --yes \
  'jupyterhub=0.9.*' \
  'jupyterlab=0.33.*' \
  'notebook=5.6.*' \
  && conda clean -tipsy

USER root
COPY jupyter/ /etc/jupyter/
ENV JUPYTER_CONFIG_DIR=/etc/jupyter \
    HOME=/home/$NB_USER
RUN chmod a+w /etc/jupyter
COPY usr/local/bin/ /usr/local/bin/

WORKDIR $HOME
USER $NB_USER

EXPOSE 8888
ENTRYPOINT ["tini", "-g", "--", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["start-notebook.sh"]
