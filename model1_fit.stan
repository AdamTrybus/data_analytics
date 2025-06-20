data {
  int<lower=0> N;
  int<lower=0> K;
  matrix[N, K] X;
  array[N] int<lower=0, upper=1> y;
}
parameters {
  vector[K] beta;
  real alpha;
}
model {
  beta ~ normal(0, 2);
  alpha ~ normal(0, 5);
  y ~ bernoulli_logit(alpha + X * beta);
}
generated quantities {
  vector[N] log_lik;
  for (n in 1:N)
    log_lik[n] = bernoulli_logit_lpmf(y[n] | alpha + dot_product(X[n], beta));
}
