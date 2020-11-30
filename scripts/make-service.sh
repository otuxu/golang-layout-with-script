#!/bin/sh

# Please insert project name here. (This environment use in container name.)
PROJECT_NAME="hoge" 

# Get the paths.
SCRIPT_DIR=$(cd $(dirname $0); pwd)
PROJECT_DIR=$(cd $(dirname $0)/../; pwd)
COMPOSE_PATH="${PROJECT_DIR}/deployment/docker-compose.yml"

# Specified arguments expression.
if [ $# -ne 2 ]; then
    echo
    echo "Invalid arguments."
    echo "Usage: ./make-service.sh [api-name] [port]"
    echo
    exit 1
fi

# number expression in port argument.
expr "${2} + 1" > /dev/null 2>&1
if [ $? -ge 2 ] && [ ${2} -lt 1 ] && [ ${2} -gt 65535 ] ; then
    echo 
    echo "Invalid argument in port number."
    echo "Please specify the port number between 1 - 65535."
    echo 
    exit 1
fi

# Expression for bind ports on docker.
BIND_PORTS=($(cat ${COMPOSE_PATH} | grep -oE '"[0-9]{1,5}:8080"' | sed -e s/\"//g | sed -e s/:8080// ))
for port in ${BIND_PORTS[@]}
do
    if [ ${2} -eq ${port} ]; then
        echo
        echo "Confict the bind ports on this project."
        echo "Using ports on this project: ${BIND_PORTS[@]}"
        echo
    fi
done

cd ${PROJECT_DIR}

mkdir cmd/${1} internal/${1} pkg/${1} test/${1} api/${1} build/docker/${1}
touch internal/${1}/.gitkeep pkg/${1}/.gitkeep test/${1}/.gitkeep api/${1}/.gitkeep
cp scripts/templates/main.go cmd/${1}

$(cat scripts/templates/Dockerfile | sed -e "s/{SERVICES}/${1}/g" >> build/docker/${1}/Dockerfile)
$(cat scripts/templates/docker-compose.yml | sed -e "s/{SERVICES}/${1}/g" | sed -e "s/{PORTS}/${2}/g" | sed -e "s/{PROJECT_NAME}/${PROJECT_NAME}/g" >> ./deployment/docker-compose.yml)

echo 
echo "Script finished successfully."
echo "Please build & run in this command."
echo "docker-compose -f deployement/docker-compose.yml up -d --build ${1}"
echo
exit 0