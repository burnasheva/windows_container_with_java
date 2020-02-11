FROM mcr.microsoft.com/windows/servercore:ltsc2019 AS tools

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    Invoke-WebRequest https://github.com/ojdkbuild/ojdkbuild/releases/download/1.8.0.131-1/java-1.8.0-openjdk-1.8.0.131-1.b11.ojdkbuild.windows.x86_64.zip -OutFile openjdk.zip; \
    Expand-Archive openjdk.zip -DestinationPath $Env:ProgramFiles\Java\OpenJDK; \
    Remove-Item -Force openjdk.zip
  
FROM mcr.microsoft.com/windows/servercore:ltsc2019  

ENV JAVA_HOME="C:\Program Files\Java\OpenJDK\java-1.8.0-openjdk-1.8.0.131-1.b11.ojdkbuild.windows.x86_64"

COPY --from=tools $JAVA_HOME $JAVA_HOME

RUN setx /M PATH "%PATH%;%JAVA_HOME%\bin"

CMD [ "java", "-version"]
