{ psCfg, pkgs }: "
address=0.0.0.0
enable_auth=true
username=${psCfg.user.name}
password=${psCfg.user.password}
private_key_file=/run/secrets/vnc-key.pem
certificate_file=/run/secrets/vnc-cert.pem
"
