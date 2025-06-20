data {
  int<lower=0> N;
  int<lower=0> K;
  matrix[N, K] X;
}

generated quantities {
  real alpha = normal_rng(0, 5);
  vector[K] beta;

  for (i in 1:K)
    beta[i] = normal_rng(0, 2);

  array[N] int y_sim;

  for (i in 1:N) {
    real logit_p = alpha + dot_product(row(X, i), beta);
    real p = inv_logit(logit_p);
    y_sim[i] = bernoulli_rng(p);
  }
}
