
import com.google.gson.Gson;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpServer;
import dao.CategoriaDao;
import dao.MaterialDao;
import dao.MaterialPontoDao;
import dao.PontoColetaDao;


import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;


public class Main {
    public static void main(String[] args) throws Exception {
        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0); //cria um servidor na porta 8080

        server.createContext("/api/categorias", exchange ->
                enviarJson(exchange, new CategoriaDao().listar())
        );

        server.createContext("/api/pontocoleta", exchange ->
                enviarJson(exchange, new PontoColetaDao().listar())
        );

        server.createContext("/api/material", exchange ->
                enviarJson(exchange, new MaterialDao().listar())
        );

        server.createContext("/api/materialponto", exchange ->
                enviarJson(exchange, new MaterialPontoDao().listar())
        );

        server.start();
        System.out.println("Servidor em http://localhost:8080");

    }
    private static void enviarJson(HttpExchange exchange, Object dados) throws IOException {
        String json = new Gson().toJson(dados);
        byte[] resposta = json.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().add("Content-Type", "application/json; charset=utf-8");
        exchange.getResponseHeaders().add("Access-Control-Allow-Origin", "*");
        exchange.sendResponseHeaders(200, resposta.length);
        try (var os = exchange.getResponseBody()) {
            os.write(resposta);
        }
    }




}


