<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FatDog Chat - 스마트 인공지능 어시스턴트</title>
    <!-- Pretendard Font Import (Highly readable, no pixelation on Windows) -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css" />
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        /* style.css - Clean Modern Website & Chatbot Theme */
        :root {
            --color-bg-base: #f8f9fa;       /* Soft clean light gray background */
            --color-bg-card: #ffffff;       /* Pure white content card */
            --color-text-main: #212529;     /* Dark charcoal */
            --color-text-secondary: #495057;/* Slate gray */
            --color-text-muted: #6c757d;    /* Soft gray */
            --color-border: #e9ecef;        /* Very light border */
            --color-primary: #2d5a27;       /* Professional deep leaf green */
            --color-primary-hover: #1f3f1b;
            --color-primary-light: #eff6ee; /* Soft green background tint */
            --font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            --radius-lg: 12px;
            --radius-md: 8px;
            --radius-sm: 4px;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.05), 0 1px 2px rgba(0,0,0,0.02);
            --shadow-md: 0 4px 6px -1px rgba(0,0,0,0.05), 0 2px 4px -1px rgba(0,0,0,0.03);
            --shadow-lg: 0 10px 15px -3px rgba(0,0,0,0.05), 0 4px 6px -2px rgba(0,0,0,0.02);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: var(--font-family);
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        body {
            background-color: var(--color-bg-base);
            color: var(--color-text-main);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header & Navigation Bar */
        .navbar {
            background-color: var(--color-bg-card);
            border-bottom: 1px solid var(--color-border);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0.85rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            color: var(--color-text-main);
            font-weight: 700;
            font-size: 1.15rem;
            letter-spacing: -0.5px;
        }

        .logo-icon {
            background-color: var(--color-primary);
            color: white;
            width: 28px;
            height: 28px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.85rem;
        }

        .nav-menu {
            display: flex;
            gap: 1.5rem;
            list-style: none;
        }

        .nav-link {
            text-decoration: none;
            color: var(--color-text-secondary);
            font-size: 0.9rem;
            font-weight: 500;
            transition: color 0.2s;
        }

        .nav-link:hover, .nav-link.active {
            color: var(--color-primary);
        }

        /* Main Layout Wrapper */
        .main-wrapper {
            max-width: 800px;
            width: 100%;
            margin: 2.5rem auto;
            padding: 0 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 2rem;
            flex-grow: 1;
        }

        /* Service Info Section */
        .hero-card {
            background-color: var(--color-bg-card);
            border: 1px solid var(--color-border);
            border-radius: var(--radius-lg);
            padding: 2rem;
            box-shadow: var(--shadow-sm);
        }

        .hero-title {
            font-size: 1.35rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--color-text-main);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .hero-badge {
            background-color: var(--color-primary-light);
            color: var(--color-primary);
            font-size: 0.75rem;
            padding: 0.2rem 0.5rem;
            border-radius: 99px;
            font-weight: 600;
        }

        .hero-desc {
            font-size: 0.9rem;
            color: var(--color-text-secondary);
            line-height: 1.6;
        }

        /* Chatbot Section Card */
        .chat-card {
            background-color: var(--color-bg-card);
            border: 1px solid var(--color-border);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            min-height: 480px;
        }

        .chat-card-header {
            background-color: #fafbfc;
            border-bottom: 1px solid var(--color-border);
            padding: 1rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chat-card-title {
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--color-text-main);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .chat-dot {
            width: 8px;
            height: 8px;
            background-color: #2ec4b6;
            border-radius: 50%;
            display: inline-block;
        }

        /* Messages Workspace */
        .chat-messages {
            flex-grow: 1;
            overflow-y: auto;
            padding: 2rem 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
            background-color: #fafbfb;
        }

        .message-row {
            display: flex;
            gap: 0.75rem;
            width: 100%;
        }

        .avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: 700;
            flex-shrink: 0;
            border: 1px solid var(--color-border);
        }

        .avatar.bot {
            background-color: var(--color-primary-light);
            color: var(--color-primary);
        }

        .avatar.user {
            background-color: #e9ecef;
            color: var(--color-text-secondary);
        }

        .message-content-box {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
            max-width: 85%;
        }

        .message-header {
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--color-text-secondary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .message-time {
            font-size: 0.7rem;
            color: var(--color-text-muted);
            font-weight: 400;
        }

        .message-bubble {
            background-color: var(--color-bg-card);
            border: 1px solid var(--color-border);
            padding: 0.85rem 1.15rem;
            border-radius: 0 10px 10px 10px;
            font-size: 0.92rem;
            line-height: 1.6;
            color: var(--color-text-main);
            box-shadow: 0 1px 2px rgba(0,0,0,0.02);
            word-break: break-word;
        }

        .message-row-user {
            flex-direction: row-reverse;
        }

        .message-row-user .message-bubble {
            background-color: var(--color-primary-light);
            border-color: #d1ebd1;
            border-radius: 10px 0 10px 10px;
        }

        .message-row-user .message-content-box {
            align-items: flex-end;
        }

        /* Collapsible technical details block */
        .meta-wrapper {
            margin-top: 1rem;
            border-top: 1px dashed var(--color-border);
            padding-top: 0.5rem;
        }

        .meta-toggle-btn {
            background: none;
            border: none;
            color: var(--color-text-muted);
            font-size: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .meta-toggle-btn:hover {
            color: var(--color-primary);
        }

        .meta-details {
            display: none;
            margin-top: 0.5rem;
            font-family: monospace;
            font-size: 0.75rem;
            background-color: var(--color-bg-base);
            border: 1px solid var(--color-border);
            padding: 0.75rem;
            border-radius: var(--radius-sm);
            overflow-x: auto;
            white-space: pre-wrap;
            color: var(--color-text-secondary);
        }

        /* Chat Input Bar */
        .chat-input-bar {
            border-top: 1px solid var(--color-border);
            padding: 1.25rem 1.5rem;
            background-color: var(--color-bg-card);
        }

        .chat-input-form {
            display: flex;
            gap: 0.75rem;
            align-items: center;
            position: relative;
        }

        .provider-wrapper {
            position: relative;
            flex-shrink: 0;
        }

        .provider-dropdown {
            appearance: none;
            background-color: var(--color-bg-base);
            border: 1px solid var(--color-border);
            border-radius: var(--radius-md);
            padding: 0.65rem 2rem 0.65rem 0.85rem;
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--color-text-secondary);
            cursor: pointer;
            outline: none;
            transition: all 0.2s;
        }

        .provider-dropdown:hover {
            background-color: #e9ecef;
        }

        .provider-chevron {
            position: absolute;
            right: 0.65rem;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
            color: var(--color-text-muted);
            font-size: 0.65rem;
        }

        .message-text-input {
            flex-grow: 1;
            background-color: var(--color-bg-base);
            border: 1px solid var(--color-border);
            border-radius: var(--radius-md);
            padding: 0.65rem 1rem;
            font-size: 0.9rem;
            color: var(--color-text-main);
            outline: none;
            transition: all 0.2s;
        }

        .message-text-input:focus {
            border-color: var(--color-primary);
            background-color: white;
            box-shadow: 0 0 0 3px rgba(45, 90, 39, 0.08);
        }

        .submit-btn {
            background-color: var(--color-primary);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            padding: 0.65rem 1.5rem;
            font-size: 0.85rem;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .submit-btn:hover {
            background-color: var(--color-primary-hover);
        }

        /* Footer Section */
        .footer {
            background-color: var(--color-bg-card);
            border-top: 1px solid var(--color-border);
            padding: 2rem 1.5rem;
            margin-top: auto;
            text-align: center;
            font-size: 0.8rem;
            color: var(--color-text-muted);
        }

        .footer-container {
            max-width: 1000px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        /* Loading display styling */
        .loading-box {
            display: none;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.8rem;
            color: var(--color-text-muted);
        }

        .loading-dots {
            display: inline-flex;
            gap: 3px;
        }

        .loading-dot {
            width: 6px;
            height: 6px;
            background-color: var(--color-text-muted);
            border-radius: 50%;
            animation: bounce 1.4s infinite ease-in-out both;
        }

        .loading-dot:nth-child(1) { animation-delay: -0.32s; }
        .loading-dot:nth-child(2) { animation-delay: -0.16s; }

        @keyframes bounce {
            0%, 80%, 100% { transform: scale(0); }
            40% { transform: scale(1.0); }
        }

        @media (max-width: 768px) {
            .main-wrapper {
                margin: 1rem auto;
                padding: 0 1rem;
            }
            .chat-messages {
                padding: 1.25rem 1rem;
            }
            .chat-card {
                min-height: 400px;
            }
            .nav-menu {
                display: none;
            }
        }
    </style>
</head>
<body>

    <!-- Header Navigation -->
    <nav class="navbar">
        <div class="navbar-container">
            <a href="/" class="logo-link">
                <div class="logo-icon">FD</div>
                <span>FatDog Chat</span>
            </a>
            <ul class="nav-menu">
                <li><a href="/" class="nav-link active">챗봇 대화방</a></li>
                <li><a href="#" class="nav-link" onclick="alert('준비 중인 서비스 설명 페이지입니다.')">서비스 소개</a></li>
                <li><a href="#" class="nav-link" onclick="alert('준비 중인 고객 지원 페이지입니다.')">고객 지원</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content Layout -->
    <div class="main-wrapper">
        <!-- Hero Introduction Card -->
        <section class="hero-card">
            <h2 class="hero-title">
                FatDog 스마트 어시스턴트
                <span class="hero-badge">v1.2</span>
            </h2>
            <p class="hero-desc">
                업무 지식 탐색, 글쓰기, 기획 등 다양한 분야의 질문에 스마트하게 답변해 드립니다. 
                궁금한 내용을 아래 대화창에 입력해 보세요.
            </p>
        </section>

        <!-- Chat Console Card -->
        <section class="chat-card">
            <div class="chat-card-header">
                <div class="chat-card-title">
                    <span class="chat-dot"></span>
                    실시간 대화 채널
                </div>
                <a href="/" class="nav-link" style="font-size: 0.8rem; text-decoration: underline;">대화 초기화</a>
            </div>

            <!-- Messages Area -->
            <div class="chat-messages" id="chat-messages">
                <!-- Welcome Message from Bot -->
                <div class="message-row">
                    <div class="avatar bot">FD</div>
                    <div class="message-content-box">
                        <div class="message-header">
                            FatDog Chat
                            <span class="message-time">오늘</span>
                        </div>
                        <div class="message-bubble">
                            안녕하세요! FatDog Chat 어시스턴트입니다. 
                            일상적인 대화부터 업무, 코딩, 기획 등 필요한 내용을 자유롭게 물어보세요.
                        </div>
                    </div>
                </div>

                <!-- User Query -->
                <c:if test="${not empty lastMessage}">
                    <div class="message-row message-row-user">
                        <div class="avatar user">나</div>
                        <div class="message-content-box">
                            <div class="message-header">
                                사용자
                                <span class="message-time">방금 전</span>
                            </div>
                            <div class="message-bubble">
                                <c:out value="${lastMessage}"/>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Bot Response -->
                <c:if test="${not empty answer}">
                    <div class="message-row">
                        <div class="avatar bot">FD</div>
                        <div class="message-content-box" style="width: 100%;">
                            <div class="message-header">
                                FatDog Chat
                                <span class="message-time">방금 전</span>
                            </div>
                            <div class="message-bubble" id="answer-bubble-container" style="background-color: var(--color-bg-card);">
                                <!-- Raw answer value container (hidden) -->
                                <div id="answer-raw" hidden><c:out value="${answer}"/></div>
                                <!-- Target container for dynamic rendering -->
                                <div id="answer-container"></div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Chat Input Area -->
            <div class="chat-input-bar">
                <form method="post" class="chat-input-form" onsubmit="showLoading()">
                    <div class="provider-wrapper">
                        <select name="provider" class="provider-dropdown" id="provider-select">
                            <c:forEach items="${providers}" var="provider">
                                <option value="${provider}" <c:if test="${provider == lastProvider}">selected</c:if>>${provider}</option>
                            </c:forEach>
                        </select>
                        <i data-lucide="chevron-down" class="provider-chevron" style="width: 12px; height: 12px;"></i>
                    </div>

                    <input name="message" id="message-input" class="message-text-input" placeholder="이곳에 메시지를 입력하세요..." required autocomplete="off">

                    <div style="display: flex; align-items: center; gap: 0.75rem;">
                        <!-- Loading Indicator -->
                        <div id="loading-box" class="loading-box">
                            <span>생각 중</span>
                            <div class="loading-dots">
                                <span class="loading-dot"></span>
                                <span class="loading-dot"></span>
                                <span class="loading-dot"></span>
                            </div>
                        </div>
                        <button class="submit-btn" type="submit">전송</button>
                    </div>
                </form>
            </div>
        </section>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-container">
            <span>Powered by Spring AI Framework & Gemini Client</span>
            <span>© 2026 FatDog Service. All Rights Reserved.</span>
        </div>
    </footer>

<!-- JS Processing -->
<script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Initialize Lucide Icons if used
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }

        // Scroll to the bottom of the chat list
        const chatMessages = document.getElementById('chat-messages');
        if (chatMessages) {
            chatMessages.scrollTop = chatMessages.scrollHeight;
        }

        // Parse and render the answer
        const rawEl = document.getElementById('answer-raw');
        const containerEl = document.getElementById('answer-container');
        
        if (rawEl && containerEl) {
            const rawText = rawEl.textContent.trim();
            const movieData = parseMovieDto(rawText);

            if (movieData) {
                // Render elegant structured block matching the modern theme
                let html = '<div style="font-weight: 700; margin-bottom: 0.25rem; font-size: 1.05rem; color: var(--color-primary);">🍿 ' + movieData.title + '</div>' +
                           '<div style="font-size: 0.75rem; color: var(--color-text-muted); margin-bottom: 0.75rem; font-weight: 500;">' + movieData.genre + ' • ' + (movieData.year ? movieData.year + '년 작' : '연도 미상') + '</div>' +
                           '<div style="font-size: 0.9rem; line-height: 1.6; color: var(--color-text-secondary);">' + movieData.reason + '</div>';
                
                if (movieData.metadata) {
                    html += '<div class="meta-wrapper">' +
                            '<button type="button" class="meta-toggle-btn" onclick="toggleMetadata(this)">' +
                            '기술 정보 보기' +
                            '</button>' +
                            '<div class="meta-details">' + escapeHtml(movieData.metadata) + '</div>' +
                            '</div>';
                }
                containerEl.innerHTML = html;
            } else {
                // Fallback to normal text/markdown rendering
                containerEl.innerHTML = marked.parse(rawText);
            }

            // Scroll to the bottom again after content expands
            chatMessages.scrollTop = chatMessages.scrollHeight;
        }
    });

    // Show loading animation
    function showLoading() {
        const loadingBox = document.getElementById('loading-box');
        if (loadingBox) {
            loadingBox.style.display = 'flex';
        }
    }

    // Toggle Technical Metadata Visibility
    function toggleMetadata(btn) {
        const codeBlock = btn.nextElementSibling;
        if (codeBlock) {
            if (codeBlock.style.display === 'block') {
                codeBlock.style.display = 'none';
            } else {
                codeBlock.style.display = 'block';
            }
        }
    }

    // Helper: Parse DTO from response string
    function parseMovieDto(text) {
        if (!text) return null;
        
        const dtoPrefix = "MovieRecommendationDTO[";
        const startIdx = text.indexOf(dtoPrefix);
        
        if (startIdx !== -1) {
            const endIdx = text.indexOf("]", startIdx);
            if (endIdx !== -1) {
                const dtoContent = text.substring(startIdx + dtoPrefix.length, endIdx);
                const metadataContent = text.substring(endIdx + 1).trim();
                
                // Extract using lazy matching up to key indicators
                const titleMatch = dtoContent.match(/title=(.*?)(?=\s*,\s*year=)/s);
                const yearMatch = dtoContent.match(/year=(\d+)/);
                const genreMatch = dtoContent.match(/genre=(.*?)(?=\s*,\s*reason=)/s);
                const reasonMatch = dtoContent.match(/reason=(.*)/s);
                
                if (titleMatch && yearMatch && genreMatch && reasonMatch) {
                    return {
                        title: titleMatch[1].trim(),
                        year: yearMatch[1].trim(),
                        genre: genreMatch[1].trim(),
                        reason: reasonMatch[1].trim(),
                        metadata: metadataContent
                    };
                }
            }
        }
        return null;
    }

    // Helper: Escape HTML
    function escapeHtml(text) {
        return text
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
</script>

</body>
</html>
