# # if you want to get self hosted runner public ip and use it, then follow one of method
# #use below github jobs in you github_workflow

# #for each job github will use fresh bash shell even we are running all jobs in same runner,
# # so if you want make files, directories, and save any bashrc changes (like add public ip in bashrc and use it) will not work through github workflow

# #method-1 get public ip 
# Job1 — Get Worker Public IP

# save_public_ip:
#   runs-on: ['worker01']

#   outputs:
#     public_ip: ${{ steps.get-ip.outputs.public_ip }}

#   steps:
#     - name: Get Worker01 Public IP
#       id: get-ip
#       run: |
#         TOKEN=$(curl -s -X PUT \
#         "http://169.254.169.254/latest/api/token" \
#         -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

#         IP=$(curl -s \
#         -H "X-aws-ec2-metadata-token: $TOKEN" \
#         http://169.254.169.254/latest/meta-data/public-ipv4)

#         echo "Worker01 Public IP: $IP"

#         echo "public_ip=$IP" >> $GITHUB_OUTPUT


# Job2 - Debug Version (Highly Recommended)
# - name: Debug output
#   run: |
#     echo "IP from previous job:"
#     echo "${{ needs.save_public_ip.outputs.public_ip }}"


# Job3 — Use Public IP

# user_public_ip:
#   runs-on: ['worker01']
#   needs: save_public_ip

#   env:
#     WORKER01_PUBLIC_IP: ${{ needs.save_public_ip.outputs.public_ip }}

#   steps:
#     - name: Checkout repo
#       uses: actions/checkout@v5

#     - name: Run script
#       run: bash app/scripts/demo.sh

# #method-2 get public ip using command "curl -s ifconfig.me"
# #only replace below line with job1 run line
# - name: Get Worker01 Public IP
#   id: get-ip
#   run: |
#     IP=$(curl -s ifconfig.me)