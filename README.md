# 📦 OmniStock Enterprise WMS

> **Ultra Inventario & Sistema de Gestión Integral Multi-Sucursal**  
> Arquitectura Polyglot de Microservicios: **Angular 19** + **Bun/Hono (Better Auth)** + **Java 21 (Spring Boot 3)** + **PostgreSQL** + **Docker**.

---

## 🏛️ Estructura de Submódulos

Este repositorio principal actúa como el **orquestador central** del ecosistema OmniStock. Cada servicio se versiona y mantiene en su propio repositorio independiente:

| Módulo / Carpeta | Repositorio GitHub | Tecnologías Clave | Responsabilidad |
| :--- | :--- | :--- | :--- |
| **[`omnistock-auth-service/`](./omnistock-auth-service)** | [omnistock-auth-service](https://github.com/HyugoDev/omnistock-auth-service) | Bun, Hono, Better Auth, Drizzle ORM | Autenticación, RBAC (roles), emisión de JWT EdDSA |
| **[`omnistock-core-backend/`](./omnistock-core-backend)** | [omnistock-core-backend](https://github.com/HyugoDev/omnistock-core-backend) | Java 21, Spring Boot 3, Spring Data JPA | Lógica WMS, Kardex, POS, control de stock concurrente |
| **[`omnistock-frontend/`](./omnistock-frontend)** | [omnistock-frontend](https://github.com/HyugoDev/omnistock-frontend) | Angular 19, Signals, Tailwind CSS | Interfaz SPA, Punto de Venta, Dashboard analítico |

---

## ⚡ Despliegue Rápido con Docker

Para levantar la infraestructura completa (PostgreSQL, Auth Service, Core Service y Frontend):

```bash
# 1. Clonar el orquestador con todos sus submódulos
git clone --recurse-submodules https://github.com/HyugoDev/omnistock.git
cd omnistock

# 2. Configurar variables de entorno
cp .env.example .env

# 3. Levantar todos los servicios en contenedores
docker compose up --build -d
```

### Puertos en Local:
* 🌐 **Frontend (Angular):** [http://localhost:4200](http://localhost:4200)
* 🔐 **Auth Service (Bun/Hono):** [http://localhost:4000](http://localhost:4000)
* ⚙️ **Core Service (Spring Boot):** [http://localhost:8080](http://localhost:8080)
* 🗄️ **Base de Datos (PostgreSQL):** `localhost:5432`

---

## 🔄 Actualización de Submódulos

Si realizas cambios en los repositorios individuales y deseas congelar y actualizar la versión en este repositorio principal:

```bash
git submodule update --remote
git add .
git commit -m "chore: bump submodules to latest stable release"
git push origin main
```
