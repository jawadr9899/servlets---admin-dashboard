# Embedded Servlet + JSP Inventory App

A lightweight Java web app using **embedded Tomcat**, **JSP/JSTL**, and **SQLite**.

It includes:
- Authentication page (sign in/sign up)
- Product dashboard (add/delete inventory)
- Product catalog view (search + category filter)
- Simple error page

---

## Tech Stack

- Java (Tomcat 10.1 requires Java 11+)
- Maven
- Embedded Tomcat (`tomcat-embed-core`, `tomcat-embed-jasper`)
- Jakarta Servlet API 6
- JSP + JSTL
- SQLite (`sqlite-jdbc`)

---

## Project Structure

```text
src/main/java/org/main/
  Main.java                 # App entrypoint (starts embedded Tomcat on port 3000)
  AuthController.java       # Login/Signup controller
  DashboardController.java  # Inventory dashboard (list/add/delete)
  ViewProductsController.java # Product catalog page
  ErrorController.java      # Error page
  DBConnection.java         # SQLite connection + table initialization

src/main/webapp/WEB-INF/
  layout.jsp
  auth.jsp
  dashboard.jsp
  products.jsp
  error.jsp
```

---

## How to Run

### 1) Build the project

```bash
mvn clean package
```

### 2) Copy runtime dependencies

```bash
mvn dependency:copy-dependencies -DincludeScope=runtime
```

### 3) Start the app

**Windows (PowerShell / CMD):**

```bash
java -cp "target/classes;target/dependency/*" org.main.Main
```

App runs on:

- `http://localhost:3000/`

---

## Routes

- `GET /` -> Authentication page
- `POST /` -> Login / Signup (`action=login` or `action=signup`)
- `GET /dashboard` -> Inventory dashboard
- `POST /dashboard` -> Add/Delete product (`action=add` or `action=delete`)
- `GET /products` -> Product catalog page
- `GET /error` -> Error page

---

## Database

The app uses SQLite with file:

- `./dev.db` (created in the project root on first run)

`DBConnection` auto-initializes tables if missing:

- `users(id, name, email UNIQUE, password)`
- `products(productId, name, category, price, description, imgURL, quantity)`

---

## Notes

- JSP files are under `WEB-INF`, so they are rendered through controllers/layout rather than direct browser access.
- Current authentication logic stores plain-text passwords (acceptable for learning/demo, not production).
- Tailwind CSS is loaded via CDN in `layout.jsp`.

---

## Quick Dev Flow

1. Start app
2. Open `http://localhost:3000/`
3. Create an account or sign in
4. Add products from dashboard
5. Open catalog at `/products`

---

## Troubleshooting

- **Port already in use (3000):** stop conflicting process or change `tomcat.setPort(3000)` in `Main.java`.
- **Class not found when running:** make sure step 2 (`dependency:copy-dependencies`) has been executed.
- **Database issues:** delete `dev.db` and restart to recreate tables.
