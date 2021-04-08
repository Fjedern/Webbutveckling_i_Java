package model;

import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class weatherBean {

	private String cityStr;
	private String countryStr;
	private ArrayList<String> allSearches = new ArrayList<String>();
	

	private String cloudsStr;
	private String lastUpdateStr;
	
	private String temperatureStr;

	public weatherBean(String cityStr, String countryStr) {

		this.cityStr = cityStr;
		allSearches.add(countryStr);
		this.countryStr = countryStr;

	}
	
	public ArrayList<String> getAllSearches() {
		return allSearches;
	}

	public String getCityStr() {
		return cityStr;
	}

	public String getCountryStr() {
		return countryStr;
	}

	public String getCloudsStr() {
		return cloudsStr;
	}

	public void setCloudsStr(String cloudsStr) {
		this.cloudsStr = cloudsStr;
	}

		
	public String getLastUpdateStr() {
		return lastUpdateStr;
	}

	public void setLastUpdateStr(String lastUpdateStr) {
		this.lastUpdateStr = lastUpdateStr;
	}
		
	public String getTemperatureStr() {
		return temperatureStr;
	}
	
	public void setTemp(String Temp) {
		this.temperatureStr = Temp;
	}

	public void setTemperatureStr(String temperatureStr) {
		//this.temperatureStr = temperatureStr;
		double calcTemp = Double.parseDouble(temperatureStr) - 273;
		calcTemp = Math.round(calcTemp * 100) / 100;
		System.out.println(calcTemp);
		String temp = Double.toString(calcTemp);
		this.temperatureStr = temp;
		
		
		//this.temperatureStr = Integer.toString((Integer.parseInt(temperatureStr) - 273));
	}
	
		

}