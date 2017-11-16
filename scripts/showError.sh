function showError {
    SAVEIFS=$IFS
    IFS=$'\n'
    err_array=($(echo "${4}" | sed -e 's/.\{60\}/&\n /g'))
    IFS=$SAVEIFS

    echo >&2
    printf "" >&2
    printf "===========|======|============================================================\n" >&2
    printf "Status     | Code | Message\n" "$1" "$2" "$3" >&2
    printf "===========|======|============================================================\n" >&2
    printf "%-10s | %4d | %-60s\n" "$1" "$2" "$3" >&2
    for i in ${!err_array[@]}
    do
        outline=$(echo "${err_array[$i]}" | sed 's/^ *//g')
        printf "           |      | %-60s\n" "${outline}" >&2
    done
    printf "===========|======|============================================================\n" >&2
    echo >&2
    echo >&2
}
