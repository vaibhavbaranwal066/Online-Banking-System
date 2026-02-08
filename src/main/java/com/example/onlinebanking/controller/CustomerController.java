package com.example.onlinebanking.controller;

import com.example.onlinebanking.model.*;
import com.example.onlinebanking.repository.*;
import com.example.onlinebanking.service.AccountService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.math.BigDecimal;

@Controller
@RequestMapping("/customer")
public class CustomerController {
    private final CustomerRepository customerRepo;
    private final BankAccountRepository accountRepo;
    private final ChequeRequestRepository chequeRepo;
    private final TransactionRepository txnRepo;
    private final AccountService accountService;

    public CustomerController(CustomerRepository customerRepo, BankAccountRepository accountRepo,
                              ChequeRequestRepository chequeRepo, TransactionRepository txnRepo,
                              AccountService accountService){
        this.customerRepo = customerRepo;
        this.accountRepo = accountRepo;
        this.chequeRepo = chequeRepo;
        this.txnRepo = txnRepo;
        this.accountService = accountService;
    }

    /**
     * Customer Home - displays customer's accounts
     */
    @GetMapping("/home")
    public String home(Model m, Principal p){
        try {
            Customer c = customerRepo.findByUsername(p.getName())
                    .orElseThrow(() -> new IllegalArgumentException("Customer not found"));
            m.addAttribute("accounts", c.getAccounts());
            m.addAttribute("customer", c);
        } catch (Exception e) {
            m.addAttribute("errorMessage", "Error loading home: " + e.getMessage());
        }
        return "customer/home";
    }

    /**
     * Withdraw money from account with PIN validation
     */
    @PostMapping("/account/withdraw")
    public String withdraw(@RequestParam String accountNumber, @RequestParam BigDecimal amount, 
                          @RequestParam String pin, RedirectAttributes redirectAttrs){
        try {
            // Validate amount
            if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
                redirectAttrs.addAttribute("error", "Invalid amount. Amount must be greater than 0");
                return "redirect:/customer/home";
            }

            BankAccount acc = accountRepo.findByAccountNumber(accountNumber)
                    .orElseThrow(() -> new IllegalArgumentException("Account not found"));
            
            accountService.withdraw(acc, amount, pin);
            redirectAttrs.addAttribute("success", "Withdraw successful. New balance: " + acc.getBalance());
        } catch (RuntimeException e) {
            redirectAttrs.addAttribute("error", "Withdraw failed: " + e.getMessage());
        } catch (Exception e) {
            redirectAttrs.addAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/customer/home";
    }

    /**
     * Deposit money to account
     */
    @PostMapping("/account/deposit")
    public String deposit(@RequestParam String accountNumber, @RequestParam BigDecimal amount,
                         RedirectAttributes redirectAttrs){
        try {
            // Validate amount
            if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
                redirectAttrs.addAttribute("error", "Invalid amount. Amount must be greater than 0");
                return "redirect:/customer/home";
            }

            BankAccount acc = accountRepo.findByAccountNumber(accountNumber)
                    .orElseThrow(() -> new IllegalArgumentException("Account not found"));
            
            accountService.deposit(acc, amount);
            redirectAttrs.addAttribute("success", "Deposit successful. New balance: " + acc.getBalance());
        } catch (Exception e) {
            redirectAttrs.addAttribute("error", "Deposit failed: " + e.getMessage());
        }
        return "redirect:/customer/home";
    }

    /**
     * Transfer money between accounts with PIN validation
     */
    @PostMapping("/account/transfer")
    public String transfer(@RequestParam String fromAcc, @RequestParam String toAcc, 
                          @RequestParam BigDecimal amount, @RequestParam String pin,
                          RedirectAttributes redirectAttrs){
        try {
            // Validate amount
            if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
                redirectAttrs.addAttribute("error", "Invalid amount. Amount must be greater than 0");
                return "redirect:/customer/home";
            }

            // Validate accounts
            if (fromAcc.equals(toAcc)) {
                redirectAttrs.addAttribute("error", "Cannot transfer to the same account");
                return "redirect:/customer/home";
            }

            BankAccount from = accountRepo.findByAccountNumber(fromAcc)
                    .orElseThrow(() -> new IllegalArgumentException("Source account not found"));
            BankAccount to = accountRepo.findByAccountNumber(toAcc)
                    .orElseThrow(() -> new IllegalArgumentException("Destination account not found"));
            
            accountService.transfer(from, to, amount, pin);
            redirectAttrs.addAttribute("success", "Transfer successful. New balance: " + from.getBalance());
        } catch (RuntimeException e) {
            redirectAttrs.addAttribute("error", "Transfer failed: " + e.getMessage());
        } catch (Exception e) {
            redirectAttrs.addAttribute("error", "Error: " + e.getMessage());
        }
        return "redirect:/customer/home";
    }

    /**
     * Request cheque book
     */
    @PostMapping("/account/requestCheque")
    public String requestCheque(@RequestParam String accountNumber, RedirectAttributes redirectAttrs){
        try {
            BankAccount acc = accountRepo.findByAccountNumber(accountNumber)
                    .orElseThrow(() -> new IllegalArgumentException("Account not found"));
            
            ChequeRequest req = new ChequeRequest();
            req.setAccount(acc);
            req.setStatus("PENDING");
            req.setCreatedAt(java.time.LocalDateTime.now());
            chequeRepo.save(req);
            redirectAttrs.addAttribute("success", "Cheque book request submitted. Status: PENDING");
        } catch (Exception e) {
            redirectAttrs.addAttribute("error", "Error requesting cheque book: " + e.getMessage());
        }
        return "redirect:/customer/home";
    }

    /**
     * View account details and transaction history
     */
    @GetMapping("/account/{accountNumber}")
    public String viewAccount(@PathVariable String accountNumber, Model m, Principal p) {
        try {
            BankAccount account = accountRepo.findByAccountNumber(accountNumber)
                    .orElseThrow(() -> new IllegalArgumentException("Account not found"));
            
            // Verify ownership
            Customer customer = customerRepo.findByUsername(p.getName())
                    .orElseThrow(() -> new IllegalArgumentException("Customer not found"));
            
            if (!account.getOwner().getId().equals(customer.getId())) {
                m.addAttribute("errorMessage", "Unauthorized access to this account");
                return "error";
            }

            m.addAttribute("account", account);
            m.addAttribute("transactions", txnRepo.findAll()); // TODO: filter by account
        } catch (Exception e) {
            m.addAttribute("errorMessage", "Error loading account: " + e.getMessage());
        }
        return "customer/account-details";
    }
}

