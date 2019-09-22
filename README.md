# oke-quickstart-hazelcast
This is a walkthrough of setting the [Hazelcast Operator](https://github.com/hazelcast/charts) up on [Oracle Cloud Infrastructure Container Engine for Kubernetes (OKE)](https://cloud.oracle.com/containers/kubernetes-engine). It is developed jointly by Oracle and Hazelcast.  For instructions on how to use this material and details on getting support from the vendor that maintains this material, please contact them directly.

## Prerequisites
First you're going to need to setup an Oracle Cloud account, your environmental variables, an OKE cluster and your kubectl.  It sounds like a lot, but there's a nice walkthrough [here](https://github.com/oracle/oke-quickstart-prerequisites) that should help.

## Get the Helm Chart
Great, you made it!

Now time for the fun part...  Let's deploy the Hazelcast Operator using a Helm chart.  That's all detailed in a great readme [here](https://github.com/hazelcast/charts) Basically all you need to do is run:

    helm init --upgrade
    helm repo add hazelcast https://hazelcast.github.io/charts/
    helm repo update

That should give you something like this:

![](./images/01%20-%20helm%20repo.png)

## Install the Chart
To install the chart run:

    helm install --name my-release hazelcast/hazelcast

This prints out all sorts of helpful stuff about how to access the cluster:

![](./images/02%20-%20helm%20install.png)

You can grab the Management Center IP by running:

    kubectl get svc --namespace default my-release-hazelcast-mancenter

That gives:

![](./images/03%20-%20kubectl.png)

You can access Management Center on `http://<ip_address>:8080/hazelcast-mancenter`

![](./images/04%20-%20management%20center.png)

Create a user and then you can check out the cluster:

![](./images/05%20-%20cluster.png)

## Deleting the Chart
When you're all done with you cluster, you can run this to delete it:

    helm delete my-release

That gives:

![](./images/06%20-%20helm%20delete.png)
