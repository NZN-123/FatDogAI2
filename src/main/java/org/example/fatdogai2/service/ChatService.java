package org.example.fatdogai2.service;

import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.dto.ChatDTO;
import org.example.fatdogai2.entity.ChatMessageJPA;
import org.example.fatdogai2.repository.ChatMemoryJpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ChatService {
    private final AIChatService aiChatService;
    private final ChatMemoryJpaRepository chatMemoryJpaRepository;

    public String chat(ChatDTO dto, String sessionId) {
        return aiChatService.chat(dto, sessionId);
    }

    public List<ChatMessageJPA> getChatHistory(String sessionId) {
        return chatMemoryJpaRepository.findAllByConversationId(sessionId);
    }

    public void clearHistory(String sessionId) {
        chatMemoryJpaRepository.deleteAllByConversationId(sessionId);
    }
}
