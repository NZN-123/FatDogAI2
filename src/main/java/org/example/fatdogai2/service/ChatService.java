package org.example.fatdogai2.service;

import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.dto.ChatDTO;
import org.example.fatdogai2.entity.Chat;
import org.example.fatdogai2.repository.ChatRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ChatService {
    private final AIChatService aiChatService;
    private final ChatRepository chatRepository;

    public String chat(ChatDTO dto, String conversationId) {
        List<Chat> recentHistory = new ArrayList<>(
                chatRepository.findRecentActiveByConversationId(conversationId));
        Collections.reverse(recentHistory);

        String answer = aiChatService.chat(dto, recentHistory);

        Chat chatRecord = new Chat();
        chatRecord.setQuestion(dto.message());
        chatRecord.setAnswer(answer);
        chatRecord.setProvider(dto.provider().name());
        chatRecord.setConversationId(conversationId);
        chatRepository.save(chatRecord);
        return answer;
    }

    @Transactional(readOnly = true)
    public List<Chat> getChatHistory(String conversationId) {
        return chatRepository.findActiveByConversationId(conversationId);
    }

    @Transactional
    public void clearChatHistory(String conversationId) {
        chatRepository.findActiveByConversationId(conversationId)
                .forEach(Chat::changeDeleted);
    }
}
