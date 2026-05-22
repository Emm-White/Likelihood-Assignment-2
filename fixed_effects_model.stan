
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
  lambda ~ exponential(1 / 4.4);

  for (k in 1:N) {
    t[k] ~ exponential(1 / lambda[cafe[k]]);
  }
}

