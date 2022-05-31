package com.choong.spr.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choong.spr.domain.ReplyDto;
import com.choong.spr.service.ReplyService;

@RestController
@RequestMapping("reply")
public class ReplyController {

	@Autowired
	private ReplyService service;

	@PostMapping(path = "insert", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> insert(ReplyDto dto, Principal principal) {
		
		if(principal == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		}else {			
			dto.setMemberId(principal.getName());
			
			boolean success = service.insertReply(dto);
			
			if (success) {
				return ResponseEntity.ok("새 댓글이 등록되었습니다.");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
			}
		}
		
	}

	@PutMapping("modify")
	public ResponseEntity<String> modify(@RequestBody ReplyDto dto, Principal principal) {
		
		if(principal == null) {
			// 로그인 상태가 아닐 때
			return ResponseEntity.status(401).build();
		}else {			
			// 로그인 상태일 때
			boolean success = service.updateReply(dto, principal);
			
			if (success) {
				return ResponseEntity.ok("댓글이 변경되었습니다.");
			}
			
			return ResponseEntity.status(500).body("");
		}
	}
	
	//{id}의 값이 delete()의 파라미터로 들어옴
	@DeleteMapping(path = "delete/{id}", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> delete(@PathVariable("id") int id, Principal principal) {
		
		if(principal == null) {
			// 로그인 상태가 아닐 때
			return ResponseEntity.status(401).build();
		}else {
			// 로그인 상태일 때
			boolean success = service.deleteReply(id, principal);
			
			if (success) {
				return ResponseEntity.ok("댓글을 삭제 하였습니다");
			} else {
				return ResponseEntity.status(500).body("");
			}
		}

	}

	@GetMapping("list")
	public List<ReplyDto> list(int boardId, Principal principal) {
		if(principal == null) {
			return service.getReplyByBoardId(boardId);						
		}else {
			return service.getReplyWithOwnByBoardId(boardId, principal.getName());
		}
	}
	
}
