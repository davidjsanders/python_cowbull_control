function deployServices {
    if [[ $INGRESS"X" == "X" ]]; then INGRESS=0; fi
    if [[ $MONGODB"X" == "X" ]]; then MONGODB=0; fi
    if [[ $VENDOR_PATH"X" == "X" ]]; then setVendorSpecifics; fi

    echo >&2
    echo "Deploying Python CowBull game configuration, pods, and services" >&2
    echo >&2

    echo "Step 1. Remove any existing deployments, services, and configuration."
    removeK8Scomponents

    deployK8Scomponents

    deployAzureSpecific

    if (( $INGRESS == 1 )); then deployIngress
    else
        echo >&2
        echo -n "Creating webapp service: " >&2
        if (( $DRYRUN != 1 ));
        then
            kubectl expose deployment webapp --type=LoadBalancer $ip_option_args
        else
            echo "" >&2
            echo "kubectl expose deployment webapp --type=LoadBalancer $ip_option_args" >&2
        fi
    fi
}
