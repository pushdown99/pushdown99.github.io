---
description: >
  This chapter shows how to upgrade Hydejack to a newer version. The method depends on how you've installed Hydejack.
hide_description: true
---

# netconfig

## Table of Contents
{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## libyang
```bash
$ git clone https://github.com/CESNET/libyang.git
$ mkdir build; cd build
$ cmake ..
$ make
# make install
```

## pyang
```bash
# git clone https://github.com/mbj4668/pyang.git
# pip install pyang
$ pyang -f tree --hello hello.xml
https://github.com/mbj4668/pyang/wiki/Tutorial
```
## yang namespace
```bash
https://tools.ietf.org/html/rfc6020
apt-get install libxml2-utils
pip install paramiko
https://blogs.cisco.com/getyourbuildon/yang-opensource-tools-for-data-modeling-driven-management
sudo apt-get install php7.2-xml
https://www.juniper.net/documentation/en_US/junos/topics/task/configuration/netconf-configuration-setting-edit-config-mode.html
```
![Yang data model](datamodeldrivenmgmt-550x312.jpg)
https://www.cse.wustl.edu/~jain/cse570-15/ftp/m_20ntc.pdf

apt-get update && apt-get install -y libssl-dev libssl1.0.0

```bash
root@haeyun-VirtualBox:/repos/confd/examples.confd/netconf_notifications# make clean all
rm -rf \
        *.o *.a *.xso *.fxs *.xsd *.ccl \
        *_proto.h \
        ./confd-cdb *.db aaa_cdb.* \
        rollback*/rollback{0..999} rollback{0..999} \
        cli-history \
        host.key host.cert ssh-keydir \
        *.log confderr.log.* \
        etc *.access \
        running.invalid global.data _tmp*
rm -rf notifier notifier_builtin_replay_store *.h interface.*\
        confd_prim.conf 2> /dev/null || true
/repos/confd//bin/confdc --fail-on-warnings  -c -o notif.fxs  notif.yang
/repos/confd//bin/confdc --emit-h notif.h notif.fxs
cc -c -o notifier.o notifier.c -Wall -g -I/repos/confd//include
cc notifier.o /repos/confd//lib/libconfd.a -lpthread -lm  -Wall -g -I/repos/confd//include  -ansi -pedantic -o notifier
cc -c -o notifier_builtin_replay_store.o notifier_builtin_replay_store.c -Wall -g -I/repos/confd//include
notifier_builtin_replay_store.c:135:12: warning: ‘datetime_le’ defined but not used [-Wunused-function]
 static int datetime_le(struct confd_datetime *a, struct confd_datetime *b)
            ^~~~~~~~~~~
cc notifier_builtin_replay_store.o /repos/confd//lib/libconfd.a -lpthread -lm  -Wall -g -I/repos/confd//include  -o notifier_builtin_replay_store
mkdir -p ./confd-cdb
cp /repos/confd//var/confd/cdb/aaa_init.xml ./confd-cdb
ln -s /repos/confd//etc/confd/ssh ssh-keydir
Build complete
```

```bash
├── bin
├── doc
│   ├── api
│   │   ├── econfd
│   │   │   └── pics
│   │   ├── java
│   │   │   ├── com
│   │   │   │   └── tailf
│   │   │   │       ├── cdb
│   │   │   │       │   └── class-use
│   │   │   │       ├── conf
│   │   │   │       │   └── class-use
│   │   │   │       ├── dp
│   │   │   │       │   ├── annotations
│   │   │   │       │   │   └── class-use
│   │   │   │       │   ├── class-use
│   │   │   │       │   ├── proto
│   │   │   │       │   │   └── class-use
│   │   │   │       │   └── services
│   │   │   │       │       └── class-use
│   │   │   │       ├── ha
│   │   │   │       │   └── class-use
│   │   │   │       ├── maapi
│   │   │   │       │   └── class-use
│   │   │   │       ├── navu
│   │   │   │       │   ├── class-use
│   │   │   │       │   └── traversal
│   │   │   │       │       └── class-use
│   │   │   │       ├── notif
│   │   │   │       │   └── class-use
│   │   │   │       ├── proto
│   │   │   │       │   └── class-use
│   │   │   │       └── util
│   │   │   │           └── class-use
│   │   │   ├── conf-api
│   │   │   └── resources
│   │   └── python
│   └── html
│       ├── common
│       │   ├── css
│       │   ├── images
│       │   │   ├── admon
│       │   │   └── callouts
│       │   └── jquery
│       │       ├── layout
│       │       ├── theme-redmond
│       │       │   └── images
│       │       └── treeview
│       │           └── images
│       ├── pics
│       └── search
│           └── stemmers
├── erlang
│   └── econfd
│       ├── doc
│       │   └── pics
│       ├── ebin
│       ├── examples
│       │   ├── action
│       │   ├── conf
│       │   │   └── etc
│       │   │       └── confd
│       │   │           └── ssh
│       │   ├── ncnotif
│       │   ├── procs
│       │   ├── simple_notrans
│       │   ├── test
│       │   │   └── ebin
│       │   └── yaws
│       ├── include
│       └── src
├── etc
│   └── confd
│       └── ssh
├── examples.confd
│   ├── cdb_oper
│   │   ├── ifstatus
│   │   └── loadhist
│   ├── cdb_subscription
│   │   ├── iter
│   │   ├── iter_c
│   │   ├── modifications
│   │   ├── trigger
│   │   └── twophase
│   │       └── logs
│   ├── cdb_upgrade
│   │   ├── moved_servers
│   │   ├── simple
│   │   ├── using_file
│   │   └── using_maapi
│   ├── confdconf
│   │   └── dyncfg
│   ├── crypto
│   │   ├── crypto1
│   │   └── crypto2
│   ├── dp
│   │   ├── delayed_reply
│   │   └── find_next
│   ├── ha
│   │   └── dummy
│   ├── include
│   ├── in_service_upgrade
│   │   ├── simple
│   │   │   ├── pkg
│   │   │   └── src
│   │   │       ├── v1
│   │   │       └── v2
│   │   └── with_helper
│   │       ├── pkg
│   │       └── src
│   │           ├── v1
│   │           └── v2
│   ├── internal_econfd
│   │   ├── embedded_applications
│   │   │   ├── erlang-skeleton
│   │   │   │   └── erlang-lib
│   │   │   │       └── app_skel
│   │   │   │           ├── ebin
│   │   │   │           └── src
│   │   │   ├── transform
│   │   │   │   └── erlang-lib
│   │   │   │       └── ec_transform
│   │   │   │           ├── ebin
│   │   │   │           ├── include
│   │   │   │           └── src
│   │   │   └── user_type
│   │   │       └── erlang-lib
│   │   │           └── ec_user_type
│   │   │               ├── ebin
│   │   │               ├── include
│   │   │               └── src
│   │   └── single_modules
│   │       ├── transform
│   │       └── user_type
│   ├── intro
│   │   ├── 10-c_transform
│   │   │   ├── src
│   │   │   └── yangs
│   │   ├── 11-c_hooks
│   │   ├── 1-2-3-start-query-model
│   │   ├── 12-c_maapi
│   │   ├── 5-c_stats
│   │   ├── 6-c_config
│   │   ├── 7-c_actions
│   │   ├── 8-c_stats_no_key
│   │   └── 9-c_threads
│   ├── kicker
│   ├── linuxcfg
│   │   ├── ietf_interfaces
│   │   ├── ietf_ip
│   │   ├── ietf_routing
│   │   ├── ietf_system
│   │   ├── ipmibs
│   │   │   └── init_data
│   │   ├── scripts
│   │   └── templates
│   ├── logging_framework
│   ├── misc
│   │   ├── aaa_eth0
│   │   ├── aaa_transform
│   │   ├── extern_candidate
│   │   ├── maapi_cli
│   │   ├── maapi_command
│   │   ├── notifications
│   │   └── user_type
│   ├── netconf_confirmed_commit
│   ├── netconf_extensions
│   │   ├── batch_rpc
│   │   └── simple_rpc
│   ├── netconf_notifications
│   │   ├── cli-history
│   │   ├── confd-cdb
│   │   └── ssh-keydir -> /repos/confd//etc/confd/ssh
│   ├── scripting
│   │   └── scripts
│   │       ├── command
│   │       ├── policy
│   │       └── post-commit
│   ├── timeout_and_locks
│   ├── user_guide_examples
│   │   ├── simple_cdb
│   │   ├── simple_notrans
│   │   └── simple_trans
│   └── validate
│       ├── c
│       ├── c_dependency
│       ├── configuration_policy
│       └── xpath_must
├── include
├── java
│   └── jar
├── lib
│   ├── confd
│   │   ├── bin
│   │   ├── erts
│   │   │   └── bin
│   │   └── lib
│   │       ├── cli
│   │       │   └── cli
│   │       │       └── priv
│   │       ├── confdc
│   │       │   ├── confdc
│   │       │   │   └── priv
│   │       │   └── yanger
│   │       │       ├── bin
│   │       │       └── priv
│   │       ├── core
│   │       │   ├── asn1
│   │       │   │   └── priv
│   │       │   │       └── lib
│   │       │   ├── capi
│   │       │   │   └── priv
│   │       │   ├── confd
│   │       │   │   └── priv
│   │       │   ├── crypto
│   │       │   │   └── priv
│   │       │   │       └── lib
│   │       │   ├── inets
│   │       │   │   ├── include
│   │       │   │   └── priv
│   │       │   │       └── bin
│   │       │   ├── kernel
│   │       │   │   └── include
│   │       │   ├── pam
│   │       │   │   └── priv
│   │       │   ├── stdlib
│   │       │   │   └── include
│   │       │   ├── tts
│   │       │   │   └── priv
│   │       │   ├── util
│   │       │   │   └── priv
│   │       │   └── xds
│   │       │       └── priv
│   │       └── netconf
│   │           └── netconf
│   │               └── priv
│   ├── cs2yang
│   └── pyang
│       ├── bin
│       └── pyang
│           ├── plugins
│           └── translators
├── man
│   ├── man1
│   ├── man3
│   ├── man5
│   └── man7
├── src
│   └── confd
│       ├── aaa
│       ├── build
│       ├── cfg
│       ├── cli
│       ├── confd_aaa_bridge
│       ├── configuration_policy
│       ├── dyncfg
│       ├── emacs
│       │   ├── relaxng
│       │   └── yang
│       ├── errors
│       ├── ipc_drv
│       ├── mmap_schema
│       ├── netconf
│       ├── tools
│       └── yang
└── var
    └── confd
        ├── candidate
        ├── cdb
        ├── log
        ├── rollback
        └── state

```
