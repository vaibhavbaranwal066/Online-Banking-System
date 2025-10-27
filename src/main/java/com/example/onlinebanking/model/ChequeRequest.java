package com.example.onlinebanking.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name="cheque_requests")
public class ChequeRequest {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne
  private BankAccount account;

  private String status;
  private LocalDateTime createdAt;
  private LocalDateTime approvedAt;

  // getters/setters
  public Long getId(){return id;}
  public void setId(Long id){this.id=id;}
  public BankAccount getAccount(){return account;}
  public void setAccount(BankAccount account){this.account=account;}
  public String getStatus(){return status;}
  public void setStatus(String status){this.status=status;}
  public LocalDateTime getCreatedAt(){return createdAt;}
  public void setCreatedAt(LocalDateTime createdAt){this.createdAt=createdAt;}
  public LocalDateTime getApprovedAt(){return approvedAt;}
  public void setApprovedAt(LocalDateTime approvedAt){this.approvedAt=approvedAt;}
}
