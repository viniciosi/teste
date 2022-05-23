FROM public.ecr.aws/lambda/dotnet:5.0 as base

FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine-amd64 AS build
WORKDIR /source

COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish --no-restore -c Release -o /app/publish --no-cache

FROM base AS final
WORKDIR /var/task
COPY --from=build /app/publish .
CMD ["Dotnet5DockerWebAPILambda::Dotnet5DockerWebAPILambda.LambdaEntryPoint::FunctionHandlerAsync"]