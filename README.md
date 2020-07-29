# INTRIGUE: Quantify and Control Reproducibility In high-throughput Experiments

## Description

This repository contains the software implementations for INTRIGUE, a statistical method to quantify and control reproducibility in high-throughput experiments. The statistical models and the computational procedures are described in [1]. 


The repository includes source code (C/C++ and R) and necessary data/scripts to replicate all the analysis results described in [1]. A docker image that replicate the original computational environment for the analysis is also included.


## License 

Software distributed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. See [LICENSE](http://www.gnu.org/licenses/gpl-3.0.en.html) for more details.



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

We provide a docker image to reproduce all our analysis described in the INTRIGUE paper. The detailed instructions are available in [docker](docker/) directory. 

## Contributors

- Yi Zhao (University of Michigan)
- Xiaoquan Wen (Univerisity of Michigan)


## References and Citations

[1] INTRIGUE: Quantify and Control Reproducibility in High-throughput Experiments. Zhao, Y., Sampson, M., and Wen, X. (2020) \[[preprint](https://bit.ly/2ACrHeJ)\]
