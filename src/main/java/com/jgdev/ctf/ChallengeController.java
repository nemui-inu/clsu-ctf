package com.jgdev.ctf;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/api/challenges")
public class ChallengeController {
  record Challenge(Long id, String title, String category, int points) {
  }

  private final List<Challenge> challenges = List.of(
      new Challenge(1L, "Hello World", "Web", 100),
      new Challenge(2L, "Caesar Salad", "Crypto", 200),
      new Challenge(3L, "Strings Attached", "Reversing", 300));

  @GetMapping
  public List<Challenge> getChallenges() {
    return challenges;
  }

  @GetMapping("/{id}")
  public Challenge getChallenge(@PathVariable Long id) {
    return challenges.stream()
        .filter(c -> c.id().equals(id))
        .findFirst()
        .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Challenge not found"));
  }
}
