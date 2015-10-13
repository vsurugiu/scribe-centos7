#!/bin/bash

echo '=================================================='
echo '===============Install necessary tools==============='
echo '=================================================='

sudo yum update
sudo yum -y groupinstall "Development Tools"
sudo yum -y install libevent-devel zlib-devel openssl-devel wget

echo '=================================================='
echo '===============update autoconf==============='
echo '=================================================='

cd ~
sudo rpm -e --nodeps `rpm -qf /usr/bin/autoconf`
wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
tar xzf autoconf-2.69.tar.gz 
cd autoconf-2.69/
./configure --prefix=/usr
make
sudo make install

echo '=================================================='
echo '===============install automake==============='
echo '=================================================='

cd ~
wget http://ftp.gnu.org/gnu/automake/automake-1.11.6.tar.gz
tar xzf automake-1.11.6.tar.gz 
cd automake-1.11.6
./configure --prefix=/usr
make
sudo make install
cd ..


echo '=================================================='
echo '===============install boost==============='
echo '=================================================='

cd ~
wget http://jaist.dl.sourceforge.net/project/boost/boost/1.45.0/boost_1_45_0.tar.gz
tar xzf boost_1_45_0.tar.gz 
cd boost_1_45_0/
./bootstrap.sh
sudo ./bjam install

echo '=================================================='
echo '===============install thrift==============='
echo '=================================================='

cd ~
git clone https://github.com/apache/thrift.git
cd thrift/
git fetch
git branch -a
git checkout 0.8.x
./bootstrap.sh
./configure --with-java
make
sudo make install
cd lib/py/
sudo python setup.py install

echo '=================================================='
echo '===============install fb303==============='
echo '=================================================='

cd ~/thrift/contrib/fb303/
./bootstrap.sh
./configure CPPFLAGS="-DHAVE_INTTYPES_H -DHAVE_NETINET_IN_H"
make
sudo make install
cd py/
sudo python setup.py install

echo '=================================================='
echo '===============install scribe==============='
echo '=================================================='

cd ~
git clone https://github.com/facebook/scribe.git
cd scribe/
export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib
./bootstrap.sh
./configure CPPFLAGS="-DHAVE_INTTYPES_H -DHAVE_NETINET_IN_H -DBOOST_FILESYSTEM_VERSION=2" LIBS="-lboost_system -lboost_filesystem"
make
sudo make install
cd lib/py/
sudo python setup.py install
cd ~

echo '=================================================='
echo '===================== Done! ======================='
echo '=================================================='
