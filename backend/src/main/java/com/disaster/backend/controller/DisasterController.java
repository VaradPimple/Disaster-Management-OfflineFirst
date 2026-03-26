package com.disaster.backend.controller;

import java.util.List;
import org.springframework.web.bind.annotation.*;

import com.disaster.backend.entity.Disaster;
import com.disaster.backend.service.DisasterService;

@RestController
@RequestMapping("/api/disasters")
@CrossOrigin(origins = "*")
public class DisasterController {

    private final DisasterService service;

    public DisasterController(DisasterService service) {
        this.service = service;
    }

    @GetMapping
    public List<Disaster> getAll() {
        return service.getAllDisasters();
    }

    @PostMapping
    public Disaster create(@RequestBody Disaster disaster) {
        return service.saveDisaster(disaster);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.deleteDisaster(id);
    }

    @GetMapping("/test")
    public String insertTestDisaster() {

        Disaster d = new Disaster();
        d.setType("Flood");
        d.setLatitude(19.05);
        d.setLongitude(73.02);
        d.setRadius(2000);
        d.setMessage("Flood warning near river");

        service.saveDisaster(d);

        return "Disaster inserted successfully";
    }
}