package com.choong.spr.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choong.spr.domain.ReplyDto;
import com.choong.spr.mapper.ReplyMapper;

@Service
public class ReplyService {

	@Autowired
	private ReplyMapper mapper;
	
	public boolean insertReply(ReplyDto dto) {
//		dto.setInserted(LocalDateTime.now());
		return mapper.insertReply(dto) == 1;
	}

	public List<ReplyDto> getReplyByBoardId(int boardId) {
		// TODO Auto-generated method stub
		return mapper.selectAllBoardId(boardId);
	}

	public boolean updateReply(ReplyDto dto) {
		// TODO Auto-generated method stub
		return mapper.updateReply(dto) == 1;
	}

	public boolean deleteReply(int id) {
		// TODO Auto-generated method stub
		return mapper.deleteReply(id) == 1;
	}

}
