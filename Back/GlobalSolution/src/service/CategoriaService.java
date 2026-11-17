package service;

import dao.CategoriaDao;
import model.Categoria;

import java.util.List;

public class CategoriaService {

    private CategoriaDao dao =
            new CategoriaDao();

    public void salvar(Categoria categoria){
        dao.salvar(categoria);
    }

    public List<Categoria> listar(){
        return dao.listar();
    }

    public void atualizar(Categoria categoria){
        dao.atualizar(categoria);
    }

    public void excluir(int id){
        dao.excluir(id);
    }
}