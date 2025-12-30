package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.IUserDAO;
import model.UserModel;
import utils.DBConnect;

public class UserDAOImpl implements IUserDAO {

    @Override
    public UserModel findById(int id) throws Exception {
        String sql = "SELECT user_id, username, password, full_name, email, phone, address, role_id, created_at FROM USERS WHERE user_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UserModel u = new UserModel();
                    u.setId(rs.getInt("user_id"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setFullname(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setPhone(rs.getString("phone"));
                    u.setCreatedate(rs.getDate("created_at"));
                    u.setRoleid(rs.getInt("role_id"));
                    return u;
                }
            }
        }
        return null;
    }

    @Override
    public UserModel findByUsername(String username) throws Exception {
        String sql = "SELECT user_id, username, password, full_name, email, phone, address, role_id, created_at FROM USERS WHERE username = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UserModel u = new UserModel();
                    u.setId(rs.getInt("user_id"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setFullname(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setPhone(rs.getString("phone"));
                    u.setCreatedate(rs.getDate("created_at"));
                    u.setRoleid(rs.getInt("role_id"));
                    return u;
                }
            }
        }
        return null;
    }

    @Override
    public UserModel findByEmail(String email) throws Exception {
        String sql = "SELECT user_id, username, password, full_name, email, phone, address, role_id, created_at FROM USERS WHERE email = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UserModel u = new UserModel();
                    u.setId(rs.getInt("user_id"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setFullname(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setPhone(rs.getString("phone"));
                    u.setCreatedate(rs.getDate("created_at"));
                    u.setRoleid(rs.getInt("role_id"));
                    return u;
                }
            }
        }
        return null;
    }

    @Override
    public List<UserModel> findAll() throws Exception {
        List<UserModel> list = new ArrayList<>();
        String sql = "SELECT user_id, username, password, full_name, email, phone, address, role_id, created_at FROM USERS";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                UserModel u = new UserModel();
                u.setId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullname(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setCreatedate(rs.getDate("created_at"));
                u.setRoleid(rs.getInt("role_id"));
                list.add(u);
            }
        }
        return list;
    }

    @Override
    public int insert(UserModel user) throws Exception {
        String sql = "INSERT INTO USERS(username, password, full_name, email, phone, address, role_id) VALUES(?,?,?,?,?,?,?)";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, null);
            ps.setInt(7, user.getRoleid());
            int affected = ps.executeUpdate();
            if (affected == 0) return -1;
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return -1;
    }

    @Override
    public boolean update(UserModel user) throws Exception {
        String sql = "UPDATE USERS SET username = ?, password = ?, full_name = ?, email = ?, phone = ?, address = ?, role_id = ? WHERE user_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, null);
            ps.setInt(7, user.getRoleid());
            ps.setInt(8, user.getId());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean delete(int id) throws Exception {
        String sql = "DELETE FROM USERS WHERE user_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}