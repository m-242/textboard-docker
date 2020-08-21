FROM golang:1.13-alpine as builder

RUN adduser -D -g "textboard" textboard
RUN apk add --no-cache git gcc musl-dev
RUN git clone https://gitlab.com/m242/txtboard.git
RUN cd txtboard; go build -o /textboard

FROM scratch
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder /textboard /opt/textboard

EXPOSE 8080
USER textboard
ENTRYPOINT ["/opt/textboard"]
