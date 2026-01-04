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

	// Find products whose name contains the given keyword
	List<ProductModel> searchByName(String keyword) throws Exception;

	// Pagination: fetch page using offset/limit
	List<ProductModel> findAllPaged(int offset, int limit) throws Exception;

	List<ProductModel> findByCategoryPaged(int cateid, int offset, int limit) throws Exception;

	List<ProductModel> searchByNamePaged(String keyword, int offset, int limit) throws Exception;

	// Counts for pagination
	int countAll() throws Exception;

	int countByCategory(int cateid) throws Exception;

	int countBySearch(String keyword) throws Exception;
}