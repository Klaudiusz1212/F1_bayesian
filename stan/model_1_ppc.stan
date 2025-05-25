data {
     real sigma;              // prior std
}

generated quantities {
    real avg_pos;            // prior for average position
    real drive_rating;       // prior for driver rating

    avg_pos = 0.5;           // standard (0,1) scale
    drive_rating = 0;        // standard 0 mean and 1 std

    real engine = normal_rng(0, sigma);
    real constructor = normal_rng(0, sigma);
    real alpha_driver = normal_rng(0, sigma);
    real beta_avg_drive = normal_rng(0, sigma);

    real theta = inv_logit(
        engine + constructor -
        alpha_driver * drive_rating +
        beta_avg_drive * avg_pos
    );

    int y_ppc = binomial_rng(19, theta);
}