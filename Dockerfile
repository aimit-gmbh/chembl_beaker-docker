FROM continuumio/miniconda:4.3.11
 
# run as
# docker build  -t chembl/beaker:0.1 .
# docker run -p 7655:8080 chembl/beaker:0.1
 
 
MAINTAINER Johannes Jander (https://github.com/iSnow/)

# set environment variables
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
ENV LC_ALL=C
 
SHELL ["/bin/bash", "-lc"]

# install gcc, make ..
RUN    apt-get update --fix-missing && apt-get -y upgrade && \
       apt-get -y install build-essential cmake pkg-config apt-utils  && \
       apt-get -y install libtclap-dev libpotrace0  libpotrace-dev  libocrad-dev  \
       libgraphicsmagick++1-dev libgraphicsmagick++1-dev libgraphicsmagick++3 \
       libgraphicsmagick1-dev libgraphicsmagick3 libnetpbm10-dev gfortran \
       libblas-dev liblapack-dev libatlas-dev
 
RUN    apt-get clean && mkdir /home/downloads && cd /home/downloads
 
RUN    git clone https://github.com/metamolecular/gocr-patched.git && \
       cd gocr-patched && ./configure && make libs && make all install && \
       cd ../ && rm -rf gocr-patched
 
RUN    git clone https://github.com/openbabel/openbabel.git && \
       cd openbabel && git checkout openbabel-2-3-2 && mkdir build && cd build && \
       cmake  -Wno-dev .. && make -j2 && make install && \
       cd ../ && rm -rf openbabel
 
RUN    git clone https://github.com/metamolecular/osra.git && \
       cd osra && ./configure --with-openbabel-include=/usr/local/include/openbabel-2.0 \
       --with-openbabel-lib=/usr/local/lib/openbabel && make all install && \
       cd ../ && rm -rf osra     
 
# install RDKit and activate environment
RUN    conda config --add channels  https://conda.anaconda.org/rdkit && \
       conda install -y nomkl rdkit pycairo cairo cairocffi patchelf && \
       pip install  scipy pillow standardiser matplotlib \
       git+https://github.com/chembl/chembl_beaker.git && \
       conda create -y --use-local -n my-rdkit-env rdkit  && \
       source activate my-rdkit-env
 
# overwrite tornado config - change here if other values are required
RUN   echo "[bottle]" > /opt/conda/lib/python2.7/site-packages/chembl_beaker/beaker.conf && \
      echo "DEBUG = False" >> /opt/conda/lib/python2.7/site-packages/chembl_beaker/beaker.conf && \
      echo "BOTTLE_PORT = 8080" >> /opt/conda/lib/python2.7/site-packages/chembl_beaker/beaker.conf && \
      echo "BOTTLE_HOST = 0.0.0.0" >> /opt/conda/lib/python2.7/site-packages/chembl_beaker/beaker.conf && \
      echo "SERVER_MIDDLEWARE = tornado" >> /opt/conda/lib/python2.7/site-packages/chembl_beaker/beaker.conf && \
      echo "osra_binaries_location = /usr/local/bin/osra" \
              >> /opt/conda/lib/python2.7/site-packages/chembl_beaker/beaker.conf
 
# expose port
EXPOSE 8080
 
WORKDIR /opt/conda/lib/python2.7/site-packages/chembl_beaker/
 
CMD ["/opt/conda/bin/run_beaker"]
