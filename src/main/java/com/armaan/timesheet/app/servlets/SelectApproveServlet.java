package com.armaan.timesheet.app.servlets;

import com.armaan.timesheet.app.dto.TimeSheet;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SelectApproveServlet", urlPatterns = {"/selectApprove"})
public class SelectApproveServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<TimeSheet> timesheets = (List<TimeSheet>) session.getAttribute("timesheets");
        int tsId = Integer.parseInt(request.getParameter("tsId"));

        TimeSheet ts = new TimeSheet();

        for (TimeSheet t : timesheets) {
            if (t.getId() == tsId) {
                ts.setId(t.getId());
                ts.setMemId(t.getMemId());
                ts.setWkStart(t.getWkStart());
                ts.setWkEnd(t.getWkEnd());
                ts.setMon(t.getMon());
                ts.setTue(t.getTue());
                ts.setWed(t.getWed());
                ts.setThu(t.getThu());
                ts.setFri(t.getFri());
                ts.setSat(t.getSat());
                ts.setSun(t.getSun());
                ts.setState(t.getState());
                break;
            }
        }

        session.setAttribute("timesheet", ts);
        request.getRequestDispatcher("/WEB-INF/jsp/approveSheet.jsp").forward(request, response);
    }

}
