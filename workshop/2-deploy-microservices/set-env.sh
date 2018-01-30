~/.launch.sh
export PATH=$PATH:/root/istio-0.4.0/bin/
echo "Wait while we install Istio in this scenario"
chmod +x /root/install-istio.sh
~/install-istio.sh
