FROM electreon/stm32cubeide:1.4.0.v1

WORKDIR /root

##git checkout
#RUN git clone git@bitbucket.org:Electreon/st-firmware-v2.git

##Version

ENV STM32QUBEIDE_INSTALLATION_FILE=${STM32QUBEIDE_INSTALLATION_FILE:-en.st-stm32cubeide_1.4.0_7511_20200720_0928_amd64_sh.zip}
ENV STM32QUBEIDE_VERSION=$("echo "$STM32QUBEIDE_INSTALLATION_FILE" | sed 's/^.*_\([0-9]\+\.[0-9]\+\.[0-9]\+\)_.*/\1/'")

RUN echo $STM32QUBEIDE_VERSION

RUN ["/bin/bash", "-c", "echo $STM32QUBEIDE_VERSION"]

##Create workspace by importing the project & building it
RUN /opt/st/stm32cubeide_${STM32QUBEIDE_VERSION}/stm32cubeide --launcher.suppressErrors -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild -data /root/workspace -import /root/st-firmware-v2/
RUN /opt/st/stm32cubeide_${STM32QUBEIDE_VERSION}/headless-build.sh -build VLAD_Tester/Debug -data /root/workspace/

##Package
## Binaries are located in /root/st-firmware-v2/Debug
#RUN ls -la /root/st-firmware-v2/Debug
RUN ls -la /root
