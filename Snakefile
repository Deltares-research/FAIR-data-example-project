from pathlib import Path
####SETTINGS####

localrules: create_sims, grid, locations # these rules are not submitted

## TODO this list also in the script create sims. How to access this list in a python script?
wind_speed_list           = [30, 20]

win = True

root = Path(r'.')

####End result####

rule all:
    input:
        path_fig=expand("reports/U{wind_speed}.png",  wind_speed=wind_speed_list),


rule analyse:
    input:
        path="data/4-output/U{wind_speed}/U{wind_speed}_p1_cleaned.tab"
    output:
        path_fig="reports/U{wind_speed}.png"
    script:
        root/r'src/4-analyze/analyse.py'


rule remove_nodata:
    input:
        data_path=root/'data/4-output/U{wind_speed}/U{wind_speed}_p1.tab'
    output:
        data_path=root/'data/4-output/U{wind_speed}/U{wind_speed}_p1_cleaned.tab'
    script:
        root/r'src/4-analyze/remove_nodata.py'


rule run:
    input:
        output_bot=root/r'data/3-input/bed.bot',
        output_p1=root/r'data/3-input/p1.xyn',
        path_sims=expand("data/4-output/U{wind_speed}/U{wind_speed}.swn",  wind_speed=wind_speed_list)
    output:
        res="data/4-output/U{wind_speed}/U{wind_speed}_p1.tab"
    run:
        if not win:
            shell("data/4-output/U{wildcards.wind_speed}/run_SWAN.sh U{wildcards.wind_speed}")
        else:
            shell("cd data/4-output/U{wildcards.wind_speed} && copy U{wildcards.wind_speed}.swn INPUT && call ..\\..\\..\\bin\\swan_4131A_1_del_w64_i18_omp.exe ")


rule create_sims:
    input:
        bot=root/r'data/3-input/bed.bot',
        p1=root/r'data/3-input/p1.xyn',
        path_template = root/r'config/template'
    output:
        path_sims=expand("data/4-output/U{wind_speed}/U{wind_speed}.swn",  wind_speed=wind_speed_list)
    script:
        root/r'src/1-prepare/create_sims.py'


rule grid:
    input:
        path_bot=root/r'data/1-external/bed.bot',
        path_fxw=root/r'data/1-external/obs.fxw',
    output:
        output_bot=root/r'data/3-input/bed.bot',
        output_fxw=root/r'data/3-input/obs.fxw',
    script:
        root/r'src/1-prepare/create_grid.py'


rule locations:
    input:
        path_p1=root/r'data/1-external/p1.xyn',
        path_p2=root/r'data/1-external/p2.xyn',
    output:
        output_p1=root/r'data/3-input/p1.xyn',
        output_p2=root/r'data/3-input/p2.xyn',
    script:
        root/r'src/1-prepare/create_output_locations.py'
