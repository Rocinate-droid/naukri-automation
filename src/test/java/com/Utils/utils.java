package com.Utils;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;

public class utils {
    
    public static WebDriver getbrowserinstance(String browsername) {
        if (browsername.equals("chrome")) {
            ChromeOptions options = new ChromeOptions();
            options.addArguments("--headless=new");  // Headless mode
            options.addArguments("--window-size=1920,1080");  // Important!
            options.addArguments("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/114.0.0.0 Safari/537.36");
            return new ChromeDriver(options);
        } else {
            return new EdgeDriver();
        }
    }
}
