# Online Banking - Sample Spring Boot + JSP Project

## Setup
1. Install Java 21 (latest LTS) and Maven.
2. Create MySQL database `online_banking`.
3. Update `src/main/resources/application.properties` with your MySQL username/password.
4. Build & run (tested with Java 21):
   - `mvn clean package`
   - `mvn spring-boot:run`
5. Open http://localhost:8080/login
   - default admin: `admin` / `Admin@123`

This project is a minimal skeleton to help you start. It includes Admin + Customer modules, basic account operations, cheque requests, and security.

Note: The project has been verified to build and run with Java 21 (LTS). Update your JDK to Java 21 and ensure your `JAVA_HOME` and PATH point to the Java 21 install before building or running.
