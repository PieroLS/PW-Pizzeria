package it.pw.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = {"/","/index","/home"})
public class HomeController {
	
	@GetMapping
	public String getPage(Model model) {
		
		
		
		return "home";
	}
	
	@PostMapping
	public String logout(Model model,HttpServletRequest request, HttpSession session) {
		session.setAttribute("loggato", false);
		
		
		return "home";
	}

}