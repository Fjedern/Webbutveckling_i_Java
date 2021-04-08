package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Optional;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.GettheWeather;
import model.weatherBean;

/**
 * Servlet implementation class OWservlet
 */
@WebServlet("/OWservlet")
public class OWservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	weatherBean wBean;
	ArrayList<weatherBean> beanArray = new ArrayList<weatherBean>();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public OWservlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		PrintWriter out = response.getWriter();

		request.setAttribute("wBean", wBean);

		RequestDispatcher rd = request.getRequestDispatcher("showWeather.jsp");
		rd.forward(request, response);
		

	}
	
	public String[] getCookiesPrint(HttpServletRequest request, String city) {
		String[] split = null;
		Cookie[] cookieList = request.getCookies();
		for(Cookie cookie : cookieList) {
			if(cookie.getName().equals(city)) {
				String allValues = URLDecoder.decode(cookie.getValue());
				split = allValues.split("#");
 				System.out.println("OldCookies exists");
			}
		}
		return split;
		
	}
	
	public void createCookie(HttpServletResponse response) {
		String allValues = wBean.getCloudsStr() + "#" + wBean.getTemperatureStr() + "#" + wBean.getLastUpdateStr();
		try {
			Cookie ck = new Cookie(wBean.getCityStr(), URLEncoder.encode(allValues, "UTF-8"));
			ck.setMaxAge(600);
			response.addCookie(ck);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cityStr = request.getParameter("city");
		String countryStr = request.getParameter("country");
		
		Cookie[] cookieList = request.getCookies();
		for(Cookie cookie : cookieList) {
			if(cookie.getName().equals(cityStr)) {
				String[] cookieValues =  getCookiesPrint(request, cityStr);
				String cookieClouds = cookieValues[0];
				String cookieTemp = cookieValues[1];
				String cookieUpdate = cookieValues[2];
				
				wBean.setCloudsStr(cookieClouds);
				wBean.setLastUpdateStr(cookieUpdate);
				wBean.setTemp(cookieTemp);
			}else {
				wBean = new weatherBean(cityStr, countryStr);
				GettheWeather.getWeather(wBean);
				
				createCookie(response);
			}
		}
		
		doGet(request, response);
	}
	

}