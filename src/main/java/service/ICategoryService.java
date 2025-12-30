package service;

import java.util.List;

import model.CategoryModel;

public interface ICategoryService {
    List<CategoryModel> findAll() throws Exception;

    CategoryModel findById(int id) throws Exception;

    int save(CategoryModel category) throws Exception; // insert returns id

    boolean update(CategoryModel category) throws Exception;

    boolean delete(int id) throws Exception;
}