package utils;

import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.Random;

import models.OTP;

public class OtpUtils {
    public static OTP generate() {
        OTP otp = new OTP();
        String value = new DecimalFormat("000000").format(new Random().nextInt(999999));
        otp.setValue(value);
        otp.setGeneratedAt(LocalDateTime.now());
        otp.setExpiry(LocalDateTime.now().plusMinutes(2));
        return otp;
    }
}
