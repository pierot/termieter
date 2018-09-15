FROM ubuntu:18.04
MAINTAINER Jack + Joe

# OS updates and install
RUN apt-get -qq update
RUN apt-get install git sudo zsh -qq -y

# Create test user and add to sudoers
RUN useradd -m -s /bin/zsh tester
RUN usermod -aG sudo tester
RUN echo "tester ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add install script and make executable

# Switch testuser
USER tester
ENV HOME /home/tester
WORKDIR /home/tester

# Run setup
RUN ./setup

CMD ["/bin/bash"]
