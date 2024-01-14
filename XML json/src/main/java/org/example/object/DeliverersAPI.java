package org.example.object;

import java.util.ArrayList;

public class DeliverersAPI {
    private Links _links;

    public Links get_links() {
        return _links;
    }

    public void set_links(Links _links) {
        this._links = _links;
    }

    public static class Links{
        private ArrayList<Deliverers> deliverers;

        public ArrayList<Deliverers> getDeliverers() {
            return deliverers;
        }

        public void setEditors(ArrayList<Deliverers> deliverers) {
            this.deliverers = deliverers;
        }
    }

    public static class Deliverers{
        private String href;
        private String title;

        public String getHref() {
            return href;
        }

        public void setHref(String href) {
            this.href = href;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }
    }
}
