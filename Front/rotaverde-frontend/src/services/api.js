// Cliente da API do backend (GlobalSolution - Main.java, porta 8080).
// Endpoints disponíveis (todos GET):
//   /api/categorias    -> [{ id, nome, descricao }]
//   /api/material      -> [{ id, nome, descricao, instrucaoDescarte, categoriaId }]
//   /api/pontocoleta   -> [{ id, nome, logradouro, numero, bairro, cidade, estado, cep, telefone }]
//   /api/materialponto -> [{ materialId, pontoId }]
//   /api/busca?cidade=&estado=&material=  -> pontos (os 3 parâmetros são obrigatórios;
//                                            "material" é o NOME exato do material)
const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:8080';

async function get(caminho, params) {
  const query = params ? `?${new URLSearchParams(params).toString()}` : '';

  let resposta;
  try {
    resposta = await fetch(`${API_URL}${caminho}${query}`);
  } catch (e) {
    throw new Error(
      `Não foi possível conectar ao servidor (${API_URL}). Verifique se o backend está rodando.`
    );
  }

  let corpo = null;
  try {
    corpo = await resposta.json();
  } catch (e) {
    // resposta sem JSON
  }

  if (!resposta.ok) {
    throw new Error((corpo && corpo.erro) || `Erro ${resposta.status} ao consultar o servidor.`);
  }
  return corpo;
}

export const listarCategorias = () => get('/api/categorias');
export const listarMateriais = () => get('/api/material');
export const listarPontos = () => get('/api/pontocoleta');
export const listarMaterialPonto = () => get('/api/materialponto');
export const buscarPontos = ({ cidade, estado, material }) =>
  get('/api/busca', { cidade, estado, material });
