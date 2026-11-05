import connection.ConnectionFactory;
import java.sql.Connection;

public class Main {

    public static void main(String[] args) {

        try {

            Connection conn = ConnectionFactory.getConnection();

            System.out.println("Conectado ao Oracle com sucesso!");

            conn.close();

        } catch (Exception e) {

            System.out.println("Erro ao conectar:");
            e.printStackTrace();

        }
    }
}
