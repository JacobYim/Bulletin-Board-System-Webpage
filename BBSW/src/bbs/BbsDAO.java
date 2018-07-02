package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn; //an object making connection with MySql.
	private ResultSet rs;
	private PreparedStatement pstmt;
	
	public  BbsDAO() {
		try {

			// make connect with MySQL
			
			String dbURL = "jdbc:mysql://localhost:3306/BBS";	// connect with mysql which address is localhost:3306 and the database named as BBS 
			String dbID = "root";								// name of account
			String dbPassword = "rootroot";						// password for account
			Class.forName("com.mysql.jdbc.Driver");				// helps to find the Driver connecting with MySQL.
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// fuction to attempt login 
		public String getDate() {
			String SQL = "SELECT NOW()";
			try {
				pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
					if(rs.next()) {
						return rs.getString(1);
					}
				}catch (Exception e) {
				e.printStackTrace();
			}
			return ""; // when returned date is not exsisted, 
		}
		
		public int getNext() {
			String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
			try {
				pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1)+1;
				}
				return 1;
				}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; // when returned date is not exsisted, 
		}

		public int write(String bbsTitle, String userID, String bbsContent) {
			String SQL = "INSERT INTO BBS VALUE (?, ?, ?, ?, ?, ?)";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1,getNext());
				pstmt.setString(2,bbsTitle);
				pstmt.setString(3,userID);
				pstmt.setString(4,getDate());
				pstmt.setString(5,bbsContent);
				pstmt.setInt(6,1);
				
				rs = pstmt.executeQuery();
				return pstmt.executeUpdate();
				
				}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		// function giving list of contents depends on the pageNumber
		public ArrayList<Bbs> getList(int pageNumber){
			String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
			ArrayList<Bbs> list = new ArrayList<Bbs>();
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() - (pageNumber - 1) *10);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					Bbs bbs = new Bbs();
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setBbsDate(rs.getString(5));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					list.add(bbs);
					
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list;
		}
		
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() - (pageNumber - 1) *10);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					return true;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false;
		}
		
}
