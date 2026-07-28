package org.example.fatdogai2.repository;

import org.example.fatdogai2.entity.Chat;
import java.util.List;

public interface ChatRepository {
    Chat save(Chat chat);
    List<Chat> findAll();
}
