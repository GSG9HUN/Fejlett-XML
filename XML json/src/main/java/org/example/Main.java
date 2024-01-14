package org.example;

import com.google.gson.Gson;
import org.example.json.Deliverer;
import org.example.json.Editor;
import org.example.json.JSON;
import org.example.json.Latest;
import org.example.object.*;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        ArrayList<JSON> jsonArrayList = new ArrayList<>();
        Gson gson = new Gson();
        try {
            for (int i = 1; i < 3; i++) {
                String apiUrl = "https://api.w3.org/specifications?page=" + i + "&items=1000";
                String response = sendRequest(apiUrl);


                ApiResponse apiResponse = gson.fromJson(response, ApiResponse.class);

                // Az "specifications" tömb kinyerése az ApiResponse objektumból
                List<ApiResponse.Specification> specifications = apiResponse.getLinks().getSpecifications();

                // Az eredmény kiíratása
                for (ApiResponse.Specification spec : specifications) {
                    JSON jsonObj = new JSON();
                    response = sendRequest(spec.getHref());
                    SpecAPI specAPI = gson.fromJson(response, SpecAPI.class);
                    String description = specAPI.getDescription();

                    description = description.replace("<p>", "");
                    description = description.replace("</p>", "");

                    jsonObj.setDescription(description);
                    jsonObj.setTitle(specAPI.getTitle());
                    jsonObj.setShortlink(specAPI.getShortlink());
                    jsonObj.setShortname(specAPI.getShortname());
                    jsonObj.setLatest(getLatest(gson, specAPI));

                    jsonArrayList.add(jsonObj);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String json = gson.toJson(jsonArrayList);

        saveJsonToFile(json, "XML.json");

    }

    public static Latest getLatest(Gson gson, SpecAPI specAPI) throws IOException, InterruptedException {
        String response = sendRequest(specAPI.getLinks().getLatestVersion().getHref());
        LatestApi latestApi = gson.fromJson(response, LatestApi.class);
        Latest latest = new Latest();
        latest.setStatus(latestApi.getStatus());
        latest.setRectrack(latestApi.getRectrack());
        latest.setProcessRules(latestApi.getProcessRules());
        latest.setInformative(latestApi.isInformative());
        latest.setDate(latestApi.getDate());

        latest.setEditors(getEditors(latestApi, gson));
        latest.setDeliveries(getDeliveries(latestApi, gson));

        return latest;
    }

    public static String sendRequest(String apiUrl) throws IOException, InterruptedException {
        HttpClient httpClient = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(apiUrl))
                .GET()
                .build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());


        return response.body();
    }


    public static ArrayList<Editor> getEditors(LatestApi latestApi, Gson gson) throws IOException, InterruptedException {
        ArrayList<Editor> editors = new ArrayList<>();

        String response = sendRequest(latestApi.get_links().getEditors().getHref());
        EditorsAPI editorsAPI = gson.fromJson(response, EditorsAPI.class);

        try {
            for (EditorsAPI.Editors editorApi :
                    editorsAPI.get_links().getEditors()) {
                Editor editor = new Editor();
                editor.setHref(editorApi.getHref());
                editor.setTitle(editorApi.getTitle());
                editors.add(editor);
            }
        } catch (NullPointerException e) {

        }
        return editors;
    }

    public static ArrayList<Deliverer> getDeliveries(LatestApi latestApi, Gson gson) throws IOException, InterruptedException {
        ArrayList<Deliverer> deliveries = new ArrayList<>();

        String response = sendRequest(latestApi.get_links().getDeliverers().getHref());
        DeliverersAPI deliverersAPI = gson.fromJson(response, DeliverersAPI.class);

        try {
            for (DeliverersAPI.Deliverers delivererAPI :
                    deliverersAPI.get_links().getDeliverers()) {
                Deliverer delivery = new Deliverer();
                delivery.setHref(delivererAPI.getHref());
                delivery.setTitle(delivererAPI.getTitle());
                deliveries.add(delivery);
            }
        } catch (NullPointerException e) {

        }
        return deliveries;
    }

    private static void saveJsonToFile(String json, String fileName) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(new File(fileName)))) {
            writer.write(json);
            System.out.println("JSON adatok sikeresen mentve a fájlba: " + fileName);
        } catch (IOException e) {
            System.err.println("Hiba a fájlba mentés során: " + e.getMessage());
        }
    }
}