import os
import numpy as np
import matplotlib.pyplot as plt
## load functions


debug = False


if debug:
    path = os.path.join('..','..','data','4-output','U30','U30_p1.tab')
    path_fig        = os.path.join('..','..','config','template')
else: 
    path_fig = snakemake.output.path_fig
    path = snakemake.input.path

data = np.loadtxt(path,skiprows=7)

print(data.shape)

plt.figure()
plt.plot(data[:,8])
plt.xlabel('Output loc')
plt.ylabel('Wave height')
plt.savefig(path_fig)
