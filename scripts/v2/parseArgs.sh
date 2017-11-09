function parseArgs {
    parse_options=""
    parse_options=$parse_options"A"	# or --azure; deploy/tear down Azure
    parse_options=$parse_options"C"	# or --deploy-cluster; only deploy/tear down the cluster (no services)
    parse_options=$parse_options"D"	# or --dry-run; run through but DO NOT execute any step
    parse_options=$parse_options"F"	# or --deploy-all; deploy/tear down cluster AND services
    parse_options=$parse_options"G"	# or --google; deploy/tear down Google Container Enginer (GKE)
    parse_options=$parse_options"K"	# or --minikube; deploy to Minikube
    parse_options=$parse_options"M"     # or --mongodb; use MongoDB for persistence
    parse_options=$parse_options"S"	# or --deploy-services; deploy/tear down services only
    parse_options=$parse_options"T"	# or --tear-down; tear down rather than create
    parse_options=$parse_options"a:"	# or --agents; specify the number of VMs to instantiate as agents
    parse_options=$parse_options"b:"	# or --disk-size; Google only - specify agent VM disk size
    parse_options=$parse_options"c:"	# or --mini-cpu; number of CPUs to allocate to minikube
    parse_options=$parse_options"d"	# or --debug; provide verbose debugging information
    parse_options=$parse_options"g:"	# or --group; specify the group name - also used to create cluster name
    parse_options=$parse_options"h"	# or --help; print help
    parse_options=$parse_options"k"	# or --get-context; get credentials for kubectl
    parse_options=$parse_options"l:"	# or --location; Azure location or Google zone
    parse_options=$parse_options"m:"	# DEPRECATED - previously was --masters number of master VMs
    parse_options=$parse_options"n:"	# or --dns-name; Azure only - specify the DNS prefix
    parse_options=$parse_options"p:"	# or --pip-name; Azure only - specify the public ip dns name
    parse_options=$parse_options"q"	# or --quiet; supress prompts
    parse_options=$parse_options"r:"	# or --mini-ram; size of RAM to allocate to minikube
    parse_options=$parse_options"t:"	# or --machine-type; Azure and Google - specify the machine type

    parse_long_options=""
    parse_long_options=$parse_long_options"debug,"
    parse_long_options=$parse_long_options"tear-down,"
    parse_long_options=$parse_long_options"deploy-cluster,"
    parse_long_options=$parse_long_options"deploy-all,"
    parse_long_options=$parse_long_options"deploy-services,"
    parse_long_options=$parse_long_options"mini-cpu:,"
    parse_long_options=$parse_long_options"mini-ram:,"
    parse_long_options=$parse_long_options"mongodb,"
    parse_long_options=$parse_long_options"disk-size:,"
    parse_long_options=$parse_long_options"minikube,"
    parse_long_options=$parse_long_options"pip-name:,"
    parse_long_options=$parse_long_options"dns-name:,"
    parse_long_options=$parse_long_options"machine-type:,"
    parse_long_options=$parse_long_options"quiet,"
    parse_long_options=$parse_long_options"get-context,"
    parse_long_options=$parse_long_options"dry-run,"
    parse_long_options=$parse_long_options"azure,google,"
    parse_long_options=$parse_long_options"group:,"
    parse_long_options=$parse_long_options"masters:,"
    parse_long_options=$parse_long_options"agents:,"
    parse_long_options=$parse_long_options"location:"

    parse_name="Cowbull deployment script"
    PARSED=$(\
      getopt \
      --options=$parse_options \
      --long=$parse_long_options \
      --name $parse_name \
      -- "$@"\
    )
    return $?
}
