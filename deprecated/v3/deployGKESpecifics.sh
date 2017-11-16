function deployAzureSpecific {
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

    if (( $INGRESS == 1 ))
    then
        echo >&2
        echo "Creating Ingres Controller using NGINX"
        if (( $DRYRUN != 1 ))
        then
            kubectl create secret tls tls-certificate --key configuration/selfsigned.key --cert configuration/selfsigned.crt
            echo -n "Creating controller " >&2
            kubectl create -f scripts/nginx-controller.yml
            echo -n "Creating backend " >&2
            kubectl create -f scripts/nginx-backend.yml
            echo "Create webapp ingress" >&2
            kubectl expose deployment webapp --name webapp-ingress --port=8080 --type=NodePort
            kubectl create -f scripts/ingress.yml
        else
            echo -n "Creating controller " >&2
            echo "...dry run -> kubectl create -f scripts/nginx-controller.yml " >&2
            echo -n "Creating backend " >&2
            echo "...dry run -> kubectl create -f scripts/nginx-backend.yml " >&2
            echo "kubectl expose deployment webapp --name webapp-ingress --port=8080 --type=NodePort ...dry run" >&2
            echo "kubectl create -f scripts/ingress.yml" >&2
        fi
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
