## 1. 执行disableenforce.sh
## 1. 重启后执行install-docker.sh

## 2. 启动server，指定网卡eth1

INSTALL_K3S_SKIP_DOWNLOAD=true INSTALL_K3S_BIN_DIR=/bin INSTALL_K3S_EXEC="--advertise-address 192.168.50.200 --node-ip 192.168.50.200 --flannel-iface eth1" ./install.sh

## 3. 启动agent

token在server节点，/var/lib/rancher/k3s/server/node-token

INSTALL_K3S_SKIP_DOWNLOAD=true INSTALL_K3S_BIN_DIR=/bin K3S_URL=https://192.168.50.200:6443 K3S_TOKEN=K10fb5c6fec80c760586ae0ce670d4f1904ad99df69d87a0f7db865e6c89db31300::server:93c72c31c6bc73e36497e74898059840 INSTALL_K3S_EXEC="--node-ip 192.168.50.201 --flannel-iface eth1" ./install.sh

INSTALL_K3S_SKIP_DOWNLOAD=true INSTALL_K3S_BIN_DIR=/bin K3S_URL=https://192.168.50.200:6443 K3S_TOKEN=K10fb5c6fec80c760586ae0ce670d4f1904ad99df69d87a0f7db865e6c89db31300::server:93c72c31c6bc73e36497e74898059840 INSTALL_K3S_EXEC="--node-ip 192.168.50.202 --flannel-iface eth1" ./install.sh
http://192.168.50.200:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

http://192.168.50.200:8001/api/v1/namespaces/default/services/my-service:http/
systemctl status firewalld

## 启动dashboard

GITHUB_URL=https://github.com/kubernetes/dashboard/releases
VERSION_KUBE_DASHBOARD=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/latest -o /dev/null | sed -e 's|.*/||')
k3s kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml
k3s kubectl create -f dashboard.admin-user.yml -f dashboard.admin-user-role.yml
k3s kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token

### 编辑服务支持nodeport
k3s kubectl edit service -n kubernetes-dashboard kubernetes-dashboard

## 启动pod
k3s kubectl run hello-minikube --image=registry.cn-qingdao.aliyuncs.com/k8slast/echoserver:1.10 --port=8080
k3s kubectl expose deployment hello-minikube --type=NodePort
