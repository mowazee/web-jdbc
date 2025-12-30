package service.impl;

import java.sql.Date;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import dao.IUserDAO;
import dao.impl.UserDAOImpl;
import model.UserModel;
import service.IUserService;

public class UserServiceImpl implements IUserService {
    private IUserDAO userDAO = new UserDAOImpl();

    @Override
    public boolean register(String email, String username, String fullname, String password, String avatar, int roleid, String phone, Date createdate) throws Exception {
        String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
        UserModel u = new UserModel(email, username, fullname, hashed, avatar, roleid, phone, createdate);
        int id = userDAO.insert(u);
        return id > 0;
    }

    @Override
    public boolean checkExistEmail(String email) throws Exception {
        return userDAO.findByEmail(email) != null;
    }

    @Override
    public boolean checkExistUsername(String username) throws Exception {
        return userDAO.findByUsername(username) != null;
    }

    @Override
    public boolean checkExistPhone(String phone) throws Exception {
        List<UserModel> all = userDAO.findAll();
        for (UserModel u : all) {
            if (phone != null && phone.equals(u.getPhone())) return true;
        }
        return false;
    }

    @Override
    public UserModel findById(int id) throws Exception {
        return userDAO.findById(id);
    }

    @Override
    public UserModel findByUsername(String username) throws Exception {
        return userDAO.findByUsername(username);
    }

    @Override
    public UserModel findByEmail(String email) throws Exception {
        return userDAO.findByEmail(email);
    }

    @Override
    public List<UserModel> findAll() throws Exception {
        return userDAO.findAll();
    }

    @Override
    public int save(UserModel user) throws Exception {
        // if password present, hash it
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            user.setPassword(hashed);
        }
        return userDAO.insert(user);
    }

    @Override
    public boolean update(UserModel user) throws Exception {
        // if password present and not hashed, hash it. We can't detect hashed, assume provided raw -> hash
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            user.setPassword(hashed);
        }
        return userDAO.update(user);
    }

    @Override
    public boolean delete(int id) throws Exception {
        return userDAO.delete(id);
    }
}