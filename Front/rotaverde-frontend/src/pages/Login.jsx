import React, { useState } from 'react';
import Logo from '../assets/Logo';
import './Auth.css';

export default function Login({ onLogin, irParaCadastro }) {
  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');
  const [erro, setErro] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    const mensagem = onLogin(email, senha);
    setErro(mensagem || '');
  };

  return (
    <div className="auth-container">
      <div className="auth-card">
        <div className="auth-logo">
          <Logo />
        </div>
        <h2>Acesse sua Conta</h2>
        <p className="auth-sub">Faça login para cadastrar novos pontos de coleta no RotaVerde.</p>

        {erro && <div className="alert-error">{erro}</div>}

        <form onSubmit={handleSubmit} className="auth-form">
          <div className="form-group">
            <label>E-mail</label>
            <input
              type="email"
              placeholder="seuemail@exemplo.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>

          <div className="form-group">
            <label>Senha</label>
            <input
              type="password"
              placeholder="Digite sua senha"
              value={senha}
              onChange={(e) => setSenha(e.target.value)}
              required
            />
          </div>

          <button type="submit" className="btn-auth-submit">
            Login
          </button>
        </form>

        <div className="auth-footer">
          <span>Ainda não tem conta?</span>
          <button className="btn-link-auth" onClick={irParaCadastro}>
            Criar conta
          </button>
        </div>

        <p className="auth-aviso">
          Contas ficam salvas apenas neste navegador (o backend ainda não possui usuários).
        </p>
      </div>
    </div>
  );
}
