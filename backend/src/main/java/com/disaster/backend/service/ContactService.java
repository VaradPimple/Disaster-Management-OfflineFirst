package com.disaster.backend.service;

import java.util.List;
import org.springframework.stereotype.Service;

import com.disaster.backend.entity.Contact;
import com.disaster.backend.repository.ContactRepository;

@Service
public class ContactService {

    private final ContactRepository repository;

    public ContactService(ContactRepository repository) {
        this.repository = repository;
    }

    public List<Contact> getContactsByUser(String email) {
        return repository.findByUserEmail(email); // ✅ UPDATED
    }

    public Contact saveContact(Contact contact) {
        return repository.save(contact);
    }

    public void deleteContact(Long id) {
        repository.deleteById(id);
    }
}