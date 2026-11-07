package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import utils.SessionUtil;

import java.io.IOException;


@WebFilter("/admin/*")
public class AdminFilter implements Filter {


    @Override
    public void doFilter( ServletRequest request,ServletResponse response, FilterChain chain)
            throws IOException, ServletException {


        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        // chưa phải admin

        if(!SessionUtil.isAdmin(req)){ resp.sendRedirect(req.getContextPath()+"/" );

            return;
        }
        // admin đi tiếp

        chain.doFilter(request,response);
    }
}