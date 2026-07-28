package org.example.springai.dto;

import lombok.Builder;

@Builder
public record MovieRecommendationDTO(
        String title,
        int year,
        String genre,
        String reason
) {
}
