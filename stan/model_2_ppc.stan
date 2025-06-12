data {
  real sigma; // prior std
  real driver_rating; // if high value driver was better
}
generated quantities {
  real engine = normal_rng(0, sigma);
  real year_constructor = normal_rng(0, sigma);
  real alpha_driver = abs(normal_rng(0, sigma));
  
  real theta = inv_logit(engine + year_constructor
                         - alpha_driver * driver_rating);
  
  int y_ppc = binomial_rng(19, theta);
}
