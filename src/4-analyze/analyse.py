import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

## load functions


debug = False


if debug:
    project_dir = Path().cwd()
    path = project_dir/r'data/4-output/U30/U30_p1.tab'
    path_fig = project_dir/r'config/template'
else:
    path_fig = snakemake.output.path_fig
    path = snakemake.input.path

data = np.loadtxt(path, skiprows=7)

wave_height = data[:, 8]
wave_height[wave_height < 0] = 0

print(data.shape)

plt.figure()
plt.plot(wave_height)
plt.xlabel('Output location')
plt.ylabel('Wave height [cm]')
plt.savefig(path_fig)
