let g:clap_layout = {
    \ 'width': '80%',
    \ 'height': '80%',
    \ 'row': '5%',
    \ 'col': '10%' }

let g:clap_selected_sign = { 'text': '→ ', 'texthl': 'WarningMsg', 'linehl': 'ClapSelected' }
let g:clap_forerunner_status_sign = { 'running': '  ', 'done': '→ ' }
let g:clap_spinner_frames = [' ', ' ']
let g:clap_prompt_format = '%forerunner_status%%provider_id%: '
