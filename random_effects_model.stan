
data {
  int<lower=0> N;
  vector<lower=0>[N] t;
  int<lower=1> n_cafes;
  array[N] int<lower=1, upper=n_cafes> cafe;
}

parameters {
  real<lower=0> alpha;
  real<lower=0> beta;
  vector<lower=0>[n_cafes] lambda;
}

model {
  alpha ~ exponential(1 / 0.7824712);
  beta  ~ exponential(1 / 0.1764025);

  lambda ~ gamma(alpha, beta);

  for (k in 1:N) {
    t[k] ~ exponential(1 / lambda[cafe[k]]);
  }
}

