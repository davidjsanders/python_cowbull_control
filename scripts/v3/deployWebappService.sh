function deployWebappService {
    echo >&2
    echo -n "Creating webapp service: " >&2
    if (( $DRYRUN != 1 ));
    then
        kubectl expose deployment webapp --type=LoadBalancer $ip_option_args
    else
        echo "" >&2
        echo "kubectl expose deployment webapp --type=LoadBalancer $ip_option_args" >&2
    fi
}
