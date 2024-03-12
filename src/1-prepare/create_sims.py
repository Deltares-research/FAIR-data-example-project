import os
import numpy as np
from shutil import copyfile
## load functions
from py_functions import render_template

debug = False


if debug:
    path_sims = os.path.join('..','..','data','4-output')
    path_template = os.path.join('..','..','config','template')
else: 
    path_sims = snakemake.output.path_sims
    path_template = snakemake.input.path_template


print(path_sims)

# =============================================================================
# 1. input
# =============================================================================

## template path


## if file exists overwrite
overwrite            = False

swan_template = 'swan_template_final.swn'

# =============================================================================
# 2. wave conditions
# =============================================================================

## complete range

wind_speed_list           = [30, 20]


# =============================================================================
# 4. create sims
# =============================================================================

string = ''
## template file
template        = os.path.join(path_template,swan_template)



## make combinations
for ii, item in enumerate(wind_speed_list):
    ## get conditions
    wind_speed  = item

    fname = 'U{}'.format(wind_speed)

    
    ## data for template
    data = {'output_path':os.path.dirname(path_sims[ii]),
            'extension':'swn',
            'variant':'A',
            'fname':fname,
            'wind_speed': wind_speed,
            'wind_dir': 180,
            'water_level': 0}
    
    ## skip if file already exists
    if os.path.exists(os.path.join(path_sims[ii], '{}.swn'.format(fname))) and overwrite:
        print('skipped {}'.format(fname))
        continue

    ## render template
    render_template(data,template)
    ## copy swan_run

    copyfile(os.path.join(path_template,'run_SWAN.sh'), os.path.join(os.path.dirname(path_sims[ii]),'run_SWAN.sh'))


        

        

    
    