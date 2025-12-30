package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.INewDAO;
import model.NewModel;
import utils.DBConnect;

public class NewDAOImpl implements INewDAO {

    @Override
    public NewModel findById(int id) throws Exception {
        String sql = "SELECT news_id, title, summary, content, thumbnail, author_id, publish_date, status, view_count FROM NEWS WHERE news_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    NewModel n = new NewModel();
                    n.setId(rs.getInt("news_id"));
                    n.setTitle(rs.getString("title"));
                    n.setPreview(rs.getString("summary"));
                    n.setContent(rs.getString("content"));
                    n.setThumbnail(rs.getString("thumbnail"));
                    n.setAuthorid(rs.getInt("author_id"));
                    n.setCreatedate(rs.getDate("publish_date"));
                    return n;
                }
            }
        }
        return null;
    }

    @Override
    public List<NewModel> findAll() throws Exception {
        List<NewModel> list = new ArrayList<>();
        String sql = "SELECT news_id, title, summary, content, thumbnail, author_id, publish_date, status, view_count FROM NEWS";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                NewModel n = new NewModel();
                n.setId(rs.getInt("news_id"));
                n.setTitle(rs.getString("title"));
                n.setPreview(rs.getString("summary"));
                n.setContent(rs.getString("content"));
                n.setThumbnail(rs.getString("thumbnail"));
                n.setAuthorid(rs.getInt("author_id"));
                n.setCreatedate(rs.getDate("publish_date"));
                list.add(n);
            }
        }
        return list;
    }

    @Override
    public int insert(NewModel news) throws Exception {
        String sql = "INSERT INTO NEWS(title, summary, content, thumbnail, author_id) VALUES(?,?,?,?,?)";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getPreview());
            ps.setString(3, news.getContent());
            ps.setString(4, news.getThumbnail());
            ps.setInt(5, news.getAuthorid());
            int aff = ps.executeUpdate();
            if (aff == 0) return -1;
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return -1;
    }

    @Override
    public boolean update(NewModel news) throws Exception {
        String sql = "UPDATE NEWS SET title = ?, summary = ?, content = ?, thumbnail = ?, author_id = ?, status = ? WHERE news_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getPreview());
            ps.setString(3, news.getContent());
            ps.setString(4, news.getThumbnail());
            ps.setInt(5, news.getAuthorid());
            ps.setInt(6, 1);
            ps.setInt(7, news.getId());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean delete(int id) throws Exception {
        String sql = "DELETE FROM NEWS WHERE news_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}
