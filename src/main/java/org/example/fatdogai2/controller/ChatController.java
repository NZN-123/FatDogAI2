package org.example.fatdogai2.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.domain.ModelProvider;
import org.example.fatdogai2.dto.ChatDTO;
import org.example.fatdogai2.service.ChatService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@RequestMapping
public class ChatController {
    private final ChatService chatService;

    @GetMapping
    public String index(
            @RequestParam(required = false, defaultValue = "chat") String tab,
            HttpSession session,
            Model model) {
        // Chatbot
        model.addAttribute("providers", ModelProvider.values());
        model.addAttribute("history", chatService.getChatHistory(session.getId()));
        return "index";
    }

    @PostMapping
    public String chat(@ModelAttribute ChatDTO dto, HttpSession session) {
        String answer = chatService.chat(dto, session.getId());
        session.setAttribute("lastMessage", dto.message());
        session.setAttribute("lastProvider", dto.provider().name());
        session.setAttribute("answer", answer);
        return "redirect:/";
    }

    @GetMapping("/clear")
    public String clear(HttpSession session) {
        chatService.clearHistory(session.getId());
        return "redirect:/";
    }
}
