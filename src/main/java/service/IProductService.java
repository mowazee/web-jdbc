package service;

import java.util.List;

import model.ProductModel;

public interface IProductService {
    ProductModel findById(int id) throws Exception;

    List<ProductModel> findByCategory(int cateid) throws Exception;

    List<ProductModel> findAll() throws Exception;

    int save(ProductModel product) throws Exception; // insert and return id

    boolean update(ProductModel product) throws Exception;

    boolean delete(int id) throws Exception;

    // Search products by name containing keyword
    List<ProductModel> searchByName(String keyword) throws Exception;

    // Pagination support
    List<ProductModel> findAllPaged(int offset, int limit) throws Exception;

    List<ProductModel> findByCategoryPaged(int cateid, int offset, int limit) throws Exception;

    List<ProductModel> searchByNamePaged(String keyword, int offset, int limit) throws Exception;

    // Counts
    int countAll() throws Exception;

    int countByCategory(int cateid) throws Exception;

    int countBySearch(String keyword) throws Exception;
}