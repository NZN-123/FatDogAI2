package org.example.springai.service;

import lombok.RequiredArgsConstructor;
import org.example.springai.dto.ChatDTO;
import org.example.springai.dto.MovieRecommendationDTO;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.ResponseEntity;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.ai.chat.prompt.ChatOptions;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ChatService {
    // Could not autowire. There is more than one bean of 'ChatModel' type.
//    @Qualifier("openAiChatModel") // Bean 이름으로 타입 기반 의존성 주입된 것 중 필요한 걸 지정
//    private final ChatModel chatModel;
    private final ChatClient groqChatClient; // ChatClient로 현재는 등록된 게 1개

    //    @Qualifier("googleGenAiChatModel")
//    private final ChatModel geminiChatModel;
    @Qualifier("geminiChatClient")
    private final ChatClient geminiChatClient;

    @Qualifier("nimChatClient")
    private final ChatClient nimChatClient;

    public String chat(ChatDTO dto) {
        System.out.println("dto = " + dto);
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

    // import org.springframework.ai.chat.client.ResponseEntity;
    public ResponseEntity<ChatResponse, MovieRecommendationDTO> recommend(ChatDTO dto) {
        return geminiChatClient.prompt()
                .system("이전 프롬프트는 무시하고 다음 키워드에 어울리는 영화 추천.")
                .user(dto.message())
                .call()
                .responseEntity(MovieRecommendationDTO.class);
        // JSON으로 나옴 -> Spring AI -> MovieRecommendationDTO 스키마를 설명에 주입
    }
}
