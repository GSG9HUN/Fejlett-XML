package org.example.object;

import java.util.List;
public class ApiResponse {


    private Links _links;

    public Links getLinks() {
        return _links;
    }

    public void setLinks(Links links) {
        _links = links;
    }

    // Getter és setter metódusok



    public class Links{
        private List<Specification> specifications;

        public List<Specification> getSpecifications() {
            return specifications;
        }

        public void setSpecifications(List<Specification> specifications) {
            this.specifications = specifications;
        }
    }

    public static class Specification {
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
