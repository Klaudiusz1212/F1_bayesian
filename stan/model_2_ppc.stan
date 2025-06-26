data {
  real driver_rating; // if high value driver was better
}
generated quantities {
  real engine = normal_rng(0, 1);
  real year_constructor = normal_rng(0, 1);
  real alpha_driver = abs(normal_rng(0, 0.8));
  real intercept = normal_rng(0, 0.5);
  
  real theta = inv_logit(intercept + engine + year_constructor
                         + alpha_driver * driver_rating);
  
  int y_ppc = binomial_rng(19, theta);
}
