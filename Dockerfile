FROM mcr.microsoft.com/dotnet/aspnet:6.0-focal-arm64v8 AS base
WORKDIR /app
EXPOSE 80

ENV ASPNETCORE_URLS=http://+:80

FROM mcr.microsoft.com/dotnet/sdk:6.0-focal-arm64v8 AS build
WORKDIR /src
COPY ["cube.csproj", "./"]
RUN dotnet restore "cube.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "cube.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "cube.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "cube.dll"]
