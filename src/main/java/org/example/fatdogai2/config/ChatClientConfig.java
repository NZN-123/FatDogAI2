package org.example.fatdogai2.config;


import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.ai.google.genai.GoogleGenAiChatOptions;
import org.springframework.ai.google.genai.common.GoogleGenAiThinkingLevel;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ChatClientConfig {
    private final String systemMessage = """
            시작할 때 본인 모델의 정보를 알려주고, 최대한 한글로만 작성, 무엇을 물어보든 식사 메뉴 추천을 함
            """.trim();

    @Bean
    public ChatClient geminiChatClient(@Qualifier("googleGenAiChatModel") ChatModel chatModel) {
        return ChatClient
                .builder(chatModel)
                .defaultSystem(systemMessage)
                .defaultOptions(GoogleGenAiChatOptions.builder()
                        // gemini-3.5-flash-lite -> gemini-3.1-flash-lite
                        .model("gemini-3.5-flash-lite")
//                        .model("gemini-3.1-flash-lite")
                        .thinkingLevel(GoogleGenAiThinkingLevel.LOW))
                .build();
    }
}