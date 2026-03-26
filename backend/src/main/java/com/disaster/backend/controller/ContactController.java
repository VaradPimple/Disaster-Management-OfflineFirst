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

    @GetMapping
    public List<Contact> getAll() {
        return service.getAllContacts();
    }

    @PostMapping
    public Contact create(@RequestBody Contact contact) {
        return service.saveContact(contact);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.deleteContact(id);
    }
}