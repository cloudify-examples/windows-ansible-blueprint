[![Build Status](https://circleci.com/gh/cloudify-examples/windows-ansible-blueprint.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/cloudify-examples/windows-ansible-blueprint)

# windows-ansible-blueprint

Uses the Cloudify Script Plugin to execute the Ansible win_ping module against a single Windows host.

Requires a Cloudify Manager

## Usage

* Clone the repository

```bash
git clone https://github.com/cloudify-examples/windows-ansible-blueprint.git cloudify-examples-windows-ansible-blueprint
cd cloudify-examples-windows-ansible-blueprint
```

* Upload the blueprint

```bash
cfy blueprints upload -p windows-openstack-blueprint.yaml -b winans
```

* Deploy the blueprint

```bash
cfy deployments create -b winans -d winans -i '
image_id: [ your windows image id in openstack ]
flavor_id: [ an appropriate flavor id in openstack ]
'
```

* Execute install worklflow

```bash
cfy executions start -w install -d winans -l
```

This will execute the win_ping module using Ansible against the created Windows host.

* Uninstall

```bash
cfy executions start -w uninstall -d winans -l
```
