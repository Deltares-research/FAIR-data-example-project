from mako.template import Template
import os

def render_template(data,template):
    '''
    Render template
    input:
        data: dictionary with variables to render
        template: template file
    '''
    with open(template) as f:
        template = f.read()
    ##
    tmpl = Template(text=template)

    with open(os.path.join(data['output_path'], '{}.{}'.format(data['fname'],data['extension']) ),mode='w') as f:
        f.write(tmpl.render(**data))

