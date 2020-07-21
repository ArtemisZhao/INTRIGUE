## R package install guidance
```{r}
library(devtools)
install_github("ArtemisZhao/INTRIGUE/R_src")
```

```{r}
library(INTRIGUE)
```

## Example dataset
```{r}
data("heterodata")
```

This is a simulation dataset, containing n=5000 units and m=2 replicates. The true overall proportion for the null, the reproducible and the irreproducible signal group is 0.80, 0.18, 0.02, respectively.

## CEFN prior
```{r}
##for convenience, only test on first 100 units 
hetero.out.cefn<-hetero(heterodata[1:100,],fdr.level=0.05)
```

## META prior
```{r}
hetero.out.meta<-hetero(heterodata[1:100,],use_cefn=FALSE,fdr.level=0.05)
```
## Outcome
```{r}
names(hetero.out.cefn)

## overall proportion
print(hetero.out$est_prop)
```

Return a list containing the following,

1. gridweight: estimated weight on each grid point.

2. ind_prob: individual probability of falling into three groups.

3. est_prop: estimated overall proportion for three groups.

4. lfdr: false discovery rate.

5. significant: decision based on the fdr.level in the input.



