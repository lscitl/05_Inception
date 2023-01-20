# syntax=docker/dockerfile:1
FROM alpine
ARG FOO=bar
COPY <<-EOT /app/foo
    hello ${FOO}
    EOT