package org.example.customDesarialize;

import com.google.gson.*;
import org.example.object.SpecAPI;

import java.lang.reflect.Type;

public class CustomDeserializer implements JsonDeserializer<SpecAPI.Links> {
    @Override
    public SpecAPI.Links deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) throws JsonParseException {
        JsonObject jsonObject = json.getAsJsonObject();
        SpecAPI.Links links = new SpecAPI.Links();
        links.setLatestVersion(context.deserialize(jsonObject.get("latest-version"), SpecAPI.LatestVersion.class));
        return links;
    }
}