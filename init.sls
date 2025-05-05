install_netdata:
  pkg.installed:
    - name: netdata

netdata_service:
  service.running:
    - name: netdata
    - enable: True

install_micro:
  pkg.installed:
    - name: micro

install_git:
  pkg.installed:
    - name: git

install_apache2:
  pkg.installed:
    - name: apache2

apache2_service:
  service.running:
    - name: apache2
    - enable: True

install_ufw:
  pkg.installed:
    - name: ufw

allow_ssh:
  cmd.run:
    - name: ufw allow 22/tcp

allow_http:
  cmd.run:
    - name: ufw allow 80/tcp

enable_ufw:
  cmd.run:
    - name: ufw enable
