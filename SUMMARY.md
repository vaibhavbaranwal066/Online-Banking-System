Upgrade summary — Spring Boot 3.5.7

What I changed
- Upgraded `spring-boot-starter-parent` from 3.1.0 to 3.5.7 in `pom.xml`.
- Added a minimal smoke test `src/test/java/com/example/onlinebanking/OnlineBankingApplicationTests.java` (annotated with `@SpringBootTest`) so builds exercise application startup.
- Initialized a git repository and created branch `upgrade/spring-3.5` with a commit: "chore: upgrade Spring Boot to 3.5.7 and add smoke test".

Verification performed
- Ran `mvn -U clean package` (with tests) — BUILD SUCCESS; smoke test passed.
- Ran `mvn -U versions:display-dependency-updates` — noted optional dependency updates (H2, Tomcat Jasper, JSTL, etc.).
- Inspected Spring-related dependency tree (`mvn dependency:tree -Dincludes="org.springframework"`) — project resolves Spring Boot 3.5.7 and Spring Framework 6.2.x.

Recommended next steps (safe, ordered)
1. Push the new branch to your remote repository and run CI to validate on a clean environment:
   - git push origin upgrade/spring-3.5
2. Run dependency updates iteratively (non-breaking first):
   - Update `com.h2database:h2` to 2.4.x
   - Update `org.apache.tomcat.embed:tomcat-embed-jasper` and JSTL libs to Jakarta-compatible releases
   - Re-run `mvn -U clean package` after each change and fix any test failures.
3. Run OpenRewrite in dry-run to list automated code migrations (javax -> jakarta and other Spring helper changes), review the generated patch, and apply only reviewed changes.
   Example command (dry-run):
   mvn org.openrewrite:rewrite-maven-plugin:4.49.0:run -Drewrite.dryRun=true \
     -Drewrite.recipeArtifactCoordinates=org.openrewrite.recipe:rewrite-spring:latest

4. Add more tests:
   - Unit tests for services and controllers
   - Integration tests that exercise key flows (create account, perform transaction)

5. Finalize:
   - Apply approved OpenRewrite changes or manual fixes.
   - Re-run full build + tests until green.
   - Update the changelog and merge the `upgrade/spring-3.5` branch into your mainline.

Notes & caveats
- The project currently builds and the basic smoke test passes on Java 21.
- Many Spring-related dependencies have newer major releases (4.0.0 / 7.0.0-R) available; do not upgrade to Spring Boot 4 or Spring 7 yet unless you plan to do a separate migration.
- OpenRewrite is recommended but should be run in dry-run first and changes inspected.

If you want, I can:
- Run OpenRewrite dry-run and present the patch for your review, or
- Update the small set of safe dependency patches (H2, Tomcat Jasper, JSTL) and re-run tests, or
- Push the `upgrade/spring-3.5` branch to a remote (if you provide remote or want me to create one).

End of summary.
