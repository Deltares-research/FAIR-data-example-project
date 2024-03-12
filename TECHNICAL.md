# SWAN wave model

This document provides background on the (dummy) calculations which are done as part of the FAIR-data-example-project. The workflow consists of a few steps which include a calculation with the SWAN wave model for a lake, the Volkerak Zoommeer, in the Netherlands (see Figure below). SWAN is a model which can compute wave properties (e.g. wave height) for a sea or a lake. It requires a wind field as an input and computes to wave properties. To do this it requires a grid an output location for which the output is given.

![Domain of model for Volkerak Zoommeer](/docs/volkerak.png)


# FAIR-data-example-project
In the example in this project we do two calculations with different constant wind speeds (20 and 30 m/s) and compute the resulting wave properties. Please note that this is a highly simplified model. For this, the following steps are added to the snakefile:

1. Prepare output location (*rule*: locations)
    - *Python script*: [create_output_locations.py](/src/1-prepare/create_output_locations.py)
2. Prepare grid (*rule*: grid)
    - *Python script*: [create_grid.py](/src/1-prepare/create_grid.py)
3. Setup input files for all the wind conditions (*rule*: create_sims)
    - *Python script*: [create_sims.py](/src/1-prepare/create_sims.py)
4. Compute calculations for all the wind conditions (*rule*: run)
5. Plot the results of all the wind conditions (*rule*: analyse)
    - *Python script*: [create_grid.py](/src/4-analyse/analyse.py)

In every step a specific task of the workflow is executed when the previous step is successfully finished. For example, it is not possible to start a calculation when the grid files are not prepared. The snakefile includes a list of wind speeds for which the computations are performed. This means that some steps of the snakefile needs to be executed for all wind speeds. A complete overview of the workflow is shown in the Figure below.

![Overview of the workflow steps in the example project](/docs/workflow.png)

Now we can try if we can run the project and do a small exercise with it. The steps to follow can be found in [EXERCISE.md](/EXERCISE.md).

# Bonus information:
### Running snakemake locally and on the h6 cluster

It is possible to run a workflow locally and on the H6 cluster. This can be achieved by specifying in the snakefile whether to run on Windows (`win=True`) or on Linux (`win=False`).

To run this demo project locally run (`win=True`):

```powershell
snakemake -c1
```
Snakemake by default looks for a snakefile in the directory. It is also possible to specify the name of a snakefile to run:

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


### Using a standard folder structure
In Deltares or with colleagues who are familiar, some standardized project templates may already be available. An example of of such a template is available from our Groundwater management department. This template can be created by:

```powershell
cookiecutter gl:deltares/imod/cookiecutter-reproducible-project
```