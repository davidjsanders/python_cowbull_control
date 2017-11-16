function processContinue {
    # Return:
    # 
    # 0 - Cancel processing (default)
    # 1 - Continue processing
    #
    user_choice=0
    read -p "Continue (y for yes, anything else to quit)? " -n 1 -r
    echo "" >&2

    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo >&2
        user_choice=1
    fi

    return $user_choice
}