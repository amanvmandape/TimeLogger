
package com.armaan.timesheet.app.dao;

import com.armaan.timesheet.app.dto.Member;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class EmpAuthDAO {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/emp_timesheets";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "test";
    
    public static Member validateMember(String username, String password)throws Exception
    {
        Member mem = new Member();
        
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        String query = "Select id, role from memcreds where username=? and password=?";
        PreparedStatement stm = con.prepareStatement(query);
        stm.setString(1, username);
        stm.setString(2, password);

        ResultSet rs = stm.executeQuery();

        if(rs.next())
        {
            mem.setId(rs.getInt("id"));
            mem.setRole(rs.getString("role"));
        }
        rs.close();
        stm.close();
        con.close();
            
        return mem;
    }
    
}
