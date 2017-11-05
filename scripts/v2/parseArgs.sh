function parseArgs {
    parse_options="ACDFGSTc:r:b:t:p:n:qdhg:m:a:l:k"
    parse_long_options="debug,tear-down,deploy-cluster,deploy-all,deploy-services,mini-cpu:,mini-ram:,disk-size:,minikube,pip-name:,dns-name:,machine-type:,quiet,dry-run,azure,google,group:,masters:,agents:,location:"
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