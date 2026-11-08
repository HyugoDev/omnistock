# 🚀 Sistema de Gestión de Inventario y Ventas (POS)
> **Fullstack Application**: Java 21 (Spring Boot 3) + Angular 19+

Bienvenido al repositorio central del proyecto. Este repositorio contiene tanto la API REST (Backend) como la aplicación web cliente (Frontend).

---

## 📁 Estructura del Repositorio

* **[`inventory-backend/`](./inventory-backend)**: API REST desarrollada en Spring Boot 3 con Spring Data JPA y base de datos H2.
* **[`inventory-frontend/`](./inventory-frontend)**: Cliente SPA desarrollado en Angular 19 con componentes Standalone y Tailwind CSS.
* **[`ARQUITECTURA_Y_DISENO.md`](./ARQUITECTURA_Y_DISENO.md)**: 📄 Documento técnico completo con diagramas de arquitectura, modelo ER de base de datos, contratos de endpoints REST y roadmap.
* **[`CONFIG.md`](./CONFIG.md)**: ⚙️ Guía de configuración base en local (puertos, H2, CORS, variables y troubleshooting).

---

## 🛠️ Requisitos Previos

* **Java JDK:** Versión 17 o 21 LTS
* **Node.js:** Versión 20+ o 24 LTS
* **Angular CLI:** `npm install -g @angular/cli` o `pnpm install -g @angular/cli`
* **Gestor de paquetes:** `npm` o `pnpm`

---

## ⚡ Ejecución Rápida

### 1. Iniciar el Backend (Spring Boot)
Desde IntelliJ IDEA: Ejecutar la clase principal `InventoryBackendApplication.java`  
O por consola:
```powershell
cd inventory-backend
./mvnw spring-boot:run
```
*API disponible en:* `http://localhost:8080/api/v1`  
*Consola H2 en:* `http://localhost:8080/h2-console`

### 2. Iniciar el Frontend (Angular)
Por consola:
```powershell
cd inventory-frontend
ng serve -o
```
*App disponible en:* `http://localhost:4200`
