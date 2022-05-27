package com.choong.spr.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.choong.spr.domain.BoardDto;
import com.choong.spr.domain.ReplyDto;
import com.choong.spr.service.BoardService;
import com.choong.spr.service.ReplyService;

@Controller
@RequestMapping("board")
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private ReplyService replyService;

	@RequestMapping("list")
	public void list(@RequestParam(name= "keyword", defaultValue = "") String keyword,
					@RequestParam(name = "type", defaultValue = "") String type,
			Model model) {
		
		List<BoardDto> list = service.listBoard(type, keyword);
		model.addAttribute("boardList", list);
	}
	
	@GetMapping("insert")
	public void insert() {
		
	}
	
	@PostMapping("insert")
	public String insert(BoardDto board, Principal principal, RedirectAttributes rttr) {
		
		board.setMemberId(principal.getName());
		boolean success = service.insertBoard(board);
		
		if (success) {
			rttr.addFlashAttribute("message", "새 글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 글이 등록되지 않았습니다.");
		}
		
		return "redirect:/board/list";
	}
	
	@GetMapping("get")
	public void get(int id, Model model) {
		BoardDto dto = service.getBoardById(id);
		List<ReplyDto> replyList = replyService.getReplyByBoardId(id);
		model.addAttribute("board", dto);
		
		// ajax로 처리하기 위해 삭제
		// model.addAttribute("replyList", replyList);
		
	}
	
	@PostMapping("modify")
	public String modify(BoardDto dto, Principal principal, RedirectAttributes rttr) {
		// 게시글 정보 얻기
		BoardDto oldBoard = service.getBoardById(dto.getId());
		// 게시글 작성자id(memberId)와 principal의 name을 비교해서 같을 때에만 동작
		if(oldBoard.getMemberId().equals(principal.getName())) {			
			boolean success = service.updateBoard(dto);
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "글이 수정되지 않았습니다.");
			}
			
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
		}
		
		rttr.addAttribute("id", dto.getId());
		return "redirect:/board/get";
	}
	
	@PostMapping("remove")
	public String remove(BoardDto dto, Principal principal, RedirectAttributes rttr) {
		
		// 게시물 정보 얻고
		BoardDto oldBoard = service.getBoardById(dto.getId());
		// 게시물 작성자(memberId)와 principal의 name과 비교해서 같을 때만 진행.
		if(oldBoard.getMemberId().equals(principal.getName())) {
			boolean success = service.deleteBoard(dto.getId());
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 삭제 되었습니다.");
				
			} else {
				rttr.addFlashAttribute("message", "글이 삭제 되지않았습니다.");
			}
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
			rttr.addAttribute("id", dto.getId());
			return "redirect:/board/get";
		}		
		
		return "redirect:/board/list";
	}
}










