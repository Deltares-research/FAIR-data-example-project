# Exercise 1a

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

### Exercise:
Add a Python script to the [snakefile](Snakefile) to produce the plots without the no data values.

# Exercise 1b
