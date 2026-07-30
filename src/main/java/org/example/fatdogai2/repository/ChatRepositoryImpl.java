package org.example.fatdogai2.repository;

import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.entity.Chat;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class ChatRepositoryImpl implements ChatRepository {
    private final JPAChatRepository jpaChatRepository;

    @Override
    public Chat save(Chat chat) {
        return jpaChatRepository.save(chat);
    }

    @Override
    public List<Chat> findAll() {
        return jpaChatRepository.findAll();
    }
}
