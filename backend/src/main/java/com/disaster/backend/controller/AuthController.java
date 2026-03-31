package com.disaster.backend.controller;

import org.springframework.web.bind.annotation.*;

import com.disaster.backend.entity.User;
import com.disaster.backend.service.UserService;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    private final UserService service;

    public AuthController(UserService service) {
        this.service = service;
    }

    // SIGNUP
    @PostMapping("/signup")
    public String signup(@RequestBody User user) {
        return service.registerUser(user);
    }

    @GetMapping("/test")
public String test() {
    return "Auth working";
}

    // LOGIN
    @PostMapping("/login")
    public String login(@RequestBody User user) {
        return service.loginUser(user.getEmail(), user.getPassword());
    }
}