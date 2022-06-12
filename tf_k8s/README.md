README.md
# k8s


## Structure
```
.Public subnet
├──Master
├──Node1
└──Node2

.Private subnet
```

## Swap disable
```
swapoff -a && sed -i '/sawp/s/^/#/' /etc/fstab
```

## Master
```
[ERROR CRI]: container runtime is not running: output: E0612 09:30:47.414402    3743 remote_runtime.go:925] "Status from runtime service failed" err="rpc error: code = Unimplemented desc = unknown service runtime.v1alpha2.RuntimeService"

sudo vi /etc/containerd/config.toml
#disabled_plugins = ["cri"]
:wq

vi /etc/docker/daemon.json
{

  "exec-opts": ["native.cgroupdriver=systemd"],

  "log-driver": "json-file",

  "log-opts": {

    "max-size": "100m"

  },

  "storage-driver": "overlay2"

}

sudo systemctl restart containerd

cat /etc/kubernetes/kubelet.conf > ~/.kube/config
kubeadm reset
ipvsadm --clear
rm -rf ~/.kube/config 
kubeadm init --apiserver-advertise-address=10.0.1.247

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 10.0.1.247:6443 --token 2kqq4x.kgmrqveycwbe8twf \
        --discovery-token-ca-cert-hash sha256:2873c87a4bf49a39544c0982a91416b6ef0c702437ad5921658775fa00ec0df5

The connection to the server 10.0.1.77:6443 was refused - did you specify the right host or port?

export KUBECONFIG=/etc/kubernetes/kubelet.conf

sudo chown ubuntu:ubuntu $HOME/.kube/config
sudo chown -R ubuntu:ubuntu /var/lib/kubelet/

sudo chown ubuntu:ubuntu /etc/kubernetes/admin.conf
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> ~/.bashrc
source .bashrc

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

kubectl get nodes


source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc 


source <(kubeadm completion bash)
echo "source <(kubeadm completion bash)" >> ~/.bashrc 

kubectl run webserver --image=nginx:1.14 --port 80
```

## Waker
```
sudo vi /etc/containerd/config.toml
#disabled_plugins = ["cri"]
:wq

vi /etc/docker/daemon.json
{

  "exec-opts": ["native.cgroupdriver=systemd"],

  "log-driver": "json-file",

  "log-opts": {

    "max-size": "100m"

  },

  "storage-driver": "overlay2"

}

vi /etc/docker/daemon.json
{

  "exec-opts": ["native.cgroupdriver=systemd"],

  "log-driver": "json-file",

  "log-opts": {

    "max-size": "100m"

  },

  "storage-driver": "overlay2"

}

sudo systemctl restart containerd

kubeadm join 10.0.1.247:6443 --token 2kqq4x.kgmrqveycwbe8twf \
        --discovery-token-ca-cert-hash sha256:2873c87a4bf49a39544c0982a91416b6ef0c702437ad5921658775fa00ec0df5

```