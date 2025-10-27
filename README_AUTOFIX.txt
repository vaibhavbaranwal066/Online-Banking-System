Auto-applied fixes:
- Switched application.properties to H2 in-memory for easy local run.
- Updated login.jsp to post to /perform_login and use c:url for css.
- Removed duplicate DataSeeder to avoid bean name collision and added customer seeding.
- Added H2 dependency to pom.xml if missing.

Run with: mvn clean install && mvn spring-boot:run

Seeded accounts: admin/Admin@123  customer/Customer@123
