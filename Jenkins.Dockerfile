FROM jenkins/jenkins:lts-jdk17@sha256:7ea4989040ce0840129937b339bf8c8f878c14b08991def312bdf51ca05aa358

# Disable the initial wizard and allow annonimous access for the demo
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Install Jenkins plugins
COPY configs/Jenkinsplugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --verbose --plugin-file /usr/share/jenkins/ref/plugins.txt

# Assign current user to Docker group and install Maven
USER root
RUN apt-get update && \
    apt-get -y --no-install-recommends install maven=3.8.7-1 && \
    apt-get clean && \
    apt-get autoclean && \
    groupadd -g 999 docker && \
    gpasswd -a jenkins docker && \
    rm -rf /var/cache
USER jenkins
