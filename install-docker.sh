#!/bin/bash
sudo yum install -y lsof
sudo mkdir -p /etc/rancher/k3s
sudo tee /etc/rancher/k3s/registries.yaml <<-'EOF'
mirrors:
  docker.io:
    endpoint:
      - "https://bbqhz556.mirror.aliyuncs.com"
EOF
## install docker-compose
sudo chmod a+x k3s
mv k3s /usr/bin/k3s

sudo tee /root/dashboard.admin-user.yml <<-'EOF'
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF

sudo tee /root/dashboard.admin-user-role.yml <<-'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF
