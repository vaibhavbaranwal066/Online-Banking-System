package com.example.onlinebanking.controller;

import com.example.onlinebanking.model.*;
import com.example.onlinebanking.repository.*;
import com.example.onlinebanking.service.AccountService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.security.Principal;
import java.math.BigDecimal;

@Controller
@RequestMapping("/customer")
public class CustomerController {
    private final CustomerRepository customerRepo;
    private final BankAccountRepository accountRepo;
    private final ChequeRequestRepository chequeRepo;
    private final AccountService accountService;

    public CustomerController(CustomerRepository customerRepo, BankAccountRepository accountRepo,
                              ChequeRequestRepository chequeRepo, AccountService accountService){
        this.customerRepo = customerRepo;
        this.accountRepo = accountRepo;
        this.chequeRepo = chequeRepo;
        this.accountService = accountService;
    }

    @GetMapping("/home")
    public String home(Model m, Principal p){
        Customer c = customerRepo.findByUsername(p.getName()).orElseThrow();
        m.addAttribute("accounts", c.getAccounts());
        m.addAttribute("customer", c);
        // view is located at /WEB-INF/jsp/customer/home.jsp
        return "customer/home";
    }

    @PostMapping("/account/withdraw")
    public String withdraw(@RequestParam String accountNumber, @RequestParam BigDecimal amount, @RequestParam String pin){
        BankAccount acc = accountRepo.findByAccountNumber(accountNumber).orElseThrow();
        accountService.withdraw(acc, amount, pin);
        return "redirect:/customer/home";
    }

    @PostMapping("/account/deposit")
    public String deposit(@RequestParam String accountNumber, @RequestParam BigDecimal amount){
        BankAccount acc = accountRepo.findByAccountNumber(accountNumber).orElseThrow();
        accountService.deposit(acc, amount);
        return "redirect:/customer/home";
    }

    @PostMapping("/account/transfer")
    public String transfer(@RequestParam String fromAcc, @RequestParam String toAcc, @RequestParam BigDecimal amount, @RequestParam String pin){
        BankAccount from = accountRepo.findByAccountNumber(fromAcc).orElseThrow();
        BankAccount to = accountRepo.findByAccountNumber(toAcc).orElseThrow();
        accountService.transfer(from, to, amount, pin);
        return "redirect:/customer/home";
    }

    @PostMapping("/account/requestCheque")
    public String requestCheque(@RequestParam String accountNumber){
        BankAccount acc = accountRepo.findByAccountNumber(accountNumber).orElseThrow();
        ChequeRequest req = new ChequeRequest();
        req.setAccount(acc);
        req.setStatus("PENDING");
        req.setCreatedAt(java.time.LocalDateTime.now());
        chequeRepo.save(req);
        return "redirect:/customer/home";
    }
}
