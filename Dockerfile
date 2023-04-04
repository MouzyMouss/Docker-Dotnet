
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

WORKDIR /App


COPY  DotNet.Docker.csproj .

RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/aspnet:7.0

WORKDIR /App

COPY --from=build-env /App/out .

ENTRYPOINT [ "dotnet", "DotNet.Docker.dll" ]