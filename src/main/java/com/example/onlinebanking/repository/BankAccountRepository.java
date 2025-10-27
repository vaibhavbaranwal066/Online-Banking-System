package com.example.onlinebanking.repository;
import com.example.onlinebanking.model.BankAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
public interface BankAccountRepository extends JpaRepository<BankAccount, Long> {
  Optional<BankAccount> findByAccountNumber(String accountNumber);
  Optional<BankAccount> findByCardId(String cardId);
}
