# Exercise 1

To start the project we need to activate the environment in the shell:

```powershell
pixi shell
```

Next, we need to pull the data from the n-drive to store it on your local machine, use:

```powershell
dvc pull
```

Now that we have all the data on our local drive, we can run the entire workflow by using:

```powershell
snakemake -c1
```

This should produce the following plots in the folder [reports](/reports/).

![Resulting Figure of calculations](/docs/U20.png)

Notice that there are many weird horizontal lines at the bottom of the plot which are related to no data values. It would be nice to add a step that gets rid of these to produce a nicer figure.

### *Exercise*:
Add a Python script "remove_nodata.py" to the [snakefile](Snakefile) to produce the plots with the no data values removed. To do this we need several steps:


- Download [remove_nodata.py](https://github.com/Deltares-research/FAIR-data-example-project/blob/exercise/src/4-analyze/remove_nodata.py) to add to the workflow.
- Create a **rule** in the Snakefile (e.g. "remove_nodata") and specify the correct input. We need to remove nodata values in the input for the plots so this is the same input as for the **rule "analyse"**.
- Pay close attention to the names in "remove_nodata.py" and the Snakefile. You can see in "remove_nodata.py" that it uses "snakemake.input.data_path" and "snakemake.output.data_path" so these should be correctly included in your rule.
- In the rule you also specify which script to use and what the output will be (e.g. "U{wind_speed}_p1_cleaned.tab").
- The rule analyse needs to depend on the output of the step you have added instead of the previous input.
- Finally, you can run the Snakefile again and check the updated figures.

> [!TIP]
> If you do not succeed you can see all the changes that were necessary to add the rule to the Snakefile. We have put the solution in a branch (exercise) and created a [pull request](https://github.com/Deltares-research/FAIR-data-example-project/pull/5/files) on the remote repository. Here we compare the changes that have been made to the Snakefile in order to include our new rule in the workflow.


# Exercise 2
For the second exercise we are going to create a reproducible project from scratch using all the tools and knowledge we have seen so far in the presentation and in this demo project. For this, we are going to combine several scripts into a fully functional workflow. The exercise can be found [here](https://github.com/Deltares-research/FAIR-data-reproducible-project-from-scratch).
