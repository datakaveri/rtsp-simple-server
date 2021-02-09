FROM --platform=linux/amd64 golang:1.15-alpine3.12 AS build

RUN apk add --no-cache git
WORKDIR /s
RUN git clone https://github.com/datakaveri/rtsp-simple-server .
RUN go mod download
ARG VERSION
ARG OPTS
RUN export CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
	&& go build -ldflags "-X main.version=$$VERSION" -o /rtsp-simple-server

FROM scratch
COPY --from=build /rtsp-simple-server /
COPY --from=build /s/rtsp-simple-server.yml /
ENTRYPOINT [ "/rtsp-simple-server" ]