package org.example.fatdogai2.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.example.fatdogai2.domain.ModelProvider;
import org.example.fatdogai2.dto.ChatDTO;
import org.example.fatdogai2.service.AIChatService;
import org.example.fatdogai2.service.ChatService;
import org.springframework.ai.chat.client.ResponseEntity;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@RequestMapping

public class ChatController {
    private final AIChatService aiChatService;

    @GetMapping
    public String index(Model model){
        model.addAttribute("providers", ModelProvider.values());
        return "index";
    }
    @PostMapping
    public String chat(
            @ModelAttribute ChatDTO dto,
            RedirectAttributes redirectAttributes
    ) {
        String answer = aiChatService.chat(dto);

        redirectAttributes.addFlashAttribute("lastMessage", dto.message());
        redirectAttributes.addFlashAttribute("lastProvider", dto.provider());
        redirectAttributes.addFlashAttribute("answer", answer);

        return "redirect:/";
    }
}