package org.example.fatdogai2.domain;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "spring.ai.nim")
public record NimProperties(
        String apiKey,
        String baseUrl,
        Chat chat
) {
    public record Chat(String model) {}
}
