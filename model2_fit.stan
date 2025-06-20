data {
  int<lower=0> N;
  int<lower=0> K;
  matrix[N, K] X;
  array[N] int<lower=0, upper=1> y;
  int<lower=1> G;
  array[N] int<lower=1, upper=G> group_id;
}
parameters {
  vector[K] beta;
  real mu_alpha;
  real<lower=0> sigma_alpha;
  vector[G] alpha_group;
}
model {
  beta ~ normal(0, 2);
  mu_alpha ~ normal(0, 5);
  sigma_alpha ~ exponential(1);
  alpha_group ~ normal(mu_alpha, sigma_alpha);

  for (n in 1:N)
    y[n] ~ bernoulli_logit(alpha_group[group_id[n]] + X[n] * beta);
}
generated quantities {
  vector[N] log_lik;
  for (n in 1:N)
    log_lik[n] = bernoulli_logit_lpmf(y[n] | alpha_group[group_id[n]] + dot_product(X[n], beta));
}
