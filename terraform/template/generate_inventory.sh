#!/bin/bash

cat << EOF
all:
  hosts:
EOF

# Iterate over the keys and values in the JSON output
terraform output -json dnat_ssh_ports | jq -r 'to_entries[] | .key as $key | .value as $port | "\($key): \(.value)"' | while IFS=: read -r host port; do
  cat << EOF
    $host:
      ansible_host: public_ip # Replace with the actual public IP variable
      ansible_port: "$port"
EOF
done
