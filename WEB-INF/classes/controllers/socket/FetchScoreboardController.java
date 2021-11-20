package controllers.socket;

import java.sql.SQLException;
import java.util.*;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import models.Score;
import utils.Database;
import utils.Utils;

@ServerEndpoint("/FetchScoreboardController")
public class FetchScoreboardController {
    @OnOpen
    public void onOpen(Session currentSession) {
    }

    @OnClose
    public void onClose(Session currentSession) {
    }

    @OnMessage
    public void onMessage(String message, Session userSession) {
        try {
            List<Score> scores = Database.fetchScores(message);
            StringBuilder sb = new StringBuilder();
            scores.stream().forEach(s -> sb.append(Utils.getScoreJSON(s) + ","));
            String data = sb.toString();
            System.out.println("{'scores': [" + data.substring(0, data.length() - 1) + "]}");
            userSession.getAsyncRemote().sendText("{'scores': [" + data.substring(0, data.length() - 1) + "]}");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
