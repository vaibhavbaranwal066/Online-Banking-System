package com.example.onlinebanking.controller;

import com.example.onlinebanking.model.*;
import com.example.onlinebanking.repository.*;
import com.example.onlinebanking.service.AccountService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;

@Controller
@RequestMapping("/admin")
public class AdminController {
    private final BranchRepository branchRepo;
    private final CustomerRepository customerRepo;
    private final BankAccountRepository accountRepo;
    private final TransactionRepository txnRepo;
    private final ChequeRequestRepository chequeRepo;
    private final AccountService accountService;
    private final PasswordEncoder passwordEncoder;

    public AdminController(BranchRepository branchRepo, CustomerRepository customerRepo,
                           BankAccountRepository accountRepo, TransactionRepository txnRepo,
                           ChequeRequestRepository chequeRepo, AccountService accountService,
                           PasswordEncoder passwordEncoder){
        this.branchRepo = branchRepo;
        this.customerRepo = customerRepo;
        this.accountRepo = accountRepo;
        this.txnRepo = txnRepo;
        this.chequeRepo = chequeRepo;
        this.accountService = accountService;
        this.passwordEncoder = passwordEncoder;
    }

    /**
     * Admin Dashboard - displays overview and lists
     */
    @GetMapping("/dashboard")
    public String dashboard(Model m){
        try {
            m.addAttribute("totalCustomers", customerRepo.count());
            m.addAttribute("totalAccounts", accountRepo.count());
            m.addAttribute("totalTransactions", txnRepo.count());
            m.addAttribute("chequeRequests", chequeRepo.findAll());
            m.addAttribute("branches", branchRepo.findAll());
            m.addAttribute("customers", customerRepo.findAll());
        } catch (Exception e) {
            m.addAttribute("errorMessage", "Error loading dashboard: " + e.getMessage());
        }
        return "admin/dashboard";
    }

    /**
     * Add Branch - POST request
     */
    @PostMapping("/branch/add")
    public String addBranch(@ModelAttribute Branch branch, RedirectAttributes redirectAttrs){
        try {
            if (branch.getName() == null || branch.getName().trim().isEmpty()) {
                redirectAttrs.addAttribute("error", "Branch name cannot be empty");
                return "redirect:/admin/dashboard";
            }
            branchRepo.save(branch);
            redirectAttrs.addAttribute("success", "Branch added successfully");
        } catch (Exception e) {
            redirectAttrs.addAttribute("error", "Error adding branch: " + e.getMessage());
        }
        return "redirect:/admin/dashboard";
    }

    /**
     * Add Customer with validation
     * Password is required and will be BCrypt encoded
     */
    @PostMapping("/customer/add")
    public String addCustomer(@ModelAttribute Customer c, @RequestParam Long branchId, 
                             RedirectAttributes redirectAttrs){
        try {
            // Validate username
            if (c.getUsername() == null || c.getUsername().trim().isEmpty()) {
                redirectAttrs.addAttribute("error", "Username cannot be empty");
                return "redirect:/admin/dashboard";
            }
            
            // Check if username already exists
            if (customerRepo.findByUsername(c.getUsername()).isPresent()) {
                redirectAttrs.addAttribute("error", "Username already exists");
                return "redirect:/admin/dashboard";
            }

            // Set branch
            Branch branch = branchRepo.findById(branchId)
                    .orElseThrow(() -> new IllegalArgumentException("Branch not found"));
            c.setBranch(branch);

            // Encode password
            String raw = c.getPassword();
            if(raw == null || raw.trim().isEmpty()){
                raw = "Customer@123"; // default password
            }
            c.setPassword(passwordEncoder.encode(raw));

            customerRepo.save(c);
            redirectAttrs.addAttribute("success", "Customer added successfully");
        } catch (Exception e) {
            redirectAttrs.addAttribute("error", "Error adding customer: " + e.getMessage());
        }
        return "redirect:/admin/dashboard";
    }

    /**
     * Create Bank Account for Customer
     */
    @PostMapping("/account/add")
    public String addAccount(@RequestParam Long customerId, @RequestParam String accountType, 
                            @RequestParam(required=false) BigDecimal initialDeposit,
                            RedirectAttributes redirectAttrs){
        try {
            Customer cust = customerRepo.findById(customerId)
                    .orElseThrow(() -> new IllegalArgumentException("Customer not found"));
            
            if (initialDeposit != null && initialDeposit.compareTo(BigDecimal.ZERO) < 0) {
                redirectAttrs.addAttribute("error", "Initial deposit cannot be negative");
                return "redirect:/admin/dashboard";
            }

            BankAccount newAccount = accountService.createAccount(cust, 
                    AccountType.valueOf(accountType), initialDeposit);
            redirectAttrs.addAttribute("success", 
                    "Account created: " + newAccount.getAccountNumber());
        } catch (Exception e) {
            redirectAttrs.addAttribute("error", "Error creating account: " + e.getMessage());
        }
        return "redirect:/admin/dashboard";
    }

    /**
     * Approve Cheque Request
     */
    @PostMapping("/cheque/approve/{id}")
    public String approveCheque(@PathVariable Long id, RedirectAttributes redirectAttrs){
        try {
            ChequeRequest req = chequeRepo.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Cheque request not found"));
            req.setStatus("APPROVED");
            req.setApprovedAt(java.time.LocalDateTime.now());
            chequeRepo.save(req);
            redirectAttrs.addAttribute("success", "Cheque request approved");
        } catch (Exception e) {
            redirectAttrs.addAttribute("error", "Error approving cheque request: " + e.getMessage());
        }
        return "redirect:/admin/dashboard";
    }

    /**
     * View customer details
     */
    @GetMapping("/customer/{id}")
    public String viewCustomer(@PathVariable Long id, Model m) {
        try {
            Customer customer = customerRepo.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Customer not found"));
            m.addAttribute("customer", customer);
            m.addAttribute("accounts", customer.getAccounts());
        } catch (Exception e) {
            m.addAttribute("errorMessage", "Error loading customer: " + e.getMessage());
        }
        return "admin/customer-details";
    }

    /**
     * View branch details
     */
    @GetMapping("/branch/{id}")
    public String viewBranch(@PathVariable Long id, Model m) {
        try {
            Branch branch = branchRepo.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Branch not found"));
            m.addAttribute("branch", branch);
        } catch (Exception e) {
            m.addAttribute("errorMessage", "Error loading branch: " + e.getMessage());
        }
        return "admin/branch-details";
    }
}

