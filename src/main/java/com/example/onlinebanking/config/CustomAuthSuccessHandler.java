package com.example.onlinebanking.config;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import java.io.IOException;

/**
 * Custom Authentication Success Handler to redirect users based on their role
 */
public class CustomAuthSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, 
                                       HttpServletResponse response,
                                       Authentication authentication) throws IOException, ServletException {
        
        if (authentication == null || !authentication.isAuthenticated()) {
            response.sendRedirect(request.getContextPath() + "/login?error=true");
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
            System.err.println("WARNING: User authenticated but no recognized role. Authorities: " + authentication.getAuthorities());
            // Redirect to home instead of root to avoid potential issues
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}
