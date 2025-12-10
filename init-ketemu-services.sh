#!/usr/bin/env bash
set -e

ROOT_DIR="$(pwd)"
BACKEND_DIR="$ROOT_DIR/backend"

JAVA_VERSION="21"
GROUP_ID="com.ketemu"
LANGUAGE="java"
TYPE="maven-project"
PACKAGING="jar"

mkdir -p "$BACKEND_DIR"
cd "$BACKEND_DIR"

echo "Generating Ketemu microservices in $BACKEND_DIR"
echo "Java: $JAVA_VERSION"
echo

create_service() {
  SERVICE_DIR="$1"
  ARTIFACT_ID="$1"
  NAME="$2"
  PACKAGE_NAME="$3"
  DEPENDENCIES="$4"

  echo ">>> Creating service: $SERVICE_DIR"
  echo "    Dependencies: $DEPENDENCIES"
  echo

  mkdir -p "$SERVICE_DIR"

  curl -s "https://start.spring.io/starter.tgz" \
    -d type="$TYPE" \
    -d language="$LANGUAGE" \
    -d packaging="$PACKAGING" \
    -d javaVersion="$JAVA_VERSION" \
    -d groupId="$GROUP_ID" \
    -d artifactId="$ARTIFACT_ID" \
    -d name="$NAME" \
    -d packageName="$PACKAGE_NAME" \
    -d dependencies="$DEPENDENCIES" \
    | tar -xzvf - -C "$SERVICE_DIR"
}

########################################
# 1) Auth Service
########################################
create_service \
  "auth-service" \
  "Auth Service" \
  "com.ketemu.auth" \
  "web,data-jpa,validation,lombok,security"

########################################
# 2) Event Service
########################################
create_service \
  "event-service" \
  "Event Service" \
  "com.ketemu.event" \
  "web,data-jpa,validation,lombok,kafka,data-redis,cache"

########################################
# 3) Order Service
########################################
create_service \
  "order-service" \
  "Order Service" \
  "com.ketemu.order" \
  "web,data-jpa,validation,lombok,kafka"

########################################
# 4) Ticket Service
########################################
create_service \
  "ticket-service" \
  "Ticket Service" \
  "com.ketemu.ticket" \
  "web,data-jpa,validation,lombok,kafka"

########################################
# 5) Contact Service
########################################
create_service \
  "contact-service" \
  "Contact Service" \
  "com.ketemu.contact" \
  "web,data-jpa,validation,lombok,kafka,data-redis,cache"

########################################
# 6) Notification Service
########################################
create_service \
  "notification-service" \
  "Notification Service" \
  "com.ketemu.notification" \
  "web,data-jpa,validation,lombok,kafka"

########################################
# 7) API Gateway (Spring Cloud Gateway)
########################################
create_service \
  "api-gateway" \
  "API Gateway" \
  "com.ketemu.gateway" \
  "cloud-gateway"

echo
echo "✅ All Ketemu services created under: $BACKEND_DIR"
echo
echo "Next steps (while still online):"
echo "  - For each service: cd backend/<service> && mvn dependency:go-offline"
echo "  - Then you can work fully offline."
