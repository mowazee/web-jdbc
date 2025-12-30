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
}