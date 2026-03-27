package com.disaster.backend.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.disaster.backend.entity.User;
import com.disaster.backend.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository repository;

    public UserService(UserRepository repository) {
        this.repository = repository;
    }

    // SIGNUP
    public String registerUser(User user) {

        Optional<User> existingUser = repository.findByEmail(user.getEmail());

        if (existingUser.isPresent()) {
            return "Email already exists";
        }

        repository.save(user);
        return "User registered successfully";
    }

    // LOGIN
    public String loginUser(String email, String password) {

        Optional<User> userOpt = repository.findByEmail(email);

        if (userOpt.isEmpty()) {
            return "User not found";
        }

        User user = userOpt.get();

        if (!user.getPassword().equals(password)) {
            return "Invalid password";
        }

        return "Login successful (" + user.getRole() + ")";
    }
}