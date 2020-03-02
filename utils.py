"""
example useage of functions:

# to save results
model = pystan.StanModel(model_code=IBL_code)
fit = sm.sampling(data=IBL_dat, iter=6000, chains=4, thin=10, warmup=1000, control=control, verbose=True)
save_path = save_stan_pkl("model.pkl", fit, model)

# to load up results, assuming you're in the directory the result is in
saved_fit = read_stan_pkl(save_path)
"""


def save_stan_pkl(path, fit, model):
    """
    parameters:
    path::string - a file name string ending in .pkl
    fit::stan_fit_object - the result of running sm.sampling(...)
    model::stan_model_object - the result of running pystan.StanModel(...)

    returns:
    path::string - the string you used in path, (this is used to load up the fit)
    """
    with open("path", "wb") as file_store:
        pickle.dump({"model": model, "fit": fit}, file_store, protocol=-1)
    return path

def read_stan_pkl(path):
    """
    parameters:
    path::string - full path to the saved pickle file,
    example: '/users/yoel/stanmodel.pkl'

    returns:
    stan_model_fit::stan_fit_object
    """
    with open(path, "rb") as file_store:
        data_dict = pickle.load(file_store)
    return data_dict
