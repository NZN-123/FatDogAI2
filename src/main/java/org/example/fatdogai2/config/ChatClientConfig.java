package org.example.fatdogai2.config;

import org.example.fatdogai2.domain.NimProperties;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.MessageChatMemoryAdvisor;
import org.springframework.ai.chat.memory.ChatMemory;
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

    private final ChatMemory chatMemory;

    public ChatClientConfig(ChatMemory chatMemory) {
        this.chatMemory = chatMemory;
    }

    @Primary
    @Bean
    public ChatClient groqChatClient(@Qualifier("openAiChatModel") ChatModel chatModel) {
        return ChatClient.builder(chatModel)
                .defaultOptions(OpenAiChatOptions.builder()
                        .model("openai/gpt-oss-120b")
                        .reasoningEffort("none"))
                .defaultAdvisors(MessageChatMemoryAdvisor.builder(chatMemory).build())
                .build();
    }

    @Bean
    public ChatClient geminiChatClient(@Qualifier("googleGenAiChatModel") ChatModel chatModel) {
        return ChatClient.builder(chatModel)
                .defaultOptions(GoogleGenAiChatOptions.builder()
                        .model("gemini-3.5-flash-lite")
                        .thinkingLevel(GoogleGenAiThinkingLevel.LOW))
                .defaultAdvisors(MessageChatMemoryAdvisor.builder(chatMemory).build())
                .build();
    }

    @Bean
    public ChatModel nimChatModel(NimProperties nimProperties) {
        return OpenAiChatModel.builder()
                .options(OpenAiChatOptions.builder()
                        .baseUrl(nimProperties.baseUrl())
                        .apiKey(nimProperties.apiKey())
                        .model(nimProperties.chat().model())
                        .build())
                .build();
    }

    @Bean
    public ChatClient nimChatClient(@Qualifier("nimChatModel") ChatModel chatModel) {
        return ChatClient.builder(chatModel)
                .defaultAdvisors(MessageChatMemoryAdvisor.builder(chatMemory).build())
                .build();
    }
}
