package models;

import java.sql.Timestamp;

public class Quiz {
    private String id;
    private String topic;
    private Timestamp timestamp;

    public Timestamp getTimestamp() {
        return this.timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTopic() {
        return this.topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }
}

// javac models/*.java && javac utils/*.java && javac controllers/*.java