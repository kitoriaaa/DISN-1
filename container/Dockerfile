FROM tensorflow/tensorflow:1.13.2-gpu-py3-jupyter

WORKDIR /usr/workspace

RUN apt update
RUN apt install -y make \
  libgl1-mesa-dev \
  libtbb2 \
  libtiff5 \
  libglu1-mesa \
  freeglut3 \
  curl \
  wget \
  gnupg \
  libtbb-dev

RUN curl -sfL https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB | apt-key add -
RUN curl -sfL https://apt.repos.intel.com/setup/intelproducts.list -o /etc/apt/sources.list.d/intelproducts.list
RUN apt update
RUN apt install -y intel-mkl-2020.0.088

RUN wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb \
  && dpkg -i /tmp/libpng12.deb \
  && rm /tmp/libpng12.deb

COPY ./requirements.txt .
RUN pip install --upgrade pip 
RUN pip install -r requirements.txt

CMD ["/bin/bash"]
