
package com.armaan.timesheet.app.dto;

import java.time.LocalDate;


public class TimeSheet {
    
    private int id;
    private int memId;
    private LocalDate wkStart;
    private LocalDate wkEnd;
    private int mon;
    private int tue;
    private int wed;
    private int thu;
    private int fri;
    private int sat;
    private int sun;
    private State state;

    public void setId(int id) {
        this.id = id;
    }

    public void setMemId(int memId) {
        this.memId = memId;
    }

    public void setWkStart(LocalDate wkStart) {
        this.wkStart = wkStart;
    }

    public void setWkEnd(LocalDate wkEnd) {
        this.wkEnd = wkEnd;
    }

    public void setMon(int mon) {
        this.mon = mon;
    }

    public void setTue(int tue) {
        this.tue = tue;
    }

    public void setWed(int wed) {
        this.wed = wed;
    }

    public void setThu(int thu) {
        this.thu = thu;
    }

    public void setFri(int fri) {
        this.fri = fri;
    }

    public void setSat(int sat) {
        this.sat = sat;
    }

    public void setSun(int sun) {
        this.sun = sun;
    }


    public int getId() {
        return id;
    }

    public int getMemId() {
        return memId;
    }

    public LocalDate getWkStart() {
        return wkStart;
    }

    public LocalDate getWkEnd() {
        return wkEnd;
    }

    public int getMon() {
        return mon;
    }

    public int getTue() {
        return tue;
    }

    public int getWed() {
        return wed;
    }

    public int getThu() {
        return thu;
    }

    public int getFri() {
        return fri;
    }

    public int getSat() {
        return sat;
    }

    public int getSun() {
        return sun;
    }

    public State getState() {
        return state;
    }

    public void setState(State state) {
        this.state = state;
    }
    
    
}
