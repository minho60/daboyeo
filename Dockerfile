FROM gradle:8.9-jdk21 AS builder

WORKDIR /workspace

COPY backend /workspace/backend

WORKDIR /workspace/backend
RUN gradle bootJar --no-daemon --no-problems-report

FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 python3-pip \
    && ln -s /usr/bin/python3 /usr/local/bin/python \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /workspace/backend/build/libs/*.jar /app/app.jar
COPY collectors /app/collectors
COPY scripts /app/scripts
COPY requirements.txt /app/requirements.txt
COPY frontend/src/map /app/frontend/src/map
COPY backend/src/main/resources/static/src/map /app/backend/src/main/resources/static/src/map

RUN pip3 install --no-cache-dir -r /app/requirements.txt

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
