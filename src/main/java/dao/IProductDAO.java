package dao;

import java.util.List;

import model.ProductModel;

public interface IProductDAO {
	ProductModel findById(int id) throws Exception;

	List<ProductModel> findByCategory(int cateid) throws Exception;

	List<ProductModel> findAll() throws Exception;

	int insert(ProductModel product) throws Exception;

	boolean update(ProductModel product) throws Exception;

	boolean delete(int id) throws Exception;
}