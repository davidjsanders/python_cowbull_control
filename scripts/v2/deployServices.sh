function deployServices {
    echo "" >&2
    echo "Deploying Python CowBull game configuration, pods, and services" >&2
    echo "===============================================================" >&2
    echo "" >&2

    removeK8Scomponents
    deployK8Scomponents

    azure_option=""
    if (( $EXEAZURE == 1 )) || (( $EXEACS == 1 ));
    then
        if (( $DRYRUN == 0 ));
        then
            echo >&2
            echo "Deploying pip to $AUTOGROUP" >&2
            echo >&2
            netcheck=$(az network public-ip list --resource-group $AUTOGROUP --query "[?name=='$DNS_PREFIX-webapp-pip']" -o json | jq -r .[].name)
            #
            # Temp:
            #
            netcheck=""
            if [[ $netcheck"x" == "x" ]]
            then
                echo "Creating new Public IP"
                ipaddr=$(\
                  az network public-ip create \
                  --name $DNS_PREFIX"-webapp-pip" \
                  --dns-name $PIP_NAME \
                  --allocation-method static \
                  --version IPv4 \
                  --resource-group $AUTOGROUP \
                  -o json | jq -r .publicIp.ipAddress)
            else
                echo -n "Reusing existing Public IP "
                ipaddr=$(\
                  az network public-ip list \
                  --resource-group $AUTOGROUP \
                  --query "[?name=='$DNS_PREFIX-webapp-pip']" \
                  -o json | jq -r .[].ipAddress\
                  )
                echo ": $ipaddr"
            fi
            azure_option="--load-balancer-ip="${ipaddr}
        else
            echo
            echo "Dry run - Assign static IP to load balancer." >&2
            echo "--------------------------------------------" >&2
            echo "ipaddr=\$(az network public-ip create --name $DNS_PREFIX"-webapp-pip" --dns-name $PIP_NAME --allocation-method static --version IPv4 -g $AUTOGROUP -o json | jq -r .publicIp.ipAddress)" >&2
            azure_option="--load-balancer-ip={tbc}"
        fi
    fi

    echo >&2
    echo ""
    echo -n "Creating webapp service: kubectl expose deployment webapp --type=LoadBalancer " >&2
    if (( $DRYRUN != 1 ));
    then
        kubectl expose deployment webapp --type=LoadBalancer $azure_option
    else
        echo "" >&2
        echo "kubectl expose deployment webapp --type=LoadBalancer $azure_option ...dry run" >&2
    fi
}
