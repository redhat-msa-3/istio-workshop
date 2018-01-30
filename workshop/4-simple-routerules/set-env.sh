~/.launch.sh
echo "Cloning project's git repository "
git clone https://github.com/redhat-developer-demos/istio-tutorial /root/tmp && cp -Rf /root/tmp/* /root/istio-tutorial/ && rm -rf /root/tmp
echo "Wait while we install Istio in this scenario"
chmod +x /root/install-istio.sh
~/install-istio.sh
echo "Wait while we install the microservices in this scenario"
chmod +x /root/install-microservices.sh
~/install-microservices.sh
export PATH=$PATH:/root/istio-0.4.0/bin/
