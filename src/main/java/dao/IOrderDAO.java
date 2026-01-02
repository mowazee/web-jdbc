package dao;

import java.util.List;
import model.OrderModel;

public interface IOrderDAO {
    OrderModel findById(int id) throws Exception;
    List<OrderModel> findByUserId(int userid) throws Exception;
    List<OrderModel> findAll() throws Exception;
    int insert(OrderModel order) throws Exception;
    boolean update(OrderModel order) throws Exception;
    boolean delete(int id) throws Exception;
}