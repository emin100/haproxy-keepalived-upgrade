Haproxy - Keepalived install - upgrade
=========

Keepalived ve Haproxy ikilisi için upgrade ve install işlemlerinin yapılması

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

haproxy: true
keepalived: true
haproxy_version: 2.4.4
keepalived_version: 2.2.4
tmp_directory: /tmp/haproxy-keepalived


Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: db
      roles:
        - name: trendyol.haproxy-keepalived
          vars:
            haproxy: true
            keepalived: true
            haproxy_version: 2.4.4
            keepalived_version: 2.2.4
            tmp_directory: /tmp/haproxy-keepalived

Example Inventory
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    [db]
    localhost


    [all:vars]
    ansible_ssh_user=root
    ansible_ssh_password=pass

Running the Playbook
----------------

    ansible-playbook -i inventory deployment.yml

License
-------

BSD

Author Information
------------------

MEK