docker run --rm -it -v /home/alextu:/home/alextu --name ansible_manager alextucc/ansible_manager:xenial
ansible-playbook -vvvv -u u -k -K debug-bring-up.yml
