package controller;

import entity.Question;
import entity.QuizResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import service.QuizGeneratorService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/quiz")
public class QuizController extends HttpServlet {

    private QuizGeneratorService quizService =
            new QuizGeneratorService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("start".equals(action)) {

            List<Question> questions =
                    quizService.generateQuiz(10);

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "quizQuestions",
                    questions);

            request.setAttribute(
                    "questions",
                    questions);

            request.getRequestDispatcher(
                    "/views/quiz/quiz.jsp")
                    .forward(request, response);

        } else {

            request.getRequestDispatcher(
                    "/views/quiz/startQuiz.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        List<Question> questions =
                (List<Question>)
                        session.getAttribute(
                                "quizQuestions");

        int correct = 0;

        List<Question> wrongQuestions =
                new ArrayList<>();

        for (Question q : questions) {

            String answer =
                    request.getParameter(
                            "q" + q.getId());

            q.setUserAnswer(answer);

            if (answer != null &&
                    answer.equals(
                            q.getCorrectAnswer())) {

                correct++;

            } else {

                wrongQuestions.add(q);
            }
        }

        QuizResult result =
                new QuizResult();

        result.setTotalQuestion(
                questions.size());

        result.setCorrectCount(correct);

        result.setWrongCount(
                questions.size() - correct);

        result.setPercentage(
                correct * 100.0
                        / questions.size());

        result.setWrongQuestions(
                wrongQuestions);

        request.setAttribute(
                "result",
                result);

        request.getRequestDispatcher(
                "/views/quiz/result.jsp")
                .forward(request, response);
    }
}