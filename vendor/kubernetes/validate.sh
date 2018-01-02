#!/usr/bin/env bash
echo >&2
echo "Validating Kubernetes environment" >&2
echo "---------------------------------" >&2
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

# Check Kubernetes version
echo -n "| Checking Kubernetes version        | "
kubever=$(kubectl version --short=true | grep "Server")
if [[ $GROUP"X" == "X"  ]];
then
    echo " FAIL  |"
    echo
    echo "Error; The kubectl version command did not return correctly!"
    echo
    return 1
fi
echo "  ok   |"
echo "|------------------------------------|--------| "

echo ""
echo ""
echo "Configuration will be set as follows:"
echo "-------------------------------------"
echo ""
echo ""
