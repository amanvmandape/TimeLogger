package com.armaan.timesheet.app.dao;

import com.armaan.timesheet.app.dto.State;
import com.armaan.timesheet.app.dto.TimeSheet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TimesheetDAO {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/emp_timesheets";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "test";

    public static TimeSheet getTimesheetData(int memId, LocalDate weekStart) throws Exception {
        TimeSheet ts = null;

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        String query = "Select * from timesheet where mem_id=? and wk_start=?";
        PreparedStatement stm = con.prepareStatement(query);
        stm.setInt(1, memId);
        stm.setObject(2, weekStart);

        ResultSet rs = stm.executeQuery();

        if (rs.next()) {
            ts = new TimeSheet();
            ts.setId(rs.getInt("id"));
            ts.setMemId(rs.getInt("mem_id"));

            // For DATE fields -> use getDate() then convert to LocalDate
            ts.setWkStart(rs.getDate("wk_start").toLocalDate());
            ts.setWkEnd(rs.getDate("wk_end").toLocalDate());

            // INT fields (minutes)
            ts.setMon(rs.getInt("mon"));
            ts.setTue(rs.getInt("tue"));
            ts.setWed(rs.getInt("wed"));
            ts.setThu(rs.getInt("thu"));
            ts.setFri(rs.getInt("fri"));
            ts.setSat(rs.getInt("sat"));
            ts.setSun(rs.getInt("sun"));
            String stateStr = rs.getString("state");
            ts.setState(State.valueOf(stateStr.toUpperCase()));
        }
        rs.close();
        stm.close();
        con.close();

        return ts;
    }

    public static boolean addTimesheet(TimeSheet timesheet) throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        String sql = "INSERT INTO TimeSheet "
                + "(mem_id, wk_start, wk_end, mon, tue, wed, thu, fri, sat, sun, state) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, timesheet.getMemId());
        ps.setDate(2, java.sql.Date.valueOf(timesheet.getWkStart()));
        ps.setDate(3, java.sql.Date.valueOf(timesheet.getWkEnd()));
        ps.setInt(4, timesheet.getMon());
        ps.setInt(5, timesheet.getTue());
        ps.setInt(6, timesheet.getWed());
        ps.setInt(7, timesheet.getThu());
        ps.setInt(8, timesheet.getFri());
        ps.setInt(9, timesheet.getSat());
        ps.setInt(10, timesheet.getSun());
        ps.setString(11, timesheet.getState().toString());

        int rowsAffected = ps.executeUpdate();

        ps.close();
        con.close();

        return (rowsAffected > 0) ? true : false;
    }

    public static boolean updateTimesheet(TimeSheet timesheet) throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

        String sql = "UPDATE TimeSheet "
                + "SET mem_id = ?, wk_start = ?, wk_end = ?, mon = ?, tue = ?, wed = ?, "
                + "thu = ?, fri = ?, sat = ?, sun = ?, state = ? "
                + "WHERE id = ?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, timesheet.getMemId());
        ps.setDate(2, java.sql.Date.valueOf(timesheet.getWkStart()));
        ps.setDate(3, java.sql.Date.valueOf(timesheet.getWkEnd()));
        ps.setInt(4, timesheet.getMon());
        ps.setInt(5, timesheet.getTue());
        ps.setInt(6, timesheet.getWed());
        ps.setInt(7, timesheet.getThu());
        ps.setInt(8, timesheet.getFri());
        ps.setInt(9, timesheet.getSat());
        ps.setInt(10, timesheet.getSun());
        ps.setString(11, timesheet.getState().toString());
        ps.setInt(12, timesheet.getId());
        int rowsAffected = ps.executeUpdate();

        ps.close();
        con.close();

        return (rowsAffected > 0) ? true : false;
    }
    
    
     public static List<TimeSheet> getPastTimesheets(int memId) throws Exception {
        List<TimeSheet> timesheets = new ArrayList<>();

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        String query = "Select * from timesheet where mem_id=? and state<>?";
        PreparedStatement stm = con.prepareStatement(query);
        stm.setInt(1, memId);
        stm.setString(2, State.UNSUBMITTED.toString());

        ResultSet rs = stm.executeQuery();

        if (rs.next()) {
            TimeSheet ts = new TimeSheet();
            ts.setId(rs.getInt("id"));
            ts.setMemId(rs.getInt("mem_id"));

            // For DATE fields -> use getDate() then convert to LocalDate
            ts.setWkStart(rs.getDate("wk_start").toLocalDate());
            ts.setWkEnd(rs.getDate("wk_end").toLocalDate());

            // INT fields (minutes)
            ts.setMon(rs.getInt("mon"));
            ts.setTue(rs.getInt("tue"));
            ts.setWed(rs.getInt("wed"));
            ts.setThu(rs.getInt("thu"));
            ts.setFri(rs.getInt("fri"));
            ts.setSat(rs.getInt("sat"));
            ts.setSun(rs.getInt("sun"));
            String stateStr = rs.getString("state");
            ts.setState(State.valueOf(stateStr.toUpperCase()));
            
            timesheets.add(ts);
        }
        rs.close();
        stm.close();
        con.close();

        return timesheets;
    }

    public static List<TimeSheet> getApproveList() throws Exception {
        List<TimeSheet> timesheets = new ArrayList<>();

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        String query = "Select * from timesheet where state=?";
        PreparedStatement stm = con.prepareStatement(query);
        stm.setString(1, State.SUBMITTED.toString());

        ResultSet rs = stm.executeQuery();

        if (rs.next()) {
            TimeSheet ts = new TimeSheet();
            ts.setId(rs.getInt("id"));
            ts.setMemId(rs.getInt("mem_id"));

            // For DATE fields -> use getDate() then convert to LocalDate
            ts.setWkStart(rs.getDate("wk_start").toLocalDate());
            ts.setWkEnd(rs.getDate("wk_end").toLocalDate());

            // INT fields (minutes)
            ts.setMon(rs.getInt("mon"));
            ts.setTue(rs.getInt("tue"));
            ts.setWed(rs.getInt("wed"));
            ts.setThu(rs.getInt("thu"));
            ts.setFri(rs.getInt("fri"));
            ts.setSat(rs.getInt("sat"));
            ts.setSun(rs.getInt("sun"));
            String stateStr = rs.getString("state");
            ts.setState(State.valueOf(stateStr.toUpperCase()));
            
            timesheets.add(ts);
        }
        rs.close();
        stm.close();
        con.close();

        return timesheets;
    }
}
