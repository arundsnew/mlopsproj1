#use centos latest
FROM centos:latest

#create repo file
RUN echo -e "[MLOPScontainer1] baseurl=https://download.docker.com/linux/centos/7/x86_64/stable/ gpgcheck=0 baseurl=http://mirror.centos.org/centos/7/os/x86_64/ gpgcheck=0 baseurl=http://mirror.centos.org/centos-8/8/BaseOS/x86_64/os/ gpgcheck=0 baseurl=http://mirror.centos.org/centos-7/7/os/x86_64/ gpgcheck=0 baseurl=http://mirror.centos.org/centos/ gpgcheck=0 >> etc/yum.repos.d/docker.repo"

#install centos
RUN echo -e "yum install -y docker-ce --nobest"

#install jenkins and configure all reqd parameters
RUN yum install wget -y
RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
RUN yum install java -y
RUN yum install jenkins -y
RUN echo -e "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
ENV USER jenkins

CMD ["java", "-jar", "/usr/lib/jenkins/jenkins.war"]

EXPOSE 9001


#this image only for jenkins and docker so removing below
#install git
#RUN yum install git -y && yum install bc -y

#install other ML Libraries
#RUN pip install tensorflow
#RUN pip install keras
#RUN pip install matplotlib
#RUN pip install numpy
