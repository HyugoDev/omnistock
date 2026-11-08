# ⚙️ Guía de Configuración Base del Entorno Local

> **Documento de Referencia Técnica:** Parámetros, variables, puertos y configuraciones necesarias para ejecutar y comunicar el Backend (Spring Boot 3) y el Frontend (Angular 19) en tu máquina local.

---

## 1. Mapa de Puertos y Servicios Locales

| Servicio | URL Local | Descripción | Credenciales / Acceso |
| :--- | :--- | :--- | :--- |
| **Frontend (Angular)** | `http://localhost:4200` | Aplicación web cliente SPA | Libre |
| **Backend (Spring Boot)** | `http://localhost:8080/api/v1` | API REST de gestión de inventario | Libre (Fase inicial) |
| **Consola Base de Datos H2** | `http://localhost:8080/h2-console` | Gestor web visual de la BD en memoria | **JDBC URL:** `jdbc:h2:mem:inventariodb`<br>**User:** `sa`<br>**Password:** *(vacío)* |

---

## 2. Configuración del Backend (Spring Boot)

El archivo de configuración principal se encuentra en:
`inventory-backend/src/main/resources/application.properties`

### 2.1 Contenido Recomendado de `application.properties`

```properties
# ==========================================
# 1. IDENTIFICACIÓN Y SERVIDOR
# ==========================================
spring.application.name=inventory-backend
server.port=8080

# ==========================================
# 2. BASE DE DATOS EN MEMORIA (H2)
# ==========================================
# 'inventariodb' es el nombre de la BD en memoria
spring.datasource.url=jdbc:h2:mem:inventariodb;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE
spring.datasource.driver-class-name=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=

# Habilitar consola web de H2
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console
# Permitir que la consola de H2 se renderice dentro de marcos (iframes)
spring.h2.console.settings.web-allow-others=false

# ==========================================
# 3. HIBERNATE / JPA (Mapeo de Tablas)
# ==========================================
# 'update': crea o actualiza las tablas automáticamente al iniciar según las clases @Entity
spring.jpa.hibernate.ddl-auto=update
# Muestra las consultas SQL en la terminal de IntelliJ
spring.jpa.show-sql=true
# Formatea el SQL para que sea legible en consola
spring.jpa.properties.hibernate.format_sql=true
# Dialecto SQL para H2
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.H2Dialect

# ==========================================
# 4. LOGS Y FORMATO
# ==========================================
logging.level.org.springframework.web=INFO
logging.level.com.inventario=DEBUG
```

---

## 3. Configuración de CORS en Spring Boot

Para que el navegador permita que Angular (`http://localhost:4200`) consuma la API (`http://localhost:8080`), se debe registrar una clase de configuración en Java:

**Ruta sugerida:** `inventory-backend/src/main/java/com/inventario/config/CorsConfig.java`

```java
package com.inventario.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig {

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/api/v1/**")
                        .allowedOrigins("http://localhost:4200")
                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH")
                        .allowedHeaders("*")
                        .allowCredentials(true);
            }
        };
    }
}
```

---

## 4. Configuración del Frontend (Angular)

### 4.1 URL Base de la API
Para evitar "quemar" (hardcodear) URLs en cada servicio, creamos un archivo central de entorno o configuración:

**Ruta sugerida:** `inventory-frontend/src/environments/environment.ts`
```typescript
export const environment = {
  production: false,
  apiUrl: 'http://localhost:8080/api/v1'
};
```

### 4.2 Habilitar `HttpClient` en Angular (Modo Standalone)
En Angular moderno (19+), `FetchBackend` viene activado por defecto, por lo que basta con invocar `provideHttpClient()` en:
`inventory-frontend/src/app/app.config.ts`

```typescript
import { ApplicationConfig, provideBrowserGlobalErrorListeners } from '@angular/core';
import { provideRouter } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';

import { routes } from './app.routes';

export const appConfig: ApplicationConfig = {
  providers: [
    provideBrowserGlobalErrorListeners(),
    provideRouter(routes),
    // Habilitar cliente HTTP para consumir APIs REST:
    provideHttpClient()
  ]
};
```

---

## 5. Procedimiento de Arranque Diario en Local

Para trabajar cómodamente, tendrás dos terminales o ventanas abiertas:

### Terminal 1: Backend
* **Opción A (Desde IntelliJ IDEA):**
  Abre la clase `InventoryBackendApplication.java` y haz clic en el botón verde de **Play (Run)**.
* **Opción B (Por terminal PowerShell):**
  ```powershell
  cd "D:\angular y java\inventory-backend"
  ./mvnw spring-boot:run
  ```
  *(Sabrás que arrancó cuando veas en consola: `Tomcat started on port 8080 (http) with context path '/'`)*.

### Terminal 2: Frontend
* Por terminal PowerShell:
  ```powershell
  cd "D:\angular y java\inventory-frontend"
  ng serve -o
  ```
  *(Se abrirá automáticamente el navegador en `http://localhost:4200`)*.

---

## 6. Pruebas de Verificación Inicial (Health Check)

1. **Verificar que el backend está vivo:**
   Abre en tu navegador `http://localhost:8080/h2-console`. Si carga la pantalla azul de login de H2, el backend está funcionando.
2. **Conectarse a la base de datos H2:**
   En la pantalla de login de H2:
   * **JDBC URL:** Cambiar el valor por defecto a `jdbc:h2:mem:inventariodb`
   * **User Name:** `sa`
   * **Password:** *(dejar en blanco)*
   * Clic en **Test Connection** (debe decir `Test successful`) y luego en **Connect**.
3. **Verificar que el frontend está vivo:**
   Abre en tu navegador `http://localhost:4200`. Debe mostrar la interfaz de Angular.

---

## 7. Solución de Problemas Frecuentes (Troubleshooting)

### Error 1: `Port 8080 was already in use`
* **Causa:** Dejaste un proceso de Java o Tomcat corriendo en segundo plano.
* **Solución rápida en PowerShell (como Administrador o normal):**
  ```powershell
  # 1. Buscar el PID que usa el puerto 8080:
  Get-Process -Id (Get-NetTCPConnection -LocalPort 8080).OwningProcess
  # 2. Cerrar el proceso:
  Stop-Process -Id (Get-NetTCPConnection -LocalPort 8080).OwningProcess -Force
  ```

### Error 2: `CORS policy: No 'Access-Control-Allow-Origin' header` en la consola de Chrome
* **Causa:** Angular está intentando llamar al backend pero Spring Boot no tiene registrado `CorsConfig.java` o el endpoint no empieza por `/api/v1/`.
* **Solución:** Verificar que `CorsConfig.java` tenga la anotación `@Configuration` y la ruta coincida.

### Error 3: No aparecen tablas en la consola H2
* **Causa:** Al conectarse a H2 pusiste una JDBC URL distinta a `jdbc:h2:mem:inventariodb` (H2 a veces autocompleta con `jdbc:h2:~/test`).
* **Solución:** Asegurarse de que el campo JDBC URL contenga exactamente `jdbc:h2:mem:inventariodb`.
