package service;

import java.util.List;

import model.OrderModel;

public interface IOrderService {
    OrderModel findById(int id) throws Exception;

    List<OrderModel> findByUserId(int userid) throws Exception;

    List<OrderModel> findAll() throws Exception;

    int save(OrderModel order) throws Exception;

    boolean update(OrderModel order) throws Exception;

    boolean delete(int id) throws Exception;
}