# INTRIGUE
## Quantify and Control Reproducibility In high-throughput Experiments
This package proposes an algorithm to quantify and control reproducibility in high-throughput experiments. It estimates the proportions of the null, the reproducible and irreproducible signal groups for the input data set. A Bayes factor calculation and EM (Expectation Maximization) algorithm procedures are included.

## Install Guidance
library(devtools)

install_github("ArtemisZhao/INTRIGUE")

## Examples
```{r}
data("heterodata")
hetero.out<-hetero(heterodata,fdr.level=0.05)
names(hetero.out)
print(hetero.out$est_prop)
```

## References
TBD
