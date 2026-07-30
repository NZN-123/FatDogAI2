package org.example.fatdogai2.repository;

import org.example.fatdogai2.entity.Chat;
import org.springframework.data.jpa.repository.JpaRepository;

public interface JPAChatRepository extends JpaRepository<Chat, Long> {
}
