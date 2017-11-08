function tearDownServices {
    echo ""
    echo "Tearing down Python CowBull game services"
    echo "========================================="
    echo ""

    echo >&2
    echo "Stop and remove configuration maps, pods, and services" >&2
    echo >&2

    removeK8Scomponents

    echo >&2
}
