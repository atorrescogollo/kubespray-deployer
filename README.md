# Kubespray Deployer
Kubespray Deployer is a wrapper for easily **[deploying Kubernetes clusters with Kubespray](https://kubernetes.io/docs/setup/production-environment/tools/kubespray/)** with Docker.

## TL;DR
```yaml
# work/cluster_inventory.yml
- hostname: master1
  type: master
- hostname: master2
  type: master
- hostname: worker1
  type: worker
- hostname: worker2
  type: worker
```
```bash
$ docker run -it --rm \
    -v $SSH_AUTH_SOCK:/ssh-agent \
    -e "SSH_AUTH_SOCK=/ssh-agent" \
    -v $PWD/work:/work \
    atorrescogollo/kubespray-deployer
```

## Requirements
All you need is to be able to reach your machines with a privileged user (or with sudo access without password).

## Usage
First, you need to prepare a cluster inventory in a file named **`cluster_inventory.yml`**. Here, you have to indicate how to reach the targets and their type (worker or master), mainly. See an [**example**](./examples/cluster_inventory.yml).

>As a result of the execution, a [**kubespray inventory**](./examples/kubespray_inventory.ini) will be created from [template](./templates/inventory.ini.j2) in the same directory.

Optionally, you can customize the deployment by creating **`host_vars/` and `group_vars/`** directories in the same level as `cluster_inventory.yml`. Available variables can be found in [Kubespray sources](https://github.com/kubernetes-sigs/kubespray/tree/master/inventory/sample).

Once your `cluster_inventory.yml` and variables are configured as desired, you can deploy the cluster using Docker:
```bash
$ docker run -it --rm \
    -v $SSH_AUTH_SOCK:/ssh-agent \
    -e "SSH_AUTH_SOCK=/ssh-agent" \
    -v $PWD/work:/work \
    atorrescogollo/kubespray-deployer
```
>Note that using `SSH_AUTH_SOCK` let's you connect to targets sharing the `ssh-agent` with the host.
