package com.disaster.backend.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.disaster.backend.entity.Disaster;
import com.disaster.backend.repository.DisasterRepository;

@Service
public class DisasterService {

    private final DisasterRepository repository;

    public DisasterService(DisasterRepository repository) {
        this.repository = repository;
    }

    public List<Disaster> getAllDisasters() {
        return repository.findAll();
    }

    public Disaster saveDisaster(Disaster disaster) {
        return repository.save(disaster);
    }

    public void deleteDisaster(Long id) {
        repository.deleteById(id);
    }
}