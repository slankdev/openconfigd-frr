#!/bin/sh

router_img=slankdev/frr-dev
docker run -td --rm --privileged --name R0 -h R0 $router_img
docker run -td --rm --privileged --name R1 -h R1 $router_img

koko=$GOPATH/bin/koko
sudo $koko -d R0,net0 -d R1,net0

###################
## Router Config ##
###################

cat <<EOF > /tmp/R0.conf
#!/bin/bash
source /etc/bash_completion.d/cli
configure
set interfaces interface net0 ipv4 address 10.0.0.1/24
commit
EOF
docker cp /tmp/R0.conf R0:/tmp/conf.sh
docker exec R0 bash -c "chmod +x /tmp/conf.sh && /tmp/conf.sh"

cat <<EOF > /tmp/R1.conf
#!/bin/bash
source /etc/bash_completion.d/cli
configure
set interfaces interface net0 ipv4 address 10.0.0.2/24
commit
EOF
docker cp /tmp/R1.conf R1:/tmp/conf.sh
docker exec R1 bash -c "chmod +x /tmp/conf.sh && /tmp/conf.sh"

