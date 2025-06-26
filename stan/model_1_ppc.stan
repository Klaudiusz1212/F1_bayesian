data {
  real driver_rating;
}
generated quantities {
  real constructor = normal_rng(0, 1);
  real alpha_driver = abs(normal_rng(0, 1));
  real intercept = normal_rng(0, 0.5);
  
  real theta = inv_logit(intercept + constructor + alpha_driver * driver_rating);
  
  int y_ppc = binomial_rng(19, theta);
}
