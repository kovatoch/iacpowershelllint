# Use the Red Hat Universal Base Image (UBI) as the base image
FROM registry.access.redhat.com/ubi8/ubi:latest

dnf install -y curl
curl https://packages.microsoft.com/config/rhel/8/prod.repo | tee /etc/yum.repos.d/microsoft.repo
dnf install -y powershell

# Copy the linting script into the container
COPY lint.sh /usr/local/bin/lint.sh

# Make the linting script executable
RUN pwsh -Command "Install-Module -Name PSScriptAnalyzer -Force -Scope AllUsers"

# Set the entry point for the container
ENTRYPOINT ["/usr/local/bin/lint.sh"]
