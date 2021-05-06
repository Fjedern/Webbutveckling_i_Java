package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.PostBean;
import beans.UserBean;

public class SQLcon {

	static Connection conn = null;
	static PreparedStatement stmt = null;
	static ResultSet rs = null;
	
	//Extra to avoid sql problems when creating multiple queries
	static Connection conn2 = null;
	static PreparedStatement stmt2 = null;
	static ResultSet rs2 = null;
	
	public static void closeConn() throws SQLException{
		if(conn != null) {
			conn.close();
			System.out.println("connection is closed");
			}
	}
	
	public static void closeConn2() throws SQLException{
		if(conn2 != null) {
			conn2.close();
			System.out.println("connection is closed");
			}
	}

	public static boolean connectSQL(String db) {
		try {
			// driver setup
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (Exception ex) {
			// handle the error
			System.out.println("Exception Driver: " + ex);
			return false;
		}

		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db+"?serverTimezone=UTC",
					DatabaseLogin.getuName(), DatabaseLogin.getuPass());
			conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db+"?serverTimezone=UTC",
					DatabaseLogin.getuName(), DatabaseLogin.getuPass());
			return true;

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			return false;
		}

	}

	public static boolean stateSQL(UserBean bean) throws SQLException {
		
		// test a query
		try {
			String requestQuery = "SELECT * FROM users WHERE email = ? and password = ?";

			stmt = conn.prepareStatement(requestQuery);

			stmt.setString(1, bean.getEmail());
			stmt.setString(2, bean.getPassword());

			rs = stmt.executeQuery();
			// ResultSet return
			while (rs.next()) {

				// print them
				System.out.println(rs.getInt(1) + "  " + rs.getString(2) + "  " + rs.getString(3));

				bean.setName(rs.getString("fullname"));
				return true;

			}
			//conn.endRequest();
			conn.close();

		} catch (SQLException ex) {
			// TODO Auto-generated catch block
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
			return false;

		}
		finally {
			closeConn();
		}
		
		return false;

	}
	
	public static void createPost(PostBean postBean) throws SQLException {

		String postid = null;
		
		try {
			String insertPost = "insert into posts(title, content, author) values(\""+postBean.getTitle()+"\", \""+postBean.getContent()+"\", \"Unkown\")";  
	        stmt2 = conn.prepareStatement(insertPost);
			stmt2.executeUpdate(insertPost);  
			
			String getLatestPostId = "select postid from posts where title = '"+postBean.getTitle()+"'";
			stmt2 = conn.prepareStatement(getLatestPostId);
			rs = stmt2.executeQuery(getLatestPostId); 
	        while(rs.next()) {
	        	postid = rs.getString(1);
	        }
	        addTag(postid, postBean.getTag());

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("not working");
		}
		finally {
			System.out.println("postid: " + postid + "Title: " );
			closeConn();
		}
	}
	
	public static void addTag(String postId, String tagName) throws SQLException {
		int tagIdint = 0;
		ResultSet tagId = null;

		try {  
			String insertNewTag = ("insert into tags (tagname) values ('"+tagName+"')");
			stmt2 = conn.prepareStatement(insertNewTag);
	        stmt2.executeUpdate();  
	        
	        String selectLatestTagId = ("SELECT tagid FROM tags WHERE tagname = '"+tagName+"'");
	        stmt2 = conn.prepareStatement(selectLatestTagId);
	        tagId = stmt2.executeQuery();  
	         while(tagId.next()) {
	        	 String tagIdString = tagId.getString(1);
	        	 tagIdint = Integer.parseInt(tagIdString);
	         }
	         System.out.println(tagIdint);
	         String createRelation = ("insert into posttags (postid, tagid) values('"+postId+"', '"+tagIdint+"')");
	         stmt2 = conn.prepareStatement(createRelation);
	         stmt2.executeUpdate();	         
	      }   
	      catch (SQLException e){  
	         e.printStackTrace();  
	      }
		finally {
			closeConn();
		}
	}
	
	public static ArrayList<PostBean> getPosts() throws SQLException {
		try {
			//Create list of postBeans
			ArrayList<PostBean> postBeanList = new ArrayList<>();

			// storing sql-query, select orderd by newest content to oldest through id nr
			String requestQuery = "SELECT * FROM posts";
			stmt = conn.prepareStatement(requestQuery);
			rs = stmt.executeQuery();

			// Loop through all posts and create a bean for every post
			while (rs.next()) {
				//Create new bean
				PostBean postBean = new PostBean();


				postBean.setPostId(rs.getString("postid"));
				postBean.setTitle(rs.getString("title"));
				postBean.setContent(rs.getString("content"));
				
				String getTags = "SELECT t.TagName FROM tags t INNER JOIN posttags pt ON t.TagId = pt.TagId INNER JOIN posts p ON pt.PostId = p.PostId WHERE p.PostId = ?";
				stmt2 = conn2.prepareStatement(getTags);
				//Insert current postid into prepared statement
				stmt2.setString(1, postBean.getPostId());
				rs2 = stmt2.executeQuery();
				
				while(rs2.next()) {
					if(rs2 != null) {
						postBean.addTag(rs2.getString("tagName"));
					}
					
				}
				postBeanList.add(postBean);
				
			}
			return postBeanList;


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
		finally {
			closeConn();
			closeConn2();
		}
	}

}