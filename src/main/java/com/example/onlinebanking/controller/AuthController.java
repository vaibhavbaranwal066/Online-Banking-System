package com.example.onlinebanking.controller;

import com.example.onlinebanking.model.Admin;
import com.example.onlinebanking.repository.AdminRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.crypto.password.PasswordEncoder;

@Controller
public class AuthController {
    private final AdminRepository adminRepo;
    private final PasswordEncoder encoder;

    public AuthController(AdminRepository adminRepo, PasswordEncoder encoder){
        this.adminRepo = adminRepo;
        this.encoder = encoder;
    }

    // ✅ Login page mapping
    @GetMapping("/login")
    public String loginPage() {
        // Simply return the login view. Spring Security handles redirects
        // for already-authenticated users via the success handler.
        return "login";
    }

    // ✅ Admin registration form
    @GetMapping("/adminregister")
    public String adminRegisterForm(Model m){
        m.addAttribute("admin", new Admin());
        return "admin/register";
    }

    // ✅ Handle admin registration
    @PostMapping("/adminregister")
    public String adminRegister(@ModelAttribute Admin admin){
        admin.setPassword(encoder.encode(admin.getPassword()));
        adminRepo.save(admin);
        return "redirect:/login";
    }

    // ❌ Removed @GetMapping("/") to avoid conflict
}
