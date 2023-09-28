# Kubernetes Autoscaling

---------------------------------------------------------------------------------------------------
Question: kubernetes: how does Horizontal Pod Autoscaling work? please explain basic idea (short) and give example walkthrough?

In Kubernetes, a **HorizontalPodAutoscaler** automatically updates a workload resource (such as a Deployment or StatefulSet), with the aim of automatically scaling the workload to match demand¹.

**Horizontal scaling** means that the response to increased load is to deploy more Pods¹. This is different from vertical scaling, which for Kubernetes would mean assigning more resources (for example: memory or CPU) to the Pods that are already running for the workload¹.

If the load decreases, and the number of Pods is above the configured minimum, the HorizontalPodAutoscaler instructs the workload resource (the Deployment, StatefulSet, or other similar resource) to scale back down¹.

The HorizontalPodAutoscaler is implemented as a Kubernetes API resource and a controller. The resource determines the behavior of the controller¹. The horizontal pod autoscaling controller, running within the Kubernetes control plane, periodically adjusts the desired scale of its target (for example, a Deployment) to match observed metrics such as average CPU utilization, average memory utilization, or any other custom metric you specify¹.

<https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/>

Source: Conversation with Bing, 28/09/2023
(1) Horizontal Pod Autoscaling | Kubernetes. <https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/>.
(2) HorizontalPodAutoscaler Walkthrough | Kubernetes. <https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/>.
(3) HorizontalPodAutoscaler Walkthrough | Kubernetes. <https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/>.
(4) Horizontal Pod autoscaling | Google Kubernetes Engine (GKE) | Google Cloud. <https://cloud.google.com/kubernetes-engine/docs/concepts/horizontalpodautoscaler>.
(5) Horizontal Pod Autoscalerウォークスルー | Kubernetes. <https://kubernetes.io/ja/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/>.
(6) undefined. <https://k8s.io/examples/application/php-apache.yaml>.
(7) Configuring horizontal Pod autoscaling - Google Cloud. <https://cloud.google.com/kubernetes-engine/docs/how-to/horizontal-pod-autoscaling>.
(8) Automatically scaling pods with the horizontal pod autoscaler. <https://docs.openshift.com/container-platform/4.10/nodes/pods/nodes-pods-autoscaling.html>.
(9) How does a HorizontalPodAutoscaler work? - GitHub. <https://github.com/kubernetes/website/blob/main/content/en/docs/tasks/run-application/horizontal-pod-autoscale.md>.

---------------------------------------------------------------------------------------------------

Question:  an aplication (api endpoint) with a status (busy or idle) as soon as all deployed apis are busy i want to deploy new one. So there hast to be always ONE api with status idle. how can i achive that?

You can achieve autoscaling in Kubernetes based on custom metrics using the **Horizontal Pod Autoscaler (HPA)**[^10^]¹¹. Here's a high-level overview of how you could set this up:

1. **Expose the status of your API endpoints as a metric**: Your application should expose an endpoint (e.g., /metrics) that provides the current status of the API (busy or idle). This can be done using a library like Prometheus[^10^].

2. **Collect and provide these metrics to Kubernetes**: You can use a service like Prometheus to scrape these metrics from your application and store them. Then, you can use the Prometheus Adapter to make these metrics available to Kubernetes[^10^].

3. **Configure HPA to scale based on your custom metric**: You can create a HorizontalPodAutoscaler resource that scales your application based on the custom metric you've defined[^10^].

Please note that setting up autoscaling based on custom metrics involves several steps and requires a good understanding of both Kubernetes and your application. You might need to adjust this approach based on the specifics of your environment and application[^10^].

<https://blog.px.dev/autoscaling-custom-k8s-metric/>

Source: Conversation with Bing, 28/09/2023
(1) Horizontal Pod Autoscaling with Custom Metrics in Kubernetes. <https://blog.px.dev/autoscaling-custom-k8s-metric/>.
(2) How to autoscale apps on Kubernetes with custom metrics. <https://learnk8s.io/autoscaling-apps-kubernetes>.
(3) Horizontal Pod Autoscaling with Custom Metrics in Kubernetes. <https://blog.px.dev/autoscaling-custom-k8s-metric/>.
(4) Optimize Pod autoscaling based on metrics | Kubernetes Engine | Google .... <https://cloud.google.com/kubernetes-engine/docs/tutorials/autoscaling-metrics>.
(5) Horizontal pod autoscaling (HPA) | Operations Suite | Google Cloud. <https://cloud.google.com/stackdriver/docs/managed-prometheus/hpa>.
(6) Custom Metrics - Stackdriver Adapter - GitHub. <https://github.com/GoogleCloudPlatform/k8s-stackdriver/blob/master/custom-metrics-stackdriver-adapter/README.md>.
(7) Configure Kubernetes Autoscaling with Custom Metrics - Bitnami. <https://docs.bitnami.com/tutorials/configure-autoscaling-custom-metrics/>.
(8) Using multiple custom metrics adapters in Kubernetes. <https://stackoverflow.com/questions/64587793/using-multiple-custom-metrics-adapters-in-kubernetes>.
(9) undefined. <https://raw.githubusercontent.com/GoogleCloudPlatform/k8s-stackdriver/master/custom-metrics-stackdriver-adapter/deploy/production/adapter_new_resource_model.yaml>.
(10) undefined. <https://raw.githubusercontent.com/GoogleCloudPlatform/k8s-stackdriver/master/custom-metrics-stackdriver-adapter/examples/prometheus-to-sd/custom-metrics-prometheus-sd.yaml>.
(11) undefined. <https://github.com/znirzej/k8s-stackdriver/tree/adapter-container-metrics/custom-metrics-stackdriver-adapter>.
(12) undefined. <https://cloud.google.com/monitoring/custom-metrics/creating-metrics>.
(13) Kubernetes Autoscaling with Custom Metrics (updated) - InfraCloud. <https://www.infracloud.io/blogs/kubernetes-autoscaling-custom-metrics/>.

---------------------------------------------------------------------------------------------------

Question: can kubernetes autoscale / generate pods by checking an api response?

Yes, Kubernetes can autoscale or generate pods by checking an API response. This is typically done using the **Horizontal Pod Autoscaler (HPA)** with **custom metrics**¹.

In your case, you could create a custom metric that tracks the status of your API endpoints (busy or idle). The HPA can then use this metric to ensure that there is always at least one idle API endpoint available¹.

Here's a high-level overview of how you could set this up:

1. **Expose the status of your API endpoints as a metric**: Your application should expose an endpoint (e.g., /metrics) that provides the current status of the API (busy or idle). This can be done using a library like Prometheus¹.

2. **Collect and provide these metrics to Kubernetes**: You can use a service like Prometheus to scrape these metrics from your application and store them. Then, you can use the Prometheus Adapter to make these metrics available to Kubernetes¹.

3. **Configure HPA to scale based on your custom metric**: You can create a HorizontalPodAutoscaler resource that scales your application based on the custom metric you've defined¹.

Please note that setting up autoscaling based on custom metrics involves several steps and requires a good understanding of both Kubernetes and your application. You might need to adjust this approach based on the specifics of your environment and application¹.

For more detailed information, you might find this [StackOverflow thread](^1^) helpful. It discusses autoscaling pods based on HTTP request count, which is similar to what you're trying to achieve¹.
