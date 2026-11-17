package service;

import dao.PontoColetaDao;
import model.PontoColeta;

import java.util.List;

public class PontoColetaService {

    private PontoColetaDao dao =
            new PontoColetaDao();

    public void salvar(PontoColeta pontoColeta){
        dao.salvar(pontoColeta);
    }

    public List<PontoColeta> listar(){
        return dao.listar();
    }

    public void atualizar(PontoColeta pontoColeta){
        dao.atualizar(pontoColeta);
    }

    public void excluir(int id){
        dao.excluir(id);
    }
}