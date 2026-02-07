package com.example.onlinebanking.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String root() {
        // Show landing page instead of immediately redirecting to login.
        // This avoids a redirect loop in some browsers when cookies/sessions
        // have inconsistent auth state. The `index.jsp` contains a link
        // to the login page.
        return "index";
    }
}
