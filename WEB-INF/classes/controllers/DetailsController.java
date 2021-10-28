package controllers;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/DetailsController")
public class DetailsController {
    private static Set<Session> userSessions = Collections.newSetFromMap(new ConcurrentHashMap<Session, Boolean>());

    @OnOpen
    public void onOpen(Session currentSession) {
        userSessions.add(currentSession);
    }

    @OnClose
    public void onClose(Session currentSession) {
        userSessions.remove(currentSession);
    }

    @OnMessage
    public void onMessage(String message, Session userSession) {
        String result = "Response from server: " + message;

        for (Session session : userSessions) {
            session.getAsyncRemote().sendText(result);
        }
    }
}
