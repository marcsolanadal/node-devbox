# Attaches the current docker environment to shell
eval $(docker-machine env default)

# Attach ssh keys to agent
ssh-add .ssh/ionid

export REDIS_HOST=192.168.99.100
export REDIS_PORT=7777


