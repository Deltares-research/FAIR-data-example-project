Demo project FAIR-data with cluster
==============================

Description
--------------------
This is a dummy project to demonstrate the Deltares FAIR-data Cookbook.

Both a workflow for the H6 cluster and a workflow to run locally are available.


Scripting
--------------------
To apply the cookbook Python is required. 

To install the required packages the following command can be used:

`pip install requirements.txt`

Snakemake
--------------------

To run this demo project run:
`snakemake --cores 1 --cluster "qsub -q {cluster.q} -N {cluster.N} -M {cluster.M}" --jobs 4 --cluster-config config/cluster.yaml `

The flag `--cluster` specifies the command to sumbit a job to a cluster. 
With the flag `--cluster-config` additional wildcards for the cluster can be set. In this case the queue (q), job name (N) and email (M).
The maximum number of jobs is specified with `--jobs`

Not all rules are submitted to the cluster. The localrules keyword in the snakefile can be used to specify the rules to be executed immediately.
`localrules: create_sims, grid, locations`


