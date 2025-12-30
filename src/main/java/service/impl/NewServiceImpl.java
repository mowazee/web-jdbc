package service.impl;

import java.util.List;

import dao.INewDAO;
import dao.impl.NewDAOImpl;
import model.NewModel;
import service.INewService;

public class NewServiceImpl implements INewService {
    private INewDAO newDAO = new NewDAOImpl();

    @Override
    public NewModel findById(int id) throws Exception {
        return newDAO.findById(id);
    }

    @Override
    public List<NewModel> findAll() throws Exception {
        return newDAO.findAll();
    }

    @Override
    public int save(NewModel news) throws Exception {
        return newDAO.insert(news);
    }

    @Override
    public boolean update(NewModel news) throws Exception {
        return newDAO.update(news);
    }

    @Override
    public boolean delete(int id) throws Exception {
        return newDAO.delete(id);
    }
}