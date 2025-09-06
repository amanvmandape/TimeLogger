package com.armaan.timesheet.app.servlets;

import com.armaan.timesheet.app.dao.TimesheetDAO;
import com.armaan.timesheet.app.dto.Member;
import com.armaan.timesheet.app.dto.State;
import com.armaan.timesheet.app.dto.TimeSheet;
import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AddTimeServlet", urlPatterns = {"/addTime"})
public class AddTimeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LocalDate today = LocalDate.now();
        LocalDate weekStart = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));

        HttpSession session = request.getSession(false);
        Member mem = (Member) session.getAttribute("memData");
        TimeSheet ts = null;
        try {
            ts = TimesheetDAO.getTimesheetData(mem.getId(), weekStart);

            if (ts == null) {
                request.getRequestDispatcher("/WEB-INF/jsp/timesheet.jsp").forward(request, response);

            } else {
                if (ts.getState() == State.UNSUBMITTED) {
                    session.setAttribute("timesheet", ts);
                    request.getRequestDispatcher("/WEB-INF/jsp/timesheet.jsp").forward(request, response);
                } else {
                    request.setAttribute("errMsg", "Timesheet for this week is already submitted, please visit past timesheets to view them");
                    request.getRequestDispatcher("/WEB-INF/jsp/userDash.jsp").forward(request, response);
                }
            }

        } catch (Exception e) {
            request.setAttribute("errMsg", "Server Unreachable, try after some time");
            request.getRequestDispatcher("/WEB-INF/jsp/userDash.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        
        HttpSession session = request.getSession();
        TimeSheet ts = (TimeSheet) session.getAttribute("timesheet");
        Member mem = (Member)session.getAttribute("memData");
        
        if(ts==null)
        {
            ts = new TimeSheet();
            LocalDate weekStart = LocalDate.parse(request.getParameter("weekStart"));
            LocalDate weekEnd = LocalDate.parse(request.getParameter("weekEnd"));
            ts.setWkStart(weekStart);
            ts.setWkEnd(weekEnd);
            ts.setMemId(mem.getId());
        }

        
        int mon = (int)(Double.parseDouble(request.getParameter("mon"))*60);
        int tue = (int)(Double.parseDouble(request.getParameter("tue"))*60);
        int wed = (int)(Double.parseDouble(request.getParameter("wed"))*60);
        int thu = (int)(Double.parseDouble(request.getParameter("thu"))*60);
        int fri = (int)(Double.parseDouble(request.getParameter("fri"))*60);
        
        ts.setMon(mon);
        ts.setTue(tue);
        ts.setWed(wed);
        ts.setThu(thu);
        ts.setFri(fri);

        if(action.equals("save"))
        {
            ts.setState(State.UNSUBMITTED);
        }
        else
        {
            ts.setState(State.SUBMITTED);
        }
        
        boolean result;
        
        try{
            if(ts.getId()!=0)
            {
                result = TimesheetDAO.updateTimesheet(ts);
            }
            else
            {
                result = TimesheetDAO.addTimesheet(ts);
            }
            
            request.setAttribute("sucMsg", "Operation Successful...");
            request.getRequestDispatcher("/WEB-INF/jsp/userDash.jsp").forward(request, response);
        }
        catch(Exception e)
        {
            request.setAttribute("errMsg", "Server Unreachable, try after some time"+e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/timesheet.jsp").forward(request, response);
        }
    }

}
