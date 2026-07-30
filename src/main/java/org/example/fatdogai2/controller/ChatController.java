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

@Controller
@RequiredArgsConstructor
@RequestMapping
public class ChatController {
    private final ChatService chatService;

    @GetMapping
    public String index(Model model, HttpSession session) {
        model.addAttribute("providers", ModelProvider.values());
        model.addAttribute("history", chatService.getChatHistory(session.getId()));
        return "index";
    }

    @PostMapping
    public String chat(@ModelAttribute ChatDTO dto, HttpSession session) {
        chatService.chat(dto, session.getId());
        return "redirect:/";
    }

    @PostMapping("/history/clear")
    public String clearChatHistory(HttpSession session) {
        chatService.clearChatHistory(session.getId());
        return "redirect:/";
    }
}
