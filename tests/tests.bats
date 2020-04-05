#!/usr/bin/env bats

@test "build docker img" {
    tempfolder="$(mktemp -d)"
    cp "${BATS_TEST_DIRNAME}"/../testing-docker/* "$tempfolder"
    pushd "$tempfolder" || exit 1
    [ -f "authorized_keys" ] || cp "$HOME"/.ssh/authorized_keys .
       python3 -c "print(open('Dockerfile.template').read().format(SERIES=\"bionic\",PYTHON_PKG=\"python\"))" > Dockerfile
       docker build -t ansible-docker-test:bionic .
       python3 -c "print(open('Dockerfile.template').read().format(SERIES=\"bionic\",PYTHON_PKG=\"python3-all\"))" > Dockerfile
       docker build -t ansible-docker-test:focal .
    popd
    rm -r "$tempfolder"
}

@test "stop existed docker instance for test" {
    for s in bionic focal; do
        if [ -n "$(docker ps -a | grep test-server-$s)" ];then
            docker stop test-server-$s
            docker rm test-server-$s
        fi
    done
}
@test "create docker instance for test" {
    for s in bionic focal; do
        docker run --name test-server-$s -d -P ansible-docker-test:$s
        docker ps >&3
    done
}

@test "ansible playbook " {
    docker ps >&3
    for s in bionic focal; do
        PORT=$(docker port test-server-$s | grep 22 | cut -d ':' -f2)
cat <<EOF > /tmp/hosts
[all]
    pc1 ansible_ssh_host=localhost ansible_ssh_port=$PORT ansible_ssh_user=alextu
EOF
        echo '# testing for '"$s" >&3
        echo '# ansible-playbook -i /tmp/hosts alex-work-pc.yml> /tmp/test.log' >&3
        ansible-playbook -i /tmp/hosts alex-work-pc.yml> /tmp/test.log
    done
}
