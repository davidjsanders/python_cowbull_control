function processArgument {
    # Return:
    # 
    # 0 - Continue processing
    # 1 - Error
    # 2 - Stop processing
    # 3 - Done processing
    #
    SHIFT_AMOUNT=0

    case "$1" in
        azure)
            if (( $VENDOR_SELECTED == 1 ))
            then
                ERROR_TEXT="Only one vendor can be selected per operation."
                return 1
            fi
            VENDOR_SELECTED=1
            EXEACS=1
            SHIFT_AMOUNT=1
            ;;
        aks)
            if (( $VENDOR_SELECTED == 1 ))
            then
                ERROR_TEXT="Only one vendor can be selected per operation."
                return 1
            fi
            VENDOR_SELECTED=1
            EXEAZURE=1
            SHIFT_AMOUNT=1
            ;;
        google)
            if (( $VENDOR_SELECTED == 1 ))
            then
                ERROR_TEXT="Only one vendor can be selected per operation."
                return 1
            fi
            VENDOR_SELECTED=1
            EXEGOOGLE=1
            SHIFT_AMOUNT=1
            ;;
        minikube)
            if (( $VENDOR_SELECTED == 1 ))
            then
                ERROR_TEXT="Only one vendor can be selected per operation."
                return 1
            fi
            VENDOR_SELECTED=1
            EXEMINIKUBE=1
            SHIFT_AMOUNT=1
            ;;
        -h|--help)
            showHelp
            return 2
            ;;
        -s|--start-at)
            START_AT=$2
            SHIFT_AMOUNT=2
            ;;
        -b|--disk-size)
            DISK_SIZE=$2
            SHIFT_AMOUNT=2
            ;;
        -M|--mongodb)
            MONGODB=1
            SHIFT_AMOUNT=1
            ;;
        -q|--quiet)
            QUIET=1
            SHIFT_AMOUNT=1
            ;;
        -p|--pip-name)
            PIP_NAME=$2
            SHIFT_AMOUNT=2
            ;;
        -r|--mini-ram)
            MINIRAM=$2
            SHIFT_AMOUNT=2
            ;;
        -c|--mini-cpu)
            MINICPU=$2
            SHIFT_AMOUNT=2
            ;;
        -n|--dns-name)
            DNS_PREFIX=$2
            SHIFT_AMOUNT=2
            ;;
        -k|--get-context)
            GET_CONTEXT_ONLY="set"
            SHIFT_AMOUNT=1
            ;;
        -t|--machine-type)
            MACHINE_TYPE=$2
            SHIFT_AMOUNT=2
            ;;
        -l|--location)
            LOCATION=$2
            SHIFT_AMOUNT=2
            ;;
        -m|--masters)
            MASTER_COUNT=$2
            SHIFT_AMOUNT=2
            ;;
        -a|--agents)
            AGENT_COUNT=$2
            SHIFT_AMOUNT=2
            ;;
        -d|--debug)
            DEBUG=1
            SHIFT_AMOUNT=1
            ;;
        -A|--azure)
            EXEAZURE=1
            SHIFT_AMOUNT=1
            ;;
        -G|--google)
            EXEGOOGLE=1
            SHIFT_AMOUNT=1
            ;;
        -K|--minikube)
            EXEMINIKUBE=1
            SHIFT_AMOUNT=1
            ;;
        -C|--deploy-cluster)
            DEPLOYCLUSTER=1
            DEPLOYFULL=0
            SHIFT_AMOUNT=1
            ;;
        -S|--deploy-services)
            DEPLOYSERVICES=1
            DEPLOYFULL=0
            SHIFT_AMOUNT=1
            ;;
        -F|--deploy-all)
            DEPLOYCLUSTER=0
            DEPLOYSERVICES=0
            DEPLOYFULL=1
            SHIFT_AMOUNT=1
            ;;
        -T|--tear-down)
            TEARDOWN=1
            SHIFT_AMOUNT=1
            ;;
        -D|--dry-run)
            DRYRUN=1
            SHIFT_AMOUNT=1
            ;;
        -g|--group)
            GROUP=$2
            SHIFT_AMOUNT=2
            ;;
        --|\ )
            SHIFT_AMOUNT=1
            return 3
            ;;
        \?)
            SHIFT_AMOUNT=1
            ;;
        *)
            if [[ $1"X" != "X" ]];
            then
                ERROR_TEXT="Unexpected argument: ${1}"
                return 1
            fi
            SHIFT_AMOUNT=1
            return 3
            ;;
    esac

    return 0
}
