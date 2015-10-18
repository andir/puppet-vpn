VERSION=2013.4.0
 
#apt-get install build-essential 
apt-get install linux-headers-$(uname -r)
#apt-get install pkg-config
#apt-get install libnl-3-dev

git clone https://github.com/freifunk-gluon/batman-adv-legacy.git
cd batman-adv-legacy
make
make install
cd ..
rm -rf batman-adv-legacy

# batman-adv for versions > 2014.3.0
#wget http://downloads.open-mesh.org/batman/releases/batman-adv-$VERSION/batman-adv-$VERSION.tar.gz
#tar -xzf batman-adv-$VERSION.tar.gz
#cd batman-adv-$VERSION/
#make
#make install
#cd ..
#rm -rf batman-adv-$VERSION*

wget http://downloads.open-mesh.org/batman/releases/batman-adv-$VERSION/batctl-$VERSION.tar.gz
tar -xzf batctl-$VERSION.tar.gz
cd batctl-$VERSION/
make
make install
cd ..
rm -rf batctl-$VERSION*

wget http://downloads.open-mesh.org/batman/stable/sources/alfred/alfred-$VERSION.tar.gz
tar -xzf alfred-$VERSION.tar.gz
cd alfred-$VERSION/
make CONFIG_ALFRED_GPSD=n 
make CONFIG_ALFRED_GPSD=n install
cd ..
rm -rf alfred-$VERSION*
