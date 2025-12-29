import os

def lambda_handler(event, context):
    os.system("locale -a")
    os.system("ansible-playbook main.yml")
