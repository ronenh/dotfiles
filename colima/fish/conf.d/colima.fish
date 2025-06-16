if command -qa colima
	set -x DOCKER_HOST (colima status -j | jq -r .docker_socket)
	set -x TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE /var/run/docker.sock
end
