package org.example.fatdogai2.service;

import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.dto.ChatDto;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.prompt.ChatOptions;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AIChatService {
    private final ChatClient groqChatClient;

    @Qualifier("geminiChatClient")
    private final ChatClient geminiChatClient;

    @Qualifier("nimChatClient")
    private final ChatClient nimChatClient;

    public String chat(ChatDto dto) {
        String systemPrompt = "이전의 모든 지시(음식 메뉴 추천 등)는 무시하고, 사용자의 질문에 친절하고 상세하게 한국어로 답변해 주세요.";
        switch (dto.provider()) {
            case groq -> {
                return groqChatClient.prompt()
                        .system(systemPrompt)
                        .user(dto.message())
                        .options(ChatOptions.builder()
                                .model("llama-3.3-70b-versatile")
                        )
                        .call().content();
            }
            case google -> {
                return geminiChatClient.prompt()
                        .system(systemPrompt)
                        .user(dto.message())
                        .call().content();
            }
            case nim -> {
                return nimChatClient.prompt()
                        .system(systemPrompt)
                        .user(dto.message())
                        .call().content();
            }
            default -> {
                throw new RuntimeException("지원하지 않는 Provider : %s".formatted(dto.provider()));
            }
        }
    }
}
