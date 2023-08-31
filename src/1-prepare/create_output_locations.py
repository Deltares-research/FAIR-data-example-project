import os
import shutil

debug = False


if debug:
    path_p1 = os.path.join('..','..','data','1-external','p1.xyn')
    path_p2 = os.path.join('..','..','data','1-external','p2.xyn')
    output_p1 = os.path.join('..','..','data','3-input','p1.xyn')
    output_p2 = os.path.join('..','..','data','3-input','p2.xyn')
else: 
    path_p1 = snakemake.input.path_p1
    path_p2 = snakemake.input.path_p2
    output_p1 = snakemake.output.output_p1
    output_p2 = snakemake.output.output_p2



print('copy from:')
print(path_p1)
print('copy to:')
print(output_p1)


shutil.copyfile(path_p1, output_p1)
shutil.copyfile(path_p2, output_p2)