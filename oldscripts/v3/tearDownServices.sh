function tearDownServices {
    if (( $DEPLOYSERVICES == 1 || $DEPLOYFULL == 1 ))
    then
        echo ""
        echo "Tearing down Python CowBull game services"
        echo "========================================="
        echo ""

        echo >&2
        echo "Stop and remove configuration maps, pods, and services" >&2
        echo >&2

        echo -n "Deleting configmap:  "
        kubectl delete configmap cowbull-config --ignore-not-found
        echo

        echo -n "Deleting secrets:  "
        kubectl delete secret tls-certificate --ignore-not-found
        echo

        echo -n "Deleting mongo persistent storage:  "
        kubectl delete -f $VENDOR_PATH/mongo-storage.yml --ignore-not-found
        echo

        echo -n "Deleting "$persister" service:  "
        kubectl delete -f $persister_script"service.yml" --ignore-not-found
        echo

        echo -n "Deleting "$persister" deployment:  "
        kubectl delete -f "$persister_script"deploy.yml --ignore-not-found
        echo

        echo -n "Deleting cowbull deployment:  "
        kubectl delete \
            -f "scripts/cowbull-deploy.yml" \
            --ignore-not-found
        echo

        echo -n "Deleting cowbull service:  "
        kubectl delete \
            -f "scripts/cowbull-service.yml" \
            --ignore-not-found
        echo

        echo -n "Deleting webapp deployment:  "
        kubectl delete -f scripts/webapp-deploy --ignore-not-found
        echo


        echo -n "Deleting webapp ingress: "
        kubectl delete -f scripts/ingress.yml --ignore-not-found

        echo -n "Deleting Ingress controller"
        kubectl delete -f scripts/nginx-controller.yml --ignore-not-found

        echo -n "Deleting Ingress default backend"
        kubectl delete -f scripts/nginx-backend.yml --ignore-not-found
        removeK8Scomponents

        echo >&2
    fi
}
