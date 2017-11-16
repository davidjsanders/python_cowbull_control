#!/usr/bin/env bash
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

gcloudpath=$(which gcloud)"x"
echo -n "| gcloud cli is installed            | "
if [[ $gcloudpath == "x" ]]
then
    echo " FAIL  |"
    echo ""
    echo "Error; the gcloud CLI (version 2.0+) must be installed. "
    echo "See https://cloud.google.com/sdk/docs/#install_the_latest_cloud_tools_version_cloudsdk_current_version "
    echo ""
    return 1
fi
echo "  ok   |"

echo -n "| private key is available           | "
if [ ! -f ~/.ssh/id_rsa ]
then
    echo " FAIL  |"
    echo ""
    echo "Error; there is no id_rsa private key in the .ssh subdirectory"
    echo "You need to create it. Do the following:"
    echo ""
    echo "1. cd ~/.ssh"
    echo "2. ssh-keygen -b 4096 -t rsa"
    echo ""
    echo "(In step 2, make sure to accept the default id_rsa)"
    echo ""
    return 1
fi
echo "  ok   |"

echo -n "| Check gcloud auth active user set  | "
gcloudauth=$(gcloud auth list --filter=status:ACTIVE --format="value(account)")"x"
if [[ $gcloudauth == "x" ]]
then
    echo " FAIL  |"
    echo ""
    echo "Error; the gcloud SDK is not authorised."
    echo "Please execute 'gcloud auth login ...' before proceeding."
    echo ""
    return 1
fi
echo "  ok   |"

echo -n "| Check project is set in SDK        | "
gcloudproject=$(gcloud config list project --format=flattened)"x"
if [[ $gcloudauth == "x" ]]
then
    echo " FAIL  |"
    echo ""
    echo "Error; the gcloud SDK default project is not set."
    echo "Please execute 'gcloud config set project ...' before proceeding."
    echo ""
    return 1
fi
echo "  ok   |"

echo -n "| Checking ssh is running correctly  | "
sshAgent=$(ps -ef | grep "ssh-agent" | grep -v grep)"x"
if [[ $sshAgent == "x" ]]
then
    echo " FAIL  |"
    echo ""
    echo "Error; ssh is not running. Run the following command before running..."
    echo "eval \$(ssh-agent -s)"
    echo ""
    return 1
fi
echo "  ok   |"

echo "|------------------------------------|--------| "
echo ""
echo ""

