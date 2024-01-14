package org.example.object;

import java.util.Date;

public class LatestApi {
    private String status;
    private String rectrack;
    private boolean informative;
    private String processRules;
    private String date;

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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }



    private Links _links;

    public Links get_links() {
        return _links;
    }

    public void set_links(Links _links) {
        this._links = _links;
    }

    public static class Links{
        private Editors editors;

        private Deliverers deliverers;

        public Editors getEditors() {
            return editors;
        }

        public void setEditors(Editors editors) {
            this.editors = editors;
        }

        public Deliverers getDeliverers() {
            return deliverers;
        }

        public void setDeliverers(Deliverers deliverers) {
            this.deliverers = deliverers;
        }
    }


    public static class Editors{
        private String href;

        public String getHref() {
            return href;
        }

        public void setHref(String href) {
            this.href = href;
        }
    }
    public static class Deliverers{
        private String href;

        public String getHref() {
            return href;
        }

        public void setHref(String href) {
            this.href = href;
        }
    }



}
