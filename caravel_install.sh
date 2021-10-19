sdir=/soft/ProgramFiles

sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io
echo "If prompted to accept the GPG key, verify that the fingerprint matches 060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35, and if so, accept it"
yum list docker-ce --showduplicates | sort -r
echo "Select and copy paste the latest Version String"
read ver_str
sudo yum install docker-ce-$ver_str docker-ce-cli-$ver_str containerd.io
sudo systemctl start docker
sudo docker run hello-world

sudo yum install kernel-headers -y
sudo yum install clang -y
sudo yum install iverilog -y
sudo yum install gtkwave -y
sudo yum install python3 -y
sudo yum update -y
sudo yum install gcc-c++ -y
sudo yum -y install python3 python3-distutils python3-tk libpython3-dev libxmu-dev tk-dev tcl-dev git g++ libglu1-mesa-dev liblapacke-dev

cd $sdir
wget https://github.com/Kitware/CMake/releases/download/v3.22.0-rc1/cmake-3.22.0-rc1.tar.gz
tar -xzvf cmake-3.22.0-rc1.tar.gz
rm -rf cmake-3.22.0-rc1.tar.gz
cd cmake-3.22.0-rc1
./bootstrap
make
sudo make install

cd $sdir

git clone https://github.com/swig/swig.git
cd swig
./autogen.sh
./configure
make
sudo make install

cd $sdir
git clone https://github.com/cliffordwolf/yosys.git
cd yosys
make config-clang
make
make test
sudo make install

cd $sir
wget https://www.klayout.org/downloads/CentOS_7/klayout-0.27.4-0.x86_64.rpm --no-check-certificate
sudo rpm -i klayout-0.27.4-0.x86_64.rpm

sudo yum install xschem -y

cd $sir
wget http://opencircuitdesign.com/magic/archive/magic-8.3.209.tgz
tar -xzvf magic-8.3.209.tgz
cd magic-8.3.209
./configure
make
sudo make install

cd $sir
git clone https://github.com/NGSolve/ngsolve.git ngsolve-src
cd ngsolve-src
git submodule update --init --recursive
mkdir ngsolve-build
mkdir ngsolve-install
cd ngsolve-build
cmake -DCMAKE_INSTALL_PREFIX=$sir/ngsolve-src/ngsolve-install $sir/ngsolve-src
make
sudo make install
export NETGENDIR="$sir/ngsolve-src/ngsolve-install/bin"
export PATH=$NETGENDIR:$PATH
export PYTHONPATH=$NETGENDIR/../`python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib(1,0,''))"`

cd $sir
git clone https://github.com/The-OpenROAD-Project/OpenSTA.git
cd OpenSTA
mkdir build
cd build
cmake ..
make
sudo make install

sudo -i
cd $sir
git clone https://github.com/efabless/caravel_user_project.git
cd caravel_user_project
export CARAVEL_ROOT=$sdir/caravel_user_project
#export CARAVEL_LITE=0
make install
make update_caravel
export OPENLANE_ROOT=$sdir/openlane
export PDK_ROOT=$sdir/openlane/pdks
make openlane
cd $sdir/openlane
make pdk
cd $sdir/caravel_user_project
make simenv
export PRECHECK_ROOT=$sdir/caravel_user_project/mpw-precheck
make precheck
sudo chmod -R 777 $sdir/caravel_user_project
sudo chmod -R 777 $sdir/openlane
