data {
  int<lower=0> N;               // liczba obserwacji
  int<lower=0> K;               // liczba cech
  matrix[N, K] X;               // macierz cech
  int<lower=1> G;               // liczba grup
  array[N] int<lower=1, upper=G> group_id;  // przypisanie do grup
}

generated quantities {
  real mu_alpha = normal_rng(0, 5);
  real sigma_alpha = exponential_rng(1);
  vector[G] alpha_group;
  vector[K] beta;

  for (g in 1:G)
    alpha_group[g] = normal_rng(mu_alpha, sigma_alpha);

  for (k in 1:K)
    beta[k] = normal_rng(0, 2);

  array[N] int y_sim;

  for (n in 1:N) {
    real logit_p = alpha_group[group_id[n]] + dot_product(row(X, n), beta);
    real p = inv_logit(logit_p);
    y_sim[n] = bernoulli_rng(p);
  }
}
