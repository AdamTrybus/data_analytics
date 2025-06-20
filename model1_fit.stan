data {
  int<lower=0> N;               // liczba obserwacji
  int<lower=0> K;               // liczba cech
  matrix[N, K] X;               // macierz cech
  array[N] int<lower=0, upper=1> y;    // etykiety (default / no-default)
}

parameters {
  vector[K] beta;               // współczynniki regresji
  real alpha;                   // wyraz wolny
}

model {
  beta ~ normal(0, 2);
  alpha ~ normal(0, 5);

  y ~ bernoulli_logit(alpha + X * beta);
}
