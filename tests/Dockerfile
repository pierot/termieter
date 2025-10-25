# Dockerfile for testing termieter installation
# Provides an isolated environment to safely test the install script

FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y \
    git \
    zsh \
    curl \
    sudo \
    vim \
    tmux \
    && rm -rf /var/lib/apt/lists/*

# Create a test user (don't run installations as root)
RUN useradd -m -s /bin/bash testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to test user
USER testuser
WORKDIR /home/testuser

# Set up minimal git config (required for git operations)
RUN git config --global user.email "test@termieter.test" && \
    git config --global user.name "Test User"

# Create directories that the install script expects
RUN mkdir -p /home/testuser/.bash_backup

# Copy the entire termieter directory into the container
COPY --chown=testuser:testuser . /home/testuser/termieter-source

# Set working directory to the source
WORKDIR /home/testuser/termieter-source

# Default command runs the verification tests
CMD ["bash", "tests/verify-installation.sh"]
