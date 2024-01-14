package org.example.json;

import java.util.ArrayList;

public class Latest{
    private String status;
    private String rectrack;
    private boolean informative;
    private String processRules;
    private String date;

    private ArrayList<Editor> editors;

    private ArrayList<Deliverer> deliveries;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRectrack() {
        return rectrack;
    }

    public void setRectrack(String rectrack) {
        this.rectrack = rectrack;
    }

    public boolean isInformative() {
        return informative;
    }

    public void setInformative(boolean informative) {
        this.informative = informative;
    }

    public String getProcessRules() {
        return processRules;
    }

    public void setProcessRules(String processRules) {
        this.processRules = processRules;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public ArrayList<Editor> getEditors() {
        return editors;
    }

    public void setEditors(ArrayList<Editor> editors) {
        this.editors = editors;
    }

    public ArrayList<Deliverer> getDeliveries() {
        return deliveries;
    }

    public void setDeliveries(ArrayList<Deliverer> deliveries) {
        this.deliveries = deliveries;
    }
}
