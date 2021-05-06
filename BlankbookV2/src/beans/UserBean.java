package beans;

import java.sql.SQLException;

import database.SQLcon;

public class UserBean {
	private String name, password, email;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	
	}
	public boolean validate(UserBean bean) throws SQLException {
		
		if (SQLcon.connectSQL("users")) {
			return SQLcon.stateSQL(bean);
    	}
	
		return false;
	}
	public void resetUserBean() {
		this.password = null;
		this.name = null;
	}

}