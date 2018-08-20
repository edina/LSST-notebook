# LSST DocMaf Docker image, for Jupyterhub

This takes the existing DocMaf Docker image, and makes it available to be run under Jupyterhub.

It is expected that users will need to take this basic image and extensively modify it for their own use:

1. The version numbers for `jupyterhub`, `jupyterlab`, and `notebook` may need to be changed to match your own services
1. You will almost certainly want to add additional python libraries
1. You may need to extend the `jupyter_notebook_config.py`
1. If you use a different base `oboberg/maf` image, expect the `miniconda` path to change.

