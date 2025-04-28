# Use a base image with necessary build tools
FROM ubuntu:20.04

# Install dependencies required for building Apache (including PCRE and Expat)
RUN apt-get update && \
    apt-get install -y \
    wget \
    build-essential \
    apache2-utils \
    libpcre3-dev \
    libexpat1-dev \
    && apt-get clean

# Copy the Apache tarball into the container
COPY httpd-2.4.50.tar.gz /tmp/

# Set the working directory to /tmp
WORKDIR /tmp

# Extract Apache, APR, and APR-Util, then configure and build
RUN tar -xvzf httpd-2.4.50.tar.gz && \
    cd httpd-2.4.50 && \
    wget https://archive.apache.org/dist/apr/apr-1.7.0.tar.gz && \
    wget https://archive.apache.org/dist/apr/apr-util-1.6.1.tar.gz && \
    tar -xvzf apr-1.7.0.tar.gz && \
    tar -xvzf apr-util-1.6.1.tar.gz && \
    mv apr-1.7.0 ./srclib/apr && \
    mv apr-util-1.6.1 ./srclib/apr-util && \
    ./configure --enable-so --enable-cgi --with-included-apr && \
    make && make install

# Expose port 80 for the Apache server
EXPOSE 80

# Run Apache in the foreground
CMD ["/usr/local/apache2/bin/httpd", "-D", "FOREGROUND"]
