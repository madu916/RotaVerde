
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
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.function.Supplier;

import java.net.URLDecoder;


public class Main {
    public static void main(String[] args) throws Exception {
        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0); //cria um servidor na porta 8080

        server.createContext("/api/categorias", exchange ->
                responder(exchange, () -> new CategoriaDao().listar())
        );

        server.createContext("/api/pontocoleta", exchange ->
                responder(exchange, () -> new PontoColetaDao().listar())
        );

        server.createContext("/api/material", exchange ->
                responder(exchange, () -> new MaterialDao().listar())
        );

        server.createContext("/api/materialponto", exchange ->
                responder(exchange, () -> new MaterialPontoDao().listar())
        );

        server.createContext(
                "/api/busca",
                exchange -> {

                    String query =
                            exchange.getRequestURI().getQuery();

                    String cidade =
                            getParametro(query, "cidade");

                    String estado =
                            getParametro(query, "estado");

                    String material =
                            getParametro(query, "material");

                    responder(
                            exchange,
                            () -> new PontoColetaDao()
                                    .buscar(
                                            cidade,
                                            estado,
                                            material
                                    )
                    );
                }
        );

        server.start();
        System.out.println("Servidor em http://localhost:8080");

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

        exchange.sendResponseHeaders(
                status,
                resposta.length
        );

        try (var os = exchange.getResponseBody()) {
            os.write(resposta);
        }
    }
    private static void enviarJson(HttpExchange exchange, Object dados) throws IOException {
        enviarJson(exchange, 200, dados);
    }

    private static void responder(
            HttpExchange exchange,
            Supplier<Object> acao
    ) throws IOException {

        if ("OPTIONS".equalsIgnoreCase(
                exchange.getRequestMethod()
        )) {

            exchange.getResponseHeaders()
                    .add("Access-Control-Allow-Origin", "*");

            exchange.getResponseHeaders()
                    .add("Access-Control-Allow-Methods",
                            "GET, POST, PUT, DELETE, OPTIONS");

            exchange.getResponseHeaders()
                    .add("Access-Control-Allow-Headers",
                            "Content-Type");

            exchange.sendResponseHeaders(204, -1);
            return;
        }

        if (!"GET".equalsIgnoreCase(
                exchange.getRequestMethod()
        )) {

            enviarJson(
                    exchange,
                    405,
                    Map.of(
                            "erro",
                            "Método não permitido"
                    )
            );

            return;
        }

        try {

            enviarJson(
                    exchange,
                    200,
                    acao.get()
            );

        } catch (ErroBancoException e) {

            e.printStackTrace();

            enviarJson(
                    exchange,
                    500,
                    Map.of(
                            "erro",
                            "Erro ao acessar o banco de dados."
                    )
            );

        } catch (Exception e) {

            e.printStackTrace();

            enviarJson(
                    exchange,
                    500,
                    Map.of(
                            "erro",
                            "Erro interno do servidor."
                    )
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

            String[] partes = param.split("=");

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


