package com.example.onlinebanking.repository;

import com.example.onlinebanking.model.ChequeRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ChequeRequestRepository extends JpaRepository<ChequeRequest, Long> {
    List<ChequeRequest> findByStatus(String status);
    List<ChequeRequest> findByStatusOrderByCreatedAtDesc(String status);
}
