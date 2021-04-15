package database;

import java.sql.*;
import java.util.ArrayList;



public class PostConnectionSQL {
	
	
	public static Connection con;  
	public Statement stm;  
	public ResultSet res = null;  
	private String title = null;  
	private String content = null;  
	private String author = null; 
	
	private static ResultSet rs = null;
	private static PreparedStatement stmt = null;
	
	public PostConnectionSQL() {  
		try {  
	  
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/posts?serverTimezone=UTC",
					DatabaseLogin.getuName(), DatabaseLogin.getuPass()); 
	        	stm = con.createStatement();   
	           
	     } catch (Exception e) {  
	    	 System.out.println("could not connect to database" + e.getMessage());  
	     }  
	} 
	
	public static boolean connectSQL() {
		try {

			// driver setup
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (Exception ex) {
			// handle the error
			System.out.println("Exception Driver: " + ex);
			return false;
		}

		try {
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/posts?serverTimezone=UTC",
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
	
	public static void test() {
		System.out.println("TESTTEEST");
	}
	
	public void setTitle(String title){  
	      this.title = title;  
	} 
	
	public void setContent(String content){  
	      this.content = content;  
	} 
	
	public void setAuthor(String author) {
		this.author = author;
	}
	
	public String getTitle() {
		return title;
	}
	
	public String getContent() {
		return content;
	}
	
	public String getAuthor() {
		return author;
	}
	
	public void createSimplePost(){  
		try {  
			String query = "insert into posts(title, content, author) values(\""+title+"\", \""+content+"\", \"Unkown\")";  
	        stm.executeUpdate(query);  
	  
	    } catch (SQLException e) {
			System.out.println("Error in inserting:" + e.getMessage());
		}  
	} 
	
	public boolean deletePost(){  
	     
		boolean test = false;  
	     
	    try {  
	    	String query = "delete from posts where title='" + title+"'";  
	        int lines = stm.executeUpdate(query);  
	           
	        if (lines > 0)  
	           test = true;  
	        else  
	           test = false;  
	  
	    }catch (SQLException e) {
	    	System.out.println("Error exclusion:" + e.getMessage());
	    }  
	    	return test;  
	}
	
	public void seeTags(int postId) {
		Statement stm2 = null;
		
		try {  
			 stm2 = con.createStatement(); 
	         res = stm2.executeQuery("SELECT t.TagName FROM tags t INNER JOIN posttags pt ON t.TagId = pt.TagId INNER JOIN posts p ON pt.PostId = p.PostId WHERE p.PostId = " +postId);  
	      }   
	      catch (SQLException e){  
	         e.printStackTrace();  
	      }  
	  
	   }
	
	public void setTag(String tagName, String postId) {
		int tagIdint = 0;
		ResultSet tagId = null;
		try {  
	         stm.executeUpdate("insert into tags (tagname) values ('"+tagName+"')");  
	         tagId = stm.executeQuery("SELECT tagid FROM tags WHERE tagname = '"+tagName+"'");
	         while(tagId.next()) {
	        	 String tagIdString = tagId.getString(1);
	        	 tagIdint = Integer.parseInt(tagIdString);
	         }
	         System.out.println(tagIdint);
	         stm.executeUpdate("insert into posttags (postid, tagid) values('"+postId+"', '"+tagIdint+"')");
	         
	      }   
	      catch (SQLException e){  
	         e.printStackTrace();  
	      }
	}
	
	public String getPostId (String title) {
		String postId = null;
		ResultSet postIdResult = null;
		try {  
			postIdResult = stm.executeQuery("select postid from posts where title = '"+title+"'");  
			while(postIdResult.next()) {
	        	 postId = postIdResult.getString(1);
	         }
		}   
	      catch (SQLException e){  
	         e.printStackTrace();  
	      }  
		
		return postId;
	}
	
	public void getPosts() {  
        
	      try {  
	         res = stm.executeQuery("select * from posts");  
	      }   
	      catch (SQLException e){  
	         e.printStackTrace();  
	      }  
	  
	   }
	
	public void searchPosts(String search) {
		try {  
	         res = stm.executeQuery("SELECT * FROM tags t INNER JOIN posttags pt ON t.TagId = pt.TagId INNER JOIN posts p ON pt.PostId = p.PostId WHERE p.Title = '"+search+"' OR t.TagName = '"+search+"' GROUP BY p.PostId;");  
	      }   
	      catch (SQLException e){  
	         e.printStackTrace();  
	      } 
	}
	
	public ResultSet getResult() {  
		return res;  
	} 
}
























