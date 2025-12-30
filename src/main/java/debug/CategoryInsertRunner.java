package debug;

import dao.impl.CategoryDAOImpl;
import model.CategoryModel;

public class CategoryInsertRunner {
    public static void main(String[] args) throws Exception {
        System.out.println("[Runner] Starting CategoryInsertRunner...");
        CategoryDAOImpl dao = new CategoryDAOImpl();
        CategoryModel m = new CategoryModel();
        m.setCatename("TEST_INSERT_FROM_RUNNER_");
        m.setIcon("runner-test.jpg");
        int id = dao.insert(m);
        System.out.println("[Runner] insert returned id=" + id);
    }
}
