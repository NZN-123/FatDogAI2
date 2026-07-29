<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FatDog Chat - 스마트 인공지능 어시스턴트</title>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css" />
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        :root {
            --color-bg-base: #f8f9fa;
            --color-bg-card: #ffffff;
            --color-text-main: #212529;
            --color-text-secondary: #495057;
            --color-text-muted: #6c757d;
            --color-border: #e9ecef;
            --color-primary: #2d5a27;
            --color-primary-hover: #1f3f1b;
            --color-primary-light: #eff6ee;
            --font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            --radius-lg: 12px;
            --radius-md: 8px;
            --radius-sm: 4px;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.05), 0 1px 2px rgba(0,0,0,0.02);
            --shadow-md: 0 4px 6px -1px rgba(0,0,0,0.05), 0 2px 4px -1px rgba(0,0,0,0.03);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: var(--font-family);
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

        /* Hero Introduction Card */
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
            max-height: 380px;
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

        .loading-box {
            display: none;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.8rem;
            color: var(--color-text-muted);
            margin-top: 0.5rem;
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
                <a href="/clear" class="nav-link" style="font-size: 0.8rem; text-decoration: underline;">대화 초기화</a>
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

                <!-- Chat history from server -->
                <c:forEach items="${history}" var="msg">
                    <c:choose>
                        <c:when test="${msg.messageType == 'USER'}">
                            <div class="message-row message-row-user">
                                <div class="avatar user">나</div>
                                <div class="message-content-box">
                                    <div class="message-header">사용자</div>
                                    <div class="message-bubble">
                                        <c:out value="${msg.content}"/>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:when test="${msg.messageType == 'ASSISTANT'}">
                            <div class="message-row">
                                <div class="avatar bot">FD</div>
                                <div class="message-content-box">
                                    <div class="message-header">FatDog Chat</div>
                                    <div class="message-bubble">
                                        <c:out value="${msg.content}"/>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                    </c:choose>
                </c:forEach>
            </div>

            <!-- Chat Input Bar -->
            <div class="chat-input-bar">
                <form action="/" method="post" class="chat-input-form" onsubmit="showLoading()">
                    <div class="provider-wrapper">
                        <select name="provider" class="provider-dropdown">
                            <c:forEach items="${providers}" var="p">
                                <option value="${p}">${p.name()}</option>
                            </c:forEach>
                        </select>
                        <span class="provider-chevron">▼</span>
                    </div>
                    <input type="text" name="message" id="messageInput" class="message-text-input" placeholder="메시지를 입력하세요..." required autocomplete="off">
                    <button type="submit" class="submit-btn">전송</button>
                </form>
                <div class="loading-box" id="loadingBox">
                    <div class="loading-dots">
                        <span class="loading-dot"></span>
                        <span class="loading-dot"></span>
                        <span class="loading-dot"></span>
                    </div>
                    <span>답변을 생성하는 중입니다...</span>
                </div>
            </div>
        </section>

    </div>

    <!-- Footer Section -->
    <footer class="footer">
        <div class="footer-container">
            <p>&copy; 2026 FatDog AI. All rights reserved.</p>
        </div>
    </footer>

    <script>
        window.addEventListener('DOMContentLoaded', () => {
            lucide.createIcons();

            // Scroll to the bottom of the chat list
            const chatMessages = document.getElementById('chat-messages');
            if (chatMessages) {
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }
        });

        function showLoading() {
            document.getElementById('loadingBox').style.display = 'flex';
        }
    </script>
</body>
</html>
