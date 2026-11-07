package listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import dao.CharacterDAO;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        CharacterDAO dao = new CharacterDAO();

        sce.getServletContext().setAttribute("DAO_CHARACTER", dao);
    }
}