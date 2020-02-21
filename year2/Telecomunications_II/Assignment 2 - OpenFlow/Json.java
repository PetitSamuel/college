package cs.tcd.ie;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class Json {
    // gets a string & parses it to a JSON object
    public static JsonObject getJsonFromString (String s) {
        JsonParser parser = new JsonParser();
        return (JsonObject) parser.parse(s);
    }
}
