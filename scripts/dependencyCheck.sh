function dependencyCheck {
#    echo >&2
#    echo "Step 1 - Checking dependencies." >&2
#    echo "-------------------------------" >&2
#    echo >&2
#    printf "|----------------------|------|\n" >&2
#    printf "| %-20s |%-6s|\n" "Dependency Check" "Status" >&2
#    printf "|----------------------|------|\n" >&2
    dependencies="docker-compose envsubst jq az gcloud kubectl minikube"
    errlist=""
    for dep in $dependencies
    do
#        printf "| %-20s | " $dep >&2
        check=$(which $dep)"X"
        if [[ $check == "X" ]] 
        then 
            inline_status="fail"; 
            errlist=$errlist" $dep"
        else 
            inline_status="pass"; 
        fi
#        printf "%-4s |\n" $inline_status
    done
#    printf "|-%-20s-|%-6s|\n" "--------------------" "------" >&2
#    echo >&2

    if [[ $errlist"X" == "X" ]]
    then
        return 0
    else
        showError "Warning" 1 "Dependency check failed" "There are dependencies missing: $errlist. These may not be required for your operation, so you can choose to continue."
        if (( $QUIET != 1)) 
        then
            processContinue
            if (( $? != 1 )); then exit 1; fi
        else
            echo "Quiet mode set - Unable to continue. Exiting." >&2
            exit 1
        fi
    fi
}
