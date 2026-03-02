*This project has been created as part of the 42 curriculum by
`<ahetru>`.*

# Inception

## Description

Inception is a system administration project focused on containerization
using Docker. The goal is to build a small infrastructure composed of
multiple services running in isolated containers and orchestrated with
Docker Compose.

This project deploys a secure WordPress website powered by: - NGINX
(HTTPS only) - WordPress - MariaDB

Each service runs in its own container, built from Debian Bookworm, and
communicates through a dedicated Docker network.

------------------------------------------------------------------------

## Project Architecture

The stack is composed of three main services:

-   MariaDB -- Database server
-   WordPress -- PHP-FPM application server
-   NGINX -- Reverse proxy with HTTPS (self-signed certificate)

All services are connected via a custom Docker bridge network named
`inception`.

Data persistence is ensured using bind-mounted Docker volumes:
- /home/ahetru/data/mariadb
- /home/ahetru/data/wordpress

Sensitive credentials are managed using Docker Secrets.

------------------------------------------------------------------------

## Virtual Machines vs Docker

Virtual Machines rely on hardware-level virtualization through a hypervisor. Each VM includes a full guest operating system, its own kernel, system libraries, and virtualized hardware. This provides strong isolation but consumes significant CPU, RAM, and disk space. Boot time is also slower because an entire OS must start.

Docker uses operating system–level virtualization. Containers share the host kernel while isolating processes, filesystems, and networking namespaces. This makes containers significantly lighter, faster to start, and more resource-efficient.

Key architectural differences:

- VM → Full OS per instance  
- Docker → Shared kernel, isolated processes  
- VM → Higher resource consumption  
- Docker → Lightweight and near-instant startup  
- VM → Strong hardware-level isolation  
- Docker → Process-level isolation  

For a microservice architecture like this project, Docker provides better scalability, faster deployment, and easier reproducibility.
------------------------------------------------------------------------

## Secrets vs Environment Variables

Environment Variables: - Visible via docker inspect - Less secure

Docker Secrets: - Stored as files in /run/secrets - Designed for
sensitive data

------------------------------------------------------------------------
## Docker Network vs Host Network

In Host Network mode, containers share the host’s networking stack directly. There is no network namespace isolation, meaning services are exposed as if they were running directly on the host. While this may slightly reduce networking overhead, it significantly reduces security and flexibility.

Docker Bridge Network (used in this project) creates an isolated virtual network. Containers communicate internally using automatic DNS resolution based on service names defined in Docker Compose. Only explicitly published ports are exposed to the host machine.

Advantages of using a custom bridge network:

- Network isolation between services
- Controlled port exposure
- Improved security boundaries

In this project, a dedicated bridge network named `inception` ensures secure and structured communication between MariaDB, WordPress, and NGINX.
------------------------------------------------------------------------

## Docker Named Volumes and Data Persistence

This project uses Docker named volumes to ensure persistent storage for both MariaDB and WordPress.

Two named volumes are defined:

- mariadb_data → stores database files
- wordpress_data → stores WordPress application files

The services mount only the named volumes, not direct host paths.  

To comply with the subject requirement that data must be stored inside `/home/ahetru/data`, the Docker local volume driver is configured with `driver_opts` to specify the host storage location.

This approach ensures:

- Proper Docker volume management
- Data persistence independent from container lifecycle
- No direct bind mount at service level

Even if containers are removed, the data remains stored in `/home/ahetru/data`.
------------------------------------------------------------------------

## Instructions

Build and start: make

Stop: make down

Full cleanup: make fclean

------------------------------------------------------------------------

## Resources

-   Docker Documentation
-   Docker Compose Documentation
-   NGINX Documentation
-   MariaDB Documentation
-   WordPress Documentation
