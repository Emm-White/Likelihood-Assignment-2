//Question 5
// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;            //number of samples 
  vector<lower=0>[N] t;      //vector time in between service
  int<lower=1> n_cafes;      //how many cafes there are in total (15 in this case)
  array[N] int<lower=1, upper=n_cafes> cafe;   //number of visits to each cafe
}




// The parameters accepted by the model. Our model
// 
parameters {
  real<lower=0>alpha;              // alpha for the gamma distribution (for lambda sampling) - rate
  real<lower=0>beta;               // beta for the gamma distribution - shape
  vector<lower=0>[n_cafes] lambda; // lambda for service time at each cafe
}

// The model to be estimated. We model the output
model {
  alpha ~ exponential(1/0.7824712); // priors
  beta  ~ exponential(1 / 0.1764025);
  
  
  lambda ~ gamma(alpha, beta);     // distribution of the lambdas
  
  for( k in 1:N){
  t[k] ~ exponential(1/lambda[cafe[k]]);               // distribution of waiting times
  }
}

