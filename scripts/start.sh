#!/bin/bash

# Pod entrypoint that configures the CMD_FLAGS.txt and then run start_linux.sh

# Make the web UI reachable from your local network
CMD_FLAGS="--listen"

# If AUTH_USER is empty or not set, set the default: admin
AUTH_USER="${AUTH_USER:-admin}"

# Enable gradio authentication
if [[ -n "$AUTH_PWD" ]]; then
    CMD_FLAGS+=" --gradio-auth $AUTH_USER:$AUTH_PWD"
fi

# Expose the API to the world
if [[ "$EXPOSE_API" =~ ^(y|Y|1)$ ]]; then
    CMD_FLAGS+=" --api --extensions openai"

    # If CMD_FLAGS does not contain --gradio-auth raise an error
    if ! echo "$CMD_FLAGS" | grep -q -- '--gradio-auth'; then
        echo "Error: Covardly refusing to expose the API to the world without --gradio-auth!" >&2
        exit 1
    fi
fi

# Enable trust_remote_code=True while loading the model
if [[ "$TRUST_REMOTE_CODE" =~ ^(y|Y|1)$ ]]; then
    CMD_FLAGS+=" --trust-remote-code"
fi

# Update CMD_FLAGS.txt
echo "$CMD_FLAGS" | xargs > CMD_FLAGS.txt

./start_linux.sh
