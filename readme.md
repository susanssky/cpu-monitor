
# Introduction
To enhance my technical skills, I decided to learn Kubernetes and apply it in a practical project. I chose to deploy a small CPU Monitor application on both AWS Elastic Kubernetes Service (EKS) and Azure Kubernetes Service (AKS). This allowed me to explore how Kubernetes works in different cloud environments and deepen my understanding of microservices and autoscaling.

My goal was to deploy the CPU Monitor application successfully on EKS and AKS, compare the differences between the two platforms, and implement Horizontal Pod Autoscaling (HPA) and cluster autoscaling. I also wanted to split the application into microservices (health, stress, node, current, and client) and manage them efficiently using Kubernetes tools like Ingress controllers and load balancers, ensuring the system could scale under pressure and remain functional.

I began by studying Kubernetes and containerisation with Docker. I developed the CPU Monitor application and split it into five services: health, stress, node, current, and client. Each service was containerised using a Dockerfile and pushed to a container registry. Then, I deployed these services as pods on both EKS and AKS.

While working on AWS EKS, I installed a metrics server to enable HPA since it wasn’t included by default. I also had to configure security groups manually to allow communication between the backend app and an RDS PostgreSQL database by adding the subnet’s IP to the ingress rules. On Azure AKS, however, the metrics server was already available, and I found it simpler to connect a PostgreSQL Flexible Server in a private subnet to AKS without needing security groups, highlighting AKS’s Platform-as-a-Service (PaaS) nature compared to EKS’s more hands-on approach.

Next, I enabled HPA and cluster autoscaling on both platforms. To test this, I added a time-limited loop function in the app to stress the pods and nodes. When CPU usage spiked, Kubernetes automatically scaled up the pods or nodes, and when usage dropped for about 10 minutes, it scaled them back down. I also learned that if a node lacked sufficient memory, neither the pods nor the application could start, reinforcing the importance of resource planning.

To manage the microservices efficiently, I used ingress-nginx on AKS to route traffic to all five services under a single Ingress resource. On EKS, I implemented the AWS Load Balancer Controller to achieve the same result, exposing the services via a load balancer IP. Although purchasing a domain and TLS certificate would have been the final step to make it production-ready, I skipped this for the demo due to cost concerns and used the raw IP instead.

I deployed the CPU Monitor application on both EKS and AKS, gaining hands-on experience with Kubernetes, Docker, and cloud-specific configurations. The HPA and cluster autoscaling worked as expected, dynamically adjusting resources based on CPU load. By implementing microservices and using Ingress and load balancers, I created a scalable, manageable system. This experience taught me the practical differences between AWS and Azure, the value of microservices in avoiding single points of failure (like in a shopping website with login, order, product, and payment services), and how Kubernetes simplifies deployment and scaling. This project has significantly boosted my confidence in cloud-native technologies, and I’m eager to apply these skills to future challenges.

# Cloud Service
- Elastic Kubernetes Service (EKS)
- Azure Kubernetes Service (AKS)
- Subscription
- Azure Database for PostgreSQL flexible server
- Entra ID
- Auto Scaling
- Load Balancer
- Virtual network
- SDK

# Tool
- Docker
- Terraform
- Kubernetes
- Github Actions
- Helm