package models;

import java.sql.Timestamp;

public class Question implements java.io.Serializable {
    private String id;
    private String question;
    private String option1, option2, option3, option4;
    private String answer;
    private Timestamp timestamp;
    private String quizId;
    private int qno;

    public int getQno() {
        return this.qno;
    }

    public void setQno(int qno) {
        this.qno = qno;
    }

    public String getQuizId() {
        return this.quizId;
    }

    public void setQuizId(String quizId) {
        this.quizId = quizId;
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getQuestion() {
        return this.question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getOption1() {
        return this.option1;
    }

    public void setOption1(String option1) {
        this.option1 = option1;
    }

    public String getOption2() {
        return this.option2;
    }

    public void setOption2(String option2) {
        this.option2 = option2;
    }

    public String getOption3() {
        return this.option3;
    }

    public void setOption3(String option3) {
        this.option3 = option3;
    }

    public String getOption4() {
        return this.option4;
    }

    public void setOption4(String option4) {
        this.option4 = option4;
    }

    public String getAnswer() {
        return this.answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Timestamp getTimestamp() {
        return this.timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }
}