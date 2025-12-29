# Disallowed image + latest tag
FROM adoptopenjdk/openjdk11:latest

# ADD command (should use COPY)
ADD . /app

# No non-root user yet
# Last USER is root (should be non-root)
USER root

# Example run command
RUN echo "This Dockerfile fails all policy checks"
