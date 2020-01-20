## Compile

The compiling of the C++ source code requires GNU [GSL library](https://www.gnu.org/software/gsl/) (including the CBLAS library). Make sure these required libraries are properly installed before the compiling.    

To compile the source code, simply run 
```
make 
```
Upon successful compiling, the executable ``intrigue`` will be generated. 


## Input data format

INTRIGUE accepts two formats of input in text format. 


### Beta-hat-SE format

This is the default input option assumed by INTRIGUE. The first format uses two numbers for each experimental unit in each experiment, namely (beta-hat, se(beta-hat)). The input for each unit starts with the identifier of the unit and follows by the measurements in each experiments, i.e., for m replication experiments,
```
unit_ID   beta-hat_1 se_1 beta-hat2 se_2 ... beta-hat_m se_m
```

### Z-score format

INTRIGUE also accepts the input where each measurement is characterized by a z-score. This can be viewed as a special case of Beta-hat-SE format, where beta-hat is scaled by the corresponding standard error and the SE for the scaled effect size is always 1. 

An example of z-score format for an experimental unit with m replication experiments is given by 
```
unit_ID z_1 z_2 ... z_m
```


## Usage

The command line syntax to run intrigue is 

```
intrigue -d input_file [--use_cefn | --use_meta] [--zval] [-t EM_converge_thresh] [-prefix output_prefix]
```

The command line options are 

+ ``-d input_file`` (required): this is the only required command line option (without proper specification, INTRIGUE will not run). Relative or absolute paths are both acceptable.
+ ``--use_cefn`` (optional): specify the CEFN model as the computational model. Note that CEFN is the default choice if neither ``--use_cefn`` or ``use_meta`` is specified.
+ ``--use_meta`` (optional)``: specify the META model as the computational model. 
+ ``--zval`` (required if the input data are formatted in z-score format): specify the input data are in z-score format
+ ``-t EM_converge_thresh]`` (optional): the increamental threshold of log10 likelihood to terminate EM run. The default is 0.05.
+``-prefix output_prefix`` (optional): the user-specified prefix for the output files.

## Output 

Two output files will be generated from each successful INTRIGUE run: ``intrigue.est`` (which records the proportion estimates) and ``intrigue.pip`` (which records the probability assessment for each experimental unit). In case the command line option ``-prefix output_prefix`` is supplied, the output file names will have the correpsonding prefix names (i.e., ``output_prefix.intrigue.est`` and ``output_prefix.intrigue.pip``).


The format of proportion estimate file is straitfoward: it contains a single line with three annotated proportion estimates.


The individual unit assessment file has the following format: for each experimental unit 

```
unit_ID  null_probability  irreproducible_probability reproducible_probability
```

Note that 1-reproducibile_probability is the correpsonding local fdr of the experimental unit for making a false reproducible discovery, which can be directly used in the formal FDR control procedure.




