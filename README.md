# Redis Book Inventory Application

A Spring Boot web application for managing a book inventory using Redis as the data store. This application demonstrates user authentication, session management, and CRUD operations on book data.

## Features

- **Book Inventory Management**: Create, read, update, and manage book inventory
- **User Authentication**: Session-based authentication with Redis-backed sessions
- **User Attribution**: Track which user last updated each book's price or inventory
- **RESTful API**: Full REST API for book operations
- **Web UI**: Modern, responsive web interface with pagination
- **Redis Integration**: Uses Jedis client for Redis operations

## Tech Stack

- **Java**: 21
- **Spring Boot**: 3.3.4
- **Redis**: Jedis 5.1.3
- **Thymeleaf**: Server-side templating
- **Maven**: Build and dependency management

## Prerequisites

- Java 21 or higher
- Maven 3.6+
- Redis server running locally (default: `localhost:6379`)

## Getting Started

### 1. Start Redis Server

Make sure Redis is running on your local machine:

```bash
redis-server
```

Or if using Docker:

```bash
docker run -d -p 6379:6379 redis:latest
```

### 2. Configure Redis Connection

Edit `src/main/resources/application.properties` if your Redis instance is not on `localhost:6379`:

```properties
app.redis.host=localhost
app.redis.port=6379
```

### 3. Build the Application

```bash
mvn clean package
```

### 4. Run the Application

```bash
mvn spring-boot:run
```

Or run the JAR directly:

```bash
java -jar target/redis-bookapp-0.0.1-SNAPSHOT.jar
```

The application will start on `http://localhost:8080`

## Usage

### Web Interface

1. Navigate to `http://localhost:8080/welcome` to log in
2. Enter your username, first name, and last name
3. After logging in, you'll be redirected to the main inventory page
4. Use the web interface to view and update book inventory and prices

### API Endpoints

#### Authentication

- `POST /api/login` - Login and create a session
  ```json
  {
    "username": "john_doe",
    "firstName": "John",
    "lastName": "Doe"
  }
  ```

- `POST /api/logout` - Logout and destroy session

- `GET /api/session` - Get current session information

#### Books

- `GET /api/books` - List all books
- `GET /api/books/{id}` - Get a specific book by ID
- `PUT /api/books/{id}` - Update book (price and/or inventory)
- `PUT /api/books/{id}/price` - Update only the price
- `PUT /api/books/{id}/inventory` - Update only the inventory

All update operations require authentication (session cookie).

## Project Structure

```
src/
├── main/
│   ├── java/com/example/redisbookapp/
│   │   ├── Application.java              # Main Spring Boot application
│   │   ├── Book.java                     # Book entity model
│   │   ├── BookController.java           # REST API controller
│   │   ├── BookService.java              # Business logic for books
│   │   ├── User.java                     # User entity model
│   │   ├── SessionService.java           # Session management
│   │   ├── WelcomeController.java        # Login/logout controller
│   │   ├── PageController.java           # Page routing
│   │   ├── JedisConfig.java              # Redis configuration
│   │   └── repo/
│   │       └── RedisBookRepository.java   # Redis data access layer
│   └── resources/
│       ├── application.properties         # Application configuration
│       ├── templates/                     # Thymeleaf templates
│       └── static/                        # Static assets (CSS, JS)
```

## Data Model

### Book
- `id`: Unique identifier
- `name`: Book title
- `author`: Author name
- `isbn`: ISBN number
- `category`: Book category
- `inventory`: Stock count
- `price`: Book price
- `lastUpdatedByUsername`: Username who last updated
- `lastUpdatedByFirstName`: First name of updater
- `lastUpdatedByLastName`: Last name of updater
- `lastUpdatedAt`: ISO-8601 timestamp of last update

## Development

### Running Tests

```bash
mvn test
```

### Building for Production

```bash
mvn clean package -DskipTests
```

## Configuration

The application can be configured via `application.properties`:

- `server.port`: Server port (default: 8080)
- `app.redis.host`: Redis host (default: localhost)
- `app.redis.port`: Redis port (default: 6379)

## License

This project is a demonstration application.

