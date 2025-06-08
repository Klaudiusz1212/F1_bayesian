data {
    int<lower=1> N;                           // liczba obserwacji
    int<lower=1> C;                           // liczba konstruktorów
    int<lower=1> E;                           // liczba silników
    int<lower=1> D;                           // liczba kierowców             
    int<lower=1> Y;                           // liczba sezonów

    array[N] real driver_rating;   
    array[N] int<lower=1, upper=E> engine;      
    array[N] int<lower=1, upper=C> constructor; 
    array[N] int<lower=1, upper=D> driver;      
    array[N] int<lower=1, upper=Y> year;        
    array[N] int<lower=0, upper=19> position;   
}

parameters {
    vector[E] alpha_engine;
    vector[C] alpha_constructor;                      
    matrix[Y, C] alpha_constructor_year; 
    vector<lower=0>[D] alpha_driver;
}

transformed parameters {
    vector[N] theta;

    for (i in 1:N) {
        theta[i] = inv_logit(
            alpha_engine[engine[i]] +
            alpha_constructor[constructor[i]] +
            alpha_constructor_year[year[i], constructor[i]] -
            alpha_driver[driver[i]] * driver_rating[i]
        );
    }
}

model {
    alpha_engine ~ normal(0, 1);
    alpha_constructor ~ normal(0, 1);
    to_vector(alpha_constructor_year) ~ normal(0, 1); 
    alpha_driver ~ normal(0, 1);

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