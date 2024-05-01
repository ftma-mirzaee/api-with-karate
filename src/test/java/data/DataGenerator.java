package data;

import java.util.Random;

public class DataGenerator {
    //Generate Random email address
    public static String getEmail() {
        String prefix = "std";
        String emailProvider = "@tekschool.us";

        Random random = new Random();
        int randomNumber = random.nextInt(10000);

        return prefix + randomNumber + emailProvider;
    }

}

