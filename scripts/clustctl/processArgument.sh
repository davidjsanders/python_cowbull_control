function showVendorError {
    showError "Error" 3 "Only one vendor can be selected per operation."
    exit 3
}

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
        kubernetes)
            if (( $VENDOR_SELECTED == 1 )); then showVendorError; fi
            VENDOR_SELECTED=1
            EXEKUBE=1
            SHIFT_AMOUNT=1
            ;;
        azure)
            if (( $VENDOR_SELECTED == 1 )); then showVendorError; fi
            VENDOR_SELECTED=1
            EXEACS=1
            SHIFT_AMOUNT=1
            ;;
        aks)
            if (( $VENDOR_SELECTED == 1 )); then showVendorError; fi
            VENDOR_SELECTED=1
            EXEAZURE=1
            SHIFT_AMOUNT=1
            ;;
        google)
            if (( $VENDOR_SELECTED == 1 )); then showVendorError; fi
            VENDOR_SELECTED=1
            EXEGOOGLE=1
            SHIFT_AMOUNT=1
            ;;
        minikube)
            if (( $VENDOR_SELECTED == 1 )); then showVendorError; fi
            VENDOR_SELECTED=1
            EXEMINIKUBE=1
            SHIFT_AMOUNT=1
            ;;
        -h|--help)
            showHelp
            exit 0
            ;;
        -b|--disk-size)
            DISK_SIZE=$2
            SHIFT_AMOUNT=2
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
                showError "Error" 4 "Unexpected argument: ${1}"
                exit 4
            fi
            SHIFT_AMOUNT=1
            return 3
            ;;
    esac

    return 0
}
