export USERNAME=saul
export CPUS=6.0
export MEMORY=32G
export SSH_PORT=2227
export VNC_PORT=5903
export NAME=rocky9_eda
export PKG=/secondary/opt
#export PROJECTS=/home/saul/projects/projects_docker
export HOME_DIR=/secondary/home_docker_kth

docker run -d --cpus ${CPUS} \
        --memory ${MEMORY} \
        -p $SSH_PORT:22 \
        -p $VNC_PORT:$VNC_PORT \
        --name ${NAME} \
        -v ${PKG}:/opt \
        -v ${HOME_DIR}:/home/${USERNAME} \
        -v /sys:/sys:ro \
        rocky9_eda
        
