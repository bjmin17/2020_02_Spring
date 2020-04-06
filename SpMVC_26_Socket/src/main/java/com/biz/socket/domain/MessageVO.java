package com.biz.socket.domain;

import java.io.Serializable;

import org.springframework.web.socket.WebSocketSession;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class MessageVO implements Serializable{

	String userName;
	String message;
	String sendUser;
	WebSocketSession wSession;
}
