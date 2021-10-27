package models;

import java.sql.Timestamp;
import java.util.Collections;
import java.util.List;

public class Quiz implements java.io.Serializable {
    private String id;
    private String topic;
    private Timestamp timestamp;
    private List<Question> questions;

    public List<Question> getQuestions() {
        return Collections.unmodifiableList(this.questions);
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }

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