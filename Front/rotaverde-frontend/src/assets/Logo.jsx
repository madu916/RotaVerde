import React from 'react';

export default function Logo() {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
      <svg width="36" height="36" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
        {/* Pin de localização em Azul Oceano */}
        <path
          d="M20 2C11.7157 2 5 8.71573 5 17C5 27.5 20 38 20 38C20 38 35 27.5 35 17C35 8.71573 28.2843 2 20 2Z"
          fill="#0288D1"
        />
        {/* Folha interna em Verde Esmeralda */}
        <path
          d="M26.5 11.5C21.5 11.5 15.5 14.5 14.5 21.5C18.5 21.5 25.5 19.5 26.5 11.5Z"
          fill="#4CAF50"
          stroke="#FFFFFF"
          strokeWidth="1.5"
        />
        <path d="M14.5 21.5L19.5 16.5" stroke="#FFFFFF" strokeWidth="1.5" strokeLinecap="round" />
      </svg>
      <span className="logo-text" style={{ fontSize: '1.5rem', fontWeight: 700, color: '#2E7D32' }}>
        Rota<span style={{ color: '#0288D1' }}>Verde</span>
      </span>
    </div>
  );
}
