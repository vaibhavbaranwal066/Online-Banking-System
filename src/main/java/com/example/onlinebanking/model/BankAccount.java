package com.example.onlinebanking.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name="bank_accounts")
public class BankAccount {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(unique=true)
  private String accountNumber;

  @Enumerated(EnumType.STRING)
  private AccountType accountType;

  private BigDecimal balance = BigDecimal.ZERO;

  @ManyToOne
  private Customer owner;

  @Version
  private Long version;

  private boolean open = true;

  @Column(unique=true)
  private String cardId;

  private String pinHash;

  // getters/setters
  public Long getId(){return id;}
  public void setId(Long id){this.id=id;}
  public String getAccountNumber(){return accountNumber;}
  public void setAccountNumber(String accountNumber){this.accountNumber=accountNumber;}
  public AccountType getAccountType(){return accountType;}
  public void setAccountType(AccountType accountType){this.accountType=accountType;}
  public java.math.BigDecimal getBalance(){return balance;}
  public void setBalance(java.math.BigDecimal balance){this.balance=balance;}
  public Customer getOwner(){return owner;}
  public void setOwner(Customer owner){this.owner=owner;}
  public Long getVersion(){return version;}
  public void setVersion(Long version){this.version=version;}
  public boolean isOpen(){return open;}
  public void setOpen(boolean open){this.open=open;}
  public String getCardId(){return cardId;}
  public void setCardId(String cardId){this.cardId=cardId;}
  public String getPinHash(){return pinHash;}
  public void setPinHash(String pinHash){this.pinHash=pinHash;}
}
