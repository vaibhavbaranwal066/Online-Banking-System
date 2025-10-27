package com.example.onlinebanking.controller;

import com.example.onlinebanking.model.*;
import com.example.onlinebanking.repository.*;
import com.example.onlinebanking.service.AccountService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/dashboard")
    public String dashboard(Model m){
        m.addAttribute("totalCustomers", customerRepo.count());
        m.addAttribute("totalAccounts", accountRepo.count());
        m.addAttribute("totalTransactions", txnRepo.count());
        m.addAttribute("chequeRequests", chequeRepo.findAll());
        m.addAttribute("branches", branchRepo.findAll());
        m.addAttribute("customers", customerRepo.findAll());
        return "admin/dashboard";
    }

    @PostMapping("/branch/add")
    public String addBranch(@ModelAttribute Branch branch){
        branchRepo.save(branch);
        return "redirect:/admin/dashboard";
    }

    /**
     * Adds a customer. Password will be encoded before saving.
     * If no password was provided, a default password will be used
     * (Customer@123) — change the default if you want.
     */
    @PostMapping("/customer/add")
    public String addCustomer(@ModelAttribute Customer c, @RequestParam Long branchId){
        Branch b = branchRepo.findById(branchId).orElse(null);
        c.setBranch(b);

        // ensure password is set and encoded
        String raw = c.getPassword();
        if(raw == null || raw.trim().isEmpty()){
            raw = "Customer@123"; // default password for new customers (you can change this)
        }
        c.setPassword(passwordEncoder.encode(raw));

        customerRepo.save(c);
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/account/add")
    public String addAccount(@RequestParam Long customerId, @RequestParam String accountType, @RequestParam(required=false) BigDecimal initialDeposit){
        Customer cust = customerRepo.findById(customerId).orElseThrow();
        accountService.createAccount(cust, AccountType.valueOf(accountType), initialDeposit);
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/cheque/approve/{id}")
    public String approveCheque(@PathVariable Long id){
        ChequeRequest req = chequeRepo.findById(id).orElseThrow();
        req.setStatus("APPROVED");
        req.setApprovedAt(java.time.LocalDateTime.now());
        chequeRepo.save(req);
        return "redirect:/admin/dashboard";
    }
}
