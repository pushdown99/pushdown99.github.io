---
layout: post
title: 'Kubernetes' 
author: haeyeon.hwang
tags: [k8s, kubernetes]
description: >
  쿠버네티스 
image: /assets/img/blog/kubernetes.png.png
hide_image: true
---

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

## [쿠버네티스 (Kubernetes)](https://kubernetes.io/docs/home/)

### [Kubernetes Documentation](https://kubernetes.io/docs/home/)

- [Understand Kubernetes](https://kubernetes.io/docs/concepts/)
  
  Learn about Kubernetes and its fundamental concepts.
  - Why Kubernetes?
  - Components of a cluster
  - The Kubernetes API
  - Objects In Kubernetes
  - Containers
  - Workloads and Pods
  
- [Try Kubernetes](https://kubernetes.io/docs/tutorials/)
  
  Follow tutorials to learn how to deploy applications in Kubernetes.
  
  - Hello Minikube
  - Walkthrough the basics
  - Stateless Example: PHP Guestbook with Redis
  - Stateful Example: Wordpress with Persistent Volumes
  
- [Set up a K8s cluster](https://kubernetes.io/docs/setup/)
  
  Get Kubernetes running based on your resources and needs.

  - Learning environment
  - Production environment
  - Install the kubeadm setup tool
  - Securing a cluster
  - kubeadm command reference
  
- [Learn how to use Kubernetes](https://kubernetes.io/docs/tasks/)
  
  Look up common tasks and how to perform them using a short sequence of steps.
  
  - kubectl Quick Reference
  - Install kubectl
  - Configure access to clusters
  - Use the Web UI Dashboard
  - Configure a Pod to Use a ConfigMap
  - Getting help

- [Look up reference information](https://kubernetes.io/docs/reference/)
  
  Browse terminology, command line syntax, API resource types, and setup tool documentation.
  
  - Glossary
  - kubectl command line tool
  - Labels, annotations and taints
  - Kubernetes API reference
  - Overview of API
  - Feature Gates

- [Contribute to Kubernetes](https://kubernetes.io/docs/contribute/)
  
  Find out how you can help make Kubernetes better.
  
  - Contribute to Kubernetes
  - Contribute to documentation
  - Suggest content improvements
  - Opening a pull request
  - Documenting a feature for a release
  - Localizing the docs
  - Participating in SIG Docs
  - Viewing Site Analytics
  
- [Training](https://kubernetes.io/training/)
  
  Get certified in Kubernetes and make your cloud native projects successful!
  
- [Download Kubernetes](https://kubernetes.io/releases/download/)
  
  Install Kubernetes or upgrade to the newest version.
  
- [About the documentation](https://kubernetes.io/docs/home/supported-doc-versions/)
  
  This website contains documentation for the current and previous 4 versions of Kubernetes.
  

### [Getting started](https://kubernetes.io/docs/setup/)

- [Learning environment](https://kubernetes.io/docs/setup/#learning-environment)
- [Production environment](https://kubernetes.io/docs/setup/#production-environment)
- [What's next](https://kubernetes.io/docs/setup/#what-s-next)
  - [Download Kubernetes](https://kubernetes.io/releases/download/)
  - Download and [install tools](https://kubernetes.io/docs/tasks/tools/) including `kubectl`
  - Select a [container runtime](https://kubernetes.io/docs/setup/production-environment/container-runtimes/) for your new cluster
  - Learn about [best practices](https://kubernetes.io/docs/setup/best-practices/) for cluster setup
  
  Kubernetes is designed for its control plane to run on Linux. Within your cluster you can run applications on Linux or other operating systems, including Windows.
  - Learn to set up clusters with Windows nodes
  

  - [Container Runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
  - Installing Kubernetes with deployment tools

    tools|descriptions
    ---|---
    [kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)|
    [Cluster API](https://cluster-api.sigs.k8s.io/)|A Kubernetes sub-project focused on providing declarative APIs and tooling to simplify provisioning, upgrading, and operating multiple Kubernetes clusters.
    [kops](https://kops.sigs.k8s.io/)|An automated cluster provisioning tool. For tutorials, best practices, configuration options and information on reaching out to the community, please check the `kOps` [website](https://kops.sigs.k8s.io/) for details.
    [jubespray](https://kubespray.io/)|A composition of Ansible playbooks, inventory, provisioning tools, and domain knowledge for generic OS/Kubernetes clusters configuration management tasks.

    - [Bootstrapping clusters with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)
      - Installing kubeadm
      - Troubleshooting kubeadm
      - Creating a cluster with kubeadm
      - Customizing components with the kubeadm API
      - Options for Highly Available Topology
      - Creating Highly Available Clusters with kubeadm
      - Set up a High Availability etcd Cluster with kubeadm
      - Configuring each kubelet in your cluster using kubeadm
      - Dual-stack support with kubeadm
  - [Turnkey Cloud Solutions](https://kubernetes.io/docs/setup/production-environment/turnkey-solutions/)
- [Best practices](https://kubernetes.io/docs/setup/best-practices/)
  - [Considerations for large clusters](https://kubernetes.io/docs/setup/best-practices/cluster-large/)
  - [Running in multiple zones](https://kubernetes.io/docs/setup/best-practices/multiple-zones/)
  - [Validate node setup](https://kubernetes.io/docs/setup/best-practices/node-conformance/)
  - [Enforcing Pod Security Standards](https://kubernetes.io/docs/setup/best-practices/enforcing-pod-security-standards/)
  - [PKI certificates and requirements](https://kubernetes.io/docs/setup/best-practices/certificates/)

### [Concepts](https://kubernetes.io/docs/concepts/)

- [Overview](https://kubernetes.io/docs/concepts/overview/)
  
  Kubernetes is a portable, extensible, open source platform for managing containerized workloads and services, that facilitates both declarative configuration and automation. It has a large, rapidly growing ecosystem. Kubernetes services, support, and tools are widely available.

  Why you need Kubernetes and what it can do.

  Features|Descriptions
  ---|---
  Service discovery and load balancing|Kubernetes can expose a container using the DNS name or using their own IP address. If traffic to a container is high, Kubernetes is able to load balance and distribute the network traffic so that the deployment is stable.
  Storage orchestration|Kubernetes allows you to automatically mount a storage system of your choice, such as local storages, public cloud providers, and more.
  Automated rollouts and rollbacks|You can describe the desired state for your deployed containers using Kubernetes, and it can change the actual state to the desired state at a controlled rate. For example, you can automate Kubernetes to create new containers for your deployment, remove existing containers and adopt all their resources to the new container.
  Automatic bin packing| You provide Kubernetes with a cluster of nodes that it can use to run containerized tasks. You tell Kubernetes how much CPU and memory (RAM) each container needs. Kubernetes can fit containers onto your nodes to make the best use of your resources.
  Self-healing|Kubernetes restarts containers that fail, replaces containers, kills containers that don't respond to your user-defined health check, and doesn't advertise them to clients until they are ready to serve.
  Secret and configuration management|Kubernetes lets you store and manage sensitive information, such as passwords, OAuth tokens, and SSH keys. You can deploy and update secrets and application configuration without rebuilding your container images, and without exposing secrets in your stack configuration.
  Batch execution|In addition to services, Kubernetes can manage your batch and CI workloads, replacing containers that fail, if desired.
  Horizontal scaling|Scale your application up and down with a simple command, with a UI, or automatically based on CPU usage.
  IPv4/IPv6 dual-stack|Allocation of IPv4 and IPv6 addresses to Pods and Services
  Designed for extensibility|Add features to your Kubernetes cluster without changing upstream source code.

  What Kubernetes is not 

  #|Kubernetes:
  ---|---
  1|**Does not limit the types of applications supported.** Kubernetes aims to support an extremely diverse variety of workloads, including stateless, stateful, and data-processing workloads. If an application can run in a container, it should run great on Kubernetes.
  2|**Does not deploy source code and does not build your application.** Continuous Integration, Delivery, and Deployment (CI/CD) workflows are determined by organization cultures and preferences as well as technical requirements.
  3|**Does not provide application-level services, such as middleware (for example, message buses), data-processing frameworks (for example, Spark), databases (for example, MySQL), caches, nor cluster storage systems (for example, Ceph) as built-in services.** Such components can run on Kubernetes, and/or can be accessed by applications running on Kubernetes through portable mechanisms, such as the Open Service Broker.
  4|**Does not dictate logging, monitoring, or alerting solutions.** It provides some integrations as proof of concept, and mechanisms to collect and export metrics.
  5|**Does not provide nor mandate a configuration language/system (for example, Jsonnet).** It provides a declarative API that may be targeted by arbitrary forms of declarative specifications.
  6|**Does not provide nor adopt any comprehensive machine configuration, maintenance, management, or self-healing systems.**
  7|Additionally, **Kubernetes is not a mere orchestration system. In fact, it eliminates the need for orchestration.** The technical definition of orchestration is execution of a defined workflow: first do A, then B, then C. In contrast, Kubernetes comprises a set of independent, composable control processes that continuously drive the current state towards the provided desired state. It shouldn't matter how you get from A to C. Centralized control is also not required. This results in a system that is easier to use and more powerful, robust, resilient, and extensible.

  Historical context for Kubernetes

  ![](/assets/img/blog/historical_context_for_kebernetes.png)
  
  history|hescriptions
  ---|---
  Traditional deployment|Early on, organizations ran applications on physical servers. There was no way to define resource boundaries for applications in a physical server, and this caused resource allocation issues. For example, if multiple applications run on a physical server, there can be instances where one application would take up most of the resources, and as a result, the other applications would underperform. A solution for this would be to run each application on a different physical server. But this did not scale as resources were underutilized, and it was expensive for organizations to maintain many physical servers.
  Virtualized deployment|As a solution, virtualization was introduced. It allows you to run multiple Virtual Machines (VMs) on a single physical server's CPU. Virtualization allows applications to be isolated between VMs and provides a level of security as the information of one application cannot be freely accessed by another application.</br></br>Virtualization allows better utilization of resources in a physical server and allows better scalability because an application can be added or updated easily, reduces hardware costs, and much more. With virtualization you can present a set of physical resources as a cluster of disposable virtual machines.</br></br>Each VM is a full machine running all the components, including its own operating system, on top of the virtualized hardware.
  Container deployment|Containers are similar to VMs, but they have relaxed isolation properties to share the Operating System (OS) among the applications. Therefore, containers are considered lightweight. Similar to a VM, a container has its own filesystem, share of CPU, memory, process space, and more. As they are decoupled from the underlying infrastructure, they are portable across clouds and OS distributions.</br></br>Containers have become popular because they provide extra benefits, such as:</br></br>- Agile application creation and deployment: increased ease and efficiency of container image creation compared to VM image use.</br>- Continuous development, integration, and deployment: provides for reliable and frequent container image build and deployment with quick and efficient rollbacks (due to image immutability).</br>- Dev and Ops separation of concerns: create application container images at build/release time rather than deployment time, thereby decoupling applications from infrastructure.</br>- Observability: not only surfaces OS-level information and metrics, but also application health and other signals.</br>- Environmental consistency across development, testing, and production: runs the same on a laptop as it does in the cloud.</br>- Cloud and OS distribution portability: runs on Ubuntu, RHEL, CoreOS, on-premises, on major public clouds, and anywhere else.</br>- Application-centric management: raises the level of abstraction from running an OS on virtual hardware to running an application on an OS using logical resources.</br>- Loosely coupled, distributed, elastic, liberated micro-services: applications are broken into smaller, independent pieces and can be deployed and managed dynamically – not a monolithic stack running on one big single-purpose machine.</br>- Resource isolation: predictable application performance.</br>- Resource utilization: high efficiency and density


  - Kubernetes Components
  - Objects In Kubernetes
    - Kubernetes Object Management
    - Object Names and IDs
    - Labels and Selectors
    - Namespaces
    - Annotations
    - Field Selectors
    - Finalizers
    - Owners and Dependents
    - Recommended Labels
  - The Kubernetes API
- [Cluster Architecture](https://kubernetes.io/docs/concepts/architecture/)
  - Nodes
  - Communication between Nodes and the Control Plane
  - Controllers
  - Leases
  - Cloud Controller Manager
  - About cgroup v2
  - Container Runtime Interface (CRI)
  - Garbage Collection
  - Mixed Version Proxy
- [Containers](https://kubernetes.io/docs/concepts/containers/)
  - Images
  - Container Environment
  - Runtime Class
  - Container Lifecycle Hooks
- [Workloads](https://kubernetes.io/docs/concepts/workloads/)
  - Pods
    - Pod Lifecycle
    - Init Containers
    - Sidecar Containers
    - Ephemeral Containers
    - Disruptions
    - Pod Quality of Service Classes
    - User Namespaces
    - Downward API
  - Workload Management
    - Deployments
    - ReplicaSet
    - StatefulSets
    - DaemonSetJobs
    - Automatic Cleanup for Finished Jobs
    - CronJob
    - ReplicationController
  - Autoscaling Workloads
  - Managing Workloads
- [Services, Load Balancing, and Networking](https://kubernetes.io/docs/concepts/services-networking/)
  - Service
  - Ingress
  - Ingress Controllers
  - Gateway API
  - EndpointSlices
  - Network Policies
  - DNS for Services and Pods
  - IPv4/IPv6 dual-stack
  - Topology Aware Routing
  - Networking on Windows
  - Service ClusterIP allocation
  - Service Internal Traffic Policy
- [Storage](https://kubernetes.io/docs/concepts/storage/)
  - Volumes
  - Persistent Volumes
  - Projected Volumes
  - Ephemeral Volumes
  - Storage Classes
  - Volume Attributes Classes
  - Dynamic Volume Provisioning
  - Volume Snapshots
  - Volume Snapshot Classes
  - CSI Volume Cloning
  - Storage Capacity
  - Node-specific Volume Limits
  - Volume Health Monitoring
  - Windows Storage
- [Configuration](https://kubernetes.io/docs/concepts/configuration/)
  - Configuration Best Practices
  - ConfigMaps
  - Secrets
  - Liveness, Readiness, and Startup Probes
  - Resource Management for Pods and Containers
  - Organizing Cluster Access Using kubeconfig Files
  - Resource Management for Windows nodes
- [Security](https://kubernetes.io/docs/concepts/security/)
  - Cloud Native Security and Kubernetes
  - Pod Security Standards
  - Pod Security Admission
  - Service Accounts
  - ~~Pod Security Policies~~
  - Security For Windows Nodes
  - Controlling Access to the Kubernetes API
  - Role Based Access Control Good Practices
  - Good practices for Kubernetes Secrets
  - Multi-tenancy
  - Hardening Guide - Authentication Mechanisms
  - Kubernetes API Server Bypass Risks
  - Linux kernel security constraints for Pods and containers
  - Security Checklist
  - Application Security Checklist
- [Policies](https://kubernetes.io/docs/concepts/policy/)
  - Limit Ranges
  - Resource Quotas
  - Process ID Limits And Reservations
  - Node Resource Managers
- [Scheduling, Preemption and Eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/)
  - Kubernetes Scheduler
  - Assigning Pods to Nodes
  - Pod Overhead
  - Pod Topology Spread Constraints
  - Taints and Tolerations
  - Scheduling Framework
  - Dynamic Resource Allocation
  - Scheduler Performance Tuning
  - Resource Bin Packing for Extended Resources
  - Pod Priority and Preemption
  - Node-pressure Eviction
  - API-initiated Eviction
- [Cluster Administration](https://kubernetes.io/docs/concepts/cluster-administration/)
  - Node Shutdowns
  - Certificates
  - Cluster Networking
  - Logging Architecture
  - Metrics For Kubernetes System Components
  - Metrics for Kubernetes Object States
  - System Logs
  - Traces For Kubernetes System Components
  - Proxies in Kubernetes
  - API Priority and Fairness
  - Cluster Autoscaling
  - Installing Addons
  - Coordinated Leader Election
- [Windows in Kubernetes](https://kubernetes.io/docs/concepts/windows/)
  - Windows containers in Kubernetes
  - Guide for Running Windows Containers in Kubernetes
- [Extending Kubernetes](https://kubernetes.io/docs/concepts/extend-kubernetes/)
  - Compute, Storage, and Networking Extensions
  - Extending the Kubernetes API
  - Operator pattern


### [Tasks](https://kubernetes.io/docs/tasks/)

- Install Tools

  Tools|Descriptions
  ---|---
  [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/)|The Kubernetes command-line tool, kubectl, allows you to run commands against Kubernetes clusters. You can use kubectl to deploy applications, inspect and manage cluster resources, and view logs
  [kind](https://kind.sigs.k8s.io/)|kind lets you run Kubernetes on your local computer. This tool requires that you have either Docker or Podman installed. [view](https://kind.sigs.k8s.io/docs/user/quick-start/)
  [minikube](https://minikube.sigs.k8s.io/)|Like kind, minikube is a tool that lets you run Kubernetes locally. minikube runs an all-in-one or a multi-node local Kubernetes cluster on your personal computer (including Windows, macOS and Linux PCs) so that you can try out Kubernetes, or for daily development work. [view](https://minikube.sigs.k8s.io/docs/start/)
  [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/)|You can use the kubeadm tool to create and manage Kubernetes clusters. It performs the actions necessary to get a minimum viable, secure cluster up and running in a user friendly way. [view](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

  - [Install and Set Up kubectl on Linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
  - [Install and Set Up kubectl on macOS](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/)
  - [Install and Set Up kubectl on Windows](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/)
- Administer a Cluster
  - [Administration with kubeadm](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/)
    - Adding Linux worker nodes
    - Adding Windows worker nodes
    - Upgrading kubeadm clusters
    - Upgrading Linux nodes
    - Upgrading Windows nodes
    - Configuring a cgroup driver
    - Certificate Management with kubeadm
    - Reconfiguring a kubeadm cluster
    - Changing The Kubernetes Package Repository
  - [Overprovision Node Capacity For A Cluster](https://kubernetes.io/docs/tasks/administer-cluster/node-overprovisioning/)
  - [Migrating from dockershim](https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/)
    - Changing the Container Runtime on a Node from Docker Engine to containerd
    - Migrate Docker Engine nodes from dockershim to cri-dockerd
    - Find Out What Container Runtime is Used on a Node
    - Troubleshooting CNI plugin-related errors
    - Check whether dockershim removal affects you
    - Migrating telemetry and security agents from dockershim
  - [Generate Certificates Manually](https://kubernetes.io/docs/tasks/administer-cluster/certificates/)
  - [Manage Memory, CPU, and API Resources](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/)
    - Configure Default Memory Requests and Limits for a Namespace
    - Configure Default CPU Requests and Limits for a Namespace
    - Configure Minimum and Maximum Memory Constraints for a Namespace
    - Configure Minimum and Maximum CPU Constraints for a Namespace
    - Configure Memory and CPU Quotas for a Namespace
    - Configure a Pod Quota for a Namespace
  - [Install a Network Policy Provider](https://kubernetes.io/docs/tasks/administer-cluster/network-policy-provider/)
    - Use Antrea for NetworkPolicy
    - Use Calico for NetworkPolicy
    - Use Cilium for NetworkPolicy
    - Use Kube-router for NetworkPolicy
    - Romana for NetworkPolicy
    - Weave Net for NetworkPolicy
  - [Access Clusters Using the Kubernetes API](https://kubernetes.io/docs/tasks/administer-cluster/access-cluster-api/)
  - [Advertise Extended Resources for a Node](https://kubernetes.io/docs/tasks/administer-cluster/extended-resource-node/)
  - [Autoscale the DNS Service in a Cluster](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)
  - [Change the Access Mode of a PersistentVolume to ReadWriteOncePod](https://kubernetes.io/docs/tasks/administer-cluster/change-pv-access-mode-readwriteoncepod/)
  - [Change the default StorageClass](https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/)
  - [Switching from Polling to CRI Event-based Updates to Container Status](https://kubernetes.io/docs/tasks/administer-cluster/switch-to-evented-pleg/)
  - [Change the Reclaim Policy of a PersistentVolume](https://kubernetes.io/docs/tasks/administer-cluster/change-pv-reclaim-policy/)
  - [Cloud Controller Manager Administration](https://kubernetes.io/docs/tasks/administer-cluster/running-cloud-controller/)
  - [Configure a kubelet image credential provider](https://kubernetes.io/docs/tasks/administer-cluster/kubelet-credential-provider/)
  - [Configure Quotas for API Objects](https://kubernetes.io/docs/tasks/administer-cluster/quota-api-object/)
  - [Control CPU Management Policies on the Node](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/)
  - [Control Topology Management Policies on a node](https://kubernetes.io/docs/tasks/administer-cluster/topology-manager/)
  - [Customizing DNS Service](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)
  - [Debugging DNS Resolution](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/)
  - [Declare Network Policy](https://kubernetes.io/docs/tasks/administer-cluster/declare-network-policy/)
  - [Developing Cloud Controller Manager](https://kubernetes.io/docs/tasks/administer-cluster/developing-cloud-controller-manager/)
  - [Enable Or Disable A Kubernetes API](https://kubernetes.io/docs/tasks/administer-cluster/enable-disable-api/)
  - [Encrypting Confidential Data at Rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)
  - [Decrypt Confidential Data that is Already Encrypted at Rest](https://kubernetes.io/docs/tasks/administer-cluster/decrypt-data/)
  - [Guaranteed Scheduling For Critical Add-On Pods](https://kubernetes.io/docs/tasks/administer-cluster/guaranteed-scheduling-critical-addon-pods/)
  - [IP Masquerade Agent User Guide](https://kubernetes.io/docs/tasks/administer-cluster/ip-masq-agent/)
  - [Limit Storage Consumption](https://kubernetes.io/docs/tasks/administer-cluster/limit-storage-consumption/)
  - [Migrate Replicated Control Plane To Use Cloud Controller Manager](https://kubernetes.io/docs/tasks/administer-cluster/controller-manager-leader-migration/)
  - [Namespaces Walkthrough](https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/)
  - [Operating etcd clusters for Kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)
  - [Reserve Compute Resources for System Daemons](https://kubernetes.io/docs/tasks/administer-cluster/reserve-compute-resources/)
  - [Running Kubernetes Node Components as a Non-root User](https://kubernetes.io/docs/tasks/administer-cluster/kubelet-in-userns/)
  - [Safely Drain a Node](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/)
  - [Securing a Cluster](https://kubernetes.io/docs/tasks/administer-cluster/securing-a-cluster/)
  - [Set Kubelet Parameters Via A Configuration File](https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/)
  - [Share a Cluster with Namespaces](https://kubernetes.io/docs/tasks/administer-cluster/namespaces/)
  - [Upgrade A Cluster](https://kubernetes.io/docs/tasks/administer-cluster/cluster-upgrade/)
  - [Use Cascading Deletion in a Cluster](https://kubernetes.io/docs/tasks/administer-cluster/use-cascading-deletion/)
  - [Using a KMS provider for data encryption](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/)
  - [Using CoreDNS for Service Discovery](https://kubernetes.io/docs/tasks/administer-cluster/coredns/)
  - [Using NodeLocal DNSCache in Kubernetes Clusters](https://kubernetes.io/docs/tasks/administer-cluster/nodelocaldns/)
  - [Using sysctls in a Kubernetes Cluster](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/)
  - [Utilizing the NUMA-aware Memory Manager](https://kubernetes.io/docs/tasks/administer-cluster/memory-manager/)
  - [Verify Signed Kubernetes Artifacts](https://kubernetes.io/docs/tasks/administer-cluster/verify-signed-artifacts/)
- Configure Pods and Containers
  - Assign Memory Resources to Containers and Pods
  - Assign CPU Resources to Containers and Pods
  - Configure GMSA for Windows Pods and containers
  - Resize CPU and Memory Resources assigned to Containers
  - Configure RunAsUserName for Windows pods and containers
  - Create a Windows HostProcess Pod
  - Configure Quality of Service for Pods
  - Assign Extended Resources to a Container
  - Configure a Pod to Use a Volume for Storage
  - Configure a Pod to Use a PersistentVolume for Storage
  - Configure a Pod to Use a Projected Volume for Storage
  - Configure a Security Context for a Pod or Container
  - Configure Service Accounts for Pods
  - Pull an Image from a Private Registry
  - Configure Liveness, Readiness and Startup Probes
  - Assign Pods to Nodes
  - Assign Pods to Nodes using Node Affinity
  - Configure Pod Initialization
  - Attach Handlers to Container Lifecycle Events
  - Configure a Pod to Use a ConfigMap
  - Share Process Namespace between Containers in a Pod
  - Use a User Namespace With a Pod
  - Use an Image Volume With a Pod
  - Create static Pods
  - Translate a Docker Compose File to Kubernetes Resources
  - Enforce Pod Security Standards by Configuring the Built-in Admission Controller
  - Enforce Pod Security Standards with Namespace Labels
  - Migrate from PodSecurityPolicy to the Built-In PodSecurity Admission Controller
- Monitoring, Logging, and Debugging
  - Troubleshooting Applications
    - Debug Pods
    - Debug Services
    - Debug a StatefulSet
    - Determine the Reason for Pod Failure
    - Debug Init Containers
    - Debug Running Pods
    - Get a Shell to a Running Container
  - Troubleshooting Clusters
    - Troubleshooting kubectl
    - Resource metrics pipeline
    - Tools for Monitoring Resources
    - Monitor Node Health
    - Debugging Kubernetes nodes with crictl
    - Auditing
    - Debugging Kubernetes Nodes With Kubectl
    - Developing and debugging services locally using telepresence
    - Windows debugging tips
- Manage Kubernetes Objects
  - Declarative Management of Kubernetes Objects Using Configuration Files
  - Declarative Management of Kubernetes Objects Using Kustomize
  - Managing Kubernetes Objects Using Imperative Commands
  - Imperative Management of Kubernetes Objects Using Configuration Files
  - Update API Objects in Place Using kubectl patch
  - Migrate Kubernetes Objects Using Storage Version Migration
- Managing Secrets
  - Managing Secrets using kubectl
  - Managing Secrets using Configuration File
  - Managing Secrets using Kustomize
- Inject Data Into Applications
  - Define a Command and Arguments for a Container
  - Define Dependent Environment Variables
  - Define Environment Variables for a Container
  - Expose Pod Information to Containers Through Environment Variables
  - Expose Pod Information to Containers Through Files
  - Distribute Credentials Securely Using Secrets
- Run Applications
  - Run a Stateless Application Using a Deployment
  - Run a Single-Instance Stateful Application
  - Run a Replicated Stateful Application
  - Scale a StatefulSet
  - Delete a StatefulSet
  - Force Delete StatefulSet Pods
  - Horizontal Pod Autoscaling
  - HorizontalPodAutoscaler Walkthrough
  - Specifying a Disruption Budget for your Application
  - Accessing the Kubernetes API from a Pod
- Run Jobs
  - Running Automated Tasks with a CronJob
  - Coarse Parallel Processing Using a Work Queue
  - Fine Parallel Processing Using a Work Queue
  - Indexed Job for Parallel Processing with Static Work Assignment
  - Job with Pod-to-Pod Communication
  - Parallel Processing using Expansions
  - Handling retriable and non-retriable pod failures with Pod failure policy
- Access Applications in a Cluster
  - Deploy and Access the Kubernetes Dashboard
  - Accessing Clusters
  - Configure Access to Multiple Clusters
  - Use Port Forwarding to Access Applications in a Cluster
  - Use a Service to Access an Application in a Cluster
  - Connect a Frontend to a Backend Using Services
  - Create an External Load Balancer
  - List All Container Images Running in a Cluster
  - Set up Ingress on Minikube with the NGINX Ingress Controller
  - Communicate Between Containers in the Same Pod Using a Shared Volume
  - Configure DNS for a Cluster
  - Access Services Running on Clusters
- Extend Kubernetes
  - Configure the Aggregation Layer
  - Use Custom Resources
    - Extend the Kubernetes API with CustomResourceDefinitions
    - Versions in CustomResourceDefinitions
  - Set up an Extension API Server
  - Configure Multiple Schedulers
  - Use an HTTP Proxy to Access the Kubernetes API
  - Use a SOCKS5 Proxy to Access the Kubernetes API
  - Set up Konnectivity service
- TLS
  - Configure Certificate Rotation for the Kubelet
  - Manage TLS Certificates in a Cluster
  - Manual Rotation of CA Certificates
- Manage Cluster Daemons
  - Perform a Rolling Update on a DaemonSet
  - Perform a Rollback on a DaemonSet
  - Running Pods on Only Some Nodes
- Networking
  - Adding entries to Pod /etc/hosts with HostAliases
  - Extend Service IP Ranges
  - Validate IPv4/IPv6 dual-stack
- Extend kubectl with plugins
- Manage HugePages
- Schedule GPUs

### [Tutorials](https://kubernetes.io/docs/tutorials/)

- Hello Minikube
- Learn Kubernetes Basics
  - Create a Cluster
  - Deploy an App
  - Explore Your App
  - Expose Your App Publicly
  - Scale Your App
  - Update Your App
- Configuration
  - Updating Configuration via a ConfigMap
  - Configuring Redis using a ConfigMap
  - Adopting Sidecar Containers
- Security
  - Apply Pod Security Standards at the Cluster Level
  - Apply Pod Security Standards at the Namespace Level
  - Restrict a Container's Access to Resources with AppArmor
  - Restrict a Container's Syscalls with seccomp
- Stateless Applications
  - Exposing an External IP Address to Access an Application in a Cluster
  - Example: Deploying PHP Guestbook application with Redis
- Stateful Applications
  - StatefulSet Basics
  - Example: Deploying WordPress and MySQL with Persistent Volumes
  - Example: Deploying Cassandra with a StatefulSet
  - Running ZooKeeper, A Distributed System Coordinator
- Cluster Management
  - Running Kubelet in Standalone Mode
- Services
  - Connecting Applications with Services
  - Using Source IP
  - Explore Termination Behavior for Pods And Their Endpoints

### [Reference](https://kubernetes.io/docs/reference/)

- Glossary
- API Overview
- API Access Control
- Well-Known Labels, Annotations and Taints
- Kubernetes API
- Instrumentation
- Kubernetes Issues and Security
- Node Reference Information
- Networking Reference
- Setup tools
- Command line tool (kubectl)
- Component tools
- Debug cluster
- Configuration APIs
- External APIs
- Scheduling
- Other Tools

### [Contribute to Kubernetes](https://kubernetes.io/docs/contribute/)

- Contribute to Kubernetes Documentation
- Suggesting content improvements
- Contributing new content
  - Opening a pull request
  - Documenting for a release
  - Blogs and case studies
- Reviewing changes
  - Reviewing pull requests
  - For approvers and reviewers
- Localizing Kubernetes documentation
- Participating in SIG Docs
  - Roles and responsibilities
  - Issue Wranglers
  - PR wranglers
- Documentation style overview
  - Content guide
  - Style guide
  - Diagram guide
  - Writing a new topic
  - Page content types
  - Content organization
  - Custom Hugo Shortcodes
- Updating Reference Documentation
  - Quickstart
  - Contributing to the Upstream Kubernetes Code
  - Generating Reference Documentation for the Kubernetes API
  - Generating Reference Documentation for kubectl Commands
  - Generating Reference Documentation for Metrics
  - Generating Reference Pages for Kubernetes Components and Tools
- Advanced contributing
- Viewing Site Analytics