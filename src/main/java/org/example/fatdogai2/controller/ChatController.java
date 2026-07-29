package org.example.fatdogai2.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.domain.ModelProvider;
import org.example.fatdogai2.dto.ChatDto;
import org.example.fatdogai2.service.ChatService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping
public class ChatController {
    private final ChatService chatService;

    @GetMapping
    public String index(Model model) {
        model.addAttribute("providers", ModelProvider.values());
        model.addAttribute("history", chatService.getChatHistory());
        return "index";
    }

    @PostMapping
    public String chat(@ModelAttribute ChatDto dto, HttpSession session) {
        String answer = chatService.chat(dto);
        session.setAttribute("lastMessage", dto.message());
        session.setAttribute("lastProvider", dto.provider().name());
        session.setAttribute("answer", answer);
        return "redirect:/";
    }
}