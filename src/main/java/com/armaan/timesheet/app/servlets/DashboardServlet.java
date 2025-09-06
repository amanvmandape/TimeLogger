
package com.armaan.timesheet.app.servlets;

import com.armaan.timesheet.app.dto.Member;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        
        Member mem = (Member) session.getAttribute("memData");
        
        if(mem==null)
        {
            response.sendRedirect("home");
        }
        else
        {
            switch(mem.getRole())
            {
                case "user":
                    request.getRequestDispatcher("/WEB-INF/jsp/userDash.jsp").forward(request, response);
                    break;
                case "admin":
                    request.getRequestDispatcher("/WEB-INF/jsp/adminDash.jsp").forward(request, response);
                    break;
            }
        }
        
        
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

}
