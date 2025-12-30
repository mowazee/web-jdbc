package service.impl;

import java.util.List;

import dao.ICategoryDAO;
import dao.impl.CategoryDAOImpl;
import model.CategoryModel;
import service.ICategoryService;

public class CategoryServiceImpl implements ICategoryService {
    private ICategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    public List<CategoryModel> findAll() throws Exception {
        return categoryDAO.findAll();
    }

    @Override
    public CategoryModel findById(int id) throws Exception {
        return categoryDAO.findById(id);
    }

    @Override
    public int save(CategoryModel category) throws Exception {
        return categoryDAO.insert(category);
    }

    @Override
    public boolean update(CategoryModel category) throws Exception {
        return categoryDAO.update(category);
    }

    @Override
    public boolean delete(int id) throws Exception {
        return categoryDAO.delete(id);
    }
}