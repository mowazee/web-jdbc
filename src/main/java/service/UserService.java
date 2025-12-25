package service;
import java.sql.Date;
//import models.UserModel;

public interface UserService {
	//UserModel login(String username, String password);
	//UserModel FindUserService(String username);
	// Register
	//public void insert(UserModel user);
	boolean register(String email, String username, String fullname, String password, String avatar, int roleid, String phone, Date createdate);
	boolean checkExistEmail(String email);
	boolean checkExistUsername(String username);
	boolean checkExistPhone(String phone);
}