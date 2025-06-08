data {
  int<lower=1> N;
  int<lower=1> C;
  int<lower=1> D;
  int<lower=1> Y;
  
  array[N] real driver_rating;
  array[N] int<lower=1, upper=C> constructor;
  array[N] int<lower=1, upper=D> driver;
  array[N] int<lower=1, upper=Y> year;
  array[N] int<lower=0, upper=19> position;
}
parameters {
  matrix[Y, C] alpha_constructor_year;
  vector<lower=0>[D] alpha_driver;
}
transformed parameters {
  vector[N] theta;
  
  for (i in 1 : N) {
    theta[i] = inv_logit(alpha_constructor_year[year[i], constructor[i]]
                         - alpha_driver[driver[i]] * driver_rating[i]);
  }
}
model {
  to_vector(alpha_constructor_year) ~ normal(0, 0.9);
  alpha_driver ~ normal(0, 0.9);
  
  position ~ binomial(19, theta);
}
generated quantities {
  vector[N] log_lik;
  vector[N] y_hat;
  
  for (j in 1 : N) {
    log_lik[j] = binomial_lpmf(position[j] | 19, theta[j]);
    y_hat[j] = binomial_rng(19, theta[j]);
  }
}
