# INTRIGUE: Quantify and Control Reproducibility In high-throughput Experiments

## Description

This repository contains the software implementations for a statistical method to quantify and control reproducibility in high-throughput experiments. This method estimates the proportions of the null, the reproducible and irreproducible signal groups for the input datasets, which is useful to evaluate the overall reproducibilty or heterogeneity for the data. Also, individual probabilities of falling into the three groups are provided and their corresponding rejection decisions according to the user-specified false discovery rate level.

The repository includes source C code, R code, and necessary data to replicate one of the simulation case described in the manuscript. A detailed tutorial to guide the users through some specific analysis tasks is also included.

A Bayes factor calculation and EM (Expectation Maximization) algorithm procedures are included.


## Source code

The computational methods are implemented in R and C/C++.

### R source

Source code for R package ``INTRIGUE`` is included in ``R_src``. To install, run

```{r}
library(devtools)
install_github("ArtemisZhao/INTRIGUE/R_src")
```

### C/C++ Source

C/C++ code for a standalone binary executable is in ``cpp_src``. To compile, run
```
make
```
The command line options for running the binary are described in [here](cpp_src/README.md).


## Simulation and real data analysis 

The necessary code and data for simulation and real data application described in the INTRIGUE paper are included in ``intrigue_paper``. They should enable readers to fully reproduce our results.


## Docker image



## Contributors

- Yi Zhao (University of Michigan)
- Xiaoquan Wen (Univerisity of Michigan)


## Reference and Citation

"INTRIGUE: Quantify and Control Reproducibility in High-throughput Experiments"
