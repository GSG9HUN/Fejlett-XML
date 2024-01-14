package org.example.object;

import com.google.gson.annotations.JsonAdapter;
import com.google.gson.annotations.SerializedName;
import org.example.customDesarialize.CustomDeserializer;

public class SpecAPI {

    @SerializedName("_links")
    @JsonAdapter(CustomDeserializer.class)
    private Links _links;
    private String shortlink;
    private String description;

    private String title;

    public String getShortlink() {
        return shortlink;
    }

    public void setShortlink(String shortlink) {
        this.shortlink = shortlink;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getShortname() {
        return shortname;
    }

    public void setShortname(String shortname) {
        this.shortname = shortname;
    }

    private String shortname;

    public Links getLinks() {
        return _links;
    }

    public void setLinks(Links _links) {
        this._links = _links;
    }

    public static class Links {
        private LatestVersion latestVersion;
        public LatestVersion getLatestVersion() {
            return latestVersion;
        }

        public void setLatestVersion(LatestVersion latestVersion) {
            this.latestVersion = latestVersion;
        }

    }

    public static class LatestVersion {
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

