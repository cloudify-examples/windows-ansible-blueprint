#!/bin/bash -e

ctx logger info "running windows_play.sh"

ctx logger info "installing gcc"
sudo yum -y install gcc python-devel

ctx logger info "installing ansible"
pip install ansible

ctx logger info "installing pywinrm"
pip install pywinrm>=0.1.1

ANSIBLE_DIR=/etc/ansible
mkdir -p ${ANSIBLE_DIR}/group_vars
ctx logger info "made ${ANSIBLE_DIR}"

INVENTORY_PATH=${ANSIBLE_DIR}/hosts
INVENTORY="""
[windows]
$(ctx instance id)
"""
touch ${INVENTORY_PATH}
echo "${INVENTORY}" | sudo tee -a ${INVENTORY_PATH}
ctx logger info "created ${INVENTORY_PATH}"

VARIABLES_PATH=${ANSIBLE_DIR}/group_vars/windows.yaml
VARIABLES="""
ansible_user: Admin
ansible_password: ${WINDOWS_PASSWORD}
ansible_port: 5985
ansible_connection: winrm
# The following is necessary for Python 2.7.9+ when using default WinRM self-signed certificates:
ansible_winrm_server_cert_validation: ignore
"""
touch ${VARIABLES_PATH}
echo "${VARIABLES}" | sudo tee -a ${VARIABLES_PATH}
ctx logger info "created ${VARIABLES_PATH}"

HOSTS_PATH=/etc/hosts
HOSTS="""
$(ctx instance host_ip) $(ctx instance id)
"""
echo "${HOSTS}" | sudo tee -a ${HOSTS_PATH}
ctx logger info "created ${HOSTS_PATH}"

set +e
ctx logger info "RUNNING COMMAND"
OUTPUT=$(ansible windows -m win_ping -vvvv)
ctx logger info "OUTPUT ${OUTPUT}"
set -e
