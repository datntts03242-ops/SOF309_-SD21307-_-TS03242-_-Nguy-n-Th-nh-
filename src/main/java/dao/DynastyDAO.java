package dao;

import java.sql.*;
import java.util.*;
import entity.Dynasty;
import utils.DBContext;
import entity.Character;

public class DynastyDAO {

    private Connection conn = DBContext.getConnection();

    // LIST DYNASTY
    public List<Dynasty> findAll() {

        List<Dynasty> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Dynasties ORDER BY StartYear";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Dynasty d = new Dynasty();

                d.setId(rs.getInt("Id"));
                d.setName(rs.getString("Name"));
                d.setFounder(rs.getString("Founder"));
                d.setStartYear(rs.getInt("StartYear"));
                d.setEndYear(rs.getInt("EndYear"));
                d.setCapital(rs.getString("Capital"));
                d.setDescription(rs.getString("Description"));
                d.setImage(rs.getString("Image"));

                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // GET DETAIL DYNASTY
    public Dynasty findById(int id) {

        try {
            String sql = "SELECT * FROM Dynasties WHERE Id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Dynasty d = new Dynasty();

                d.setId(rs.getInt("Id"));
                d.setName(rs.getString("Name"));
                d.setFounder(rs.getString("Founder"));
                d.setStartYear(rs.getInt("StartYear"));
                d.setEndYear(rs.getInt("EndYear"));
                d.setCapital(rs.getString("Capital"));
                d.setDescription(rs.getString("Description"));
                d.setImage(rs.getString("Image"));

                return d;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // GET CHARACTERS BY DYNASTY
    public List<Character> getCharacters(int dynastyId) {

        List<Character> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Characters WHERE dynasty_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, dynastyId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Character c = new Character();

                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setImage(rs.getString("image"));
                c.setDescription(rs.getString("description"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countDynasties() {

        String sql = "SELECT COUNT(*) FROM Dynasties";

        try {

            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                return rs.getInt(1);
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return 0;
    }
    public void insert(Dynasty d) {

        String sql = """
            INSERT INTO Dynasties
            (name, founder, startYear, endYear, capital, description, image)
            VALUES (?,?,?,?,?,?,?)
            """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, d.getName());
            ps.setString(2, d.getFounder());
            ps.setInt(3, d.getStartYear());
            ps.setInt(4, d.getEndYear());
            ps.setString(5, d.getCapital());
            ps.setString(6, d.getDescription());
            ps.setString(7, d.getImage());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void update(Dynasty d) {

        String sql = """
            UPDATE Dynasties
            SET name=?,
                founder=?,
                startYear=?,
                endYear=?,
                capital=?,
                description=?,
                image=?
            WHERE id=?
            """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, d.getName());
            ps.setString(2, d.getFounder());
            ps.setInt(3, d.getStartYear());
            ps.setInt(4, d.getEndYear());
            ps.setString(5, d.getCapital());
            ps.setString(6, d.getDescription());
            ps.setString(7, d.getImage());
            ps.setInt(8, d.getId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void delete(int id) {

        String sql = "DELETE FROM Dynasties WHERE id=?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<Dynasty> getAll(){

        List<Dynasty> list=new ArrayList<>();

        String sql="SELECT * FROM Dynasties ORDER BY startYear";

        try(Connection conn=DBContext.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql);
            ResultSet rs=ps.executeQuery()){

            while(rs.next()){

                Dynasty d=new Dynasty();

                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));

                list.add(d);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
}