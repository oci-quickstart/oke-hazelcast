# oke-hazelcast
This is a walkthrough of setting the [Hazelcast Operator](https://github.com/hazelcast/charts) up on [Oracle Kubernetes Engine](https://cloud.oracle.com/containers/kubernetes-engine) (OKE).

## Prerequisites
First you're going to need to setup an Oracle Cloud account, your environmental variables, an OKE cluster and your kubectl.  It sounds like a lot, but there's a nice walkthrough [here](https://github.com/cloud-partners/oke-how-to) that should help.

## Get the Helm Chart
Great, you made it!

Now time for the fun part...  Let's deploy the Hazelcast Operator using a Helm chart.  That's all detailed in a great readme [here](https://github.com/hazelcast/charts) Basically all you need to do is run:

    helm init
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

You can access Management Center on `http://<ip_address>:8080/hazelcast-mancenter`

## Port Forwarding
Right now, OKE isn't assigning an external IP to Management Center for some mysterious reason.  To work around that we can setup port forwarding.  First run this to get the name of the Management Center pod:

    kubectl get pods

That give something like this:

![](./images/03%20-%20kubectl%20get%20pods.png)

In my case it was: `my-release-hazelcast-mancenter-6fb87d7794-d9gsx`.  So, now I can run:

    kubectl port-forward my-release-hazelcast-mancenter-6fb87d7794-d9gsx 8080:8080

That should show something like this and hang while continuing to run:

![](./images/04%20-%20port%20forward.png)

Leave that running and open a web browser to http://localhost:8080/hazelcast-mancenter.  You should see Management Center:

![](./images/05%20-%20management%20center.png)

## Deleting the chart
When you're all done with you cluster, you can run this to delete it:

    helm delete my-release

That gives:

![](./images/06%20-%20helm%20delete.png)
