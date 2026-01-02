package service;

import java.util.List;

import model.NewModel;

public interface INewService {
    NewModel findById(int id) throws Exception;
    List<NewModel> findAll() throws Exception;

    int save(NewModel news) throws Exception;
    boolean update(NewModel news) throws Exception;
    boolean delete(int id) throws Exception;

    List<NewModel> findTopViewed(int limit) throws Exception; // new
}