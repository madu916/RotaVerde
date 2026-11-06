package dao;
import connection.ConnectionFactory;
import model.Categoria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDao {
    public void salvar(Categoria categoria){
        String sql = "INSERT INTO CATEGORIA " +   //recebe o objeto que será gravado no banco
                "(ID, NOME, DESCRICAO) " +
                "VALUES " +
                "(SEQ_CATEGORIA.NEXTVAL, ?, ?)";
        try (
                Connection conn = ConnectionFactory.getConnection(); //conecta com oracle
                PreparedStatement stmt = conn.prepareStatement(sql)
        ){

            stmt.setString(1, categoria.getNome());
            stmt.setString(2, categoria.getDescricao());
            stmt.executeUpdate(); // Update para INSERT

        } catch (SQLException e){  //caso algo dê errado
            e.printStackTrace();
        }
    }

    public List<Categoria> listar(){
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT * FROM CATEGORIA";

        try (
                Connection conn = ConnectionFactory.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery() //Query para SELECT
        ){

            while (rs.next()){
                Categoria categoria = new Categoria();
                categoria.setId(rs.getInt("ID"));
                categoria.setNome(rs.getString("NOME"));
                categoria.setDescricao(rs.getString("DESCRICAO"));

                categorias.add(categoria);
            }

        }   catch (SQLException e){
            e.printStackTrace();
        }
        return categorias;
    }
}
