
# Introduction
To enhance my technical skills and gain a deeper understanding of cloud-native technologies, I decided to learn Kubernetes and practise deploying applications on AWS EKS and Azure AKS. At the time, I observed that many modern applications, such as e-commerce websites, require highly available and scalable backend services. However, traditional monolithic architectures often lead to complete system failures when a service crashes. Therefore, I aimed to implement a microservices architecture using Kubernetes to improve system stability and maintainability.

My goal was to deploy a small CPU Monitor application to test Kubernetes’ auto-scaling features (HPA and Cluster Autoscaling) and simulate a microservices architecture for an e-commerce website. My specific tasks included:

1. Deploying the application on EKS and AKS, and comparing their differences.
2. Implementing HPA and Cluster Autoscaling to ensure the system could automatically adjust the number of Pods and Nodes under load pressure.
3. Breaking down the backend services of a hypothetical e-commerce website (e.g., login, orders, products, and payments) into microservices, and managing them with Kubernetes.

I began by learning and applying the basics of Kubernetes, then deployed the CPU Monitor application on both AWS EKS and Azure AKS. During this process, I noticed that AKS comes with a built-in Metrics Server, whereas EKS requires manual installation. This gave me a clearer insight into the configuration differences between the two platforms.

To test auto-scaling, I created a time-limited loop function to deliberately increase the CPU load on the Pods. When the load rose, HPA automatically increased the number of Pods; if Node resources were insufficient, Cluster Autoscaling added more Nodes. Conversely, if CPU usage remained low for about 10 minutes, the system automatically reduced the number of Pods and Nodes. I also observed that if a Node lacked sufficient memory, Pods couldn’t start, which reinforced the importance of resource management.

Next, I simulated a microservices architecture for an e-commerce website. I wrote Dockerfiles for services like login, orders, products, and payments, and pushed them to a container registry. Using Kubernetes, I pulled these services and deployed them as Pods. To simplify communication and management between services, I introduced Ingress-Nginx to consolidate all services into a single entry point, then used a Load Balancer to provide a single IP address. Although the final step would involve purchasing a domain and TLS certificate for a fully functional website, I opted to use just the IP for the demo due to cost considerations.

In the end, I successfully deployed the CPU Monitor application on EKS and AKS, and implemented HPA and Cluster Autoscaling, proving Kubernetes’ strength in flexible resource management. Additionally, by simulating an e-commerce microservices architecture, I completed the entire process—from Docker containerisation to Kubernetes deployment—and built a highly available, scalable backend system. This project not only improved my technical skills but also deepened my practical understanding of cloud deployment and microservices. While I didn’t purchase a domain, the demo effectively showcased my work.

# Cloud Service
- AKS
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