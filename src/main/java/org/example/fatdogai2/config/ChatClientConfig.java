package org.example.fatdogai2.config;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.ai.openai.OpenAiChatOptions;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
public class ChatClientConfig {
    @Primary
    @Bean
    public ChatClient groqChatClient(@Qualifier("openAiChatModel") ChatModel chatModel) {
        String model = "openai/gpt-oss-120b";
        return ChatClient
                .builder(chatModel)
                .defaultOptions(OpenAiChatOptions.builder()
                        .model(model)
                        .reasoningEffort("none"))
                .build();
    }
}
