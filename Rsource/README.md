# INTRIGUE: Quantify and Control Reproducibility In high-throughput Experiments - R

## R package install guidance
```{r}
library(devtools)
install_github("ArtemisZhao/INTRIGUE")
library(INTRIGUE)
```

## Examples in R
```{r}
data("heterodata")

## CEFN prior
hetero.out<-hetero(heterodata[1:100,],fdr.level=0.05)

## META prior
hetero.out.meta<-hetero(heterodata[1:100,],use_cefn=FALSE,fdr.level=0.05)

## results name
names(hetero.out)

## overall proportion
print(hetero.out$est_prop)
```

