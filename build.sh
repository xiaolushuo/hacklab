echo "Relaunching docker with a new security profile for builder"
sudo systemctl stop docker
sudo dockerd --seccomp-profile ./seccomp/allow.json &
sleep 3
docker image rm hackerfantastic/hacklab
docker build -t hackerfantastic/hacklab .
echo dockerd is currently running with insecure profile - restarting
sudo pkill dockerd
sleep 5
sudo systemctl start docker
echo Ready to run "docker run -it hackerfantastic/hacklab"
