package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.IOrderDAO;
import model.OrderItemModel;
import model.OrderModel;
import utils.DBConnect;

public class OrderDAOImpl implements IOrderDAO {

    @Override
    public OrderModel findById(int id) throws Exception {
        String sql = "SELECT order_id, user_id, order_date, total_amount, status, recipient_name, recipient_phone, recipient_address FROM ORDERS WHERE order_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    OrderModel o = new OrderModel();
                    o.setId(rs.getInt("order_id"));
                    o.setUserid(rs.getInt("user_id"));
                    o.setOrderdate(rs.getDate("order_date"));
                    o.setTotal(rs.getDouble("total_amount"));
                    o.setStatus(rs.getInt("status"));
                    o.setRecipientName(rs.getString("recipient_name"));
                    o.setRecipientPhone(rs.getString("recipient_phone"));
                    o.setRecipientAddress(rs.getString("recipient_address"));
                    o.setItems(findItemsByOrderId(o.getId(), conn));
                    return o;
                }
            }
        }
        return null;
    }

    private List<OrderItemModel> findItemsByOrderId(int orderId, Connection conn) throws Exception {
        List<OrderItemModel> list = new ArrayList<>();
        String sql = "SELECT order_detail_id, order_id, product_id, quantity, unit_price FROM ORDER_DETAIL WHERE order_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItemModel it = new OrderItemModel();
                    it.setId(rs.getInt("order_detail_id"));
                    it.setOrderId(rs.getInt("order_id"));
                    it.setProductId(rs.getInt("product_id"));
                    it.setQuantity(rs.getInt("quantity"));
                    it.setPrice(rs.getDouble("unit_price"));
                    list.add(it);
                }
            }
        }
        return list;
    }

    @Override
    public List<OrderModel> findByUserId(int userid) throws Exception {
        List<OrderModel> list = new ArrayList<>();
        String sql = "SELECT order_id, user_id, order_date, total_amount, status, recipient_name, recipient_phone, recipient_address FROM ORDERS WHERE user_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userid);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderModel o = new OrderModel();
                    o.setId(rs.getInt("order_id"));
                    o.setUserid(rs.getInt("user_id"));
                    o.setOrderdate(rs.getDate("order_date"));
                    o.setTotal(rs.getDouble("total_amount"));
                    o.setStatus(rs.getInt("status"));
                    o.setRecipientName(rs.getString("recipient_name"));
                    o.setRecipientPhone(rs.getString("recipient_phone"));
                    o.setRecipientAddress(rs.getString("recipient_address"));
                    list.add(o);
                }
            }
        }
        return list;
    }

    @Override
    public List<OrderModel> findAll() throws Exception {
        List<OrderModel> list = new ArrayList<>();
        String sql = "SELECT order_id, user_id, order_date, total_amount, status, recipient_name, recipient_phone, recipient_address FROM ORDERS";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                OrderModel o = new OrderModel();
                o.setId(rs.getInt("order_id"));
                o.setUserid(rs.getInt("user_id"));
                o.setOrderdate(rs.getDate("order_date"));
                o.setTotal(rs.getDouble("total_amount"));
                o.setStatus(rs.getInt("status"));
                o.setRecipientName(rs.getString("recipient_name"));
                o.setRecipientPhone(rs.getString("recipient_phone"));
                o.setRecipientAddress(rs.getString("recipient_address"));
                list.add(o);
            }
        }
        return list;
    }

    @Override
    public int insert(OrderModel order) throws Exception {
        String sql = "INSERT INTO ORDERS(user_id, total_amount, status, recipient_name, recipient_phone, recipient_address) VALUES(?,?,?,?,?,?)";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getUserid());
            ps.setDouble(2, order.getTotal());
            ps.setString(3, "NEW");
            ps.setString(4, order.getRecipientName());
            ps.setString(5, order.getRecipientPhone());
            ps.setString(6, order.getRecipientAddress());
            int aff = ps.executeUpdate();
            if (aff == 0) return -1;
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    int orderId = keys.getInt(1);
                    // insert order items
                    for (OrderItemModel it : order.getItems()) {
                        insertOrderItem(orderId, it, conn);
                    }
                    return orderId;
                }
            }
        }
        return -1;
    }

    private void insertOrderItem(int orderId, OrderItemModel it, Connection conn) throws Exception {
        String sql = "INSERT INTO ORDER_DETAIL(order_id, product_id, quantity, unit_price) VALUES(?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, it.getProductId());
            ps.setInt(3, it.getQuantity());
            ps.setDouble(4, it.getPrice());
            ps.executeUpdate();
        }
    }

    @Override
    public boolean update(OrderModel order) throws Exception {
        String sql = "UPDATE ORDERS SET total_amount = ?, status = ? WHERE order_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, order.getTotal());
            ps.setString(2, String.valueOf(order.getStatus()));
            ps.setInt(3, order.getId());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean delete(int id) throws Exception {
        String sql = "DELETE FROM ORDERS WHERE order_id = ?";
        try (Connection conn = new DBConnect().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}