package org.example.fatdogai2.dto;

import org.example.fatdogai2.domain.ModelProvider;

public record ChatDto(String message, ModelProvider provider) {
}
