
package com.armaan.timesheet.app.servlets;

import com.armaan.timesheet.app.dao.TimesheetDAO;
import com.armaan.timesheet.app.dto.Member;
import com.armaan.timesheet.app.dto.TimeSheet;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "ViewApproveList", urlPatterns = {"/viewApprove"})
public class ViewApproveServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();

        try {
            List<TimeSheet> timesheets = TimesheetDAO.getApproveList();
            
            session.setAttribute("timesheets", timesheets);

            request.getRequestDispatcher("/WEB-INF/jsp/approveSheetList.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errMsg", "Server Unreachable, try after some time" + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/adminDash.jsp").forward(request, response);
        }
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

}
