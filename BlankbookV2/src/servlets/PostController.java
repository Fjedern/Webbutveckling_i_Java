package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.PostBean;
import beans.UserBean;
import database.SQLcon;

/**
 * Servlet implementation class PostController
 */
@WebServlet("/PostController")
public class PostController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getSession().getAttribute("user") != null) {
			// get the user out of session
			UserBean bean = (UserBean) request.getSession().getAttribute("user");

			// Validate username and password again
			try {
				if (bean.validate(bean)) {

					// get the session and the request to go to the content page
					HttpSession session = request.getSession();
					session.setAttribute("user", bean);
					request.setAttribute("user", bean);

					RequestDispatcher rd = request.getRequestDispatcher("success.jsp");
					rd.forward(request, response);
				} else {
					// this only happens if the sessionid is removed, manually or because it timed
					// out and you try to go directly to the "success.jsp"
					// goto logout to clean up

					RequestDispatcher rd = request.getRequestDispatcher("Logout");
					rd.forward(request, response);

				}
			} catch (SQLException | ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			// this should only happen if you try to goto "/Login" manually
			response.sendRedirect("index.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

    	//Check if someone creates a new post or a new tag
    	String newPost = "0";
    	String newTag = null;
    	
    	//Connect to database
    	SQLcon.connectSQL("posts");

		newPost = request.getParameter("newpost");
		newTag = request.getParameter("newTag");

		HttpSession session = request.getSession();
		UserBean bean = (UserBean) session.getAttribute("user");
		// the user is logged in or not
		session.setAttribute("user", bean);
		request.setAttribute("user", bean);
		
		//Check if someone created a new post
		if(newPost != null) {
			
			PostBean postBean = new PostBean();
			
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String tag = request.getParameter("tagName");
			
			postBean.setTitle(title);
			postBean.setContent(content);
			postBean.setTag(tag);

			try {
				SQLcon.createPost(postBean); //Ends with a disconnect
				SQLcon.connectSQL("posts");	//Open connection again
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}

		//Check if new tag should be added
		if(newTag != null) {
			String postId = request.getParameter("postid");
			String tagName = request.getParameter("tagName");
			try {
				SQLcon.addTag(postId, tagName); //Ends with a disconnect
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			SQLcon.connectSQL("posts"); //Connect again
		}
		ArrayList<PostBean> postBeanList = new ArrayList<>();
		
		try {
			postBeanList = SQLcon.getPosts();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.print("Error"); //Something went wrong
			e.printStackTrace();
		}

		session.setAttribute("posts", postBeanList); //Store posts in session

		RequestDispatcher rd = request.getRequestDispatcher("success.jsp"); 
		rd.forward(request, response);

	}

}
