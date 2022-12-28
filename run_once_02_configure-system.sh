#!/usr/bin/env bash

# public DNS server
#  check faster: https://www.dnsperf.com/#!dns-resolvers
#    2022/12 cloudflare
PUBLIC_DNS_PRIMARY="1.1.1.1"
PUBLIC_DNS_SECONDARY="1.0.0.1"

. $HOME/.local/bin/my_own/_log
. $HOME/.local/bin/my_own/_gather_facts

# gather facts
eval $(get_package_management_method)
eval $(get_system)

# etckeeper settings
eval $(get_escalation_method) $_facts_install git etckeeper 1>/dev/null
eval $(get_escalation_method) etckeeper init

# WSL settings
if $_facts_is_wsl; then
  # overwrite wsl.conf
  eval $(get_escalation_method) tee /etc/wsl.conf <<EOF
[network]
generateResolvConf = false
[boot]
systemd = true
EOF
  # overwrite facts for systemd setting
  _facts_init="systemd"
fi

# Init daemon settings
case "$_facts_init" in
  systemd) \
    # DNS
    #   /etc/systemd/resolved.conf for systemd-resloved
    eval "$(get_escalation_method)" sed -i.bak "/DNS=/Id" /etc/systemd/resolved.conf
    echo "DNS=${PUBLIC_DNS_PRIMARY} ${PUBLIC_DNS_SECONDARY}" | eval "$(get_escalation_method)" tee -a /etc/systemd/resolved.conf
    # disable apt-daily*
    #  see: https://gist.github.com/noromanba/6e062d38fd7fd2cd609a6ef1c26ea7bc
    if systemctl is-active -q apt-daily.timer; then
      eval "$(get_escalation_method)" systemctl stop apt-daily.timer
      eval "$(get_escalation_method)" systemctl disable apt-daily.timer
    fi
    if systemctl is-active -q apt-daily-upgrade.timer; then
      eval "$(get_escalation_method)" systemctl stop apt-daily-upgrade.timer
      eval "$(get_escalation_method)" systemctl disable apt-daily-upgrade.timer
    fi
    eval "$(get_escalation_method)" systemctl daemon-reload
  ;;
  *) \
    # DNS
    #   /etc/resolv.conf
    if [ -f /etc/resolv.conf ]; then
      eval "$(get_escalation_method)" sed -i.bak "/nameserver/Id" /etc/resolv.conf
      eval "$(get_escalation_method)" tee -a /etc/resolv.conf <<EOF
nameserver ${PUBLIC_DNS_PRIMARY}
nameserver ${PUBLIC_DNS_SECONDARY}
EOF
    fi
      ;;
esac

# Docker settings
if [ $_facts_is_docker == false ]; then
  if ! command -v docker ; then
    # install docker
    curl -sL https://get.docker.com | sh
    $(get_escalation_method) gpasswd -a $USER docker
  fi
  $(get_escalation_method) mkdir -p /etc/docker/
  $(get_escalation_method) tee /etc/docker/daemon.json <<EOF
{
  "containerd": "/run/containerd/containerd.sock",
  "debug": true,
  "default-runtime": "runc",
  "dns": ["$PUBLIC_DNS_PRIMARY", "$PUBLIC_DNS_SECONDARY"],
  "features": {"buildkit": true},
  "hosts": ["fd://", "unix:///var/run/docker.sock", "tcp://0.0.0.0:2375"]
}
EOF
  if [ "$_facts_init" == "systemd" ]; then
    # overwrite default option
    $(get_escalation_method) mkdir -p /etc/systemd/system/docker.service.d/
    $(get_escalation_method) tee /etc/systemd/system/docker.service.d/docker.conf <<EOF
[Service]
EnvironmentFile=-/etc/systemd/system/docker.service.d/docker-proxy
ExecStart=
ExecStart=/usr/bin/dockerd --config-file /etc/docker/daemon.json
EOF
    eval "$(get_escalation_method)" systemctl daemon-reload
  else
    eval "$(get_escalation_method)" sed -i.bak "/DOCKER_OPTS=/Id" /etc/default/docker
    echo "DOCKER_OPTS=\"--config-file /etc/docker/daemon.json\"" | eval "$(get_escalation_method)" tee -a /etc/default/docker
  fi
fi

