
data {
    int <lower = 1> N;
    int <lower = 1> P;
    matrix[N, P] X;
    vector[N] y;
}

parameters {
    real alpha;
    vector[P] beta;
    real <lower = 0> sigma; 
}

model {
    y ~ normal(alpha + X * beta , sigma);
}
