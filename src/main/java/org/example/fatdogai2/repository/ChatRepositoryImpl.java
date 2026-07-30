package org.example.fatdogai2.repository;

import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.entity.Chat;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class ChatRepositoryImpl implements ChatRepository {
    private static final int CONTEXT_HISTORY_SIZE = 5;

    private final JPAChatRepository jpaChatRepository;

    @Override
    public Chat save(Chat chat) {
        return jpaChatRepository.save(chat);
    }

    @Override
    public List<Chat> findActiveByConversationId(String conversationId) {
        return jpaChatRepository.findActiveByConversationId(conversationId);
    }

    @Override
    public List<Chat> findRecentActiveByConversationId(String conversationId) {
        return jpaChatRepository.findRecentActiveByConversationId(
                conversationId,
                PageRequest.of(0, CONTEXT_HISTORY_SIZE));
    }
}
