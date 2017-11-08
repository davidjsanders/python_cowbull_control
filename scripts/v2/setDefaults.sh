function setDefaults {
    USAGE_STRING="usage: deploy [-abcdghlmnpqrtADGKFSCT] [-a|--agents agent count] [-b|--disk-size disk size (Google only)]"
    USAGE_STRING=$USAGE_STRING" [-c|--mini-cpu number of cpus (Minikube only)] [-g|--group group name] "
    USAGE_STRING=$USAGE_STRING" [-l|--location location (Azure location/Google zone)] [-m|--masters master count (deprecated)]"
    USAGE_STRING=$USAGE_STRING" [-n|--dns-name dns name] [-p|--pip-name public IP name] "
    USAGE_STRING=$USAGE_STRING" [-r|--mini-ram ram (Minikube only)] [-t|--machine-type machine type (Azure and Google)]"

    PARSED=""
    EXEAZURE=0
    EXEGOOGLE=0
    EXEMINIKUBE=0
    DATEFILL=$(date +"%m%d%y")
    GROUP="dasander"${DATEFILL}
    MASTER_COUNT=1
    AGENT_COUNT=1
    LOCATION="**notset**"
    MACHINE_TYPE="**notset**"
    DNS_PREFIX="dnsprefix"
    PIP_NAME="cowbull_webapp"
    DEBUG=0
    DRYRUN=0
    KEYFILE=~/.ssh/id_rsa
    QUIET=0
    START_AT=1
    DISK_SIZE=100
    MINIRAM=5192
    MINICPU=4
    DEPLOYCLUSTER=0
    DEPLOYSERVICES=0
    DEPLOYFULL=1
    TEARDOWN=0

    SHIFT_AMOUNT=0
    ERROR_TEXT=""
}
