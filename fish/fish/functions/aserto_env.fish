function aserto_env
    kubectl config use-context $argv[1]
    bass source ~/aserto-dev/toolbox/aserto-$argv[1]
end

