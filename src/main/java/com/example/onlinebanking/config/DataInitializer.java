package com.example.onlinebanking.config;

import com.example.onlinebanking.model.Admin;
import com.example.onlinebanking.model.Customer;
import com.example.onlinebanking.repository.AdminRepository;
import com.example.onlinebanking.repository.CustomerRepository;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class DataInitializer {

    @Bean
    public CommandLineRunner init(AdminRepository adminRepo, CustomerRepository custRepo, PasswordEncoder encoder) {
        return args -> {
            // Seed default admin if not present
            if (adminRepo.findByUsername("admin").isEmpty()) {
                Admin a = new Admin();
                a.setUsername("admin");
                a.setFullName("Super Admin");
                a.setPassword(encoder.encode("Admin@123"));
                adminRepo.save(a);
                System.out.println("Created default admin -> admin / Admin@123");
            }

            // Seed default customer if not present
            if (custRepo.findByUsername("customer").isEmpty()) {
                Customer c = new Customer();
                c.setUsername("customer");
                c.setFullName("Default Customer");
                c.setPassword(encoder.encode("Customer@123"));
                custRepo.save(c);
                System.out.println("Created default customer -> customer / Customer@123");
            }
        };
    }
}


