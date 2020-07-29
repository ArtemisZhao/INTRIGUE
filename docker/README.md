## Instructions for using Docker image

We provide a docker image that replicates the computational environment for running INTRIGUE analysis. 

To download the image, run

```
docker pull docker pull xqwen/intrigue:latest
```

To start the docker container, run
```
docker run -it intrigue
```

You will be placed in the working directory ``/home/``. The complete github repo is contained in the directory ``/home/INTRIGUE``. To reproduce the analysis results described in the paper, simply go to the sub-directories within ``/home/INTRIGUE/intrigue_paper`` and run
```
make
```
from there. 





