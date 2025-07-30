package com.Utils;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;

public class utils {
    
    public static WebDriver getbrowserinstance(String browsername) {
        if (browsername.equals("chrome")) {
            ChromeOptions options = new ChromeOptions();
           options.addArguments("--headless=new"); // <- swap "--headless=new" with this
           options.addArguments("--no-sandbox");
           options.addArguments("--disable-dev-shm-usage");
           options.addArguments("--window-size=1920,1300");
           options.addArguments("--disable-gpu");
           options.addArguments("--remote-allow-origins=*");
           options.addArguments("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36");
            return new ChromeDriver(options);
        } else {
            return new EdgeDriver();
        }
    }
}
