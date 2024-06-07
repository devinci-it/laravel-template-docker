# Laravel Template with Docker

This repository provides a template for a Laravel application using Docker for local development. It includes a PHP application container, a MariaDB database container, and a Vite container for front-end asset compilation.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Usage](#usage)
- [Configuration](#configuration)
- [Docker Services](#docker-services)
- [Volumes](#volumes)
- [Environment Variables](#environment-variables)
- [License](#license)

## Prerequisites

- Docker: [Install Docker](https://docs.docker.com/get-docker/)
- Docker Compose: [Install Docker Compose](https://docs.docker.com/compose/install/)

## Setup

1. Clone the repository:

    ```sh
    git clone https://github.com/devinci-it/laravel-template.git
    cd laravel-template
    ```

2. Copy the example environment file and update it with your own settings:

    ```sh
    cp .env.example .env
    ```

3. Build and start the Docker containers:

    ```sh
    docker-compose up -d
    ```

4. Install PHP dependencies using Composer:

    ```sh
    docker-compose exec laravel-dev composer install
    ```

5. Generate a new application key:

    ```sh
    docker-compose exec laravel-dev php artisan key:generate
    ```

6. Run database migrations:

    ```sh
    docker-compose exec laravel-dev php artisan migrate
    ```

## Usage

- Access the Laravel application at [http://localhost:8000](http://localhost:8000).
- Access the Vite development server at [http://localhost:5173](http://localhost:5173).

## Configuration

### Docker Services

- **laravel-dev**: Runs the Laravel application.
- **vite**: Compiles front-end assets using Vite.
- **db**: Runs a MariaDB database.

### Volumes

- `./:/var/www`: Mounts the current directory to `/var/www` in the `laravel-dev` and `vite` containers.
- `mariadb_data:/var/lib/mysql`: Persists MariaDB data.

### Environment Variables

- `MIX_VITE_HOST`: The host URL for the Vite development server.
- `MYSQL_HOST`: The hostname of the MySQL server (should be `db` as defined in `docker-compose.yml`).
- `MYSQL_DATABASE`: The name of the MySQL database.
- `MYSQL_USER`: The MySQL user.
- `MYSQL_PASSWORD`: The MySQL user password.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
