data {
  int<lower=1> N;
  int<lower=1> C;
  int<lower=1> D;
  
  array[N] real driver_rating;
  array[N] int<lower=1, upper=C> constructor;
  array[N] int<lower=1, upper=D> driver;
  array[N] int<lower=0, upper=19> position;
}
parameters {
  vector[C] alpha_constructor;
  vector<lower=0>[D] alpha_driver;
  real alpha_intercept;
}
transformed parameters {
  vector[N] theta;
  
  for (i in 1 : N) {
    theta[i] = inv_logit(alpha_intercept + alpha_constructor[constructor[i]]
                         + alpha_driver[driver[i]] * driver_rating[i]);
  }
}
model {
  alpha_constructor ~ normal(0, 1);
  alpha_driver ~ normal(0, 1);
  alpha_intercept ~ normal(0, 1);
  
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
