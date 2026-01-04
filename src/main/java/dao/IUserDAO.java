package dao;
import java.util.List;
import model.UserModel;

public interface IUserDAO {
    UserModel findById(int id) throws Exception;
    UserModel findByUsername(String username) throws Exception;
    UserModel findByEmail(String email) throws Exception;
    UserModel findByActivationToken(String token) throws Exception;
    UserModel findByResetToken(String token) throws Exception; // new
    List<UserModel> findAll() throws Exception;
    int insert(UserModel user) throws Exception; // returns generated id
    boolean update(UserModel user) throws Exception;
    boolean delete(int id) throws Exception;
    boolean activateByToken(String token) throws Exception;
    boolean setResetTokenByEmail(String email, String token, long expiryMillis) throws Exception; // new
    boolean clearResetToken(String token) throws Exception; // new
    boolean updatePasswordByResetToken(String token, String hashedPassword) throws Exception; // new
}