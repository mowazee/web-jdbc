package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.ICategoryDAO;
import model.CategoryModel;
import utils.DBConnect;

public class CategoryDAOImpl implements ICategoryDAO {

    @Override
    public List<CategoryModel> findAll() throws Exception {
        List<CategoryModel> list = new ArrayList<>();
        String sql = "SELECT category_id, category_name, category_image, description FROM CATEGORY";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CategoryModel c = new CategoryModel();
                c.setCateid(rs.getInt("category_id"));
                c.setCatename(rs.getString("category_name"));
                c.setIcon(rs.getString("category_image"));
                // populate description so views can display it
                c.setDescription(rs.getString("description"));
                list.add(c);
            }
        }
        return list;
    }

    @Override
    public CategoryModel findById(int id) throws Exception {
        String sql = "SELECT category_id, category_name, category_image, description FROM CATEGORY WHERE category_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CategoryModel c = new CategoryModel();
                    c.setCateid(rs.getInt("category_id"));
                    c.setCatename(rs.getString("category_name"));
                    c.setIcon(rs.getString("category_image"));
                    // populate description so edit form shows current value
                    c.setDescription(rs.getString("description"));
                    return c;
                }
            }
        }
        return null;
    }

    @Override
    public int insert(CategoryModel category) throws Exception {
        // Standard insert using RETURN_GENERATED_KEYS for portability
        String sql = "INSERT INTO CATEGORY(category_name, category_image, description) VALUES(?,?,?)";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, category.getCatename());
            ps.setString(2, category.getIcon());
            if (category.getDescription() != null) {
                ps.setString(3, category.getDescription());
            } else {
                ps.setNull(3, java.sql.Types.VARCHAR);
            }
            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new java.sql.SQLException("Creating category failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new java.sql.SQLException("Creating category failed, no ID obtained.");
                }
            }
        }
    }

    @Override
    public boolean update(CategoryModel category) throws Exception {
        String sql = "UPDATE CATEGORY SET category_name = ?, category_image = ?, description = ? WHERE category_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getCatename());
            ps.setString(2, category.getIcon());
            // set description from model (use setNull if null)
            if (category.getDescription() != null) {
                ps.setString(3, category.getDescription());
            } else {
                ps.setNull(3, java.sql.Types.VARCHAR);
            }
            ps.setInt(4, category.getCateid());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean delete(int id) throws Exception {
        String sql = "DELETE FROM CATEGORY WHERE category_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

}
