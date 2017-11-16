#!/usr/bin/env bash
echo >&2
echo "Validating Minikube environment" >&2
echo "-------------------------------" >&2
echo >&2

echo "|------------------------------------|--------| "
echo "| Validation step                    | Status |"
echo "|------------------------------------|--------| "

# Check variables are defined
echo -n "| Variables have been defined okay   | "
if [[ $GROUP"X" == "X"  ]];
then
    echo " FAIL  |"
    echo
    echo "Error; the variables are not set. This script must ONLY be called"
    echo "       using the deploy script. Please run deploy in the root of"
    echo "       the python_cowbull_control installation directory." 
    echo
    return 1
fi
echo "  ok   |"

gcloudpath=$(which minikube)"x"
echo -n "| Minikube is installed              | "
if [[ $gcloudpath == "x" ]]
then
    echo " FAIL  |"
    echo ""
    echo "Error; minikube must be installed. "
    echo "See https://kubernetes.io/docs/tasks/tools/install-minikube/"
    echo ""
    return 1
fi
echo "  ok   |"

echo -n "| Minikube current status            |"
minikubeStatus=$(minikube status --format "{{.MinikubeStatus}}" | tr [A-Z] [a-z])
if [[ $minikubeStatus == "running" ]]
then
    echo "running |"
else
    echo "stopped |"
fi

echo "|------------------------------------|--------| "
echo ""
echo ""
echo "Configuration will be set as follows:"
echo "-------------------------------------"
echo ""
echo "Minikube RAM  :   "$MINIRAM
echo "Minikube CPUs :   "$MINICPU
echo ""
