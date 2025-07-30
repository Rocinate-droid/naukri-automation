package com.myproject;

import java.io.File;
import java.io.IOException;
import java.time.Duration;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
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
    public void login() throws IOException, InterruptedException{
	String email = System.getProperty("email");
	String password = System.getProperty("password");
    File file = new File("srjresume.pdf");
    String absolutePath = file.getAbsolutePath();
    WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    Thread.sleep(5000);
    TakesScreenshot scr  = (TakesScreenshot) driver;
        File srcfile = scr.getScreenshotAs(OutputType.FILE);
        String destfile = System.getProperty("user.dir") + File.separator + "scr.png";
        FileUtils.copyFile(srcfile, new File(destfile));
    wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("a[id=\"login_Layer\"][title=\"Jobseeker Login\"]")));
    driver.findElement(By.cssSelector("a[id=\"login_Layer\"][title=\"Jobseeker Login\"]")).click();
    WebElement emailfield = driver.findElement(By.xpath("//input[@type=\"text\"][@placeholder=\"Enter your active Email ID / Username\"]"));
    WebElement passwordfield = driver.findElement(By.cssSelector("input[type=\"password\"]"));
    emailfield.sendKeys(email);
    passwordfield.sendKeys(password);
    driver.findElement(By.cssSelector("button[type=\"submit\"]")).click();
    driver.findElement(By.cssSelector("div[class=\"view-profile-wrapper\"]")).click();;
    WebElement uploadbutton = driver.findElement(By.cssSelector("input[type=\"file\"][id=\"attachCV\"]"));
    uploadbutton.sendKeys(absolutePath);
    }

}
