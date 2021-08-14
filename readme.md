This play books is targeted to migrate from old PC to new PC quickly.
The main idea is to copy daily using environment to target new PC.

All ansible commands are executed on old PC then files and configurations will be synced to target PC.
So far, the expected pre-configed account on target new PC is _alextu_.
It should still works well if anyone replaced it by another.

# preconditions

* openssh-server is installed on new PC.
* the public key of old PC is already in new PC ~/.ssh/authorized_keys
* the IP and created account on new PC is set in hosts

# steps

* force remote account to have ability executing suto without password.; for convenient.
```
$ ansible-playbook --become --ask-become-pass sudo-set-no-pw.yml    
```

* [TODO]Prepare environment on target machine. e.g. disable suspend.
```
$ ansible-playbook before-ansible-setup-work-pc.yml
```

* install base packages and personal favor packages.
```
$ ansible-playbook alex-work-pc.yml
```

* for projects stuff only, more related to copy credental.
  * adjust local file permission then clone needed stuff to remote target; so password here is for local machine
```
$ ansible-playbook alex-work-pc-projects-stuff.yml --ask-become-pass
```

* [TODO]Reset environment from target machine. e.g. re-enable suspend.
```
$ ansible-playbook after-ansible-setup-work-pc.yml
```
