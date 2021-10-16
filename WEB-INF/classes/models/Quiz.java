package models;

public class Quiz {
    private String id;
    private String topic;

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