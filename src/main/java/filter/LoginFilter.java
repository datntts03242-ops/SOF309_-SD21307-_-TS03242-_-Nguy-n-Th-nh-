package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import utils.SessionUtil;

import java.io.IOException;

@WebFilter({
    "/profile",
    "/favorite",
    "/comment",
    "/admin/*"
})
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;

        HttpServletResponse resp =
                (HttpServletResponse) response;

        if (!SessionUtil.isAuthenticated(req)) {

            resp.sendRedirect(
                    req.getContextPath()+"/login");

            return;
        }

        chain.doFilter(request,response);
    }
}