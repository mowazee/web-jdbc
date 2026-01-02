package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.IProductDAO;
import model.ProductModel;
import utils.DBConnect;

public class ProductDAOImpl implements IProductDAO {

    @Override
    public ProductModel findById(int id) throws Exception {
        String sql = "SELECT product_id, product_name, price, weight, stock, image, description, category_id, created_at, CONVERT(INT,0) as status FROM PRODUCT WHERE product_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductModel p = new ProductModel();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("product_name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setQuantity(rs.getInt("stock"));
                    p.setImage(rs.getString("image"));
                    p.setDescription(rs.getString("description"));
                    p.setCateid(rs.getInt("category_id"));
                    p.setCreatedate(rs.getDate("created_at"));
                    return p;
                }
            }
        }
        return null;
    }

    @Override
    public List<ProductModel> findByCategory(int cateid) throws Exception {
        List<ProductModel> list = new ArrayList<>();
        String sql = "SELECT product_id, product_name, price, weight, stock, image, description, category_id, created_at FROM PRODUCT WHERE category_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cateid);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductModel p = new ProductModel();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("product_name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setQuantity(rs.getInt("stock"));
                    p.setImage(rs.getString("image"));
                    p.setDescription(rs.getString("description"));
                    p.setCateid(rs.getInt("category_id"));
                    p.setCreatedate(rs.getDate("created_at"));
                    list.add(p);
                }
            }
        }
        return list;
    }

    @Override
    public List<ProductModel> findAll() throws Exception {
        List<ProductModel> list = new ArrayList<>();
        String sql = "SELECT product_id, product_name, price, weight, stock, image, description, category_id, created_at FROM PRODUCT";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProductModel p = new ProductModel();
                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("stock"));
                p.setImage(rs.getString("image"));
                p.setDescription(rs.getString("description"));
                p.setCateid(rs.getInt("category_id"));
                p.setCreatedate(rs.getDate("created_at"));
                list.add(p);
            }
        }
        return list;
    }

    @Override
    public int insert(ProductModel product) throws Exception {
        String sql = "INSERT INTO PRODUCT(product_name, price, weight, stock, image, description, category_id) VALUES(?,?,?,?,?,?,?)";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getQuantity());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getImage());
            ps.setString(6, product.getDescription());
            ps.setInt(7, product.getCateid());
            int aff = ps.executeUpdate();
            if (aff == 0) return -1;
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return -1;
    }

    @Override
    public boolean update(ProductModel product) throws Exception {
        String sql = "UPDATE PRODUCT SET product_name = ?, price = ?, weight = ?, stock = ?, image = ?, description = ?, category_id = ? WHERE product_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getQuantity());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getImage());
            ps.setString(6, product.getDescription());
            ps.setInt(7, product.getCateid());
            ps.setInt(8, product.getId());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean delete(int id) throws Exception {
        String sql = "DELETE FROM PRODUCT WHERE product_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public List<ProductModel> searchByName(String keyword) throws Exception {
        List<ProductModel> list = new ArrayList<>();
        String sql = "SELECT product_id, product_name, price, weight, stock, image, description, category_id, created_at FROM PRODUCT WHERE product_name LIKE ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductModel p = new ProductModel();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("product_name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setQuantity(rs.getInt("stock"));
                    p.setImage(rs.getString("image"));
                    p.setDescription(rs.getString("description"));
                    p.setCateid(rs.getInt("category_id"));
                    p.setCreatedate(rs.getDate("created_at"));
                    list.add(p);
                }
            }
        }
        return list;
    }

    @Override
    public List<ProductModel> findAllPaged(int offset, int limit) throws Exception {
        List<ProductModel> list = new ArrayList<>();
        String sql = "SELECT product_id, product_name, price, weight, stock, image, description, category_id, created_at FROM PRODUCT ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, Math.max(0, offset));	
            ps.setInt(2, Math.max(0, limit));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductModel p = new ProductModel();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("product_name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setQuantity(rs.getInt("stock"));
                    p.setImage(rs.getString("image"));
                    p.setDescription(rs.getString("description"));
                    p.setCateid(rs.getInt("category_id"));
                    p.setCreatedate(rs.getDate("created_at"));
                    list.add(p);
                }
            }
        }
        return list;
    }

    @Override
    public List<ProductModel> findByCategoryPaged(int cateid, int offset, int limit) throws Exception {
        List<ProductModel> list = new ArrayList<>();
        String sql = "SELECT product_id, product_name, price, weight, stock, image, description, category_id, created_at FROM PRODUCT WHERE category_id = ? ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cateid);
            ps.setInt(2, Math.max(0, offset));
            ps.setInt(3, Math.max(0, limit));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductModel p = new ProductModel();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("product_name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setQuantity(rs.getInt("stock"));
                    p.setImage(rs.getString("image"));
                    p.setDescription(rs.getString("description"));
                    p.setCateid(rs.getInt("category_id"));
                    p.setCreatedate(rs.getDate("created_at"));
                    list.add(p);
                }
            }
        }
        return list;
    }

    @Override
    public List<ProductModel> searchByNamePaged(String keyword, int offset, int limit) throws Exception {
        List<ProductModel> list = new ArrayList<>();
        String sql = "SELECT product_id, product_name, price, weight, stock, image, description, category_id, created_at FROM PRODUCT WHERE product_name LIKE ? ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, Math.max(0, offset));
            ps.setInt(3, Math.max(0, limit));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductModel p = new ProductModel();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("product_name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setQuantity(rs.getInt("stock"));
                    p.setImage(rs.getString("image"));
                    p.setDescription(rs.getString("description"));
                    p.setCateid(rs.getInt("category_id"));
                    p.setCreatedate(rs.getDate("created_at"));
                    list.add(p);
                }
            }
        }
        return list;
    }

    @Override
    public int countAll() throws Exception {
        String sql = "SELECT COUNT(*) FROM PRODUCT";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    @Override
    public int countByCategory(int cateid) throws Exception {
        String sql = "SELECT COUNT(*) FROM PRODUCT WHERE category_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cateid);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    @Override
    public int countBySearch(String keyword) throws Exception {
        String sql = "SELECT COUNT(*) FROM PRODUCT WHERE product_name LIKE ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }
}