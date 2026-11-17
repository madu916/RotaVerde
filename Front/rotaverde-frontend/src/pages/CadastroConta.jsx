import React, { useState } from 'react';
import Logo from '../assets/Logo';
import './Auth.css';

export default function CadastroConta({ onCadastrar, irParaLogin }) {
  const [email, setEmail] = useState('');
  const [telefone, setTelefone] = useState('');
  const [senha, setSenha] = useState('');
  const [confirmarSenha, setConfirmarSenha] = useState('');
  const [erro, setErro] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    if (senha.length < 6) {
      setErro('A senha deve ter pelo menos 6 caracteres.');
      return;
    }
    if (senha !== confirmarSenha) {
      setErro('As senhas não coincidem.');
      return;
    }
    const mensagem = onCadastrar({ email, telefone, senha });
    if (mensagem) {
      setErro(mensagem);
      return;
    }
    setErro('');
    irParaLogin();
  };

  return (
    <div className="auth-container">
      <div className="auth-card">
        <div className="auth-logo">
          <Logo />
        </div>
        <h2>Criar Nova Conta</h2>
        <p className="auth-sub">Preencha seus dados para colaborar com o mapeamento.</p>

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
            <label>Número de Telefone</label>
            <input
              type="tel"
              placeholder="(11) 99999-9999"
              value={telefone}
              onChange={(e) => setTelefone(e.target.value)}
              required
            />
          </div>

          <div className="form-group">
            <label>Senha</label>
            <input
              type="password"
              placeholder="Crie uma senha (mín. 6 caracteres)"
              value={senha}
              onChange={(e) => setSenha(e.target.value)}
              required
            />
          </div>

          <div className="form-group">
            <label>Confirmar Senha</label>
            <input
              type="password"
              placeholder="Repita a senha"
              value={confirmarSenha}
              onChange={(e) => setConfirmarSenha(e.target.value)}
              required
            />
          </div>

          <button type="submit" className="btn-auth-submit green">
            Confirmar e voltar para login
          </button>
        </form>

        <div className="auth-footer">
          <span>Já tem conta?</span>
          <button className="btn-link-auth" onClick={irParaLogin}>
            Fazer login
          </button>
        </div>
      </div>
    </div>
  );
}
