#!/bin/bash

sudo ansible-playbook -i hosts main.yml "$@"
