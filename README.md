#code-server Integration with Jupyter Lab

Overview
This document outlines how to integrate code-server with Jupyter Lab using the jupyter-codeserver-proxy extension.

Prerequisites
Docker environment with jupyter/datascience-notebook:latest image.
Root access to install code-server.
Basic familiarity with Docker and Jupyter configuration.


Conclusion
This setup allows seamless integration of code-server within Jupyter Lab




When creating the environment, use the following command:
jupyter lab --allow-root
and arguments:
--NotebookApp.base_url=/${RUNAI_PROJECT}/${RUNAI_JOB_NAME} --NotebookApp.token=''

This allows you to access Vscode within jupyter lab.
