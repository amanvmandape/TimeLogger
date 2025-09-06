
package com.armaan.timesheet.app.servlets;

import com.armaan.timesheet.app.dao.EmpAuthDAO;
import com.armaan.timesheet.app.dto.Member;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    

   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");    

        try{
           Member mem = EmpAuthDAO.validateMember(username, password);
           
           if(mem.getId() != 0 && mem.getRole() != null)
            {
                HttpSession session = request.getSession();
                session.setAttribute("memData", mem);
                response.sendRedirect(request.getContextPath() + "/");
            }
            else {
                request.setAttribute("errMsg", "Invalid credentials");
                request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);

            }
        }
        catch(Exception e)
        {
            request.setAttribute("errMsg", "Server Unreachable, try after some time");
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        }
        
    }

}
