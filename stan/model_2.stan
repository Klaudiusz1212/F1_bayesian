data {
    int<lower=1> N;                           // num of observations
    int<lower=1> C;                           // num of unique constructors
    int<lower=1> E;                           // num of unique engine
    int<lower=1> D;                           // num of unique driver             
    int<lower=1> Y;                           // num of year  

    array [N] real driver_rating;   
    array[N] int<lower=1, upper=E> engine;      // engine indices list
    array[N] int<lower=1, upper=C> constructor; // constructors indices list
    array[N] int<lower=1, upper=D> driver;      // driver indices list
    array[N] int<lower=1, upper=Y> year;        // driver indices list
    array[N] int<lower=0, upper=19> position;   // race position     
}

parameters {
    vector[E] alpha_engine;
    vector[C] alpha_constructor;
    vector<lower=0>[D] alpha_driver;
    vector[Y] alpha_year;
}


transformed parameters {
    vector[N] theta;

    for (i in 1:N)
        theta[i] = inv_logit(alpha_engine[engine[i]] + alpha_constructor[constructor[i]] - alpha_driver[driver[i]] * driver_rating[i] + alpha_year[year[i]]);
}

model {
    alpha_engine ~ normal(0, 0.8);
    alpha_constructor ~ normal(0, 0.8);
    
    alpha_driver ~ normal(0, 0.8);
    alpha_year ~ normal(0, 0.8);

    position ~ binomial(19, theta);
}

generated quantities {
    vector[N] log_lik;
    vector[N] y_hat;
    for (j in 1:N) {
        log_lik[j] = binomial_lpmf(position[j] | 19, theta[j]);
        y_hat[j] = binomial_rng(19, theta[j]);
    }   
}