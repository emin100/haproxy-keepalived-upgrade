Haproxy - Keepalived install - upgrade
=========

Keepalived ve Haproxy 

* Eğer Haproxy yüklü ise verilen versiyona göre güncelleme yapılır.
* Eğer Haproxy yüklü değilse verilen versiyon yüklenir.
* Eğer Keepalived yüklü ise verilen versiyona göre güncelleme yapılır.
* Eğer Keepalived yüklü değilse verilen versiyon yüklenir.

Haproxy - Keepalived  upgrade
---------

Güncelleme sırasında izlenecek adımlar.

* Keepalived için priority master ve backup için eşitlenir. 
* ilk olarak virtual ipyi almamış(Keepalived Backup state tinde olan sunucu) ile güncelleme işlemi başlatılır. 
* Kurulum bitince keepalived -v / haproxy -v ile versiyon kontrolü yapılır.
* journalctl -xe -u haproxy ve journalctl -xe -u keepalived ile servislerin durumu kontrol edilir.
* Daha sonra master state deki makineye güncelleme geçilir.

Haproxy - Keepalived  install
---------

Herhangi bir özel adım bulunmamaktadır.



Haproxy - Keepalived  Extralar
=========

Prometheus Metrics
---------

Haproxy build in exporter ile beraber gelmektedir.

Güncelleme;

Aşağıdaki bloğu haproxy.conf içerisine eklemek gerekmektedir. 

    listen metrics
      bind *:9101
      mode http
      http-request use-service prometheus-exporter if { path /metrics }

Yeni Yükleme;

Aşağıdaki blok haproxy.conf içerisinede yer almaktadır.

    listen metrics
      bind *:9101
      mode http
      http-request use-service prometheus-exporter if { path /metrics }


Ip Kısıtlama
---------

Haproxy üzerinden erişimi kısıtlamak istediğiniz ipler için aşağıdaki kod bloğunu kullanabilirsiniz.
Aşağıdaki kod bloğunda VPN ipleri üzerinden bağlantı yasaklanabilir. Bu alan mutlaka eklenerek son kullanıcıların proxy üzerinden gelmesi engellenmelidir.

    listen read
      acl network_rejected src 10.212.232.0
      tcp-request connection set-src src,ipmask(21)
      tcp-request connection reject if network_rejected

External-check
---------

Pgbouncer ve patronin aynı anda kullanıldığı durumlarda port kontrolü ve patroninin master kontrolün aynı anda yapılması gerekmektedir. Bu işlem için aşağıdaki kod bloğunu kullnabilirsiniz.

    listen read
      option external-check
      external-check path "/usr/bin:/bin:/usr/local/bin:/etc/haproxy"
      external-check command /etc/haproxy/replica.sh

    listen write
      option external-check
      external-check path "/usr/bin:/bin:/usr/local/bin:/etc/haproxy"
      external-check command /etc/haproxy/master.sh


Supported Operating Systems
------------

* CentOS 7.x
* Ubuntu 20.04

Requirements
------------

* Jinja2 >= 2.8
* Ansible >= 2.9

Role Variables
--------------

| Parameter | Default | Exp |
| ------ | ------ | ------ |
| haproxy | true | Haproxy Yükle / Güncelle |
| keepalived | true | Keepalived Yükle / Güncelle |
| haproxy_version | 2.4.4 | Haproxy istenilen versiyon |
| keepalived_version | 2.2.4 | Keepalived istenilen versiyon |
| tmp_directory | /tmp/haproxy-keepalived | Lokal bilgisayarda gerekli dosyaların indirildiği klasör |



Dependencies
------------



Example Playbook
----------------

    - hosts: db
      roles:
        - name: trendyol.haproxy-keepalived
          vars:
            haproxy: true
            keepalived: true
            haproxy_version: 2.4.4
            keepalived_version: 2.2.4
            tmp_directory: /tmp/haproxy-keepalived

Example Inventory
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    [db]
    localhost


    [all:vars]
    ansible_ssh_user=root
    ansible_ssh_password=pass

Running the Playbook
----------------

    ansible-playbook -i inventory deployment.yml

License
-------

BSD

Author Information
------------------

MEK