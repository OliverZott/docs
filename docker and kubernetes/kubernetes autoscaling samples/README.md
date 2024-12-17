# Kubernetes - Horizontal Pod Autoscaling (HPA)

<https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/>
<https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#scaling-on-custom-metrics>

## Default cpu / memory autoscalling

### Example 1

<https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#scaling-on-custom-metrics>

- `kubectl apply -f \php-apache.yaml`  ... create deployment and service
- `kubectl get all -o wide`  ... get all resources
- `kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10` ... create HPA
- `kubectl get hpa` ... get HPA

Now increse load on the application:

- `kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"`  ... more load, wait 1 MIN
- `kubectl get hpa php-apache --watch` console 2
- `kubectl get pods -o wide` console 3

Clean up:

- `kubectl delete deployment php-apache`
- `kubectl delete pod load-generator`
- `kubectl delete hpa php-apache`
- `kubectl delete service php-apache`
OR
- `kubectl delete all -l run=php-apache`

## Autoscaling on multiple metrics and custom metrics

<https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/#autoscaling-on-multiple-metrics-and-custom-metrics>

### Example 2

- `kubectl apply -f \php-apache-v2.yaml`  ... create deployment and service
