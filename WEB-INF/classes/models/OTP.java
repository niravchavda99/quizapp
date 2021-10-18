package models;

import java.time.LocalDateTime;

public class OTP implements java.io.Serializable {
    private String value;
    private LocalDateTime generatedAt;

    public LocalDateTime getGeneratedAt() {
        return this.generatedAt;
    }

    public void setGeneratedAt(LocalDateTime generatedAt) {
        this.generatedAt = generatedAt;
    }

    private LocalDateTime expiry;

    public String getValue() {
        return this.value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public LocalDateTime getExpiry() {
        return this.expiry;
    }

    public void setExpiry(LocalDateTime expiry) {
        this.expiry = expiry;
    }
}
