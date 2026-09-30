install-from-flatcar name:
    sudo mkdir -p /var/lib/extensions /etc/sysupdate.{{name}}.d
    sudo rm -f /etc/sysupdate.{{name}}.d/{{name}}.conf
    printf '%s\n' \
        '[Transfer]' \
        'Verify=false' \
        '' \
        '[Source]' \
        'Type=url-file' \
        'Path=https://extensions.flatcar.org/extensions/{{name}}/' \
        'MatchPattern={{name}}-@v-%a.raw' \
        '' \
        '[Target]' \
        'Type=regular-file' \
        'Path=/var/lib/extensions' \
        'MatchPattern={{name}}_@v.raw' \
        'InstancesMax=2' \
        | sudo tee /etc/sysupdate.{{name}}.d/{{name}}.transfer > /dev/null
    sudo /usr/lib/systemd/systemd-sysupdate -C {{name}} update
    sudo systemd-sysext refresh

docker: (install-from-flatcar "docker")

ollama: (install-from-flatcar "ollama")

nerdctl: (install-from-flatcar "nerdctl")

k3s: (install-from-flatcar "k3s")

rke2: (install-from-flatcar "rke2")

tailscale: (install-from-flatcar "tailscale")
    sudo bash -c 'echo -e "FLAGS=\nPORT=41641" > /etc/default/tailscaled'
