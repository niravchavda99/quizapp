package controllers.socket;

import java.sql.SQLException;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import utils.Database;

@ServerEndpoint("/SubmitAnswerController")
public class SubmitAnswerController {
    @OnOpen
    public void onOpen(Session currentSession) {
    }

    @OnClose
    public void onClose(Session currentSession) {
    }

    @OnMessage
    public void onMessage(String message, Session userSession) {
        System.out.println(message);
        String[] data = message.split("[,]");
        String questionid = data[0].split("[:]")[1];
        String email = data[1].split("[:]")[1];
        String response = data[2].split("[:]")[1];

        if (response.equals("0"))
            response = null;

        boolean result = false;

        try {
            result = Database.submitResponse(questionid, email, response);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            userSession.getAsyncRemote().sendText("" + result);
        }
    }
}
