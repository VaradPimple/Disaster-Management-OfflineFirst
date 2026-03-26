package com.disaster.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.disaster.backend.entity.Disaster;

public interface DisasterRepository extends JpaRepository<Disaster, Long> {
}