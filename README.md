This is the code for the paper "Simultaneous selection and inference for varying coefficients with zero regions: a soft-thresholding approach".

Citation: Yang, Y., Pan, Z., Kang, J., Brummett, C. & Li, Y. (2023) Simultaneous selection and inference for varying coefficients with zero regions: a soft-thresholding approach. *Biometrics*, 00, 1–14. https://doi.org/10.1111/biom.13900

Main script:

Follow "STV_example.R" to implement STV method.

Step 1. Load packages and functions. Paths need to be modified.
Step 2. Simulation. An example for setting is provided; here, beta_1 is designed to have two turning points.
Step 3. Estimation. Examples for estumation using STV method, finding turning points, and bootstrapping are given. Note that the bootstrapping step may be time-consuming.
Step 4. Evaluation. We provide two datasets as the required inputs and then an example about bootstrap-based confidence intervals is shown here.

Additional files:
"STV_updated.R" contains functions in need to simulate data, estimate parameters, and evaluate results.
"STV_linear_cpp.cpp" contains functions in need to be used with "STV_updated.R".
"STV_example.Rmd" is a R Markdown version of "STV_example.R".
"STV_example.html" is the HTML document created by "STV_example.Rmd".
"wd_btsp_example.RData" and "wd_ori_example.RData" contain the example dataset as the required inputs for bootstrap-based confidence intervals
