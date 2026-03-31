package com.disaster.backend.controller;

import java.util.List;
import org.springframework.web.bind.annotation.*;

import com.disaster.backend.entity.Contact;
import com.disaster.backend.service.ContactService;

@RestController
@RequestMapping("/api/contacts")
@CrossOrigin(origins = "*")
public class ContactController {

    private final ContactService service;

    public ContactController(ContactService service) {
        this.service = service;
    }

    // ✅ GET contacts by user
    @GetMapping("/user/{email}")
    public List<Contact> getUserContacts(@PathVariable String email) {
        return service.getContactsByUser(email);
    }

    // POST
    @PostMapping
    public Contact create(@RequestBody Contact contact) {
        return service.saveContact(contact);
    }

    // DELETE
    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.deleteContact(id);
    }
}