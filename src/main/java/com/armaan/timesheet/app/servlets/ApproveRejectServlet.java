package com.armaan.timesheet.app.servlets;

import com.armaan.timesheet.app.dao.TimesheetDAO;
import com.armaan.timesheet.app.dto.State;
import com.armaan.timesheet.app.dto.TimeSheet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ApproveRejectServlet", urlPatterns = {"/approveReject"})
public class ApproveRejectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        TimeSheet ts = (TimeSheet) session.getAttribute("timesheet");

        if (action.equals("approve")) {
            ts.setState(State.APPROVED);
        } else {
            ts.setState(State.REJECTED);
        }

        boolean result;

        try {

            result = TimesheetDAO.updateTimesheet(ts);

            request.setAttribute("sucMsg", "Operation Successful...");
            request.getRequestDispatcher("/WEB-INF/jsp/adminDash.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errMsg", "Server Unreachable, try after some time" + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/approveSheet.jsp").forward(request, response);
        }

    }
}
