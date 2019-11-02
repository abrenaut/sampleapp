# Deploying the survey app using Ansible Playbooks.

## Requirements

* [Ansible](https://www.ansible.com/)

## Deploying the app

These playbooks were tested on Ubuntu 18.x.

This stack can be on a single node or multiple nodes. The inventory file 'hosts' defines the nodes in which the stacks should be configured.

    [webservers]
    abrenaut

    [dbservers]
    abrenaut

Here the webserver and the dbserver would be configured on a server named "abrenaut". The stack can be deployed using the following command:

    ansible-playbook -i hosts site.yml

Once done, you can check the results by running the following command

```
curl -X POST http://server.ip:5000/survey -d '{"title": "Survey 1"}' -H "Content-Type: application/json"
```

You should see the survey you just created in the console output.
