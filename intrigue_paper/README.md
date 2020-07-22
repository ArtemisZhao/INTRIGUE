## Data analysis in INTRIGUE paper

This directory contains the code and necessary data to reproduce the numerical results presented in the paper. Each sub-directory represents a set of analyses. To generate the results, simply go into each directory, and run
```
make
```

For simulations, this will start the process of data generation -> data analysis -> summarizing results. For real data analysis (in ``TWAS``), all necessary real data are included.

In all cases, the intermediate results are saved in the generated ``output`` directory. The final summary of results and pdf plots are saved in the generated ``results`` directory. In a few occasions,the summary may directory output to screen.

To restore the original directory structure before analysis, run
```
make clean
```

### Setup computing environment

The analysis requires the C/C++ implementation of INTRIGUE, a multi-thread batch command tool [``openmp_wrapper``](https://github.com/xqwen/openmp_wrapper), and some relevant R packages from CRAN and bioconductor.

We have created a [docker image](https://hub.docker.com/r/xqwen/intrigue), which has the complete computational environment pre-configured. 


