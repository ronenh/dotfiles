function nvim -d "run nvim with 'integration' build tag"
    set -lx GOFLAGS "-tags=integration"
    command nvim $argv
end
