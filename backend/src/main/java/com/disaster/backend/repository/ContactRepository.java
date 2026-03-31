package com.disaster.backend.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.disaster.backend.entity.Contact;

public interface ContactRepository extends JpaRepository<Contact, Long> {

    List<Contact> findByUserEmail(String userEmail); // ✅ NEW
}