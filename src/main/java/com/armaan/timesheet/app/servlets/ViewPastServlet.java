package com.armaan.timesheet.app.servlets;

import com.armaan.timesheet.app.dao.TimesheetDAO;
import com.armaan.timesheet.app.dto.Member;
import com.armaan.timesheet.app.dto.TimeSheet;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ViewPastServlet", urlPatterns = {"/viewPast"})
public class ViewPastServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Member mem = (Member) session.getAttribute("memData");

        try {
            List<TimeSheet> timesheets = TimesheetDAO.getPastTimesheets(mem.getId());
            
            session.setAttribute("timesheets", timesheets);

            request.getRequestDispatcher("/WEB-INF/jsp/userSheetsList.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errMsg", "Server Unreachable, try after some time" + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/userDash.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
