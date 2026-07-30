package org.example.fatdogai2.service;

import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.dto.ChatDTO;
import org.example.fatdogai2.entity.Chat;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.prompt.ChatOptions;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AIChatService {
    private static final String SYSTEM_PROMPT = "사용자의 질문에 친절하고 상세하게 한국어로 답변해 주세요.";

    private final ChatClient groqChatClient;

    @Qualifier("geminiChatClient")
    private final ChatClient geminiChatClient;

    @Qualifier("nimChatClient")
    private final ChatClient nimChatClient;

    public String chat(ChatDTO dto, List<Chat> recentHistory) {
        String prompt = buildPrompt(dto.message(), recentHistory);

        return switch (dto.provider()) {
            case groq -> groqChatClient.prompt()
                    .system(SYSTEM_PROMPT)
                    .user(prompt)
                    .options(ChatOptions.builder()
                            .model("openai/gpt-oss-120b")
                            .temperature(0.4)
                            .maxTokens(4096))
                    .call()
                    .content();
            case google -> geminiChatClient.prompt()
                    .system(SYSTEM_PROMPT)
                    .user(prompt)
                    .call()
                    .content();
            case nim -> nimChatClient.prompt()
                    .system(SYSTEM_PROMPT)
                    .user(prompt)
                    .call()
                    .content();
        };
    }

    private String buildPrompt(String message, List<Chat> recentHistory) {
        if (recentHistory.isEmpty()) {
            return message;
        }

        String history = recentHistory.stream()
                .map(chat -> "사용자: %s\nAI: %s".formatted(chat.getQuestion(), chat.getAnswer()))
                .reduce((first, second) -> first + "\n\n" + second)
                .orElse("");

        return """
                다음은 이전 대화 기록입니다. 문맥으로만 참고하고, 현재 질문에 답변하세요.

                [이전 대화]
                %s

                [현재 질문]
                %s
                """.formatted(history, message);
    }
}
