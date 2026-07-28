package org.example.springai.config;

import org.example.springai.domain.NimProperties;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.ai.google.genai.GoogleGenAiChatOptions;
import org.springframework.ai.google.genai.common.GoogleGenAiThinkingLevel;
import org.springframework.ai.openai.OpenAiChatModel;
import org.springframework.ai.openai.OpenAiChatOptions;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration // Auto Scan <- ***Application
// -> @Bean을 등록하는데 쓰임 -> Spring Container 관리하는 객체
// -> 우리가 의도적으로 사용하는 건 Singleton
// 상태관리는 무엇으로? -> DB (Persistence - RDBMS, Redis)
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
//                .defaultOptions(ChatOptions.builder()
//                        // openai/gpt-oss-120b
//                        .model("qwen/qwen3.6-27b")
//                        ) // .build() X -> builder 자체를 넣어야함
                .defaultOptions(OpenAiChatOptions.builder()
                        .model(model)
                        .reasoningEffort("none")) // 모델과 프로바이더마다 조금씩 설정 작성 방법이 다 다름
                .build();
    }

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
        // deepseek-ai/deepseek-v4-flash
        String model = "stepfun-ai/step-3.7-flash";
        return ChatClient
                .builder(chatModel)
                .defaultSystem(systemMessage)
                .defaultOptions(OpenAiChatOptions.builder()
                        .model(model))
                .build();
    }
}
