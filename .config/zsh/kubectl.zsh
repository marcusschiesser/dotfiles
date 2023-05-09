alias k=kubectl

# lazy-load kubectl comple
kubectl() {
    command kubectl $*
    if [[ -z $KUBECTL_COMPLETE ]]; then
        source <(command kubectl completion zsh)
        KUBECTL_COMPLETE=1
    fi
}
