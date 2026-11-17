package connection;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionFactory {

    public static Connection getConnection() throws SQLException {

        String urlEnv = System.getenv("DB_URL");
        String userEnv = System.getenv("DB_USER");
        String passwordEnv = System.getenv("DB_PASSWORD");

        String url;
        String user;
        String password;

        boolean usandoAmbiente =
                urlEnv != null ||
                userEnv != null ||
                passwordEnv != null;

        if (usandoAmbiente) {

            if (urlEnv == null || urlEnv.isBlank()
                    || userEnv == null || userEnv.isBlank()
                    || passwordEnv == null || passwordEnv.isBlank()) {

                throw new SQLException(
                        "Configure DB_URL, DB_USER e DB_PASSWORD."
                );
            }

            url = urlEnv;
            user = userEnv;
            password = passwordEnv;

        } else {

            Properties config = new Properties();

            try (FileInputStream in =
                         new FileInputStream("config.properties")) {

                config.load(in);

            } catch (IOException e) {

                throw new SQLException(
                        "Não foi possível ler o config.properties.",
                        e
                );
            }

            url = config.getProperty("db.url");
            user = config.getProperty("db.user");
            password = config.getProperty("db.password");

            if (url == null || url.isBlank()
                    || user == null || user.isBlank()
                    || password == null || password.isBlank()) {

                throw new SQLException(
                        "Verifique as propriedades de conexão do Oracle."
                );
            }
        }

        return DriverManager.getConnection(url, user, password);
    }
}