package org.example.springai.dto;

import org.example.springai.domain.ModelProvider;

public record ChatDTO(String message, ModelProvider provider) {
}
