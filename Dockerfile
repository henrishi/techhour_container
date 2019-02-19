FROM r-base:latest

USER root


RUN echo "manually installing the libsodium library" \
	&& cd ~ \
	&& wget "https://download.libsodium.org/libsodium/releases/LATEST.tar.gz" \
	&& tar -xzvf LATEST.tar.gz \
	&& cd libsodium* \
	&& ./configure \
	&& make && make check \
	&& make install \
	&& ldconfig \
	&& echo "check if libsodium is linked" \
	&& ldconfig -p | grep libsodium \
	&& cd / \
	&& rm ~/LATEST.tar.gz \
	&& rm -r ~/libsodium* \
	&& apt-get install -y --allow-unauthenticated r-base-core  r-recommended \
	&& R --slave -e 'install.packages("sodium", dependencies = T, repos="https://cloud.r-project.org/")' \
	&& mkdir /atheylab_demo
