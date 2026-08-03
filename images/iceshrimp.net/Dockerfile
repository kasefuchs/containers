ARG ICESHRIMP_NET_VERSION

FROM --platform=$BUILDPLATFORM iceshrimp.dev/iceshrimp/dotnet-sdk:10.0-alpine AS build

RUN apk add --no-cache git

WORKDIR /app

ARG ICESHRIMP_OBJECTSTORAGE_VERSION

RUN git init Iceshrimp.ObjectStorage \
    && cd Iceshrimp.ObjectStorage \
    && git remote add origin https://iceshrimp.dev/iceshrimp/Iceshrimp.ObjectStorage.git \
    && git fetch --depth=1 origin ${ICESHRIMP_OBJECTSTORAGE_VERSION} \
    && git checkout --detach FETCH_HEAD

WORKDIR /app/Iceshrimp.ObjectStorage/src

RUN --mount=type=cache,target=/root/.nuget \
    dotnet restore -p:Configuration=Release

RUN sed -i 's|https://|http://|g' Iceshrimp.ObjectStorage.S3/Actions/S3Request.cs

RUN --mount=type=cache,target=/root/.nuget \
    dotnet publish --no-restore -c Release -o /build -p:DeterministicSourcePaths=true -p:ContinuousIntegrationBuild=true

FROM iceshrimp.dev/iceshrimp/iceshrimp.net:v${ICESHRIMP_NET_VERSION}

WORKDIR /app

COPY --from=build /build/Iceshrimp.ObjectStorage.*.dll .
