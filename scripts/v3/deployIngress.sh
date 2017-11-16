function deployIngress {
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
}
