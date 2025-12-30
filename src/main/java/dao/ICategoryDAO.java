package dao;

import java.util.List;
import model.CategoryModel;

public interface ICategoryDAO {
    List<CategoryModel> findAll() throws Exception;
    CategoryModel findById(int id) throws Exception;
    int insert(CategoryModel category) throws Exception;
    boolean update(CategoryModel category) throws Exception;
    boolean delete(int id) throws Exception;
}