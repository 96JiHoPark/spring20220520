package com.choong.spr.mapper;

import java.util.List;

import com.choong.spr.domain.ReplyDto;

public interface ReplyMapper {

	int insertReply(ReplyDto dto);

	List<ReplyDto> selectAllBoardId(int boardId);

	int updateReply(ReplyDto dto);

	int deleteReply(int id);

	void deleteByBoardId(int boardId);

}
