// Persistência local (navegador). O backend atual é somente leitura e não tem
// usuários, então contas, sessão e pontos cadastrados ficam no localStorage.
const CHAVES = {
  contas: 'rotaverde_contas',
  usuario: 'rotaverde_usuario',
  pontos: 'rotaverde_pontos_locais',
};

function ler(chave, padrao) {
  try {
    const bruto = window.localStorage.getItem(chave);
    return bruto ? JSON.parse(bruto) : padrao;
  } catch (e) {
    return padrao;
  }
}

function gravar(chave, valor) {
  try {
    window.localStorage.setItem(chave, JSON.stringify(valor));
  } catch (e) {
    // armazenamento indisponível: segue só em memória
  }
}

export const lerContas = () => ler(CHAVES.contas, []);
export const gravarContas = (contas) => gravar(CHAVES.contas, contas);
export const lerUsuario = () => ler(CHAVES.usuario, null);
export const gravarUsuario = (usuario) =>
  usuario ? gravar(CHAVES.usuario, usuario) : window.localStorage.removeItem(CHAVES.usuario);
export const lerPontosLocais = () => ler(CHAVES.pontos, []);
export const gravarPontosLocais = (pontos) => gravar(CHAVES.pontos, pontos);
