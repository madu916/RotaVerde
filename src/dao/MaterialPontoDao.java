package dao;

import connection.ConnectionFactory;
import model.MaterialPonto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MaterialPontoDao {
    public void salvar(MaterialPonto materialPonto) {
        String sql = "INSERT INTO material_ponto (material_id, ponto_id) " +
                " VALUES (?, ?) ";

        try (

                Connection conn = ConnectionFactory.getConnection(); //conecta com oracle
                PreparedStatement stmt = conn.prepareStatement(sql)
                ){
            stmt.setInt(1, materialPonto.getMaterialId());
            stmt.setInt(2, materialPonto.getPontoId());

            stmt.executeUpdate();

            System.out.println("Relacionamento cadastrado com sucesso!");

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
    public List<MaterialPonto> listar() {

        List<MaterialPonto> relacionamentos = new ArrayList<>();

        String sql = "SELECT * FROM MATERIAL_PONTO";

        try (
                Connection conn = ConnectionFactory.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()

                ){
            while (rs.next()){
                MaterialPonto materialPonto = new MaterialPonto();

                materialPonto.setMaterialId(rs.getInt("MATERIAL_ID"));
                materialPonto.setPontoId(rs.getInt("PONTO_ID"));

                relacionamentos.add(materialPonto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return relacionamentos;
    }
    public void excluir(int materialId, int pontoId) {
        String sql = "DELETE FROM MATERIAL_PONTO " +
                "WHERE MATERIAL_ID = ? " +
                "AND PONTO_ID = ?";

        try (

                Connection conn = ConnectionFactory.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);

                ){
            stmt.setInt(1, materialId);
            stmt.setInt(2, pontoId);

            int linhasAfetadas = stmt.executeUpdate();

            System.out.println("Linhas afetadas: " + linhasAfetadas);
        } catch (SQLException e){
            e.printStackTrace();
        }
    }

}
