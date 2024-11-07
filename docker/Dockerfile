FROM ubuntu:latest

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    vim \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 80

CMD ["/bin/bash"]
