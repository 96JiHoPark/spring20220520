package com.choong.spr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.choong.spr.domain.ReplyDto;
import com.choong.spr.service.ReplyService;

@Controller
@RequestMapping("reply")
public class ReplyController {

	@Autowired
	private ReplyService service;

	@PostMapping("insert")
	public String insert(ReplyDto dto, RedirectAttributes rttr) {

		boolean success = service.insertReply(dto);

		if (success) {
			rttr.addFlashAttribute("message", "새 댓글이 등록되었습니다.");
		}

		rttr.addAttribute("id", dto.getBoardId());
		return "redirect:/board/get";
	}

	@PostMapping("modify")
	public String modify(ReplyDto dto, RedirectAttributes rttr) {
		boolean success = service.updateReply(dto);

		if (success) {
			rttr.addFlashAttribute("message", "댓글이 수정되었습니다.");
		}

		rttr.addAttribute("id", dto.getBoardId());
		return "redirect:/board/get";
	}
	
	@PostMapping("delete")
	public String delete(ReplyDto dto, RedirectAttributes rttr) {
		boolean success = service.deleteReply(dto);
		
		if (success) {
			rttr.addFlashAttribute("messag", "댓글이 삭제되었습니다.");
		}
		
		rttr.addAttribute("id", dto.getBoardId());
		return "redirect:/board/get";
	}
}






