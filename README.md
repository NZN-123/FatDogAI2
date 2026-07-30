# FatDogAI2

Spring Boot, Spring AI, JPA, MySQL로 만든 다중 AI 제공자 기반 웹 채팅 애플리케이션입니다. 사용자는 Groq, Gemini, NVIDIA NIM 중 하나를 선택해 질문할 수 있으며, 같은 브라우저 세션의 이전 대화를 DB에 저장하고 최근 대화 문맥을 다음 AI 요청에 전달합니다.

## 주요 기능

- Groq, Gemini, NVIDIA NIM 제공자 선택
- JSP 기반 웹 채팅 화면
- MySQL `chats` 테이블에 질문·답변·제공자·생성 시각 저장
- `HttpSession` ID를 이용한 브라우저 세션별 대화 분리
- 최근 활성 대화 5건을 AI 프롬프트에 포함해 문맥 유지
- 대화 초기화 시 하드 삭제 대신 `is_deleted = true`로 처리하는 소프트 딜리트
- 초기화된 대화는 화면과 AI 문맥 조회에서 제외

## 동작 흐름

```text
브라우저
  │ POST / (message, provider)
  ▼
ChatController ── HttpSession ID를 conversationId로 사용
  ▼
ChatService
  ├─ JPA로 현재 세션의 최근 활성 대화 5건 조회
  ├─ AIChatService에 이전 대화와 현재 질문 전달
  └─ 질문·답변을 Chat 엔티티로 저장
  ▼
MySQL chats 테이블
```

대화 초기화는 다음 흐름으로 작동합니다.

```text
POST /history/clear
→ 현재 session ID의 활성 Chat 조회
→ Chat.changeDeleted()
→ Hibernate 더티 체킹
→ UPDATE chats SET is_deleted = true
```

## 프로젝트 구조

```text
src/main/java/org/example/fatdogai2
├── config/
│   ├── ChatClientConfig.java    # 세 AI 제공자용 ChatClient 빈
│   └── JPAConfig.java
├── controller/
│   └── ChatController.java      # GET /, POST /, POST /history/clear
├── domain/
│   ├── ModelProvider.java       # groq, google, nim
│   └── NimProperties.java
├── dto/
│   └── ChatDTO.java
├── entity/
│   └── Chat.java                # chats 테이블 매핑
├── repository/
│   ├── ChatRepository.java      # 애플리케이션용 저장소 추상화
│   ├── ChatRepositoryImpl.java
│   └── JPAChatRepository.java   # Spring Data JPA/JPQL 조회
└── service/
    ├── AIChatService.java       # AI 요청 및 이전 대화 프롬프트 조합
    └── ChatService.java          # 저장·조회·소프트 딜리트
```

## 데이터 모델

Hibernate가 `Chat` 엔티티를 기준으로 `chats` 테이블을 관리합니다.

| 컬럼 | 설명 |
|---|---|
| `id` | 기본 키 |
| `question` | 사용자 질문 |
| `answer` | AI 답변 |
| `provider` | `groq`, `google`, `nim` |
| `created_at` | 저장 시각 |
| `conversation_id` | 브라우저 세션별 대화 식별자 |
| `is_deleted` | 소프트 딜리트 여부 |

현재 `spring.jpa.hibernate.ddl-auto=update` 설정을 사용하므로 애플리케이션 시작 시 테이블과 누락 컬럼이 반영됩니다. `src/main/resources/sql/schema.sql`은 수동 스키마 관리가 필요할 때 참고용으로만 사용하고, Hibernate가 스키마를 관리하는 동안에는 별도로 실행하지 않는 편이 안전합니다.

## 시작하기

### 요구 사항

- Java 17
- MySQL
- Groq, Gemini, NVIDIA NIM 중 사용할 제공자의 API 키

### 환경 변수 설정

루트의 `.env.dev.example` 또는 `.env.dev.sample`을 참고해 루트에 `.env.dev` 파일을 만듭니다. 이 파일은 Git에서 제외됩니다.

```properties
DB_HOST=localhost
DB_PORT=3306
DB_NAME=fatdog
DB_USER=your_db_user
DB_PASSWORD=your_db_password

GROQ_API_KEY=your_groq_key
GEMINI_API_KEY=your_gemini_key
NIM_API_KEY=your_nim_key
```

`application.properties`는 `.env.dev`를 선택적으로 불러옵니다. 사용하지 않는 제공자의 키는 비워 둘 수 있지만, 해당 제공자를 선택해 요청하면 인증 오류가 발생합니다.

### 로컬 실행

```bash
./mvnw spring-boot:run
```

브라우저에서 `http://localhost:8080`을 엽니다.

### 테스트와 컴파일

```bash
./mvnw test
./mvnw -DskipTests compile
```

### Docker 실행

```bash
docker build -t fatdog-ai2 .
docker run --env-file .env.dev -p 8080:8080 fatdog-ai2
```

컨테이너에서도 DB에 연결할 수 있도록 `DB_HOST`를 실제 MySQL 접근 주소로 설정해야 합니다.

## API 경로

| 메서드 | 경로 | 설명 |
|---|---|---|
| `GET` | `/` | 현재 세션의 활성 대화 이력 조회 및 화면 렌더링 |
| `POST` | `/` | 질문 전송, AI 답변 생성, 대화 저장 |
| `POST` | `/history/clear` | 현재 세션의 대화를 소프트 딜리트 |

## 대화 문맥 확인

같은 브라우저에서 다음처럼 테스트할 수 있습니다.

1. `내 이름은 철수야`를 전송합니다.
2. 이어서 `내 이름이 뭐야?`를 전송합니다.
3. AI 요청에는 이전 질문·답변이 포함되므로 철수라는 정보를 참고해 답변합니다.

AI 문맥에는 최근 활성 대화 5건만 전달됩니다. 전체 대화 기록은 `chats` 테이블에 남고, 초기화한 기록은 `is_deleted = true`로 표시되어 기본 조회에서 제외됩니다.

MySQL에서 저장 결과를 확인하려면 다음 쿼리를 사용합니다.

```sql
SELECT id, question, answer, provider, conversation_id, created_at, is_deleted
FROM chats
ORDER BY created_at DESC;
```
