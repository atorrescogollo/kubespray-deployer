ARG KUBESPRAY_VERSION=v2.14.2
FROM thesoul/kubespray:${KUBESPRAY_VERSION}

ENV KUBESPRAY_HOME=/kubespray \
    DEPLOYER_HOME=/deployer \
    CLUSTER_INVENTORY=/work/cluster_inventory.yml \
    KUBESPRAY_INVENTORY=/work/kubespray_inventory.ini

# Add this repo to /deployer
ADD . /deployer
RUN pip3 install -r /deployer/requirements.txt \
    && chmod 700 /deployer/docker_entrypoint.sh \
    && mkdir -p /work
WORKDIR /deployer
ENTRYPOINT [ "/deployer/docker_entrypoint.sh" ]
