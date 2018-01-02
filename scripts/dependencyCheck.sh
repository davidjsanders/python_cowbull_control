function dependencyCheck {
    dependencies="docker-compose jq az gcloud kubectl minikube"
    reqd_dependencies="envsubst"
    errlist=""
    warnlist=""

    echo >&2
    echo "Checking suggested dependencies." >&2
    echo >&2
    printf "|----------------------|------|\n" >&2
    printf "| %-20s |%-6s|\n" "Dependency Check" "Status" >&2
    printf "|----------------------|------|\n" >&2

    for dep in $dependencies
    do
        printf "| %-20s | " $dep >&2

        check=$(which $dep)"X"
        if [[ $check == "X" ]] 
        then 
            inline_status="  no  "; 
            warnlist=$errlist" $dep"
        else 
            inline_status="pass"; 
        fi

        printf "%-4s |\n" $inline_status
    done
    printf "|----------------------|------|\n" >&2

    echo >&2
    echo "Checking mandatory dependencies." >&2
    echo >&2
    printf "|----------------------|------|\n" >&2
    printf "| %-20s |%-6s|\n" "Dependency Check" "Status" >&2
    printf "|----------------------|------|\n" >&2

    for dep in $reqd_dependencies
    do
        printf "| %-20s | " $dep >&2
        check=$(which $dep)"X"
        if [[ $check == "X" ]]
        then
            inline_status="  no  ";
            errlist=$errlist" $dep"
        else
            inline_status="pass";
        fi

        printf "%-4s |\n" $inline_status
    done
    printf "|----------------------|------|\n\n" >&2

    if [[ $errlist"X" == "X" ]]
    then
        echo "All dependencies passed" >&2
        echo "" >&2
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
