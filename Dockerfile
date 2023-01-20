﻿FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["ToDoSquared/ToDoSquared.csproj", "ToDoSquared/"]
RUN dotnet restore "ToDoSquared/ToDoSquared.csproj"
COPY . .
WORKDIR "/src/ToDoSquared"
RUN dotnet build "ToDoSquared.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ToDoSquared.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ToDoSquared.dll"]
