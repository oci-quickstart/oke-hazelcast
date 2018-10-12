# This doesn't work yet.  Sorry.

# oke-hazelcast
This is a walkthrough of setting the [Hazelcast Operator](https://github.com/hazelcast/charts) up on [Oracle Kubernetes Engine](https://cloud.oracle.com/containers/kubernetes-engine) (OKE).

# Prerequisites
First you're going to need to setup an Oracle Cloud account, your environmental variables, an OKE cluster and your kubectl.  It sounds like a lot, but there's a nice walkthrough [here](https://github.com/cloud-partners/oke-howto) that should help.

# Deploy the Hazelcast Operator
Great, you made it!

Now time for the fun part...  Let's deploy the Hazelcast Operator using a Helm chart.  That's all detailed in a great readme [here](https://github.com/hazelcast/charts) Basically all you need to do is run:

    helm repo add hazelcast https://hazelcast.github.io/charts/
    helm repo update
    ...
