import scipy.io
import pandas as pd
print("ici")
mat = scipy.io.loadmat('app/python/ecg-sample.mat') 
print('test')
mat = {k:v for k, v in mat.items() if k[0] != '_'}
data = pd.DataFrame({k: pd.Series(v[0]) for k, v in mat.items()})
data.to_csv("test.csv")
