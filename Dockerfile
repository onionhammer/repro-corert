FROM rsmmr/clang

RUN apt-get install curl
RUN curl -o dotnet.tar.gz https://download.visualstudio.microsoft.com/download/pr/57e63f03-ebdf-4c22-96ff-2b85dc70cf7f/988576869e82a80f4a97ca5a733a5295/dotnet-sdk-3.1.102-linux-x64.tar.gz && \
    mkdir -p /dotnet && tar zxf dotnet.tar.gz -C /dotnet && \
    rm dotnet.tar.gz

ENV DOTNET_ROOT=/dotnet
ENV PATH=${PATH}:/dotnet
ENV PATH=${PATH}:/.dotnet/tools

COPY . /source

WORKDIR /source
RUN mkdir /app
RUN dotnet publish -r linux-x64 -c Release -o /app

EXPOSE 5000
EXPOSE 5001

ENTRYPOINT [ "/app/MyApp" ]