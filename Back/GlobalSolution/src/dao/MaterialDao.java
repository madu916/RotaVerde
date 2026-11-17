package dao;

import connection.ConnectionFactory;
import exception.ErroBancoException;
import model.Material;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MaterialDao {
    public void salvar(Material material) {
        String sql = "INSERT INTO MATERIAL " +
                "(ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID) " +
                "VALUES "+
                "(SEQ_MATERIAL.NEXTVAL, ?, ?, ?, ?)";

        try (
                Connection conn = ConnectionFactory.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
                ){
            stmt.setString(1, material.getNome());
            stmt.setString(2, material.getDescricao());
            stmt.setString(3, material.getInstrucaoDescarte());
            stmt.setInt(4, material.getCategoriaId());

            stmt.executeUpdate();

            System.out.println("Material cadastrado com sucesso!");

        } catch (SQLException e){
            throw new ErroBancoException("Erro ao salvar materiais", e);
        }
    }
    public List<Material> listar() {
        List<Material> materiais = new ArrayList<>();
        String sql = "SELECT * FROM MATERIAL";

        try (
                Connection conn = ConnectionFactory.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);

                ResultSet rs = stmt.executeQuery()
                ){
            while (rs.next()){
                Material material = new Material();
                material.setId(rs.getInt("ID"));
                material.setNome(rs.getString("NOME"));
                material.setDescricao(rs.getString("DESCRICAO"));
                material.setInstrucaoDescarte(rs.getString("INSTRUCAO_DESCARTE"));
                material.setCategoriaId(rs.getInt("CATEGORIA_ID"));
                materiais.add(material);
            }
        } catch (SQLException e){
            throw new ErroBancoException("Erro ao listar materiais", e);
        }
        return materiais;
    }
    public void atualizar(Material material) {
        String sql = "UPDATE MATERIAL " +
                "SET NOME = ?, DESCRICAO = ?, INSTRUCAO_DESCARTE = ?, CATEGORIA_ID = ? " +
                "WHERE ID = ?";
        try (
                Connection conn = ConnectionFactory.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);

                ){
            stmt.setString(1, material.getNome());
            stmt.setString(2, material.getDescricao());
            stmt.setString(3, material.getInstrucaoDescarte());
            stmt.setInt(4, material.getCategoriaId());
            stmt.setInt(5, material.getId());

            int linhasAfetadas = stmt.executeUpdate();
            System.out.println("Linhas afetadas: " + linhasAfetadas);

        } catch (Exception e) {
            throw new ErroBancoException("Erro ao atualizar materiais", e);
        }
    }
    public void excluir(int id) {
        String sql = "DELETE FROM MATERIAL " +
                "WHERE ID = ?";

        try (
                Connection conn = ConnectionFactory.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);

                ){
            stmt.setInt(1, id);
            int linhasAfetadas = stmt.executeUpdate();

            System.out.println("Linhas afetadas: " + linhasAfetadas);

        } catch (Exception e) {
            throw new ErroBancoException("Erro ao excluir materiais", e);
        }
    }
}
