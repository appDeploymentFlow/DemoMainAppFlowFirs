import boto3
from botocore.exceptions import ClientError
import requests
# import subprocess
import os
from datetime import datetime
import paramiko
import argparse

#PACKAGE_REQUIRE, install using "sudo apt install python3-paramiko"
#some variables
LOG_FILE="githubRunner.log"
INSTANCE_NAME="worker01"
# INSTANCE_NAME="workStation01"
REGION="us-east-1"
# WORKING_PATH=~/action-runner or $HOME/action-runner or want home path run echo ~ or echo $HOME
WORKING_PATH=os.path.join(os.getenv("HOME"), "action-runner")
REPO_URL="https://github.com/appDeploymentFlow/DemoMainAppFlowFirs"

def make_directory():
    # mkdir -p actions-runner
    # os.makedirs("action-runner", mode=0o755, exist_ok=True)
    os.makedirs(WORKING_PATH, mode=0o755, exist_ok=True)
    # cd actions-runner
    # os.chdir("action-runner")
    os.chdir(WORKING_PATH)
    
def log(message):
    timestamps=datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(LOG_FILE, "a") as f:
        f.write(f"{timestamps} {message}\n")


def get_ec2_connection(region):
    try:
        #directory where all file and log file present
        make_directory()
        parse=argparse.ArgumentParser()
        parse.add_argument("-awsKey", help="aws access key id")
        # auth_awsKey=parse.parse_args()
        parse.add_argument("-awsSecret", help="aws access secret key")
        auth_value=parse.parse_args()
        if not auth_value.awsKey and not auth_value.awsSecret:
            print("aws authentication key and secret required...")
            log(f"❌ERROR: aws authentication key and secret required are not provided..\n")
            raise ValueError("aws authentication key and secret required are not provided..")
        ec2=boto3.client('ec2', region_name=region, aws_access_key_id={auth_value.awsKey}, aws_secret_access_key={auth_value.awsSecret})
        log("CONNECTION: stablished with ec2 ✅")
        print("ec2 connection established..")
        return ec2
    except ClientError as e:
        log(f"❌EXCEPTION: occured duing stablishing connectio with ec2 {e}\n")
        print(e)
        return False


def get_public_ip(instance_name, region):
    try:
        # ec2=get_ec2_connection('us-east-1')
        ec2=get_ec2_connection(region)
        if not ec2:
            print("EC2 connection is not established...")
            log(f"❌ERROR: connection with AWS's EC2 is not estalished..\n")
            raise ValueError("Couldn't make connection with AWS's EC2..")
        # reservations=ec2.describe_instances(Filters=[{'Name':'tag:Name', 'Values':['workStation01']}])
        reservations=ec2.describe_instances(Filters=[{'Name':'tag:Name', 'Values':[instance_name]}])
        for reservation in reservations['Reservations']:
            for instance in reservation['Instances']:
                if instance['State']['Name'] == 'running':
                    log(f"EC2-PUBLIC-IP: get ec2 instance public ip ✅")
                    print(instance.get('PublicIpAddress'))
                    return instance.get('PublicIpAddress')
    except ValueError:
        log("ERROR: EC2 instance public ip couldn't get...❌\n")
        print("instance public ip didn't get")
        return False


def get_runner_token():
    try:
        parse=argparse.ArgumentParser()
        parse.add_argument("-token", help="github auth token")
        auth_token=parse.parse_args()
        if not auth_token.token:
            print("Github authentication token required...")
            log(f"❌ERROR: Github authenticatio access token is not provided..\n")
            raise ValueError("Github authenticatio access token is not provided..")
            #sys.exit(1)
        # RUNNER_TOKEN=\$(curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${1}" -H "X-GitHub-Api-Version: 2026-03-10" https://api.github.com/repos/appDeploymentFlow/DemoMainAppFlowFirs/actions/runners/registration-token | tee response.json | jq -r '.token')
        repo = "appDeploymentFlow/DemoMainAppFlowFirs"
        url = f"https://api.github.com/repos/{repo}/actions/runners/registration-token"
        # token=f"{auth_token}"
        token=auth_token.token
        header = {
            "Accept": "application/vnd.github+json",
            "Authorization": f"Bearer {token}",
            "X-GitHub-Api-Version": "2026-03-10"
        }
        response=requests.post(url, headers=header)

        if response.status_code == 201:
            reg_token=response.json()["token"]
            log("RUNNER_TOKEN_GENERATED: OK✅\n")
            print("join runner token generated....")
            print(reg_token)            #comment it after testing⚠️
            return reg_token
        else:
            log(f"❌FAILED: occured during token generation. {response.json()}\n")
            print("Failed to get token:", response.json())
            return False
    except Exception as e:
        log(f"❌ERROR: occuried during generating runner join token --> {str(e)}\n")
        print(str(e))
        return False


def build_runner_commands(runner_token,runner):
    RUNNER_NAME=runner

# #we can use below command also which is written like we are using in shell script
# #set -e, will stop execution of command when got any error
#     commands = f"""
#     set -e
#     mkdir -p /home/ubuntu/actions-runner
#     cd /home/ubuntu/actions-runner
#     curl -o actions-runner.tar.gz -L https://github.com/actions/runner/releases/download/v2.332.0/actions-runner-linux-x64-2.332.0.tar.gz
#     echo "f2094522a6b9afeab07ffb586d1eb3f190b6457074282796c497ce7dce9e0f2a  actions-runner.tar.gz" | sha256sum -c
#     tar xzf actions-runner.tar.gz
#     ./config.sh --unattended --replace \
#         --url {REPO_URL} \
#         --token {runner_token} \
#         --name {RUNNER_NAME} \
#         --labels linux,ubuntu,x64,{RUNNER_NAME} \
#         --work _work
#     sudo ./svc.sh install
#     sudo ./svc.sh start
#     """

    commands=[
        "mkdir -p action-runner",
        "cd action-runner && curl -o actions-runner-linux-x64-2.332.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.332.0/actions-runner-linux-x64-2.332.0.tar.gz",
        'cd action-runner && echo "f2094522a6b9afeab07ffb586d1eb3f190b6457074282796c497ce7dce9e0f2a  actions-runner-linux-x64-2.332.0.tar.gz" | shasum -a 256 -c',
        "cd action-runner && tar xzf ./actions-runner-linux-x64-2.332.0.tar.gz",
        f"cd action-runner && ./config.sh --unattended --replace --url {REPO_URL} --token {runner_token} --name {RUNNER_NAME} --labels linux,ubuntu,x64,{RUNNER_NAME} --work _work",
        "cd action-runner && sudo ./svc.sh install",
        f"sudo systemctl start  actions.runner.appDeploymentFlow-DemoMainAppFlowFirs.{RUNNER_NAME}.service",
    ]

    return commands

def run_runner_join_remote(IP,runner):
    try:
        runner_join_token=get_runner_token()
        if not runner_join_token:
            log(f"ERROR: Runner join token is not generated...❌\n")
            return 1

        hostname= IP
        username="ubuntu"
        #password="root@123"
        key_file=os.path.join(os.getenv("HOME"), ".ssh/serverPrivate01")
        commands=build_runner_commands(runner_join_token,runner)

        client=paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        # client.connect(hostname, username=username, password=password, look_for_keys=False)
        client.connect(hostname, username=username, key_filename=key_file, look_for_keys=False)

        for command in commands:
            stdin, stdout, stderr = client.exec_command(command)
            log(f"COMMAND: {' '.join(command)}")
            print(stdout.read().decode())
            log(f"STDOUT: {stdout.read().decode()}")
            print(stderr.read().decode())
            log(f"STDERR: {stderr.read().decode()}")
            print(f"COMMAND {command} excuted..")
            
        log("SUCCESS: github installation successfully completed..✅\n")
        print("github join successfully.")
        
        client.close()
        log("SSH CONNECTION: closed..✅")
        return True
    
    except FileNotFoundError:
        log(f"❌ERROR: ssh private key not found...\n")
        print("private key file is not found")
        return False
 
def main():
    # WORKER_IP=get_public_ip('worker01', 'us-east-1')
    WORKER_IP=get_public_ip(INSTANCE_NAME, REGION)
    if not WORKER_IP:
        log(f"ERROR: EC2 instance public ip didn't get...❌\n")
        return 1
    run_runner_join_remote(WORKER_IP,INSTANCE_NAME)


if __name__ == "__main__":
    main()