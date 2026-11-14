package com.jgdev.ctf;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/challenges")
public class ChallengeController {
  record Challenge(Long id, String title, String category, int points) {
  }

  @GetMapping
  public List<Challenge> getChallenges() {
    return List.of(
        new Challenge(1L, "Hello World", "Web", 100),
        new Challenge(2L, "Caesar Salad", "Crypto", 200),
        new Challenge(3L, "Strings Attached", "Reversing", 300));
  }
}
