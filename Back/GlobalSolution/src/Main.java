import com.google.gson.Gson;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpServer;
import dao.CategoriaDao;
import dao.MaterialDao;
import dao.MaterialPontoDao;
import dao.PontoColetaDao;
import exception.ErroBancoException;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.function.Supplier;

public class Main {

    public static void main(String[] args) throws Exception {

        String portaConfig = System.getenv("PORT");

        int port = (portaConfig == null || portaConfig.isBlank())
                ? 8080
                : Integer.parseInt(portaConfig);

        HttpServer server = HttpServer.create(
                new InetSocketAddress("0.0.0.0", port),
                0
        );

        // Verificação de saúde do servidor
        server.createContext("/health", exchange -> {

            byte[] resposta = "OK".getBytes(StandardCharsets.UTF_8);

            exchange.getResponseHeaders().set(
                    "Content-Type",
                    "text/plain; charset=utf-8"
            );

            exchange.sendResponseHeaders(200, resposta.length);

            try (var os = exchange.getResponseBody()) {
                os.write(resposta);
            }
        });

        // Categorias
        server.createContext("/api/categorias", exchange ->
                responder(exchange, () -> new CategoriaDao().listar())
        );

        // Pontos de coleta
        server.createContext("/api/pontocoleta", exchange ->
                responder(exchange, () -> new PontoColetaDao().listar())
        );

        // Materiais
        server.createContext("/api/material", exchange ->
                responder(exchange, () -> new MaterialDao().listar())
        );

        // Relacionamento entre materiais e pontos
        server.createContext("/api/materialponto", exchange ->
                responder(exchange, () -> new MaterialPontoDao().listar())
        );

        // Busca de pontos
        server.createContext("/api/busca", exchange -> {

            String query = exchange.getRequestURI().getQuery();

            String cidade = getParametro(query, "cidade");
            String estado = getParametro(query, "estado");
            String material = getParametro(query, "material");

            responder(
                    exchange,
                    () -> new PontoColetaDao().buscar(
                            cidade,
                            estado,
                            material
                    )
            );
        });

        server.start();

        System.out.println(
                "Servidor RotaVerde iniciado na porta " + port
        );
    }

    private static void enviarJson(
            HttpExchange exchange,
            int status,
            Object dados
    ) throws IOException {

        String json = new Gson().toJson(dados);
        byte[] resposta = json.getBytes(StandardCharsets.UTF_8);

        exchange.getResponseHeaders().set(
                "Content-Type",
                "application/json; charset=utf-8"
        );

        exchange.getResponseHeaders().set(
                "Access-Control-Allow-Origin",
                "*"
        );

        exchange.getResponseHeaders().set(
                "Access-Control-Allow-Methods",
                "GET, POST, PUT, DELETE, OPTIONS"
        );

        exchange.getResponseHeaders().set(
                "Access-Control-Allow-Headers",
                "Content-Type"
        );

        exchange.sendResponseHeaders(status, resposta.length);

        try (var os = exchange.getResponseBody()) {
            os.write(resposta);
        }
    }

    private static void enviarJson(
            HttpExchange exchange,
            Object dados
    ) throws IOException {

        enviarJson(exchange, 200, dados);
    }

    private static void responder(
            HttpExchange exchange,
            Supplier<Object> acao
    ) throws IOException {

        if ("OPTIONS".equalsIgnoreCase(
                exchange.getRequestMethod()
        )) {

            exchange.getResponseHeaders().set(
                    "Access-Control-Allow-Origin",
                    "*"
            );

            exchange.getResponseHeaders().set(
                    "Access-Control-Allow-Methods",
                    "GET, POST, PUT, DELETE, OPTIONS"
            );

            exchange.getResponseHeaders().set(
                    "Access-Control-Allow-Headers",
                    "Content-Type"
            );

            exchange.sendResponseHeaders(204, -1);
            exchange.close();
            return;
        }

        if (!"GET".equalsIgnoreCase(
                exchange.getRequestMethod()
        )) {

            enviarJson(
                    exchange,
                    405,
                    Map.of("erro", "Método não permitido")
            );

            return;
        }

        try {

            enviarJson(exchange, 200, acao.get());

        } catch (ErroBancoException e) {

            e.printStackTrace();

            enviarJson(
                    exchange,
                    500,
                    Map.of("erro", "Erro ao acessar o banco de dados.")
            );

        } catch (Exception e) {

            e.printStackTrace();

            enviarJson(
                    exchange,
                    500,
                    Map.of("erro", "Erro interno do servidor.")
            );
        }
    }

    private static String getParametro(
            String query,
            String nome
    ) {

        if (query == null) {
            return null;
        }

        for (String param : query.split("&")) {

            String[] partes = param.split("=", 2);

            if (partes.length == 2 &&
                    partes[0].equals(nome)) {

                return URLDecoder.decode(
                        partes[1],
                        StandardCharsets.UTF_8
                );
            }
        }

        return null;
    }
}