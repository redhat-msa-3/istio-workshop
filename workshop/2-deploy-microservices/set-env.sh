~/.launch.sh
echo "Wait while we install Istio in this scenario"
chmod +x /root/install-istio.sh
~/install-istio.sh
export PATH=$PATH:/root/installation/istio-0.5.0/bin/
cd ~/projects/