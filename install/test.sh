sudo apt-get install -y \
    libx11-dev libgl1-mesa-dev libxext-dev perl perl-modules make git

git clone https://github.com/kdlucas/byte-unixbench.git

cd byte-unixbench/UnixBench/

./Run
