### Load packages and functions

library(Rcpp)
library(MASS)
library(mvtnorm)
library(splines2)
library(crs)
library(sfsmisc)
library(splines)
library(bsplinePsd)
library(ggplot2)

source("STV_updated.R")
Rcpp::sourceCpp('STV_linear_cpp.cpp')

### Simulation

# Setting

n = 200 # sample size
p = 3 # number of covariates
max_time = 3 # maximum of index variable [0,max_time]
err_sd_ratio =  0.1 # noise to effect ratio is 0.1

# functions for betas 
f1<-function(x){
  (4*(x-1.5)^2-1)*(x <=1 | x >= 2)
}
f1 =  Vectorize(f1)

f2<-function(x){
  2*log(x+0.01)*(x>=1)
}
f2 = Vectorize(f2)

f3<-function(x){
  (-6/(x+1)+2)*(x<=2)
}
f3 = Vectorize(f3)

f_list = list(f1,f2,f3)
f_pos = 1:length(f_list)#sample(1:p, size = length(f_list))
tau = 0.01 #paramter in the smooth approximation of threshold operator.


n_grid = 100 #number of grid points
w_grid = seq(0,3,length.out = n_grid)

# STV simulation result
sim.data = STV_linear_simulation(n, p, max_time = 3, err_sd_ratio = 0.2, f_list, f_pos, seed = 12, cov_type = "AR1",z_rho = 0.5, sigma=1)

### Estimation

z = sim.data$z
y = sim.data$y
w = sim.data$w

stv.fit = SoftThreshVarying(z, y, w, rho=NULL, n_folds=5, w_grid=NULL)

#### Find turning points

work.ds = cbind.data.frame(i=1:n, beta = stv.fit$beta[ ,1], w = w)
w1_left = work.ds[get_w1_idx_left(num = n, df = work.ds),]$w # left turning point
w1_right = work.ds[get_w1_idx_right(num = n, df = work.ds),]$w # right turning point

#### Bootstrapping

n.btsp = 200

stv.fit.btsp = get_btsp_res(sim_data = sim.data, n_btsp = n.btsp)
prep.data = stv.fit.btsp$result1 # two turning points are designed for beta1

#### Preparation for bootstrap-based confidence intervals

calc_w1(prep_data = prep.data, q_left = 0.1, q_right = 0.9, n_btsp = n.btsp, n = n)

### Evaluation

load("wd_ori_example.RData")
load("wd_btsp_example.RData")

calc_btspCI(wd_ori = wd.ori, wd_btsp = wd.btsp, true_left = 1, true_right = 2)

