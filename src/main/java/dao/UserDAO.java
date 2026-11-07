package dao;

import entity.User;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
	
	public User login(String username, String password) {
	    // Delegate sang findByUsername để tái sử dụng, BCrypt check ở LoginServlet
	    return findByUsername(username);
	}

	
    public User findByUsername(String username) {

        String sql = "SELECT * FROM Users WHERE username=?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullname(rs.getString("fullname"));
                u.setRole(rs.getString("role"));
                u.setAvatar(rs.getString("avatar"));
                u.setActive(rs.getBoolean("active"));

                u.setWarningCount(rs.getInt("warning_count"));
                u.setBannedAt(rs.getTimestamp("banned_at"));
                return u;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean insert(User u) throws SQLException {
        String sql = "INSERT INTO Users(username,password,fullname) VALUES(?,?,?)";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getFullname());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    public boolean updateAvatar(String username, String avatar) {

        String sql =
            "UPDATE Users SET avatar = ? WHERE username = ?";

        try (
            Connection conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, avatar);
            ps.setString(2, username);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    
    public int countUsers() {
        String sql = "SELECT COUNT(*) FROM Users";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public List<User> findAll(){

        List<User> list=new ArrayList<>();

        String sql="SELECT * FROM Users";

        try(Connection conn=DBContext.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql);
            ResultSet rs=ps.executeQuery()){


            while(rs.next()){

                User u=new User();

                u.setId(rs.getInt("id"));
                u.setFullname(rs.getString("fullname"));
                u.setUsername(rs.getString("username"));
                u.setRole(rs.getString("role"));
                u.setActive(rs.getBoolean("active"));

                list.add(u);
            }


        }catch(Exception e){
            e.printStackTrace();
        }


        return list;
    }
    
    public void updateActive(int id,boolean active){

        String sql=
        "UPDATE Users SET active=? WHERE id=?";


        try(Connection conn=DBContext.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql)){


            ps.setBoolean(1,active);

            ps.setInt(2,id);

            ps.executeUpdate();


        }catch(Exception e){

            e.printStackTrace();

        }

    }
    public void delete(int id){

    	String sql=
    	"DELETE FROM Users WHERE id=?";


    	try(Connection conn=DBContext.getConnection();
    	PreparedStatement ps=conn.prepareStatement(sql)){


    	ps.setInt(1,id);

    	ps.executeUpdate();


    	}catch(Exception e){

    	e.printStackTrace();

    	}

    	}
    
    public User getById(int id){

    	String sql="SELECT * FROM Users WHERE id=?";

    	User u=null;

    	try(Connection conn=DBContext.getConnection();
    	PreparedStatement ps=conn.prepareStatement(sql)){


    	ps.setInt(1,id);

    	ResultSet rs=ps.executeQuery();


    	if(rs.next()){

    	u=new User();

    	u.setId(rs.getInt("id"));
    	u.setFullname(rs.getString("fullname"));
    	u.setUsername(rs.getString("username"));
    	u.setRole(rs.getString("role"));
    	u.setActive(rs.getBoolean("active"));
    	
    	u.setWarningCount(rs.getInt("warning_count"));
        u.setBannedAt(rs.getTimestamp("banned_at"));

    	}


    	}catch(Exception e){

    	e.printStackTrace();

    	}

    	return u;
    	
    	}
    
    public void incrementWarning(int userId) {
        String sql = "UPDATE Users SET warning_count = warning_count + 1 WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void banUser(int userId) {
        String sql = "UPDATE Users SET active=0, banned_at=GETDATE() WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void restoreUser(int userId) {
        String sql = "UPDATE Users SET active=1, banned_at=NULL, warning_count=0 WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<User> findBannedUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE active=0 AND banned_at IS NOT NULL";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setFullname(rs.getString("fullname"));
                u.setRole(rs.getString("role"));
                u.setActive(rs.getBoolean("active"));
                u.setWarningCount(rs.getInt("warning_count"));
                u.setBannedAt(rs.getTimestamp("banned_at"));
                list.add(u);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    	
}