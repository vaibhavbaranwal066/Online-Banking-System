package com.example.onlinebanking.repository;
import com.example.onlinebanking.model.Branch;
import org.springframework.data.jpa.repository.JpaRepository;
public interface BranchRepository extends JpaRepository<Branch, Long> {}
