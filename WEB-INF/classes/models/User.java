package models;

public class User implements java.io.Serializable {
    private String email;
    private String password;
    private String name;
    private String phone;
    private OTP otp;
    private boolean isVerified;

    public boolean isIsVerified() {
        return this.isVerified;
    }

    public boolean getIsVerified() {
        return this.isVerified;
    }

    public void setIsVerified(boolean isVerified) {
        this.isVerified = isVerified;
    }

    public OTP getOtp() {
        return this.otp;
    }

    public void setOtp(OTP otp) {
        this.otp = otp;
    }

    public String getPhone() {
        return this.phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
