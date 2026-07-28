package org.example.fatdogai2.config;

import org.example.fatdogai2.domain.NimProperties;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.ai.google.genai.GoogleGenAiChatOptions;
import org.springframework.ai.google.genai.common.GoogleGenAiThinkingLevel;
import org.springframework.ai.openai.OpenAiChatModel;
import org.springframework.ai.openai.OpenAiChatOptions;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
@EnableConfigurationProperties(NimProperties.class)
public class ChatClientConfig {
    private final String systemMessage = """
            시작할 때 본인 모델의 정보를 알려주고, 최대한 한글로만 작성, 무엇을 물어보든 식사 메뉴 추천을 함
            """.trim();

    @Primary
    @Bean
    public ChatClient groqChatClient(@Qualifier("openAiChatModel") ChatModel chatModel) {
        String model = "qwen/qwen3.6-27b";
        return ChatClient
                .builder(chatModel)
                .defaultSystem(systemMessage)
                .defaultOptions(OpenAiChatOptions.builder()
                        .model(model)
                        .reasoningEffort("none"))
                .build();
    }

    @Bean
    public ChatClient geminiChatClient(@Qualifier("googleGenAiChatModel") ChatModel chatModel) {
        return ChatClient
                .builder(chatModel)
                .defaultSystem(systemMessage)
                .defaultOptions(GoogleGenAiChatOptions.builder()
                        .model("gemini-3.5-flash-lite")
                        .thinkingLevel(GoogleGenAiThinkingLevel.LOW))
                .build();
    }

    @Bean
    public ChatModel nimChatModel(NimProperties nimProperties) {
        return OpenAiChatModel.builder()
                .options(
                        OpenAiChatOptions.builder()
                                .baseUrl(nimProperties.baseUrl())
                                .apiKey(nimProperties.apiKey())
                                .model(nimProperties.chat().model())
                                .build()
                ).build();
    }

    @Bean
    public ChatClient nimChatClient(@Qualifier("nimChatModel") ChatModel chatModel) {
        String model = "stepfun-ai/step-3.7-flash";
        return ChatClient
                .builder(chatModel)
                .defaultSystem(systemMessage)
                .defaultOptions(OpenAiChatOptions.builder()
                        .model(model))
                .build();
    }
}
