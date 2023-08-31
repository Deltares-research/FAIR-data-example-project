Demo project FAIR-data with cluster
==============================


This is a dummy project to demonstrate the Deltares FAIR-data Cookbook. The fours steps, scripting, Folder Structure, version control and Workflow, are included in this exmaple. Note that it is a dummy project. So no realistic calculations are performed.

Both a workflow for the H6 cluster and a workflow to run locally are available.


Scripting
--------------------
To apply the cookbook Python is required. 

To install the required packages a requirements file is pressent. To install the package with pip:

`pip install requirements.txt`

Alternatively, conda can be used:

`conda install --file requirements.txt`

Folder structure of the project
--------------------
The project organization is created with cookiecutter. To create this structure the following command can be executed in Python:

`cookiecutter gl:deltares/imod/cookiecutter-reproducible-project`

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

Version of your code and data
-------------------------------
GIT is used as version control system for the scripts. DVC is applied as version control system for the data.

To get a clone of this repositry use:

`git clone https://github.com/Deltares/FAIR-data-example-project FAIR-data-example-project `

To update the data from the n-drive use:

`dvc pull`


Manage the worklow
--------------------
Snakemake is used to manage the workflow. This example can be executed both on the H6 or locally. In the snakefile it can be specified whether the simulation is perfomred on windows (`win=True`) or Linux (`win=False`).


To run this demo project on the h6 run (`win=False`):

`snakemake --cores 1 --cluster "qsub -q {cluster.q} -N {cluster.N} -M {cluster.M}" --jobs 4 --cluster-config config/cluster.yaml `

The flag `--cluster` specifies the command to sumbit a job to a cluster. 
With the flag `--cluster-config` additional wildcards for the cluster can be set. In this case the queue (q), job name (N) and email (M).
The maximum number of jobs is specified with `--jobs`

Not all rules are submitted to the cluster. The localrules keyword in the snakefile can be used to specify the rules to be executed immediately.
`localrules: create_sims, grid, locations`

To run this demo project locally  run (`win=True`):

`snakemake --cores 1 --snakefile snakefile`
