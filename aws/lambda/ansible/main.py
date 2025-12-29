#!/usr/bin/env python3
"""
Security Ansible Lambda

"""

import os


def handler(event, context):
    """
        Main lambda function entry point

        @params event: provides the payload passed to the lambda function
        @params context: provides the runtime information to the lambda function
    """

    os.system('ansible-playbook main.yml')
    os.system('df -h')


# if __name__ == "__main__":
#     event = ""
#     context = ""
#     handler(event, context)
