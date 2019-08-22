#!/usr/bin/env bats

@test "build docker img" {
    cd "${BATS_TEST_DIRNAME}"/../testing-docker || false
    docker build -t ansible-docker-test .
}

@test "stop existed docker instance for test" {
    if [ -n "$(docker ps -a | grep server1)" ];then
        docker stop server1
        docker rm server1
    fi
}
@test "create docker instance for test" {
    docker run --name server1 -d -P ansible-docker-test
}

@test "ansible playbook " {
    PORT=$(docker port server1 | grep 22 | cut -d ':' -f2)
cat <<EOF > /tmp/hosts
[all]
    pc1 ansible_ssh_host=localhost ansible_ssh_port=$PORT ansible_ssh_user=alextu
EOF
    ansible-playbook -i /tmp/hosts alex-work-pc.yml> /tmp/test.log
}
