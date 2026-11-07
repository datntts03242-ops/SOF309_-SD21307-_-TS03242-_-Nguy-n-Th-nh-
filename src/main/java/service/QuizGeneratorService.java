package service;

import dao.CharacterDAO;
import entity.Character;
import entity.Question;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class QuizGeneratorService {

    private CharacterDAO characterDAO = new CharacterDAO();

    public List<Question> generateQuiz(int totalQuestion) {

        List<Question> quiz = new ArrayList<>();

        List<Character> chars =
                characterDAO.getRandomCharacters(totalQuestion);

        Random rd = new Random();

        int id = 1;

        for (Character c : chars) {

            int type = rd.nextInt(5);

            Question q = null;

            switch(type) {

                case 0:
                    q = createAchievementQuestion(id++, c);
                    break;

                case 1:
                    q = createDescriptionQuestion(id++, c);
                    break;

                case 2:
                    q = createDynastyQuestion(id++, c);
                    break;

                case 3:
                    q = createLocationQuestion(id++, c);
                    break;

                default:
                    q = createImageQuestion(id++, c);
                    break;
            }

            quiz.add(q);
        }

        return quiz;
    }

    private Question createAchievementQuestion(int id, Character c) {

        Question q = new Question();

        q.setId(id);

        q.setType("achievement");

        q.setQuestionText(
                "Nhân vật nào có thành tựu sau?\n\n"
                        + c.getAchievement());

        buildCharacterOptions(q, c);

        return q;
    }

    private Question createDescriptionQuestion(int id, Character c) {

        Question q = new Question();

        q.setId(id);

        q.setType("description");

        q.setQuestionText(
                "Nhân vật nào được mô tả như sau?\n\n"
                        + c.getDescription());

        buildCharacterOptions(q, c);

        return q;
    }

    private Question createLocationQuestion(int id, Character c) {

        Question q = new Question();

        q.setId(id);

        q.setType("location");

        q.setQuestionText(
                "Nhân vật nào gắn với địa danh sau?\n\n"
                        + c.getHistorical_site());

        buildCharacterOptions(q, c);

        return q;
    }

    private Question createImageQuestion(int id, Character c) {

        Question q = new Question();

        q.setId(id);

        q.setType("image");

        q.setImage(c.getImage());

        q.setQuestionText("Đây là nhân vật nào?");

        buildCharacterOptions(q, c);

        return q;
    }

    private Question createDynastyQuestion(int id, Character c) {

        Question q = new Question();

        q.setId(id);

        q.setType("dynasty");

        q.setQuestionText(
                c.getName() + " thuộc triều đại nào?");

        List<String> options = new ArrayList<>();

        options.add(c.getDynasty());

        List<Character> all =
                characterDAO.getRandomCharacters(20);

        for(Character item : all) {

            if(!item.getDynasty().equals(c.getDynasty())
                    && !options.contains(item.getDynasty())) {

                options.add(item.getDynasty());

                if(options.size() == 4)
                    break;
            }
        }

        Collections.shuffle(options);

        q.setOptions(options);

        q.setCorrectAnswer(c.getDynasty());

        return q;
    }

    private void buildCharacterOptions(
            Question q,
            Character correct) {

        List<String> options = new ArrayList<>();

        options.add(correct.getName());

        List<Character> all =
                characterDAO.getRandomCharacters(20);

        for(Character c : all) {

            if(c.getId() != correct.getId()) {

                options.add(c.getName());

                if(options.size() == 4)
                    break;
            }
        }

        Collections.shuffle(options);

        q.setOptions(options);

        q.setCorrectAnswer(correct.getName());
    }
}