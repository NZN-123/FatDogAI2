package org.example.springai.domain;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "spring.ai.nim")
public record NimProperties(
        String apiKey, // api-key -> apiKey
        String baseUrl, // base-url -> baseUrl
//        String model
        Chat chat // record -> model
) {
    public record Chat(String model) {
    }
}
