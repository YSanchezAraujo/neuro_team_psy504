model = '''
data{
    int<lower=1> D; // num predictors
    int<lower=0> N; // num samples
    int<lower=1> L; // num groups
    int<lower=1> K; // num possible outcomes (0,1,2)
    int<lower=0,upper=K-1> y[N]; //targets
    int<lower=1,upper=L> ll[N]; //levels
    row_vector[D] x[N]; //predictors
}
parameters {
    real mu[D]; // population mean for predictor
    real<lower=0> sigma[D]; //population std for predictor
    matrix[D,K] beta[L]; //regression coefficients for each predictor in each level
}
model {
    for (d in 1:D){
        mu[d] ~ normal(0, 100);
        for (l in 1:L)
            beta[l,d] ~ normal(mu[d], sigma[d]);
  }
    for (n in 1:N)
        y[n] ~ categorical(softmax((x[n] * beta[ll[n]])'));
}'''