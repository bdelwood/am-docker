# am-docker
A Dockerized version of [am](https://lweb.cfa.harvard.edu/~spaine/am/download/src/).

You can run it with 
```
docker run -it --rm ghcr.io/bdelwood/am
```
Or with singularity
```
singularity pull am.sif docker://ghcr.io/bdelwood/am
singularity run am.sif
```

If you want to build it locally, 
```
git clone https://github.com/bdelwood/am-docker && cd am-docker
docker build -t local/am .
```


# License
`am`'s license is [here](https://lweb.cfa.harvard.edu/~spaine/am/download/src/LICENSE).

Everything else in this repo is under the MIT license. 
