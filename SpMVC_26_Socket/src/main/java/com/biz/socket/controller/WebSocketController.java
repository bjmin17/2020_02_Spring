package com.biz.socket.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.biz.socket.domain.MessageVO;
import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;

/*
 * 			[TextWebSocketHandler]
 * STOMP을 지원하는 기능을 사용할 수 있도록 만들어져 있는 
 * 기본 클래스를 상속받아서 사용한다.
 */
@Slf4j
// service와 controller annotaion의 기능이 모두 포함되어있음(어떤걸 사용하기 애매할 때 주로 사용)
@Component
public class WebSocketController extends TextWebSocketHandler{
	
	// socket으로 서버에 접속할 때 접속되는 클라이언트들을 관리하기 위한 session
	List<WebSocketSession> sessionList;
	
	public WebSocketController() {
		sessionList = new ArrayList<WebSocketSession>();
	}

	// Client가 websocket을 통해서 접속을 시도할 때 처음 실행될 method
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
		
		// 접속된 client정보를 sessionList에 추가
		sessionList.add(session);
		log.debug("접속된 client Id : {}", session.getId());
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionClosed(session, status);
		sessionList.remove(session);
	}
	
	// Client가 message를 보내면 message를 수신하는 method
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		super.handleTextMessage(session, message);
		log.debug("{} Client가 보낸 메시지 : {}",session.getId(), message.getPayload());
		

		
		for(WebSocketSession ws : sessionList) {
//			String msg = message.getPayload();
			String msg = "Republic of Korea";
			
			// TextMessage
			// 문자열이나 여러 메시지를 socket을 통해 전송하기 편리한 
			// STOMP 데이터 구조로 변경함
			TextMessage textMessage = new TextMessage(msg);
			
			// 수신된 문자열 구조가 TextMessage 이므로
			// 바로 클라이언트로 전송
			ws.sendMessage(textMessage);
		}
	}

	
}
