package com.example.onlinebanking.repository;

import com.example.onlinebanking.model.BankTransaction;
import com.example.onlinebanking.model.BankAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface TransactionRepository extends JpaRepository<BankTransaction, Long> {
    List<BankTransaction> findByFromAccount(BankAccount account);
    List<BankTransaction> findByToAccount(BankAccount account);
    List<BankTransaction> findByFromAccountOrToAccount(BankAccount fromAccount, BankAccount toAccount);
}
