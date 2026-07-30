package org.example.fatdogai2.repository;

import org.example.fatdogai2.entity.Chat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface JPAChatRepository extends JpaRepository<Chat, Long> {
    @Query("""
            SELECT c
            FROM Chat c
            WHERE c.conversationId = ?1
              AND c.isDeleted = false
            ORDER BY c.createdAt ASC
            """)
    @Transactional(readOnly = true)
    List<Chat> findActiveByConversationId(String conversationId);

    @Query("""
            SELECT c
            FROM Chat c
            WHERE c.conversationId = ?1
              AND c.isDeleted = false
            ORDER BY c.createdAt DESC
            """)
    @Transactional(readOnly = true)
    List<Chat> findRecentActiveByConversationId(String conversationId, Pageable pageable);
}
