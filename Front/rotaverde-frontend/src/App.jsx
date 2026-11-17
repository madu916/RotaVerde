import React, { useCallback, useEffect, useMemo, useState } from 'react';
import Navbar from './components/Navbar';
import Home from './pages/Home';
import Pesquisa from './pages/Pesquisa';
import Login from './pages/Login';
import CadastroConta from './pages/CadastroConta';
import CadastrarPonto from './pages/CadastrarPonto';
import {
  listarCategorias,
  listarMateriais,
  listarPontos,
  listarMaterialPonto,
} from './services/api';
import {
  lerContas,
  gravarContas,
  lerUsuario,
  gravarUsuario,
  lerPontosLocais,
  gravarPontosLocais,
} from './services/storage';

function App() {
  // 'home' | 'pesquisa' | 'login' | 'cadastro-conta' | 'cadastrar-ponto'
  const [telaAtual, setTelaAtual] = useState('home');
  const [usuarioLogado, setUsuarioLogado] = useState(lerUsuario);
  const [pontosLocais, setPontosLocais] = useState(lerPontosLocais);

  const [catalogo, setCatalogo] = useState({
    categorias: [],
    materiais: [],
    pontos: [],
    materialPontos: [],
  });
  const [carregando, setCarregando] = useState(true);
  const [erro, setErro] = useState('');

  const carregar = useCallback(async () => {
    setCarregando(true);
    setErro('');
    try {
      const [categorias, materiais, pontos, materialPontos] = await Promise.all([
        listarCategorias(),
        listarMateriais(),
        listarPontos(),
        listarMaterialPonto(),
      ]);
      setCatalogo({ categorias, materiais, pontos, materialPontos });
    } catch (e) {
      setErro(e.message);
    } finally {
      setCarregando(false);
    }
  }, []);

  useEffect(() => {
    carregar();
  }, [carregar]);

  // Une os dados do backend com os pontos cadastrados neste navegador
  const pontosTodos = useMemo(
    () => [...catalogo.pontos, ...pontosLocais.map(({ materialIds, ...p }) => ({ ...p, local: true }))],
    [catalogo.pontos, pontosLocais]
  );
  const materialPontosTodos = useMemo(
    () => [
      ...catalogo.materialPontos,
      ...pontosLocais.flatMap((p) => p.materialIds.map((materialId) => ({ materialId, pontoId: p.id }))),
    ],
    [catalogo.materialPontos, pontosLocais]
  );

  // Cadastrar ponto exige login
  const irParaCadastrarPonto = () => setTelaAtual(usuarioLogado ? 'cadastrar-ponto' : 'login');

  const handleCadastrarConta = ({ email, telefone, senha }) => {
    const contas = lerContas();
    const emailNormalizado = email.trim().toLowerCase();
    if (contas.some((c) => c.email === emailNormalizado)) {
      return 'Já existe uma conta com este e-mail.';
    }
    gravarContas([...contas, { email: emailNormalizado, telefone, senha }]);
    return '';
  };

  const handleLogin = (email, senha) => {
    const emailNormalizado = email.trim().toLowerCase();
    const conta = lerContas().find((c) => c.email === emailNormalizado && c.senha === senha);
    if (!conta) return 'E-mail ou senha incorretos. Se ainda não tem conta, clique em "Criar conta".';
    const usuario = { email: conta.email };
    setUsuarioLogado(usuario);
    gravarUsuario(usuario);
    setTelaAtual('cadastrar-ponto');
    return '';
  };

  const handleLogout = () => {
    setUsuarioLogado(null);
    gravarUsuario(null);
    setTelaAtual('home');
  };

  const handleAdicionarPonto = (novoPonto) => {
    const lista = [...pontosLocais, { ...novoPonto, id: Date.now() }];
    setPontosLocais(lista);
    gravarPontosLocais(lista);
  };

  return (
    <div className="app-wrapper">
      <Navbar
        telaAtual={telaAtual}
        setTelaAtual={setTelaAtual}
        usuarioLogado={usuarioLogado}
        onLogout={handleLogout}
        irParaCadastrarPonto={irParaCadastrarPonto}
      />

      <main>
        {telaAtual === 'home' && (
          <Home
            irParaPesquisa={() => setTelaAtual('pesquisa')}
            irParaCadastrarPonto={irParaCadastrarPonto}
          />
        )}

        {telaAtual === 'pesquisa' && (
          <Pesquisa
            categorias={catalogo.categorias}
            materiais={catalogo.materiais}
            pontos={pontosTodos}
            materialPontos={materialPontosTodos}
            carregando={carregando}
            erro={erro}
            onTentarNovamente={carregar}
            irParaCadastrarPonto={irParaCadastrarPonto}
          />
        )}

        {telaAtual === 'login' && (
          <Login onLogin={handleLogin} irParaCadastro={() => setTelaAtual('cadastro-conta')} />
        )}

        {telaAtual === 'cadastro-conta' && (
          <CadastroConta
            onCadastrar={handleCadastrarConta}
            irParaLogin={() => setTelaAtual('login')}
          />
        )}

        {telaAtual === 'cadastrar-ponto' && (
          <CadastrarPonto
            categorias={catalogo.categorias}
            materiais={catalogo.materiais}
            onSalvarPonto={handleAdicionarPonto}
            irParaPesquisa={() => setTelaAtual('pesquisa')}
          />
        )}
      </main>
    </div>
  );
}

export default App;
