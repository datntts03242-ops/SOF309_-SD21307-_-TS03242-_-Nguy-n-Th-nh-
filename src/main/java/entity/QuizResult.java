package entity;

import java.util.List;

public class QuizResult {

    private int totalQuestion;

    private int correctCount;

    private int wrongCount;

    private double percentage;

    private List<Question> wrongQuestions;

    public QuizResult() {
    }

    public int getTotalQuestion() {
        return totalQuestion;
    }

    public void setTotalQuestion(int totalQuestion) {
        this.totalQuestion = totalQuestion;
    }

    public int getCorrectCount() {
        return correctCount;
    }

    public void setCorrectCount(int correctCount) {
        this.correctCount = correctCount;
    }

    public int getWrongCount() {
        return wrongCount;
    }

    public void setWrongCount(int wrongCount) {
        this.wrongCount = wrongCount;
    }

    public double getPercentage() {
        return percentage;
    }

    public void setPercentage(double percentage) {
        this.percentage = percentage;
    }

    public List<Question> getWrongQuestions() {
        return wrongQuestions;
    }

    public void setWrongQuestions(List<Question> wrongQuestions) {
        this.wrongQuestions = wrongQuestions;
    }
}