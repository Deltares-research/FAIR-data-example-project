#!/bin/sh


#$ -cwd



module load swan/41.31A.1_intel18.0.3
swan_omp_exe=swan_4131A_1_del_l64_i18_omp.exe

export OMP_NUM_THREADS=4

### Some general information available via SGE.
echo ----------------------------------------------------------------------
echo Run of
echo $swan_omp_exe
echo with OpenMP on linux-cluster.
echo SGE_O_WORKDIR : $SGE_O_WORKDIR
echo HOSTNAME : $HOSTNAME
echo OMP_NUM_THREADS : $OMP_NUM_THREADS
echo ----------------------------------------------------------------------

### General, start SWAN.
cp "$1".swn INPUT

$swan_omp_exe
rm swaninit

cp PRINT "$1".prt 
###rm PRINT 
