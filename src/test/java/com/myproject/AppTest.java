package com.myproject;

import java.time.Duration;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import com.Utils.utils;;

/**
 * Unit test for simple App.
 */
public class AppTest 
{
   WebDriver driver;
    @BeforeTest
    public void OpenBrowser()
    {
        driver = utils.getbrowserinstance("chrome");
        driver.manage().window().maximize();
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(5));
        driver.get("https://www.naukri.com/");
    }

    @Test
    public void login(){
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        wait.until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.partialLinkText("Login")));
        driver.findElement(By.partialLinkText("Login")).click();
        WebElement email = driver.findElement(By.xpath("//input[@type=\"text\"][@placeholder=\"Enter your active Email ID / Username\"]"));
        WebElement password = driver.findElement(By.cssSelector("input[type=\"password\"]"));
        email.sendKeys("sreejithcs895@gmail.com");
        password.sendKeys("Ancallagon99#");
        driver.findElement(By.cssSelector("button[type=\"submit\"]")).click();
        driver.findElement(By.cssSelector("div[class=\"view-profile-wrapper\"]")).click();;
        WebElement uploadbutton = driver.findElement(By.cssSelector("input[type=\"file\"][id=\"attachCV\"]"));
        uploadbutton.sendKeys("/mnt/d/Resume (2).pdf");



    }

}
