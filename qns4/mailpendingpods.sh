#!/bin/bash

TO_EMAIL="vdvs99@gmail.com"

SUBJECT="Pending Pods Found!"

PENDING_PODS=$(kubectl get pods --field-selector=status.phase=Pending -o json | jq -r '.items[].metadata.name')
TIMESTAMP=$(date +"data -> %Y-%m-%d  time -> %H-%M-%S")

if [ -n "$PENDING_PODS" ] && [ -n "$TIMESTAMP" ]; then
    echo "$PENDING_PODS - $TIMESTAMP" | ssmtp vdvs99@gmail.com
    echo "Email Sent!"
else
    echo "No pending pods found or timestamp is empty."
fi
