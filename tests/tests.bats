#!/usr/bin/env bats

@test "build docker img" {
    cd "${BATS_TEST_DIRNAME}"/../testing-docker || false
    docker build -t ansible-docker-test .
}

@test "stop existed docker instance for test" {
    docker stop server1
    docker rm server1
}
@test "create docker instance for test" {
    docker run --name server1 -d -P ansible-docker-test
}

@test "ansible playbook " {
    PORT=$(docker port server1 | grep 22 | cut -d ':' -f2)
    ansible-playbook alex-work-pc.yml --extra-vars "ansible_ssh_host=localhost ansible_ssh_port=${PORT} ansible_ssh_user=alextu"
}
