#Change this line with the resolution of your screen:
export DISPLAY_RESOLUTION=1920x1080

docker run -d --name my_tiger_xfce \
                -p 2227:22 \
                -p 5900:5900 \
                -e VNCDISPLAY=${DISPLAY_RESOLUTION} \
                tiger_xfce
