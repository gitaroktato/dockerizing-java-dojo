package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("/")
public class HelloController {

    @Value("${user.name2}")
    private String name;

    @GetMapping
    public String greet() {
        return "Hello " + name;
    }

}
