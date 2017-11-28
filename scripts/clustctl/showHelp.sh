function showHelp {
	echo >&2
    echo "deploy (deploy the infrastructure and/or Kubernetes services for python cowbull)" >&2
    echo >&2
    printf "${USAGE_STRING}" >&2
    echo >&2
    echo "----------------------------|---------------------------------------------------------" >&2
    echo "All platform parameters     |" >&2
    echo "--------------------------------------------------------------------------------------" >&2
    echo " -a | --agents {number}     | Specify the number of K8S agents" >&2
    echo " -g | --group {name}        | Specify the resource group (generates cluster name)" >&2
    echo " -h | --help                | Display this message" >&2
    echo " -k | --get-context         | Get the kubectl context for the current deployment" >&2
    echo " -l | --location l          | Specify the cluster location (Azure RG, GKE Zone)" >&2
    echo " -q | --quiet               | Run in quiet mode supressing prompts" >&2
    echo " -t | --machine-type {type} | Specify the machine type for agents (Azure and Google)" >&2
    echo " -D | --dry-run             | Do NOT create the cluster, perform a dry run only" >&2
    echo " -T | --tear-down           | Destroy the cluster and associated resources" >&2
    echo "----------------------------|---------------------------------------------------------" >&2
    echo "Minikube parameters         |" >&2
    echo "--------------------------------------------------------------------------------------" >&2
    echo " -c | --mini-cpu {number}   | Specify the number of CPUs to allow Minikube to consume"
    echo " -r | --mini-ram {MB}       | Specify the memory to be used with Minikube" >&2
    echo "----------------------------|---------------------------------------------------------" >&2
    echo "Google K8s parameters       |" >&2
    echo "--------------------------------------------------------------------------------------" >&2
    echo " -b | --disk-size {number}  | Specify the disk size for the agent machines" >&2
    echo "----------------------------|---------------------------------------------------------" >&2
    echo "Azure parameters            |" >&2
    echo "--------------------------------------------------------------------------------------" >&2
    echo " -n | --dns-name {name}     | Specify the DNS prefix name" >&2
    echo " -p | --pip-name {name}     | Specify the DNS name for the webapp public IP" >&2
    echo >&2
}
