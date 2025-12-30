package service;

import java.util.List;

import model.OderModel;

public interface IOrderService {
    OderModel findById(int id) throws Exception;

    List<OderModel> findByUserId(int userid) throws Exception;

    List<OderModel> findAll() throws Exception;

    int save(OderModel order) throws Exception;

    boolean update(OderModel order) throws Exception;

    boolean delete(int id) throws Exception;
}