function showHelp {
	echo >&2
    echo "deploy (deploy the infrastructure and/or Kubernetes services for python cowbull)" >&2
    echo >&2
    echo $USAGE_STRING >&2
    echo >&2
    echo "Platform key: * - Azure, * - Google, * - Minikube" >&2
    echo "(dep. means deprecated)" >&2
    echo >&2
    echo "Parameter                | Description" >&2
    echo "-------------------------|---------------------------------------------------------" >&2
    echo " -a | --agents x         | Specify the number of K8S agents" >&2
    echo " -b | --disk-size        | Specify the disk size (for Google only)" >&2
    echo " -c | --mini-cpu         | Specify the number of CPUs to allow Minikube to consume"
    echo " -d | --debug            | Use debug mode" >&2
    echo " -g | --group *          | Specify the resource group (generates cluster name)" >&2
    echo " -h | --help             | Display this message" >&2
    echo " -l | --location l       | Specify the location for the resource group" >&2
    echo " -n | --dns-name n       | Specify the DNS prefix name" >&2
    echo " -p | --pip-name n       | Specify the DNS name for the webapp public IP" >&2
    echo " -q | --quiet            | Run in quiet mode supressing prompts" >&2
    echo " -r | --mini-ram         | Specify the memory to be used with Minikube" >&2
    echo " -t | --machine-type *   | Specify the machine type for agents" >&2
    echo " -x | --experiments      | Specify the machine type for agents" >&2
    echo " -A | --azure            | Deploy to Azure" >&2
    echo " -D | --dry-run          | Do NOT execute the script, simply dry run it" >&2
    echo " -G | --google           | Deploy to Google" >&2
    echo " -K | --minikube         | Deploy the application on minikube locally" >&2
    echo " -F | --deploy-all       | Deploy the complete application stack" >&2
    echo " -S | --deploy-services  | Deploy only the Kubernetes services" >&2
    echo " -C | --deploy-cluster   | Deploy only the Kubernetes cluster with NO services" >&2
    echo " -T | --tear-down        | Tear down the K8S services and the cluster" >&2
    echo >&2
}
