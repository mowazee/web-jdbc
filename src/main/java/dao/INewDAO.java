package dao;
import java.util.List;
import model.NewModel;

public interface INewDAO {
    NewModel findById(int id) throws Exception;
    List<NewModel> findAll() throws Exception;
    int insert(NewModel news) throws Exception;
    boolean update(NewModel news) throws Exception;
    boolean delete(int id) throws Exception;
    List<NewModel> findTopViewed(int limit) throws Exception; // new
}