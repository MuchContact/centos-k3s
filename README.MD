1. 配置镜像仓库

  `touch /etc/rancher/k3s/registries.yaml`
  ```
  mirrors:
    docker.io:
      endpoint:
        - "https://bbqhz556.mirror.aliyuncs.com"
  ```

1. 启动server，指定对外IP，避免多网卡问题

  `nohup k3s server --node-ip 192.168.50.200 &`

1. 启动agent

  token在server节点，/var/lib/rancher/k3s/server/node-token

  `nohup k3s agent --server https://k3s01:6443 --token ${token} &`
