CREATE TABLE IF NOT EXISTS chats (
                                     id BIGINT NOT NULL AUTO_INCREMENT,
                                     question TEXT NOT NULL,
                                     answer TEXT NOT NULL,
                                     provider VARCHAR(30) NOT NULL,
    created_at DATETIME NOT NULL,
    conversation_id VARCHAR(100) NOT NULL,

    PRIMARY KEY (id),
    INDEX idx_chats_conversation_created_at (conversation_id, created_at)
    ) ENGINE=InnoDB
    DEFAULT CHARSET=utf8mb4
    COLLATE=utf8mb4_unicode_ci;