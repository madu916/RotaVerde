package dao;

import connection.ConnectionFactory;
import exception.ErroBancoException;
import model.PontoColeta;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PontoColetaDao {
    public void salvar(PontoColeta pontoColeta) {
        String sql = "INSERT INTO PONTO_COLETA " +
                "(ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE) " +
                "VALUES " +
                "(SEQ_PONTO_COLETA.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (
                Connection conn = ConnectionFactory.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);

                ){
            stmt.setString(1,pontoColeta.getNome());
            stmt.setString(2, pontoColeta.getLogradouro());
            stmt.setString(3, pontoColeta.getNumero());
            stmt.setString(4, pontoColeta.getBairro());
            stmt.setString(5, pontoColeta.getCidade());
            stmt.setString(6, pontoColeta.getEstado());
            stmt.setString(7, pontoColeta.getCep());
            stmt.setString(8, pontoColeta.getTelefone());

            stmt.executeUpdate();
            System.out.println("Ponto de coleta cadastrado com sucesso!");

        } catch (SQLException e) {
            throw new ErroBancoException("Erro ao salvar PontoColeta", e);
        }
    }
    public List<PontoColeta> listar() {
        List<PontoColeta> pontoColetas = new ArrayList<>();

        String sql = "SELECT * FROM PONTO_COLETA";

        try (
                Connection conn = ConnectionFactory.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()
        ){
            while (rs.next()){
                PontoColeta pontoColeta = new PontoColeta();

                pontoColeta.setId(rs.getInt("ID"));
                pontoColeta.setNome(rs.getString("NOME"));
                pontoColeta.setLogradouro(rs.getString("LOGRADOURO"));
                pontoColeta.setNumero(rs.getString("NUMERO"));
                pontoColeta.setBairro(rs.getString("BAIRRO"));
                pontoColeta.setCidade(rs.getString("CIDADE"));
                pontoColeta.setEstado(rs.getString("ESTADO"));
                pontoColeta.setCep(rs.getString("CEP"));
                pontoColeta.setTelefone(rs.getString("TELEFONE"));

                pontoColetas.add(pontoColeta);
            }
        } catch (SQLException e) {
            throw new ErroBancoException("Erro ao listar PontoColeta", e);
        }
        return pontoColetas;

    }
    public List<PontoColeta> buscar(
            String cidade,
            String estado,
            String material
    ) {

        List<PontoColeta> pontos = new ArrayList<>();

        String sql =
                "SELECT DISTINCT p.* " +
                        "FROM PONTO_COLETA p " +
                        "JOIN MATERIAL_PONTO mp ON mp.PONTO_ID = p.ID " +
                        "JOIN MATERIAL m ON m.ID = mp.MATERIAL_ID " +
                        "WHERE UPPER(p.CIDADE) = UPPER(?) " +
                        "AND UPPER(p.ESTADO) = UPPER(?) " +
                        "AND UPPER(m.NOME) = UPPER(?)";

        try (
                Connection conn = ConnectionFactory.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, cidade);
            stmt.setString(2, estado);
            stmt.setString(3, material);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                PontoColeta ponto = new PontoColeta();

                ponto.setId(rs.getInt("ID"));
                ponto.setNome(rs.getString("NOME"));
                ponto.setLogradouro(rs.getString("LOGRADOURO"));
                ponto.setNumero(rs.getString("NUMERO"));
                ponto.setBairro(rs.getString("BAIRRO"));
                ponto.setCidade(rs.getString("CIDADE"));
                ponto.setEstado(rs.getString("ESTADO"));
                ponto.setCep(rs.getString("CEP"));
                ponto.setTelefone(rs.getString("TELEFONE"));

                pontos.add(ponto);
            }

        } catch (SQLException e) {
            throw new ErroBancoException(
                    "Erro ao buscar pontos de coleta",
                    e
            );
        }

        return pontos;
    }
    public void atualizar(PontoColeta pontoColeta) {
        String sql = "UPDATE PONTO_COLETA " +
                "SET NOME = ?, " +
                "LOGRADOURO = ?, " +
                "NUMERO = ?, " +
                "BAIRRO = ?, " +
                "CIDADE = ?, " +
                "ESTADO = ?, " +
                "CEP = ?, " +
                "TELEFONE = ? " +
                "WHERE ID = ?";
        try (
                Connection conn = ConnectionFactory.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ){
            stmt.setString(1,pontoColeta.getNome());
            stmt.setString(2, pontoColeta.getLogradouro());
            stmt.setString(3, pontoColeta.getNumero());
            stmt.setString(4, pontoColeta.getBairro());
            stmt.setString(5, pontoColeta.getCidade());
            stmt.setString(6, pontoColeta.getEstado());
            stmt.setString(7, pontoColeta.getCep());
            stmt.setString(8, pontoColeta.getTelefone());
            stmt.setInt(9, pontoColeta.getId());

            int linhasAfetadas = stmt.executeUpdate();

            System.out.println("Linhas afetadas: " + linhasAfetadas);

        } catch (SQLException e) {
            throw new ErroBancoException("Erro ao atualizar PontoColeta", e);
        }
    }
    public void excluir(int id) {
        String sql = "DELETE FROM PONTO_COLETA " +
                "WHERE ID = ?";
        try (
                Connection conn = ConnectionFactory.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
        ){
            stmt.setInt(1, id);
            int linhasAfetadas = stmt.executeUpdate();

            System.out.println("Linhas afetadas: " + linhasAfetadas);

    } catch (SQLException e) {
            throw new ErroBancoException("Erro ao excluir PontoColeta", e);
        }
    }
}
