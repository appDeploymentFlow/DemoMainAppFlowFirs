if [ -n "${WORKER01_PUBLIC_IP}" ]
then
echo "Your public ip is: ${WORKER01_PUBLIC_IP}"
else
echo "public ip doesn't exist"
exit 1
fi