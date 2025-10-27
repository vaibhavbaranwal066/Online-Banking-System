package com.example.onlinebanking.model;

import jakarta.persistence.*;
import java.util.*;

@Entity
@Table(name="customers")
public class Customer {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  @Column(unique=true)
  private String username;
  private String password;
  private String fullName;

  @ManyToOne
  private Branch branch;

  @OneToMany(mappedBy="owner", cascade = CascadeType.ALL)
  private List<BankAccount> accounts = new ArrayList<>();

  // getters/setters
  public Long getId(){return id;}
  public void setId(Long id){this.id=id;}
  public String getUsername(){return username;}
  public void setUsername(String username){this.username=username;}
  public String getPassword(){return password;}
  public void setPassword(String password){this.password=password;}
  public String getFullName(){return fullName;}
  public void setFullName(String fullName){this.fullName=fullName;}
  public Branch getBranch(){return branch;}
  public void setBranch(Branch branch){this.branch=branch;}
  public List<BankAccount> getAccounts(){return accounts;}
  public void setAccounts(List<BankAccount> accounts){this.accounts=accounts;}
}
