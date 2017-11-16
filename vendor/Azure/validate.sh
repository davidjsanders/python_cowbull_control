#!/usr/bin/env bash
#
# ERROR CHECKING *BEFORE* EXECUTION STARTS
#
#
echo "|------------------------------------|--------| "
echo "| Validate environment               | Status |"
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

azpath=$(which az)"x"
echo -n "| azure cli is installed             | "
if [[ $azpath == "x" ]]
then
    echo " FAIL  |"
    echo ""
    echo "Error; the Azure CLI (version 2.0+) must be installed. "
    echo "See https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latesti "
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

echo -n "| Checking group does not exist      | "

if (( $DRYRUN == 0 ))
then
    groupCheck=$(az group list --query '[?name==`$GROUP`]|[?location==`$LOCATION`].name' --output tsv)"x"
else
    groupCheck="x"
fi

if [[ $groupCheck != "x" ]]
then
    echo " FAIL  |"
    echo ""
    echo "Error; the group ("$GROUP") in location "$LOCATION" already exists!"
    echo "Remove the group before proceeding"
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
    echo "eval "$(ssh-agent -s)""
    echo ""
    return 1
fi
echo "  ok   |"

echo "|------------------------------------|--------| "
echo ""
