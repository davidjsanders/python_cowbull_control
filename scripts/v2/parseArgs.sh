function parseArgs {
    parse_options=""
    parse_options=$parse_options"A"
    parse_options=$parse_options"C"
    parse_options=$parse_options"D"
    parse_options=$parse_options"F"
    parse_options=$parse_options"G"
    parse_options=$parse_options"S"
    parse_options=$parse_options"T"
    parse_options=$parse_options"c:"
    parse_options=$parse_options"r:"
    parse_options=$parse_options"b:"
    parse_options=$parse_options"t:"
    parse_options=$parse_options"p:"
    parse_options=$parse_options"n:"
    parse_options=$parse_options"q"
    parse_options=$parse_options"d"
    parse_options=$parse_options"h"
    parse_options=$parse_options"g:"
    parse_options=$parse_options"m:"
    parse_options=$parse_options"a:"
    parse_options=$parse_options"l:"
    parse_options=$parse_options"k"

    parse_long_options=""
    parse_long_options=$parse_long_options"debug,"
    parse_long_options=$parse_long_options"tear-down,"
    parse_long_options=$parse_long_options"deploy-cluster,"
    parse_long_options=$parse_long_options"deploy-all,"
    parse_long_options=$parse_long_options"deploy-services,"
    parse_long_options=$parse_long_options"mini-cpu:,"
    parse_long_options=$parse_long_options"mini-ram:,"
    parse_long_options=$parse_long_options"disk-size:,"
    parse_long_options=$parse_long_options"minikube,"
    parse_long_options=$parse_long_options"pip-name:,"
    parse_long_options=$parse_long_options"dns-name:,"
    parse_long_options=$parse_long_options"machine-type:,"
    parse_long_options=$parse_long_options"quiet,"
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