package dao;

import java.util.List;
import model.UserModel;

public interface IUserDAO {
    UserModel findById(int id) throws Exception;
    UserModel findByUsername(String username) throws Exception;
    UserModel findByEmail(String email) throws Exception;
    List<UserModel> findAll() throws Exception;
    int insert(UserModel user) throws Exception; // returns generated id
    boolean update(UserModel user) throws Exception;
    boolean delete(int id) throws Exception;
}