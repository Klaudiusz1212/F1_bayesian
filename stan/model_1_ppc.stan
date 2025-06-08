data {
  real sigma;
  real driver_rating;
}
generated quantities {
  real year_constructor = normal_rng(0, sigma);
  real alpha_driver = abs(normal_rng(0, sigma));
  
  real theta = inv_logit(year_constructor - alpha_driver * driver_rating);
  
  int y_ppc = binomial_rng(19, theta);
}
