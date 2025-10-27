package com.example.onlinebanking.repository;
import com.example.onlinebanking.model.BankTransaction;
import org.springframework.data.jpa.repository.JpaRepository;
public interface TransactionRepository extends JpaRepository<BankTransaction, Long> {}
