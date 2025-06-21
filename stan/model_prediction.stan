data {
  int<lower=0> N; // Number of races
  real driver_rating;
  array[N] real alpha_engine;
  array[N] real alpha_constructor_year;
  array[N] real alpha_driver;
}
generated quantities {
  vector[N] theta;
  
  for (i in 1 : N) {
    theta[i] = inv_logit(alpha_engine[i] + alpha_constructor_year[i]
                         - alpha_driver[i] * driver_rating);
  }
  array[N] real y_hat;
  for (i in 1 : N) 
    y_hat[i] = binomial_rng(19, theta[i]);
}
