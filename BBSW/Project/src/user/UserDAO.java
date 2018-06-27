package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn; //an object making connection with MySql.
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {
		try {

			// make connect with MySQL
			
			String dbURL = "jdbc:mysql://localhost:3306/BBS";	// connect with mysql which address is localhost:3306 and the database named as BBS 
			String dbID = "root";								// name of account
			String dbPassword = "rootroot";						// password for account
			Class.forName("com.mysql.jdbc.Driver");				// helps to find the Driver connecting with MySQL.
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.print("adfa");
		}
	}
	
	// fuction to attempt login 
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
				if(rs.next()) {
					if (rs.getString(1).equals(userPassword))
						return 1;	// login success
					else
						return 0; 	// password incorrect
				}
				return -1;			// ID does not exist.
		}catch (Exception e) {
			e.printStackTrace();
		}
		System.out.print("adfa");
		return -2; // means database error
	}
}
