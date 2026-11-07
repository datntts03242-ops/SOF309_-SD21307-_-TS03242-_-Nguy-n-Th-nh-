package entity;

import java.io.Serializable;
import java.util.List;

public class Question implements Serializable {

    private int id;

    private String questionText;

    private String image;

    private List<String> options;

    private String correctAnswer;

    private String userAnswer;

    private String type;

    public Question() {
    }

    public Question(int id, String questionText, String image,
                    List<String> options,
                    String correctAnswer,
                    String type) {

        this.id = id;
        this.questionText = questionText;
        this.image = image;
        this.options = options;
        this.correctAnswer = correctAnswer;
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public List<String> getOptions() {
        return options;
    }

    public void setOptions(List<String> options) {
        this.options = options;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }

    public String getUserAnswer() {
        return userAnswer;
    }

    public void setUserAnswer(String userAnswer) {
        this.userAnswer = userAnswer;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}