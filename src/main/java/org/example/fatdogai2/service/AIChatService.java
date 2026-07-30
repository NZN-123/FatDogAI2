package org.example.fatdogai2.service;

import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.dto.ChatDTO;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.ai.chat.prompt.ChatOptions;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AIChatService {
    private static final String SYSTEM_PROMPT = "사용자의 질문에 친절하고 상세하게 한국어로 답변해 주세요.";

    private final ChatClient groqChatClient;

    @Qualifier("geminiChatClient")
    private final ChatClient geminiChatClient;

    @Qualifier("nimChatClient")
    private final ChatClient nimChatClient;

    public String chat(ChatDTO dto, String sessionId) {
        return switch (dto.provider()) {
            case groq -> groqChatClient.prompt()
                    .system(SYSTEM_PROMPT)
                    .advisors(a -> a.param(ChatMemory.CONVERSATION_ID, sessionId))
                    .user(dto.message())
                    .options(ChatOptions.builder()
                            .model("openai/gpt-oss-120b")
                            .temperature(0.4)
                            .maxTokens(4096))
                    .call()
                    .content();
            case google -> geminiChatClient.prompt()
                    .system(SYSTEM_PROMPT)
                    .advisors(a -> a.param(ChatMemory.CONVERSATION_ID, sessionId))
                    .user(dto.message())
                    .call()
                    .content();
            case nim -> nimChatClient.prompt()
                    .system(SYSTEM_PROMPT)
                    .advisors(a -> a.param(ChatMemory.CONVERSATION_ID, sessionId))
                    .user(dto.message())
                    .call()
                    .content();
        };
    }
}
