package dao;
//import models.UserModel;
public interface UserDao {

	//UserModel FindUserDao(String username);
	//register
	//public void insert(UserModel user);
	boolean checkExistEmail(String email);
	boolean checkExistUsername(String username);
	boolean checkExistPhone(String phone);

}