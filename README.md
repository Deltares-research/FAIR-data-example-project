# Demo project FAIR-data
This is a dummy project to demonstrate the Deltares [FAIR-data Cookbook](https://publicwiki.deltares.nl/display/FAIR/Checklist+Reproducible+Numerical+Modelling). Note that it is a dummy project, so no realistic calculations are performed. [More information about the FAIR cookbook is available at the Deltares wiki](https://publicwiki.deltares.nl/display/FAIR/Checklist+Reproducible+Numerical+Modelling). This dummy project is meant to get a basic understanding and working knowledge of version control for scripts and data, workflow management and sensible folder structure. For this we use GIT, DVC, Snakemake and Cookiecutter. More information and instructions can be found in [Deltares documentation](https://deltares.github.io/iMOD-Documentation\practical_git_dvc.html) and other online sources, but for the practical example the instructions below will suffice.


## Version control and retrieving the repository
GIT is used as version control system for the scripts.

First, if you do not have git already installed:
- Download and install git: https://git-scm.com/download/win

Then: 
Open *Windows Powershell*

To get a clone of the repository use the following command in powershell:

```powershell
git clone https://github.com/Deltares-research/FAIR-data-example-project.git
```

> [!NOTE]
>
> Probably the first time you try a powershell command, it will throw you an
> error about execution policies or not being able to run a script. In this case
> use the command:
> 
> ``Set-ExecutionPolicy RemoteSigned -Scope CurrentUser``

## Scripting environment
To be able to run this dummy project Python is required, in this case we use [pixi](https://prefix.dev/) to install a Python environment and all the required dependencies.

Download & install pixi with the command *in Windows Powershell*:

```powershell
iwr -useb https://pixi.sh/install.ps1 | iex
```

Change directory (cd in short) in windows powershell with:

```powershell
cd FAIR-data-example-project
```

Install the python environment:

```powershell
pixi install
```

## Data version control
Dcv is used as a data version control system for the data that is required for this dummy project. This provides Git-like data version control to keep track of changes in data and to share data with colleagues.

## Manage the worklow
Snakemake is used to manage the workflow. These are managed in a single [snakefile](Snakefile)
Individual steps (e.g. script/shell command) are added as Snakemake *"rules"*. Each rule defines which input and output is required and generated in each step. Based on this snakemake determines the order in which multiple rules need to be executed.  


## Folder structure of the project
Cookiecutter is used to create a standardized template for a folder structure for projects. Below is an example of such a template created using Cookiecutter:
    
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


## Explanation of the project
In this dummy project some very basic calculations are done using the SWAN wave model. For a more detailed explanation, read [TECHNICAL.md](/TECHNICAL.md).

# Pizza course exercises
This pizza course consists of two exercises. This repository contains the first
exercise, where you will reproduce an existing example project. [You can find
the first excercise here.](/EXERCISE.md)

The second exercise is contained in a different Github repository. This exercise
will walk you through the steps to upgrade your project from a set of scripts to
a fully reproducible workflow. [You can find it
here](https://github.com/Deltares-research/FAIR-data-reproducible-project-from-scratch).
