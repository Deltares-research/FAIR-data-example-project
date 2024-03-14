import numpy as np
from pathlib import Path, WindowsPath


def read_header(swan_output: str | WindowsPath) -> list:
    """
    Read the header part of a SWAN model output file.

    Parameters
    ----------
    swan_output : str | WindowsPath
        Pathname of the SWAN output file to read the header for.

    Returns
    -------
    list
        List containing the header rows.

    """
    with open(swan_output) as f:
        header = f.readlines()[:7]
    return header


debug = False
if debug:
    project_dir = Path().cwd()
    data_path = project_dir / r'data/4-output/U30/U30_p1.tab'
    output_path = project_dir / r'data/4-output/U30/U30_p1_cleaned.tab'
else:
    data_path = snakemake.input.data_path
    output_path = snakemake.output.data_path

header = read_header(data_path)
data = np.loadtxt(data_path, skiprows=7)
data[data < 0] = np.nan

with open(output_path, 'w') as f:
    for line in header:
        f.write(line)
    np.savetxt(f, data)
