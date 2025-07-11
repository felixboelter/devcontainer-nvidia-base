# update system
apt-get update
apt-get upgrade -y

# install Linux tools and Python 3
apt-get install software-properties-common wget curl \
    python3-dev python3-pip python3-wheel python3-setuptools -y

# install Python packages
python3 -m pip install --upgrade pip
pip3 install --user -r .devcontainer/requirements.txt

# update CUDA Linux GPG repository key
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb
dpkg -i cuda-keyring_1.0-1_all.deb
rm cuda-keyring_1.0-1_all.deb

# install cuDNN for CUDA 12.1
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /" -y
apt-get update
apt-get install libcudnn8=8.9.7.*-1+cuda12.1 -y
apt-get install libcudnn8-dev=8.9.7.*-1+cuda12.1 -y

# install exact NVIDIA driver libraries to match host kernel driver 570.133.20
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/libnvidia-compute-570_570.133.20-0ubuntu1_amd64.deb
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/nvidia-utils-570_570.133.20-0ubuntu1_amd64.deb
dpkg -i ./libnvidia-compute-570_570.133.20-0ubuntu1_amd64.deb ./nvidia-utils-570_570.133.20-0ubuntu1_amd64.deb

# install recommended packages
apt-get install zlib1g g++ freeglut3-dev \
    libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev libfreeimage-dev -y

# clean up
pip3 cache purge
apt-get autoremove -y
apt-get clean
