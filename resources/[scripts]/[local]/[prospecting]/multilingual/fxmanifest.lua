name 'Multilingual'
author 'glitchdetector'
contact 'glitchdetector@gmail.com'

fx_version 'adamant'
game 'gta5'

description 'Support for multiple client languages without using RAGE formats'
usage [[
    Check the instructions in the /files/ readme.
    Add the language file as `language_json` and `file` entries
]]

shared_script "@evp/main.lua"
client_script 'scripts/cl_*.lua'
