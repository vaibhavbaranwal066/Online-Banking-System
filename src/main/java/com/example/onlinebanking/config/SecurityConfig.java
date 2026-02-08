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
        return new CustomAuthSuccessHandler();
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
                .loginPage("/login")                        // GET /login - form login page
                .loginProcessingUrl("/perform_login")       // POST /perform_login - form action
                .successHandler(customAuthSuccessHandler()) // Handle successful login with role-based redirect
                .failureUrl("/login?error=true")            // Failed login redirect
                .permitAll()                                // Allow login page for all users
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID", "XSRF-TOKEN")
                .permitAll()
            )
            // Prevent redirect loop for authenticated users accessing login page
            .requestCache(cache -> cache.requestCache(null));

        return http.build();
    }
}
