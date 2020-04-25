FROM baalajimaestro/app_build

RUN zypper -n in swig &> /dev/null

RUN echo y | sdkmanager "ndk;21.1.6352462" &> /dev/null && \
    echo y | sdkmanager "extras;google;m2repository" &> /dev/null && \ 
    echo y | sdkmanager "extras;android;m2repository" &> /dev/null && \
    mkdir ~/.gradle && \
    echo icsopenvpnDebugSign=true > ~/.gradle/gradle.properties

WORKDIR /tmp/project

CMD ["./gradlew","assembleUiRelease"]