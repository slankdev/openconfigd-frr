# FRRd

`frrd` is openconfigd configuration gateway to frr.
This is based on `coreswitch/openconfigd/quagga`.
Following figure shows system architecture.

```
        +---------+
        | cli_cmd +------+
        +----+----+      |
             |           |
          (gRPC)      (gRPC)
             |           |
      +------+------+    |
      | Openconfigd |    |
      +------+------+    |
             |           |
          (gRPC)         |
             |           |
         +---+--+        |
         | FRRd +--------+
         +---+--+
             |
   (zapi/socket/netlink)
             |
       +-----+-----+
       | Linux FIB |
       +-----------+
```

## Install & Run

setup frr and chech it's running
```
$ cd /tmp
$ wget https://github.com/FRRouting/frr/releases/download/frr-5.0.1/frr_5.0.1-1.ubuntu16.04.1_amd64.deb
$ sudo dpkg -i frr_5.0.1*.deb
$ sudo cp /usr/share/doc/frr/examples/bgpd.conf.sample /etc/frr/bgpd.conf
$ sudo cp /usr/share/doc/frr/examples/ospfd.conf.sample /etc/frr/ospfd.conf
$ sudo cp /usr/share/doc/frr/examples/zebra.conf.sample /etc/frr/zebra.conf
$ sudo vim /etc/frr/daemons
~ zebra=yes
~ bgpd=yes
~ ospfd=yes
$ sudo systemctl restart frr
$ ps aux | grep frr
...
frr      21579  0.0  0.1  38896  5724 ?        S<s  09:14   0:00 /usr/lib/frr/zebra -s 90000000 --daemon -A 127.0.0.1
frr      21586  0.0  0.1 187772  7448 ?        S<sl 09:14   0:00 /usr/lib/frr/bgpd --daemon -A 127.0.0.1
frr      21595  0.0  0.1  37932  4352 ?        S<s  09:14   0:00 /usr/lib/frr/ospfd --daemon -A 127.0.0.1
...
```

setup openconfigd
```
$ go get github.com/coreswitch/openconfigd/openconfigd
$ go get github.com/coreswitch/openconfigd/cli_command
$ cd $GOPATH/src/github.com/coreswitch/openconfigd/cli
$ ./configure && make && sudo make install
$ sudo cp $GOPATH/src/github.com/coreswitch/openconfigd/bash_completion.d/cli /etc/bash_completion.d/
```

setup frrd
```
$ go get github.com/slankdev/frr/frrd
```

start frrd with openconfigd
```
$ cd $GOPATH/bin
$ sudo $GOPATH/bin/openconfigd -y $GOPATH/src/github.com/slankdev/frr/yang &
$ sudo $GOPATH/bin/frrd &
$ cli
router>
```

