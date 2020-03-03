package com.biz.bbs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.biz.bbs.domain.CommentVO;
import com.biz.bbs.service.CommentService;

import lombok.RequiredArgsConstructor;

/*
 * class에 부착하는 RequestMapping
 * 		이를 type 수준의 Req..라고 부르기도 하고
 * 		top level의 Req...라고 부르기도 한다.
 * 메서드에 /list 라고 RequestMapping을 붙이면
 * 호출을 할 때
 * context/comment/list라고 path를 지정한다.
 */
@RequestMapping(value="/comment")
@Controller
public class CommentController {

	@Autowired
	@Qualifier("cmtV2")
	private CommentService cmtService;
	
	/*
	 * 게시판의 id값을 매개변수로 받아서
	 * 코멘트 리스트를 보여주는 메서드
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(String b_id, Model model) {
		long c_b_id = Long.valueOf(b_id);
		List<CommentVO> cmtList = cmtService.findByBId(c_b_id);
		model.addAttribute("COMMENT",cmtList);
		return "comment_list";
	}
	
	/*
	 * 코멘트 입력 값을 매개변수로 받아서
	 * db insert를 수행할 메서드
	 */
	@RequestMapping(value="/insert",method=RequestMethod.POST)
	public String insert(CommentVO commentVO,Model model) {
		cmtService.insert(commentVO);
		// 전통적으로 사용하는 일반적인 방법
//		String retId = commentVO.getC_b_id()+"";
//		return "redirect:/detail?b_id="+retId;
		
		// 두번째 방식은 model 사용,(spring 4점대 버전부터)
		// model을 넘길때 b_id가 b_id=retId까지 다 가져간다.
		// 쿼리로 넘겨야할 변수가 여러개이면 코드가 더 짧아짐
		
		/*
		 * redirect로 방향전환을 할 때, 변수에 값을 전달하고 싶으면
		 * 일반적인 방법은 ?변수=값&변수1=값 형식으로 문자열 연결연산을
		 * 		수행해야한다.
		 * model에 Attribute로 해당 값을 add 수행한 후
		 * 		redirect를 수행하면
		 * 		쿼리 문자열을 자동으로 만들어서 전달한다.
		 */
//		model.addAttribute("b_writer",commentVO.getC_writer());
		model.addAttribute("b_id",commentVO.getC_b_id());
//		return "redirect:/detail";
		return "redirect:/comment/list";
		
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public String delete(String c_id, String b_id, Model model) {
		int ret = cmtService.delete(Long.valueOf(c_id));
		
		model.addAttribute("b_id",b_id);
		return "redirect:/comment/list";
	}
	
	@RequestMapping(value="/repl",method=RequestMethod.GET)
	public String repl(CommentVO cmtVO, Model model) {
		
		model.addAttribute("CMT",cmtVO);
		
		return "comment_write";
	}
}
