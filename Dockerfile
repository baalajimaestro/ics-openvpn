FROM baalajimaestro/app_build

RUN dnf -y install swig &> /dev/null

RUN echo y | sdkmanager "ndk;21.1.6352462" &> /dev/null && \
    echo y | sdkmanager "extras;google;m2repository" &> /dev/null && \ 
    echo y | sdkmanager "extras;android;m2repository" &> /dev/null && \
    mkdir ~/.gradle && \
    echo icsopenvpnDebugSign=true > ~/.gradle/gradle.properties

WORKDIR /tmp/project

CMD bash build.sh | ts '[%Y-%m-%d %H:%M:%S]'
