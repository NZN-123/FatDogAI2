package org.example.fatdogai2.service;

import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.dto.ChatDto;
import org.example.fatdogai2.entity.Chat;
import org.example.fatdogai2.repository.ChatRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ChatService {
    private final AIChatService aiChatService;
    private final ChatRepository chatRepository;

    @Transactional
    public String chat(ChatDto dto) {
        // 1. Create and populate conversation log
        Chat chatRecord = new Chat();
        chatRecord.setQuestion(dto.message());
        chatRecord.setProvider(dto.provider().name());
        
        // 2. Call AI to generate answer
        String answer = aiChatService.chat(dto);
        
        // 3. Populate answer and save to Database
        chatRecord.setAnswer(answer);
        chatRepository.save(chatRecord);
        
        return answer;
    }

    @Transactional(readOnly = true)
    public List<Chat> getChatHistory() {
        return chatRepository.findAll();
    }
}
