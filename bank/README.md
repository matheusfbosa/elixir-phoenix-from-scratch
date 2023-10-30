# Bank - Elixir/Phoenix REST API

**Bank** is a REST API built using Elixir and Phoenix for managing users, accounts, and transactions. This README provides an overview of the project, including how to set it up and make API requests.

## Table of Contents

- [Project Structure](#project-structure)
- [Installation](#installation)
- [API Endpoints](#api-endpoints)
  - [Users](#users)
  - [Accounts](#accounts)
  - [Transactions](#transactions)
- [Authentication](#authentication)
- [Testing](#testing)
- [Docker Compose](#docker-compose)

## Project Structure

The project consists of Elixir and Phoenix components, and it follows a standard Elixir Mix project structure. Key components include:

- **`lib`**: Contains the main application code.
- **`config`**: Configuration files for the application.
- **`priv/repo`**: Ecto database migration and seeds files.
- **`test`**: Unit and integration tests for the application.

## Installation

To run the Bank API locally, follow these steps:

1. Install Elixir and Erlang if you haven't already. You can do this by following the instructions on the [Elixir website](https://elixir-lang.org/install.html).

2. Clone the project repository:

   ```shell
   git clone https://github.com/matheusfbosa/bank.git
   cd bank
   ```

3. Install project dependencies:

   ```shell
   mix deps.get
   ```

4. Create and migrate the database:

   ```shell
   mix ecto.setup
   ```

5. Start the Phoenix server:

   ```shell
   mix phx.server
   ```

The Bank API should now be running on `http://localhost:4000`.

## API Endpoints

### Users

- **Create User**

  - URL: `POST /api/users`
  - Headers: `Content-Type: application/json`
  - Request Body:

    ```json
    {
        "name": "Bosa",
        "email": "bosa@gmail.com",
        "cep": "29560000",
        "password": "123456"
    }
    ```

- **Login User**

  - URL: `POST /api/users/login`
  - Headers: `Content-Type: application/json`
  - Request Body:

    ```json
    {
        "id": 1,
        "password": "123456"
    }
    ```

- **Get User**

  - URL: `GET /api/users/{userId}`
  - Headers: `Authorization: Bearer {bearerToken}`

- **Update User**

  - URL: `PUT /api/users/{userId}`
  - Headers: `Content-Type: application/json`, `Authorization: Bearer {bearerToken}`
  - Request Body:

    ```json
    {
        "name": "Bosa",
        "email": "bosa@gmail.com",
        "cep": "29560000",
        "password": "123456"
    }
    ```

- **Delete User**

  - URL: `DELETE /api/users/{userId}`
  - Headers: `Authorization: Bearer {bearerToken}`

### Accounts

- **Create Account**

  - URL: `POST /api/accounts`
  - Headers: `Content-Type: application/json`
  - Request Body:

    ```json
    {
        "user_id": 1,
        "balance": 100
    }
    ```

### Transactions

- **Create Transaction**

  - URL: `POST /api/accounts/transaction`
  - Headers: `Content-Type: application/json`
  - Request Body:

    ```json
    {
        "from_account_id": 1,
        "to_account_id": 2,
        "value": 10
    }
    ```

## Authentication

This API uses Bearer token authentication for certain endpoints. Here's how it works:

- When a user logs in, the API issues a Bearer token to the authenticated user.
- To access protected endpoints (e.g., to view or update user information), you must include the Bearer token in the request headers.

### Example Bearer Token Usage

```http
GET {{baseUrl}}/api/users/{{userId}}
Authorization: Bearer {{bearerToken}}
```

In this example, `{{baseUrl}}` is the base URL of your API, `{{userId}}` is the user's ID, and `{{bearerToken}}` is the Bearer token issued to the authenticated user during login.

## Testing

The project includes tests to ensure its functionality. You can run the tests using the following command:

```shell
mix test
```

The tests cover various aspects of the API, including user management, account creation, and transaction handling.

## Docker Compose

A Docker Compose file (`docker-compose.yml`) is provided to set up the required PostgreSQL database and pgAdmin for managing the database.

To use Docker Compose:

1. Ensure you have Docker and Docker Compose installed on your system.

2. Run the following command to start the database and pgAdmin containers:

   ```shell
   docker-compose up
   ```

3. PostgreSQL will be available at `localhost:5432`, and pgAdmin will be available at `localhost:5050`. You can use pgAdmin to manage the PostgreSQL database.

---

Feel free to use and modify this API as needed. If you encounter any issues or have questions, please refer to the Phoenix documentation or reach out for support.
