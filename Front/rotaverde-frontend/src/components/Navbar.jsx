import React from 'react';
import Logo from '../assets/Logo';
import './Navbar.css';

export default function Navbar({
  telaAtual,
  setTelaAtual,
  usuarioLogado,
  onLogout,
  irParaCadastrarPonto,
}) {
  return (
    <header className="navbar">
      <div className="container navbar-content">
        <div className="navbar-brand" onClick={() => setTelaAtual('home')}>
          <Logo />
        </div>

        <nav className="navbar-links">
          <button
            className={`nav-link ${telaAtual === 'home' ? 'active' : ''}`}
            onClick={() => setTelaAtual('home')}
          >
            Sobre e Como Funciona
          </button>
          <button
            className={`nav-link ${telaAtual === 'pesquisa' ? 'active' : ''}`}
            onClick={() => setTelaAtual('pesquisa')}
          >
            Categorias e Pesquisa
          </button>

          {usuarioLogado ? (
            <div className="user-menu">
              <span className="user-badge">{usuarioLogado.email}</span>
              <button className="btn-logout" onClick={onLogout}>
                Sair
              </button>
            </div>
          ) : (
            <button
              className={`nav-link ${
                telaAtual === 'login' || telaAtual === 'cadastro-conta' ? 'active' : ''
              }`}
              onClick={() => setTelaAtual('login')}
            >
              Entrar / Criar Conta
            </button>
          )}

          <button className="btn-add-ponto" onClick={irParaCadastrarPonto}>
            + Adicionar Novo Ponto
          </button>
        </nav>
      </div>
    </header>
  );
}
