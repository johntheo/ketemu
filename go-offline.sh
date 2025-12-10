#!/usr/bin/env bash
set -e

SERVICES=(
  auth-service
  event-service
  order-service
  ticket-service
  contact-service
  notification-service
  api-gateway
)

for service in "${SERVICES[@]}"; do
  echo ">>> Preparing $service for offline mode..."
  cd backend/$service
  ./mvnw dependency:go-offline
  cd ../..
done

echo "🎉 All services prepared for offline mode!"
