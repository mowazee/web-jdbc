package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import dao.IUserDAO;
import model.UserModel;
import utils.DBConnect;

public class UserDAOImpl implements IUserDAO {

    @Override
    public UserModel findById(int id) throws Exception {
        String sql = "SELECT user_id, username, password, full_name, email, phone, address, activation_token, is_active, reset_token, reset_token_expiry, role_id, created_at FROM USERS WHERE user_id = ?";
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
                    u.setAddress(rs.getString("address"));
                    u.setActivationToken(rs.getString("activation_token"));
                    u.setIsActive(rs.getInt("is_active"));
                    u.setResetToken(rs.getString("reset_token"));
                    Timestamp t = rs.getTimestamp("reset_token_expiry");
                    u.setResetTokenExpiry(t);
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
        String sql = "SELECT user_id, username, password, full_name, email, phone, address, activation_token, is_active, reset_token, reset_token_expiry, role_id, created_at FROM USERS WHERE username = ?";
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
                    u.setAddress(rs.getString("address"));
                    u.setActivationToken(rs.getString("activation_token"));
                    u.setIsActive(rs.getInt("is_active"));
                    u.setResetToken(rs.getString("reset_token"));
                    Timestamp t = rs.getTimestamp("reset_token_expiry");
                    u.setResetTokenExpiry(t);
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
        String sql = "SELECT user_id, username, password, full_name, email, phone, address, activation_token, is_active, reset_token, reset_token_expiry, role_id, created_at FROM USERS WHERE email = ?";
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
                    u.setAddress(rs.getString("address"));
                    u.setActivationToken(rs.getString("activation_token"));
                    u.setIsActive(rs.getInt("is_active"));
                    u.setResetToken(rs.getString("reset_token"));
                    Timestamp t = rs.getTimestamp("reset_token_expiry");
                    u.setResetTokenExpiry(t);
                    u.setCreatedate(rs.getDate("created_at"));
                    u.setRoleid(rs.getInt("role_id"));
                    return u;
                }
            }
        }
        return null;
    }

    @Override
    public UserModel findByActivationToken(String token) throws Exception {
        String sql = "SELECT user_id, username, password, full_name, email, phone, address, activation_token, is_active, reset_token, reset_token_expiry, role_id, created_at FROM USERS WHERE activation_token = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UserModel u = new UserModel();
                    u.setId(rs.getInt("user_id"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setFullname(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setPhone(rs.getString("phone"));
                    u.setAddress(rs.getString("address"));
                    u.setActivationToken(rs.getString("activation_token"));
                    u.setIsActive(rs.getInt("is_active"));
                    u.setResetToken(rs.getString("reset_token"));
                    Timestamp t = rs.getTimestamp("reset_token_expiry");
                    u.setResetTokenExpiry(t);
                    u.setCreatedate(rs.getDate("created_at"));
                    u.setRoleid(rs.getInt("role_id"));
                    return u;
                }
            }
        }
        return null;
    }

    @Override
    public UserModel findByResetToken(String token) throws Exception {
        String sql = "SELECT user_id, username, password, full_name, email, phone, address, activation_token, is_active, reset_token, reset_token_expiry, role_id, created_at FROM USERS WHERE reset_token = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UserModel u = new UserModel();
                    u.setId(rs.getInt("user_id"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setFullname(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setPhone(rs.getString("phone"));
                    u.setAddress(rs.getString("address"));
                    u.setActivationToken(rs.getString("activation_token"));
                    u.setIsActive(rs.getInt("is_active"));
                    u.setResetToken(rs.getString("reset_token"));
                    Timestamp t = rs.getTimestamp("reset_token_expiry");
                    u.setResetTokenExpiry(t);
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
        String sql = "SELECT user_id, username, password, full_name, email, phone, address, activation_token, is_active, reset_token, reset_token_expiry, role_id, created_at FROM USERS";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                UserModel u = new UserModel();
                u.setId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullname(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setActivationToken(rs.getString("activation_token"));
                u.setIsActive(rs.getInt("is_active"));
                u.setResetToken(rs.getString("reset_token"));
                Timestamp t = rs.getTimestamp("reset_token_expiry");
                u.setResetTokenExpiry(t);
                u.setCreatedate(rs.getDate("created_at"));
                u.setRoleid(rs.getInt("role_id"));
                list.add(u);
            }
        }
        return list;
    }

    @Override
    public int insert(UserModel user) throws Exception {
        String sql = "INSERT INTO USERS(username, password, full_name, email, phone, address, activation_token, is_active, reset_token, reset_token_expiry, role_id) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getActivationToken());
            ps.setInt(8, user.getIsActive());
            ps.setString(9, user.getResetToken());
            if (user.getResetTokenExpiry() != null) ps.setTimestamp(10, user.getResetTokenExpiry()); else ps.setTimestamp(10, null);
            ps.setInt(11, user.getRoleid());
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
        String sql = "UPDATE USERS SET username = ?, password = ?, full_name = ?, email = ?, phone = ?, address = ?, activation_token = ?, is_active = ?, reset_token = ?, reset_token_expiry = ?, role_id = ? WHERE user_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getActivationToken());
            ps.setInt(8, user.getIsActive());
            ps.setString(9, user.getResetToken());
            if (user.getResetTokenExpiry() != null) ps.setTimestamp(10, user.getResetTokenExpiry()); else ps.setTimestamp(10, null);
            ps.setInt(11, user.getRoleid());
            ps.setInt(12, user.getId());
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

    @Override
    public boolean activateByToken(String token) throws Exception {
        String sql = "UPDATE USERS SET is_active = 1, activation_token = NULL WHERE activation_token = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean setResetTokenByEmail(String email, String token, long expiryMillis) throws Exception {
        String sql = "UPDATE USERS SET reset_token = ?, reset_token_expiry = ? WHERE email = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.setTimestamp(2, new Timestamp(expiryMillis));
            ps.setString(3, email);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean clearResetToken(String token) throws Exception {
        String sql = "UPDATE USERS SET reset_token = NULL, reset_token_expiry = NULL WHERE reset_token = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean updatePasswordByResetToken(String token, String hashedPassword) throws Exception {
        String sql = "UPDATE USERS SET password = ?, reset_token = NULL, reset_token_expiry = NULL WHERE reset_token = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hashedPassword);
            ps.setString(2, token);
            return ps.executeUpdate() > 0;
        }
    }
}