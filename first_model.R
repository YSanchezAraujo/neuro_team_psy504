library("rstan")

work_dir <- "/Users/yoelsanchezaraujo/Desktop/regressionclass/neuro_team_psy504/"
setwd(work_dir)

# load in cars dataset, there's now an object called mtcars as a dataframe I think?
data("mtcars")

# mpg = miles per gallon, I guess this is our response variable?

# list the files in the current directory
files_here <- list.files()

# there's probably a better way to do this, this should give the file name 
# for the model if it was indeed written to the directory
mtcars_model <- files_here[match("mtcars_model.stan", files_here)]

# column names for all other features of mtcars
predictor_names <- colnames(mtcars)[2:length(colnames(mtcars))]

# number of samples
N <- dim(mtcars)[1]
P <- dim(mtcars)[2] - 1
# create a data object for stan
mtcar_data <- list(N=N, P=P, y=mtcars$mpg, X=mtcars[predictor_names])

# hopefully this works?
model_fit <- stan(mtcars_model, model_name="mtcarmodel", data=mtcar_data, )
posterior <- extract(model_fit)

mean_alpha <- mean(posterior$alpha)
# for each feature make a plot
iterations <- dim(posterior$alpha)
for (col_idx in 2:P) {
    jpeg(file = paste("postPlot", col_idx, sep="_"))
    plot(mtcars$mpg)
    abline(mean_alpha, mean(posterior$beta[, col_idx]), col=6, lw=2)
    dev.off()
}

