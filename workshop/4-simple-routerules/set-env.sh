~/.launch.sh
echo "Wait while we install Istio in this scenario"
chmod +x /root/install-istio.sh
~/install-istio.sh
echo "Wait while we install the microservices in this scenario"
chmod +x /root/install-microservices.sh
~/install-microservices.sh
cp -Rf /root/tmp/* /root/projects/istio-tutorial/ && rm -rf /root/tmp
export PATH=$PATH:/root/installation/istio-0.4.0/bin/
cd ~/projects/