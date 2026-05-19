// Question 8: Fixed effects model

data {
  int<lower=0> N;            
  vector<lower=0>[N] t;      
  int<lower=1> n_cafes;      
  array[N] int<lower=1, upper=n_cafes> cafe;
}

parameters {
  vector<lower=0>[n_cafes] lambda;
}

model {
  // Fixed effects prior for each cafe-specific mean waiting time
  // Prior mean is 4.4 minutes.
  // Stan uses rate parametrisation, so rate = 1 / 4.4
  lambda ~ exponential(1 / 4.4);

  // Likelihood
  // Model uses scale lambda, but Stan exponential uses rate,
  // so rate = 1 / lambda[cafe[k]]
  for (k in 1:N) {
    t[k] ~ exponential(1 / lambda[cafe[k]]);
  }
}
