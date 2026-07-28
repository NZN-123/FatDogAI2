package org.example.fatdogai2.service;

// Spring AI를 이용한 모델 호출 담당

import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.dto.ChatDTO;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.prompt.ChatOptions;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor

public class AIChatService {
    private final ChatClient groqChatClient;

    public String chat(ChatDTO dto) {
        switch (dto.provider()){
            case groq -> {
                return groqChatClient.prompt()
                        .system("최대한 사용자를 위해 대답")
                        .user(dto.message())
                        .options(ChatOptions.builder()
                                .model("openai/gpt-oss-120b")
                                .temperature(0.4)
                                .maxTokens(4096)
                        )
                        .call().content();
            }
            default -> {
                throw new RuntimeException(" %s는 지원하지 않는 모델입니다".formatted(dto.provider()));
            }
        }
    }
}
