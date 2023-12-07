FROM mcr.microsoft.com/dotnet/core/sdk:8.0-alpine AS build
WORKDIR /app

COPY *.sln .
COPY MyWebApi/*.csproj ./MyWebApi/
RUN dotnet restore

COPY MyWebApi/. ./MyWebApi/
WORKDIR /app/MyWebApi
RUN dotnet publish -c Release -o /out --no-restore


FROM mcr.microsoft.com/dotnet/core/aspnet:8.0-alpine AS runtime
WORKDIR /app
COPY --from=build /out ./
ENTRYPOINT ["dotnet", "MyWebApi.dll"]