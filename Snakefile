import os

####SETTINGS####

localrules: create_sims, grid, locations # these rules are not submitted


wind_speed_list           = [30, 20]


####End result####

rule all:
    input:
        output_bot=os.path.join('data','3-input','vzm-j19_6-v1a_20m.bot'),
        output_fxw=os.path.join('data','3-input','vzm-j19_6-v1a_20m.fxw'),
        output_p1=os.path.join('data','3-input','p1.xyn'),
        output_p2=os.path.join('data','3-input','p2.xyn'),
        path_sims=expand("data/4-output/U{wind_speed}/U{wind_speed}.swn",  wind_speed=wind_speed_list),
        res=expand("data/4-output/U{wind_speed}/U{wind_speed}_p1.tab",  wind_speed=wind_speed_list)

rule run:
    output:
        res="data/4-output/U{wind_speed}/U{wind_speed}_p1.tab"
    shell: "data/4-output/U{wildcards.wind_speed}/swan4131A1c7.sh U{wildcards.wind_speed}"

rule create_sims:
    input:
        bot=os.path.join('data','3-input','vzm-j19_6-v1a_20m.bot'),
        p1=os.path.join('data','3-input','p1.xyn'),
        path_template = os.path.join('config','template')
    output:
        path_sims=expand("data/4-output/U{wind_speed}/U{wind_speed}.swn",  wind_speed=wind_speed_list)
    group:
        "wind_speed_list"
    script:
        os.path.join('src','1-prepare','create_sims.py')



rule grid:
    input:
        path_bot=os.path.join('data','1-external','vzm-j19_6-v1a_20m.bot'),
        path_fxw=os.path.join('data','1-external','vzm-j19_6-v1a_20m.fxw'),
    output:
        output_bot=os.path.join('data','3-input','vzm-j19_6-v1a_20m.bot'),
        output_fxw=os.path.join('data','3-input','vzm-j19_6-v1a_20m.fxw'),
    script:
        os.path.join('src','1-prepare','create_grid.py')


rule locations:
    input:
        path_p1=os.path.join('data','1-external','p1.xyn'),
        path_p2=os.path.join('data','1-external','p2.xyn'),
    output:
        output_p1=os.path.join('data','3-input','p1.xyn'),
        output_p2=os.path.join('data','3-input','p2.xyn'),
    script:
        os.path.join('src','1-prepare','create_output_locations.py')
