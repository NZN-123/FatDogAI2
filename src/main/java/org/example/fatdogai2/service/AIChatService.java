package org.example.fatdogai2.service;

import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.dto.ChatDTO;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.prompt.ChatOptions;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

// Spring AI를 이용한 모델 호출 담당

@Service
@RequiredArgsConstructor
public class AIChatService {

    @Qualifier("geminiChatClient")
    private final ChatClient geminiChatClient;

    public String chat(ChatDTO dto) {
        switch (dto.provider()) {
            case google -> {
//                return geminiChatModel.call(dto.message());
                return geminiChatClient.prompt().user(dto.message()).call().content();
            }
            default -> {
                throw new RuntimeException("지원하지 않는 Provider : %s".formatted(dto.provider()));
            }
        }
    }
}
