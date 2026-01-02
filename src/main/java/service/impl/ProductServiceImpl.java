package service.impl;

import java.util.List;

import dao.IProductDAO;
import dao.impl.ProductDAOImpl;
import model.ProductModel;
import service.IProductService;

public class ProductServiceImpl implements IProductService {
    private IProductDAO productDAO = new ProductDAOImpl();

    @Override
    public ProductModel findById(int id) throws Exception {
        return productDAO.findById(id);
    }

    @Override
    public List<ProductModel> findByCategory(int cateid) throws Exception {
        return productDAO.findByCategory(cateid);
    }

    @Override
    public List<ProductModel> findAll() throws Exception {
        return productDAO.findAll();
    }

    @Override
    public int save(ProductModel product) throws Exception {
        return productDAO.insert(product);
    }

    @Override
    public boolean update(ProductModel product) throws Exception {
        return productDAO.update(product);
    }

    @Override
    public boolean delete(int id) throws Exception {
        return productDAO.delete(id);
    }

    @Override
    public List<ProductModel> searchByName(String keyword) throws Exception {
        return productDAO.searchByName(keyword == null ? "" : keyword);
    }

    @Override
    public List<ProductModel> findAllPaged(int offset, int limit) throws Exception {
        return productDAO.findAllPaged(offset, limit);
    }

    @Override
    public List<ProductModel> findByCategoryPaged(int cateid, int offset, int limit) throws Exception {
        return productDAO.findByCategoryPaged(cateid, offset, limit);
    }

    @Override
    public List<ProductModel> searchByNamePaged(String keyword, int offset, int limit) throws Exception {
        return productDAO.searchByNamePaged(keyword == null ? "" : keyword, offset, limit);
    }

    @Override
    public int countAll() throws Exception {
        return productDAO.countAll();
    }

    @Override
    public int countByCategory(int cateid) throws Exception {
        return productDAO.countByCategory(cateid);
    }

    @Override
    public int countBySearch(String keyword) throws Exception {
        return productDAO.countBySearch(keyword == null ? "" : keyword);
    }
}