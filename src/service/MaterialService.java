package service;

import dao.MaterialDao;
import model.Material;

import java.util.List;

public class MaterialService {

    private MaterialDao dao =
            new MaterialDao();

    public void salvar(Material material){
        dao.salvar(material);
    }

    public List<Material> listar(){
        return dao.listar();
    }

    public void atualizar(Material material){
        dao.atualizar(material);
    }

    public void excluir(int id){
        dao.excluir(id);
    }
}