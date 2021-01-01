ARG KUBESPRAY_VERSION=v2.14.2
FROM thesoul/kubespray:${KUBESPRAY_VERSION}

ENV KUBESPRAY_HOME=/kubespray

ENV WORKDIR=/work

# Input file with cluster information
ENV CLUSTER_INVENTORY=$WORKDIR/cluster_inventory.yml
ENV KUBESPRAY_INVENTORY=$WORKDIR/kubespray_inventory.ini

# Add this repo to /deployer
ADD . /deployer
RUN mkdir -p $WORKDIR && chmod 700 /deployer/deploy.sh
WORKDIR /deployer

ENTRYPOINT [ "/deployer/deploy.sh" ]
