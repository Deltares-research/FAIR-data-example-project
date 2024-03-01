Demo project FAIR-data with cluster
==============================


This is a dummy project to demonstrate the Deltares FAIR-data Cookbook. Note that it is a dummy project. So no realistic calculations are performed. More information about the FAIR cookbook is available at the Deltares wiki.

Both a workflow for the H6 cluster and a workflow to run locally are available.


Version control, retrieving the repository and scripting environment
--------------------
GIT is used as version control system for the scripts. DVC is applied as version control system for the data.
More information and instructions can be found in [Deltares documentation](https://deltares.github.io/iMOD-Documentation\practical_git_dvc.html) and other online sources, but for the practical example the instructions below will suffice.

First:
- Download and install git: https://git-scm.com/download/win
- Download and install dvc: https://dvc.org/#get-started-dvc

Then: 
Open windows powershell

To get a clone of the repository use the following command in powershell:

```powershell
git clone https://github.com/Deltares-research/FAIR-data-example-project.git
```

To apply the cookbook Python is required, in this case we use [pixi](https://prefix.dev/).

Download & install pixi with the command (in windows powershell):

```powershell
iwr -useb https://pixi.sh/install.ps1 | iex
```

Change directory (cd in short) in windows powershell with:

```powershell
cd FAIR-data-example-project
```

To pull the data from the n-drive to your local machine use:

```powershell
dvc pull
```

Install the python environment:

```powershell
pixi install
```

Next, activate the environment in the shell:

```powershell
pixi shell
```

Manage the worklow
--------------------
Snakemake is used to manage the workflow. This example can be executed both on the H6 cluster or locally. In the snakefile it can be specified whether the simulation is perfomred on windows (`win=True`) or Linux (`win=False`).

To run this demo project locally  run (`win=True`):

```powershell
snakemake --cores 1 --snakefile snakefile
```

To run this demo project on the h6 run (`win=False`):

```powershell
snakemake --cores 1 --cluster "qsub -q {cluster.q} -N {cluster.N} -M {cluster.M}" --jobs 4 --cluster-config config/cluster.yaml
```

The flag `--cluster` specifies the command to sumbit a job to a cluster. 
With the flag `--cluster-config` additional wildcards for the cluster can be set. In this case the queue (q), job name (N) and email (M).
The maximum number of jobs is specified with `--jobs`

Not all rules are submitted to the cluster. The localrules keyword in the snakefile can be used to specify the rules to be executed immediately.
`localrules: create_sims, grid, locations`

Folder structure of the project
--------------------
The project organization was created with cookiecutter. To create this structure yourself for a future project, the following command can be executed in Python:

```powershell
cookiecutter gl:deltares/imod/cookiecutter-reproducible-project
```

This results in the following structure:
    .
    
    ├── AUTHORS.md
    ├── LICENSE
    ├── README.md
    ├── bin                 <- Your compiled model code can be stored here (not tracked by git)
    ├── config              <- Configuration files, e.g., for doxygen or for your model if needed
    ├── data                
    │   ├── 1-external      <- Data external to the project.
    │   ├── 2-interim       <- Intermediate data that has been altered.
    │   ├── 3-input         <- The processed data sets, ready for modeling.
    │   ├── 4-output        <- Data dump from the model.
    │   └── 5-visualization <- Post-processed data, ready for visualisation.
    ├── docs                <- Documentation, e.g., doxygen or scientific papers (not tracked by git)
    ├── notebooks           <- Jupyter notebooks
    ├── reports             <- For a manuscript source, e.g., LaTeX, Markdown, etc., or any project reports
    │   └── figures         <- Figures for the manuscript or reports
    └── src                 <- Source code for this project
        ├── 0-setup         <- Install necessary software, dependencies, pull other git projects, etc.
        ├── 1-prepare       <- Scripts and programs to process data, from 1-external to 2-interim.
        ├── 2-build         <- Scripts to create model specific inputm from 2-interim to 3-input. 
        ├── 3-model         <- Scripts to run model and convert or compress model results, from 3-input to 4-output.
        ├── 4-analyze       <- Scripts to post-process model results, from 4-output to 5-visualization.
        └── 5-visualize     <- Scripts for visualisation of your results, from 5-visualization to ./report/figures.




