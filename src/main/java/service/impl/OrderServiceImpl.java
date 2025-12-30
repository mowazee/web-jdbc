package service.impl;

import java.util.List;

import dao.IOrderDAO;
import dao.impl.OrderDAOImpl;
import model.OderModel;
import service.IOrderService;

public class OrderServiceImpl implements IOrderService {
    private IOrderDAO orderDAO = new OrderDAOImpl();

    @Override
    public OderModel findById(int id) throws Exception {
        return orderDAO.findById(id);
    }

    @Override
    public List<OderModel> findByUserId(int userid) throws Exception {
        return orderDAO.findByUserId(userid);
    }

    @Override
    public List<OderModel> findAll() throws Exception {
        return orderDAO.findAll();
    }

    @Override
    public int save(OderModel order) throws Exception {
        return orderDAO.insert(order);
    }

    @Override
    public boolean update(OderModel order) throws Exception {
        return orderDAO.update(order);
    }

    @Override
    public boolean delete(int id) throws Exception {
        return orderDAO.delete(id);
    }
}