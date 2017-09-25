FROM microsoft/windowsservercore

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Invoke-WebRequest https://github.com/ojdkbuild/ojdkbuild/releases/download/1.8.0.131-1/java-1.8.0-openjdk-1.8.0.131-1.b11.ojdkbuild.windows.x86_64.zip -OutFile openjdk.zip; \
    Expand-Archive openjdk.zip -DestinationPath $Env:ProgramFiles\Java\OpenJDK; \
    Remove-Item -Force openjdk.zip
    
ENV JAVA_HOME="C:\Program Files\Java\OpenJDK"

RUN setx /M PATH "%PATH%;%JAVA_HOME\bin%

CMD [ "java", "-version"]
