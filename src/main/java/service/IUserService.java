package service;
import java.sql.Date;
import model.UserModel;
import java.util.List;

public interface IUserService {
	// Register
	boolean register(String email, String username, String fullname, String password, String avatar, int roleid, String phone, Date createdate) throws Exception;
	boolean checkExistEmail(String email) throws Exception;
	boolean checkExistUsername(String username) throws Exception;
	boolean checkExistPhone(String phone) throws Exception;
	UserModel findById(int id) throws Exception;
	UserModel findByUsername(String username) throws Exception;
	UserModel findByEmail(String email) throws Exception;
	UserModel findByActivationToken(String token) throws Exception;
	UserModel findByResetToken(String token) throws Exception; // new
	List<UserModel> findAll() throws Exception;

	int save(UserModel user) throws Exception; // insert returns id
	boolean update(UserModel user) throws Exception;
	boolean delete(int id) throws Exception;
	boolean activate(String token) throws Exception;
	boolean setResetTokenByEmail(String email, String token, long expiryMillis) throws Exception; // new
	boolean clearResetToken(String token) throws Exception; // new
	boolean updatePasswordByResetToken(String token, String rawPassword) throws Exception; // new: raw password, service will hash
}