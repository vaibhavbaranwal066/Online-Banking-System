package com.example.onlinebanking.service;

import com.example.onlinebanking.model.*;
import com.example.onlinebanking.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Random;

@Service
public class AccountService {
    private final BankAccountRepository accountRepo;
    private final TransactionRepository txnRepo;
    private final PasswordEncoder passwordEncoder;

    public AccountService(BankAccountRepository accountRepo,
                          TransactionRepository txnRepo,
                          PasswordEncoder passwordEncoder) {
        this.accountRepo = accountRepo;
        this.txnRepo = txnRepo;
        this.passwordEncoder = passwordEncoder;
    }

    public BankAccount createAccount(Customer owner, AccountType type, BigDecimal initialDeposit) {
        BankAccount a = new BankAccount();
        a.setOwner(owner);
        a.setAccountType(type);
        a.setAccountNumber(generateAccountNumber());
        a.setBalance(initialDeposit == null ? BigDecimal.ZERO : initialDeposit);
        String cardId = generateCardId();
        a.setCardId(cardId);
        String rawPin = generate4DigitPin();
        a.setPinHash(passwordEncoder.encode(rawPin));
        a.setOpen(true);
        BankAccount saved = accountRepo.save(a);
        System.out.println("Created account " + saved.getAccountNumber() + " PIN: " + rawPin);
        return saved;
    }

    @Transactional
    public void withdraw(BankAccount account, BigDecimal amount, String providedPin) {
        if (!account.isOpen()) throw new IllegalStateException("Account closed");
        if (!passwordEncoder.matches(providedPin, account.getPinHash())) throw new RuntimeException("Invalid PIN");
        if (account.getBalance().compareTo(amount) < 0) throw new RuntimeException("Insufficient funds");
        account.setBalance(account.getBalance().subtract(amount));
        accountRepo.save(account);
        BankTransaction t = new BankTransaction();
        t.setType("WITHDRAW");
        t.setAmount(amount);
        t.setFromAccount(account);
        t.setTimestamp(LocalDateTime.now());
        t.setDescription("Withdraw");
        txnRepo.save(t);
    }

    @Transactional
    public void deposit(BankAccount account, BigDecimal amount) {
        if (!account.isOpen()) throw new IllegalStateException("Account closed");
        account.setBalance(account.getBalance().add(amount));
        accountRepo.save(account);
        BankTransaction t = new BankTransaction();
        t.setType("DEPOSIT");
        t.setAmount(amount);
        t.setToAccount(account);
        t.setTimestamp(LocalDateTime.now());
        t.setDescription("Deposit");
        txnRepo.save(t);
    }

    @Transactional
    public void transfer(BankAccount from, BankAccount to, BigDecimal amount, String providedPin) {
        if(!from.isOpen() || !to.isOpen()) throw new IllegalStateException("Either account closed");
        if(!passwordEncoder.matches(providedPin, from.getPinHash())) throw new RuntimeException("Invalid PIN");
        if(from.getBalance().compareTo(amount) < 0) throw new RuntimeException("Insufficient funds");
        from.setBalance(from.getBalance().subtract(amount));
        to.setBalance(to.getBalance().add(amount));
        accountRepo.save(from);
        accountRepo.save(to);
        BankTransaction t = new BankTransaction();
        t.setType("TRANSFER");
        t.setFromAccount(from);
        t.setToAccount(to);
        t.setAmount(amount);
        t.setTimestamp(LocalDateTime.now());
        t.setDescription("Transfer");
        txnRepo.save(t);
    }

    // helpers
    private String generateAccountNumber() {
        return "AC" + System.currentTimeMillis()%10000000;
    }
    private String generateCardId() {
        return "CARD" + System.currentTimeMillis()%100000;
    }
    private String generate4DigitPin() {
        Random r = new Random();
        int pin = 1000 + r.nextInt(9000);
        return String.valueOf(pin);
    }
}
