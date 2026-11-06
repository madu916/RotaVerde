import connection.ConnectionFactory;
import dao.CategoriaDao;
import model.Categoria;

import java.sql.Connection;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        /*Categoria categoria = new Categoria();

        categoria.setNome("Eletrônicos");
        categoria.setDescricao("Resíduos eletrônicos");

        System.out.println(categoria.getNome());
        System.out.println(categoria.getDescricao());

        CategoriaDao dao = new CategoriaDao();

        dao.salvar(categoria);*/

        /*CategoriaDao dao = new CategoriaDao();

        for (Categoria categoria : dao.listar()) {
            System.out.println(categoria);
        }*/

        Categoria categoria = new Categoria();
        categoria.setId(1);
        categoria.setNome("Categoria");
        categoria.setDescricao("Lixo eletrônico e componentes");

        CategoriaDao dao = new CategoriaDao();

        dao.atualizar(categoria);


    }
}
