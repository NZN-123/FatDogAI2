package org.example.springai.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.example.springai.domain.ModelProvider;
import org.example.springai.dto.ChatDTO;
import org.example.springai.dto.MovieRecommendationDTO;
import org.example.springai.service.ChatService;
import org.springframework.ai.chat.client.ResponseEntity;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping
@RequiredArgsConstructor
public class MainController {
    private final ChatService chatService;

    @GetMapping
    public String index(Model model) {
        model.addAttribute("providers", ModelProvider.values());
        return "index";
    }

    @PostMapping
    public String chat(@ModelAttribute ChatDTO dto, HttpSession session) {
        String answer = chatService.chat(dto);
        session.setAttribute("lastMessage", dto.message());
        session.setAttribute("lastProvider", dto.provider().name());
        session.setAttribute("answer", answer);
        return "redirect:/";
    }
}
