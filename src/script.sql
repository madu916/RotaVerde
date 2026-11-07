--TABELAS
CREATE TABLE CATEGORIA (
                           ID NUMBER PRIMARY KEY,
                           NOME VARCHAR2(200) NOT NULL,
                           DESCRICAO VARCHAR2(255)
);
CREATE TABLE PONTO_COLETA(
                             ID NUMBER PRIMARY KEY,
                             NOME VARCHAR2(200) NOT NULL,
                             LOGRADOURO VARCHAR2(255),
                             NUMERO VARCHAR2(20),
                             BAIRRO VARCHAR2(100),
                             CIDADE VARCHAR2(100),
                             ESTADO VARCHAR2(2),
                             CEP VARCHAR2(20),
                             TELEFONE VARCHAR2(10)
);
CREATE TABLE MATERIAL(
                         ID NUMBER PRIMARY KEY,
                         NOME VARCHAR2(200) NOT NULL,
                         DESCRICAO VARCHAR2(255),
                         INSTRUCAO_DESCARTE VARCHAR2(255),
                         CATEGORIA_ID NUMBER NOT NULL,

                         CONSTRAINT FK_MATERIAL_CATEGORIA
                             FOREIGN KEY (CATEGORIA_ID)
                                 REFERENCES CATEGORIA(ID)
);
CREATE TABLE MATERIAL_PONTO(
                               MATERIAL_ID NUMBER NOT NULL,
                               PONTO_ID NUMBER NOT NULL,

                               CONSTRAINT PK_MATERIAL_PONTO
                                   PRIMARY KEY (MATERIAL_ID, PONTO_ID),

                               CONSTRAINT FK_MATERIAL_PONTO_MATERIAL
                                   FOREIGN KEY (MATERIAL_ID)
                                       REFERENCES MATERIAL(ID),

                               CONSTRAINT FK_MATERIAL_PONTO_PONTO_COLETA
                                   FOREIGN KEY (PONTO_ID)
                                       REFERENCES PONTO_COLETA(ID)
);

--ORACLE CRIA A SEQUENCIA ID
CREATE SEQUENCE SEQ_CATEGORIA
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE SEQ_MATERIAL
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE SEQ_PONTO_COLETA
    START WITH 1
    INCREMENT BY 1;

--categorias iniciais
INSERT INTO CATEGORIA (ID, NOME, DESCRICAO)
VALUES(SEQ_CATEGORIA.NEXTVAL, 'Pilhas', 'Descarte de pilhas usadas');

INSERT INTO CATEGORIA (ID, NOME, DESCRICAO)
VALUES(SEQ_CATEGORIA.NEXTVAL, 'Baterias', 'Descarte de baterias usadas');

INSERT INTO CATEGORIA (ID, NOME, DESCRICAO)
VALUES(SEQ_CATEGORIA.NEXTVAL, 'Eletrônicos', 'Descarte de equipamentos eletrônicos');

INSERT INTO CATEGORIA (ID, NOME, DESCRICAO)
VALUES(SEQ_CATEGORIA.NEXTVAL, 'Medicamentos', 'Descarte de medicamentos vencidos');

INSERT INTO CATEGORIA (ID, NOME, DESCRICAO)
VALUES(SEQ_CATEGORIA.NEXTVAL, 'Óleo', 'Descarte de óleos usados');
