function deployServices {
    echo "" >&2
    echo "Deploying Python CowBull game configuration, pods, and services" >&2
    echo "===============================================================" >&2
    echo "" >&2

    removeK8Scomponents
    deployK8Scomponents

    ip_option_args=""
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
            ip_option_args="--load-balancer-ip="${ipaddr}
        else
            echo
            echo "Dry run - Assign static IP to load balancer." >&2
            echo "--------------------------------------------" >&2
            echo "ipaddr=\$(az network public-ip create --name $DNS_PREFIX"-webapp-pip" --dns-name $PIP_NAME --allocation-method static --version IPv4 -g $AUTOGROUP -o json | jq -r .publicIp.ipAddress)" >&2
            ip_option_args="--load-balancer-ip={tbc}"
        fi
#    elif (( $EXEGOOGLE == 1 ))
#    then
#        if (( $DRYRUN == 0 ))
#        then
#            gcloud compute addresses create cowbull-ingress --global
#            ipaddr=$(gcloud compute addresses describe cowbull-ingress --global --format='value(address)')
#            ip_option_args="--load-balancer-ip="${ipaddr}
#        else
#            echo
#            echo "Dry run - Assign static IP to load balancer." >&2
#            echo "--------------------------------------------" >&2
#            echo "gcloud compute addresses create cowbull-ingress --global" >&2
#            echo "ipaddr=\$(gcloud compute addresses describe cowbull-ingress --global --format='value(address)')" >&2
#            echo "ip_option_args='--load-balancer-ip=\${ipaddr}'" >&2
#            ip_option_args="--load-balancer-ip={tbc}"
#        fi
    fi

    echo >&2
    echo ""
    echo -n "Creating webapp service: " >&2
    if (( $DRYRUN != 1 ));
    then
#        kubectl expose deployment webapp --type=LoadBalancer $ip_option_args
        kubectl expose deployment webapp --name webapp-ingress --target-port=8080 --type=NodePort
        kubectl create -f scripts/ingress.yml
    else
        echo "" >&2
        echo "kubectl expose deployment webapp --name webapp-ingress --target-port=8080 --type=NodePort ...dry run" >&2
    fi
}
