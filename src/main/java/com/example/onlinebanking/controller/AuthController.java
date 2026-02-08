package com.example.onlinebanking.controller;

import com.example.onlinebanking.model.Admin;
import com.example.onlinebanking.repository.AdminRepository;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.security.Principal;

@Controller
public class AuthController {
    private final AdminRepository adminRepo;
    private final PasswordEncoder encoder;

    public AuthController(AdminRepository adminRepo, PasswordEncoder encoder){
        this.adminRepo = adminRepo;
        this.encoder = encoder;
    }

    /**
     * ✅ Login page mapping
     * Shows login form for unauthenticated users
     * Redirects authenticated users to their dashboard
     */
    @GetMapping("/login")
    public String loginPage(Model m, Principal principal) {
        // If user is already authenticated, redirect them to appropriate dashboard
        if (principal != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            boolean isAdmin = auth.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
            if (isAdmin) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/customer/home";
            }
        }
        // Otherwise, show the login form
        return "login";
    }

    /**
     * ✅ Admin registration form page
     */
    @GetMapping("/adminregister")
    public String adminRegisterForm(Model m){
        m.addAttribute("admin", new Admin());
        return "admin/register";
    }

    /**
     * ✅ Handle admin registration
     */
    @PostMapping("/adminregister")
    public String adminRegister(@ModelAttribute Admin admin, Model m){
        try {
            // Validate input
            if (admin.getUsername() == null || admin.getUsername().trim().isEmpty()) {
                m.addAttribute("error", "Username cannot be empty");
                m.addAttribute("admin", admin);
                return "admin/register";
            }
            
            // Check if username already exists
            if (adminRepo.findByUsername(admin.getUsername()).isPresent()) {
                m.addAttribute("error", "Username already exists. Please choose another.");
                m.addAttribute("admin", admin);
                return "admin/register";
            }
            
            // Validate password
            if (admin.getPassword() == null || admin.getPassword().isEmpty()) {
                m.addAttribute("error", "Password cannot be empty");
                m.addAttribute("admin", admin);
                return "admin/register";
            }
            
            // Encrypt and save password
            admin.setPassword(encoder.encode(admin.getPassword()));
            adminRepo.save(admin);
            
            // Redirect to login with success message
            return "redirect:/login?registered=true";
        } catch (Exception e) {
            m.addAttribute("error", "Error during registration: " + e.getMessage());
            m.addAttribute("admin", admin);
            return "admin/register";
        }
    }
}

