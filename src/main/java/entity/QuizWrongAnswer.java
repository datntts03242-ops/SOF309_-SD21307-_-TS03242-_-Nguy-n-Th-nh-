package entity;

public class QuizWrongAnswer {

    private int id;

    private int resultId;

    private String questionText;

    private String correctAnswer;

    private String userAnswer;


    public int getId() {
        return id;
    }


    public void setId(int id) {
        this.id = id;
    }


    public int getResultId() {
        return resultId;
    }


    public void setResultId(int resultId) {
        this.resultId = resultId;
    }


    public String getQuestionText() {
        return questionText;
    }


    public void setQuestionText(String questionText) {
        this.questionText = questionText;
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
}