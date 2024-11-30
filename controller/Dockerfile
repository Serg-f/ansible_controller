FROM ubuntu:22.04

# Disable interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    openssh-client \
    sshpass \
    software-properties-common && \
    add-apt-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y ansible && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root Ansible user
RUN useradd -m ansible && echo "ansible:1234" | chpasswd

# Set up SSH keys for Ansible user
RUN mkdir -p /home/ansible/.ssh && \
    ssh-keygen -t rsa -b 2048 -f /home/ansible/.ssh/id_rsa -q -N "" && \
    chmod 700 /home/ansible/.ssh && \
    chmod 600 /home/ansible/.ssh/id_rsa && \
    chmod 644 /home/ansible/.ssh/id_rsa.pub && \
    chown -R ansible:ansible /home/ansible/.ssh


# Add entrypoint script as root and set permissions
COPY entrypoint.sh /home/ansible/entrypoint.sh
RUN chown ansible:ansible /home/ansible/entrypoint.sh && chmod +x /home/ansible/entrypoint.sh

# Switch to the ansible user
USER ansible

# Set entrypoint
ENTRYPOINT ["/home/ansible/entrypoint.sh"]
