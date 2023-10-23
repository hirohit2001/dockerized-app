#!/bin/bash

/c/Program\ Files/Docker/Docker/Docker\ Desktop.exe stop

# terminate docker-desktop distro
nohup wsl -t docker-desktop &

# terminate docker-desktop-data distro
nohup wsl -t docker-desktop-data &

# terminate wsl
nohup wsl --shutdown
