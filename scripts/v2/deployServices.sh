function deployServices {
    echo "" >&2
    echo "Deploying Python CowBull game configuration, pods, and services" >&2
    echo "===============================================================" >&2
    echo "" >&2

    removeK8Scomponents
    deployK8Scomponents

    azure_option=""
    if (( $EXEAZURE == 1 ));
    then
        if (( $DRYRUN == 0 ));
        then
            ipaddr=$(\
              az network public-ip create \
              --name $DNS_PREFIX"-webapp-pip" \
              --dns-name $PIP_NAME \
              --allocation-method static \
              --version IPv4 \
              --resource-group $AUTOGROUP \
              -o json | jq -r .publicIp.ipAddress)
            azure_option="--load-balancer-ip="${ipaddr}
        else
            echo
            echo "Dry run - Assign static IP to load balancer." >&2
            echo "--------------------------------------------" >&2
            echo "ipaddr=\$(az network public-ip create --name $DNS_PREFIX"-webapp-pip" --dns-name $PIP_NAME --allocation-method static --version IPv4 -g $AUTOGROUP -o json | jq -r .publicIp.ipAddress)" >&2
            echo "azure_option=--load-balancer-ip=\${ipaddr}" >&2
        fi
    fi

    echo >&2
    echo ""
    echo -n "Creating webapp service: kubectl expose deployment webapp --type=LoadBalancer " >&2
    if (( $DRYRUN != 1 ));
    then
        kubectl expose deployment webapp --type=LoadBalancer $azure_option
    else
        echo "...dry run" >&2
    fi
}
