#!/bin/bash

WKEY='a9cc73e0430a2a319571e8734c097d46'
KEY=key.enc
IV=$(cat key.iv)

openssl enc -d -aes-128-cbc -K $WKEY -iv "$IV" -in "$KEY" -out ${KEY%.*}

