package com.example.onlinebanking.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name="transactions")
public class BankTransaction {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  private String type;
  private BigDecimal amount;
  private LocalDateTime timestamp;

  @ManyToOne
  private BankAccount fromAccount;

  @ManyToOne
  private BankAccount toAccount;

  private String description;

  // getters/setters
  public Long getId(){return id;}
  public void setId(Long id){this.id=id;}
  public String getType(){return type;}
  public void setType(String type){this.type=type;}
  public BigDecimal getAmount(){return amount;}
  public void setAmount(BigDecimal amount){this.amount=amount;}
  public LocalDateTime getTimestamp(){return timestamp;}
  public void setTimestamp(LocalDateTime timestamp){this.timestamp=timestamp;}
  public BankAccount getFromAccount(){return fromAccount;}
  public void setFromAccount(BankAccount fromAccount){this.fromAccount=fromAccount;}
  public BankAccount getToAccount(){return toAccount;}
  public void setToAccount(BankAccount toAccount){this.toAccount=toAccount;}
  public String getDescription(){return description;}
  public void setDescription(String description){this.description=description;}
}
