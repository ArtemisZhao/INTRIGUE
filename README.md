# INTRIGUE: Quantify and Control Reproducibility In high-throughput Experiments

## Description

This repository contains the software implementations for a statistical method to quantify and control reproducibility in high-throughput experiments. This method estimates the proportions of the null, the reproducible and irreproducible signal groups for the input datasets, which is useful to evaluate the overall reproducibilty or heterogeneity for the data. Also, individual probabilities of falling into the three groups are provided and their corresponding rejection decisions according to the user-specified false discovery rate level.

The repository includes source C code, R code, and necessary data to replicate one of the simulation case described in the manuscript. A detailed tutorial to guide the users through some specific analysis tasks is also included.

A Bayes factor calculation and EM (Expectation Maximization) algorithm procedures are included.

## Liscense

## Install Guidance
```{r}
library(devtools)
install_github("ArtemisZhao/INTRIGUE")
library(INTRIGUE)
```

## Examples
```{r}
data("heterodata")
hetero.out<-hetero(heterodata[1:100,],fdr.level=0.05)
#hetero.out.meta<-hetero(heterodata[1:100,],use_cefn=FALSE,fdr.level=0.05)

names(hetero.out)
print(hetero.out$est_prop)
```
## Contributors
- Xiaoquan Wen (Univerisity of Michigan)

- Yi Zhao (University of Michigan)

## Reference and Citation

