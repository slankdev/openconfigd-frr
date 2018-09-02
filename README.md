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

```
$ go get github.com/coreswitch/openconfigd/openconfigd
$ go get github.com/slankdev/frr/frrd
```

chech frr is running
```
$ ps aux | grep frr
...
frr      21579  0.0  0.1  38896  5724 ?        S<s  09:14   0:00 /usr/lib/frr/zebra -s 90000000 --daemon -A 127.0.0.1
frr      21586  0.0  0.1 187772  7448 ?        S<sl 09:14   0:00 /usr/lib/frr/bgpd --daemon -A 127.0.0.1
frr      21595  0.0  0.1  37932  4352 ?        S<s  09:14   0:00 /usr/lib/frr/ospfd --daemon -A 127.0.0.1
...
```

start frrd with openconfigd
```
$ cd $GOPATH/bin
$ sudo $GOPATH/bin/openconfigd -y $GOPATH/src/github.com/slankdev/frr/yang &
$ sudo $GOPATH/bin/frrd &
$ cli
router>
```

