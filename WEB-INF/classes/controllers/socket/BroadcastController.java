package controllers.socket;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/BroadcastController")
public class BroadcastController {
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
        for (Session session : userSessions) {
            if (session != userSession)
                session.getAsyncRemote().sendText(message);
        }
    }
}
