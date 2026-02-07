package com.example.onlinebanking.config;

import com.example.onlinebanking.repository.AdminRepository;
import com.example.onlinebanking.repository.CustomerRepository;
import com.example.onlinebanking.model.Admin;
import com.example.onlinebanking.model.Customer;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.Optional;

@Configuration
public class SecurityConfig {

    // Password encoder bean (use this whenever you store passwords)
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // Custom user details service: loads Admins & Customers from DB
    // NOTE: stored passwords MUST be BCrypt-encoded for authentication to succeed.
    @Bean
    public UserDetailsService userDetailsService(AdminRepository adminRepo, CustomerRepository custRepo) {
        return username -> {
            Optional<Admin> a = adminRepo.findByUsername(username);
            if (a.isPresent()) {
                Admin ad = a.get();
                return User.withUsername(ad.getUsername())
                        .password(ad.getPassword()) // encoded in DB
                        .roles("ADMIN")
                        .build();
            }

            Optional<Customer> c = custRepo.findByUsername(username);
            if (c.isPresent()) {
                Customer cu = c.get();
                return User.withUsername(cu.getUsername())
                        .password(cu.getPassword()) // encoded in DB
                        .roles("CUSTOMER")
                        .build();
            }

            throw new UsernameNotFoundException("User not found: " + username);
        };
    }

    // Redirect users after login based on role
    @Bean
    public AuthenticationSuccessHandler customAuthSuccessHandler() {
        return (HttpServletRequest request, HttpServletResponse response,
                org.springframework.security.core.Authentication authentication) -> {

            if (authentication == null || !authentication.isAuthenticated()) {
                // Not actually authenticated; let Spring handle the error
                return;
            }

            boolean isAdmin = authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
            boolean isCustomer = authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_CUSTOMER"));

            if (isAdmin) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else if (isCustomer) {
                response.sendRedirect(request.getContextPath() + "/customer/home");
            } else {
                // No valid role: just return without redirecting.
                // Let the app render the default error page instead of redirect loop.
                System.err.println("WARNING: User authenticated but no recognized role. Authorities: " + authentication.getAuthorities());
                return;
            }
        };
    }

    // Main security configuration
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable()) // disabled for dev; enable in production
            .authorizeHttpRequests(auth -> auth
                // public resources and pages
                .requestMatchers("/css/**", "/js/**", "/images/**",
                                 "/", "/login", "/adminregister",
                                 "/perform_login", "/error")
                .permitAll()

                // role-based access
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .requestMatchers("/customer/**").hasRole("CUSTOMER")

                // everything else requires authentication
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")                   // GET /login
                .loginProcessingUrl("/perform_login")  // POST /perform_login
                .successHandler(customAuthSuccessHandler()) // only this handler
                .failureUrl("/login?error=true")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
            );

        return http.build();
    }
}
