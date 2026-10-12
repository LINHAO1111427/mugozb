ARG BASE_IMAGE=sub2api-local:pr7315
FROM ${BASE_IMAGE}

ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
WORKDIR /app
RUN apk add --no-cache python3 py3-pip \
    && python3 -m venv /opt/excel-codex-venv
COPY pyproject.toml README.md LICENSE UPSTREAM-LICENSE ./
COPY src/ ./src/
RUN /opt/excel-codex-venv/bin/pip install --no-cache-dir --disable-pip-version-check --timeout 120 --retries 5 . \
    && addgroup -g 10001 -S bridge \
    && adduser -u 10001 -S -D -H -G bridge bridge
ENV PATH=/opt/excel-codex-venv/bin:$PATH
USER bridge:bridge
EXPOSE 8000
CMD ["excel-sub2api", "serve", "--host", "0.0.0.0", "--port", "8000"]
