package utils;

import models.Score;

public class Utils {
    public static String getUniqueID(int n) {
        String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789" + "abcdefghijklmnopqrstuvxyz";
        StringBuilder sb = new StringBuilder(n);

        for (int i = 0; i < n; i++) {
            int index = (int) (AlphaNumericString.length() * Math.random());
            sb.append(AlphaNumericString.charAt(index));
        }

        return sb.toString();
    }

    public static String getScoreJSON(Score score) {
        return String.format("{'email':'%s', 'name': '%s', 'score': %s}", score.getUser().getEmail(),
                score.getUser().getName(), score.getScore());
    }
}
