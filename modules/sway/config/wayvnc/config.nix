{ psCfg, pkgs }: "
address=0.0.0.0
enable_auth=true
username=${psCfg.user.name}
password=testtest
private_key_file=/run/agenix/vnc-key.pem
certificate_file=/run/agenix/vnc-cert.pem
"
