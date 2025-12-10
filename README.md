# ketemu – Conference Ticketing & Networking Platform  
*A microservices-based system for events, ticketing, QR check-in, and attendee networking.*

Ketemu (from Javanese: **"to meet"**) is a fully containerized backend platform for conferences.  
It provides ticketing, agenda management, QR-based check-in, and a unique QR-powered contact exchange system.

Built with **Java + Spring Boot**, **Kafka**, **PostgreSQL**, **Redis**, and **Docker**, following **DDD** and **Hexagonal Architecture**.

---

## 🚀 Features

- **Authentication & User Profiles** (JWT)
- **Conference & Session Management**
- **Ticket Purchasing Flow**
- **QR Code Ticket Issuance**
- **QR Check-In Workflow**
- **QR-based Contact Exchange** between attendees/exhibitors/speakers
- **Notifications**

---

## 🧱 Architecture Overview

```
         +-----------------+
         |    API Gateway  |
         +--------+--------+
                  |
```

+---------+--------+--------+----------+
|         |                   |         |
+--+--+  +---+----+        +-----+----+ +--+------+
|Auth |  |Event   |        |Order     | |Contact  |
|Srv  |  |Service |        |Service   | |Service  |
+-----+  +--------+        +----------+ +---------+
|
+----+------+
| Ticket    |
| Service   |
+-----------+
|
+-----+--------+
| Notification |
|   Service    |
+--------------+

Infra: PostgreSQL • Redis • Kafka • Zookeeper • Docker

```

---

## 🧩 Microservices

### **API Gateway**
- Routes all client traffic
- Validates JWT tokens

### **Auth Service**
- User registration, login, roles
- JWT authentication

### **Event Service**
- Conferences, sessions, speakers
- Ticket types  
- Agenda with Redis caching

### **Order Service**
- Ticket orders
- Simulated payment
- Publishes `OrderPaid` events (Kafka)

### **Ticket Service**
- Consumes `OrderPaid`
- Generates QR-coded tickets (ZXing)
- Check-in workflow  
- Publishes `TicketCheckedIn`

### **Contact Service**
- User contact cards
- QR-based networking
- Publishes `ContactExchanged`

### **Notification Service**
- Consumes domain events
- Logs or stores simple notifications

---

## 🧠 Tech Stack

- **Java 21**, Spring Boot 3.x  
- Spring Web, Data JPA, Security, Kafka, Cache  
- **PostgreSQL**, **Redis**, **Kafka**  
- **ZXing** (QR code generation)  
- **Docker & Docker Compose**  
- DDD + Hexagonal Architecture  

---

## 🐳 Running the Project

### 1. Start infrastructure
```bash
docker-compose up -d
````

### 2. Start services (example)

```bash
cd backend/auth-service
mvn spring-boot:run
```

Repeat for the remaining services.

---

## 🛠️ Future Enhancements

* Real payment gateway (Stripe sandbox)
* Admin portal
* Analytics & dashboards
* Mobile app
* Real-time notifications

---

## ✨ Author

**Ketemu Platform — Built by John Theo**
Senior Java Developer / Engineering Manager
Barcelona, Spain
