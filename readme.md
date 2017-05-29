# force remote account to have ability executing suto without password.
ansible-playbook --become --ask-become-pass sudo-set-no-pw.yml    
# install base packages and personal favor packages.
ansible-playbook alex-work-pc.yml
# or only play tag for private stuff
ansible-playbook alex-work-pc.yml --tags private
# for projects stuff only, more related to credental.
# adjust local file permission then clone needed stuff to remote target; so password here is for local machine
ansible-playbook alex-work-pc-projects-stuff.yml --ask-become-pass
