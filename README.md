
# Purpose

This tool is to generate and stitch together the static data for Eve Echoes, into something more usable for third party developers.

# Generating data-dump

This is based off the work done here: https://github.com/xforce/eve-echoes-tools

Place the latest XAPK in the data-dump folder and run the following command in the root folder to generate the data in the expected location:

`docker run -v$(pwd):/data cookiemagic/evee-tools dump_static /data/data-dump/eve.xapk /data/data-dump`