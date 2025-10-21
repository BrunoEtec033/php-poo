USE sistema_bancario;
DELIMITER $$

-- PROCEDURES PARA CLIENTES PESSOA FÍSICA (PF)

DROP PROCEDURE IF EXISTS clientePF_cadastrar;
CREATE PROCEDURE clientePF_cadastrar (
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cpf VARCHAR(14),
    IN p_data_nascimento DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
        INSERT INTO Clientes (nome, email, telefone, endereco, username, password)
        VALUES (p_nome, p_email, p_telefone, p_endereco, p_username, p_password);
        SET @last_id = LAST_INSERT_ID();
        INSERT INTO Clientes_PF (cliente_id, cpf, data_nascimento)
        VALUES (@last_id, p_cpf, p_data_nascimento);
    COMMIT;
END $$

DROP PROCEDURE IF EXISTS clientePF_alterar;
CREATE PROCEDURE clientePF_alterar (
    IN p_id INT,
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cpf VARCHAR(14),
    IN p_data_nascimento DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
        UPDATE Clientes SET
            nome = p_nome,
            email = p_email,
            telefone = p_telefone,
            endereco = p_endereco,
            username = p_username,
            password = p_password
        WHERE id = p_id;
        UPDATE Clientes_PF SET
            cpf = p_cpf,
            data_nascimento = p_data_nascimento
        WHERE cliente_id = p_id;
    COMMIT;
END $$

DROP PROCEDURE IF EXISTS clientePF_deletar;
CREATE PROCEDURE clientePF_deletar (
    IN p_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
        DELETE FROM Clientes_PF WHERE cliente_id = p_id;
        DELETE FROM Clientes WHERE id = p_id;
    COMMIT;
END $$

DROP PROCEDURE IF EXISTS clientePF_consultarpornome;
CREATE PROCEDURE clientePF_consultarpornome (
    IN p_nome VARCHAR(100)
)
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    LEFT JOIN Clientes_PF pf ON c.id = pf.cliente_id
    WHERE c.nome LIKE CONCAT('%', p_nome, '%');
END $$

DROP PROCEDURE IF EXISTS clientePF_consultarporemail;
CREATE PROCEDURE clientePF_consultarporemail (
    IN p_email VARCHAR(100)
)
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    LEFT JOIN Clientes_PF pf ON c.id = pf.cliente_id
    WHERE c.email = p_email;
END $$

DROP PROCEDURE IF EXISTS clientePF_consultarporcpf;
CREATE PROCEDURE clientePF_consultarporcpf (
    IN p_cpf VARCHAR(14)
)
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    JOIN Clientes_PF pf ON c.id = pf.cliente_id
    WHERE pf.cpf = p_cpf;
END $$

DROP PROCEDURE IF EXISTS clientePF_consultarporid;
CREATE PROCEDURE clientePF_consultarporid (
    IN p_id INT
)
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    LEFT JOIN Clientes_PF pf ON c.id = pf.cliente_id
    WHERE c.id = p_id;
END $$

-- PROCEDURES PARA CLIENTES PESSOA JURÍDICA (PJ)

DROP PROCEDURE IF EXISTS clientePJ_cadastrar;
CREATE PROCEDURE clientePJ_cadastrar (
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cnpj VARCHAR(18),
    IN p_razao_social VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
        INSERT INTO Clientes (nome, email, telefone, endereco, username, password)
        VALUES (p_nome, p_email, p_telefone, p_endereco, p_username, p_password);
        SET @last_id = LAST_INSERT_ID();
        INSERT INTO Clientes_PJ (cliente_id, cnpj, razao_social)
        VALUES (@last_id, p_cnpj, p_razao_social);
    COMMIT;
END $$

DROP PROCEDURE IF EXISTS clientePJ_alterar;
CREATE PROCEDURE clientePJ_alterar (
    IN p_id INT,
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cnpj VARCHAR(18),
    IN p_razao_social VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
        UPDATE Clientes SET
            nome = p_nome,
            email = p_email,
            telefone = p_telefone,
            endereco = p_endereco,
            username = p_username,
            password = p_password
        WHERE id = p_id;
        UPDATE Clientes_PJ SET
            cnpj = p_cnpj,
            razao_social = p_razao_social
        WHERE cliente_id = p_id;
    COMMIT;
END $$

DROP PROCEDURE IF EXISTS clientePJ_deletar;
CREATE PROCEDURE clientePJ_deletar (
    IN p_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
        DELETE FROM Clientes_PJ WHERE cliente_id = p_id;
        DELETE FROM Clientes WHERE id = p_id;
    COMMIT;
END $$

DROP PROCEDURE IF EXISTS clientePJ_consultarpornome;
CREATE PROCEDURE clientePJ_consultarpornome (
    IN p_nome VARCHAR(100)
)
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    LEFT JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE c.nome LIKE CONCAT('%', p_nome, '%');
END $$

DROP PROCEDURE IF EXISTS clientePJ_consultarporrazaosocial;
CREATE PROCEDURE clientePJ_consultarporrazaosocial (
    IN p_razao_social VARCHAR(100)
)
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE pj.razao_social LIKE CONCAT('%', p_razao_social, '%');
END $$

DROP PROCEDURE IF EXISTS clientePJ_consultarporcnpj;
CREATE PROCEDURE clientePJ_consultarporcnpj (
    IN p_cnpj VARCHAR(18)
)
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE pj.cnpj = p_cnpj;
END $$

DROP PROCEDURE IF EXISTS clientePJ_consultarporid;
CREATE PROCEDURE clientePJ_consultarporid (
    IN p_id INT
)
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    LEFT JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE c.id = p_id;
END $$

DROP PROCEDURE IF EXISTS clientePJ_consultarporemail;
CREATE PROCEDURE clientePJ_consultarporemail (
    IN p_email VARCHAR(100)
)
BEGIN
    SELECT c.*, pj.cnpj, pj.razao_social
    FROM Clientes c
    LEFT JOIN Clientes_PJ pj ON c.id = pj.cliente_id
    WHERE c.email = p_email;
END $$

-- PROCEDURES PARA CONTAS

DROP PROCEDURE IF EXISTS conta_criar;
CREATE PROCEDURE conta_criar (
    IN p_cliente_id INT,
    IN p_tipo_conta VARCHAR(20),
    IN p_saldo DECIMAL(15,2)
)
BEGIN
    INSERT INTO Contas (cliente_id, tipo_conta, saldo)
    VALUES (p_cliente_id, p_tipo_conta, p_saldo);
END $$

DROP PROCEDURE IF EXISTS conta_alterar;
CREATE PROCEDURE conta_alterar (
    IN p_id INT,
    IN p_tipo_conta VARCHAR(20),
    IN p_saldo DECIMAL(15,2)
)
BEGIN
    UPDATE Contas SET
        tipo_conta = p_tipo_conta,
        saldo = p_saldo
    WHERE id = p_id;
END $$

DROP PROCEDURE IF EXISTS conta_deletar;
CREATE PROCEDURE conta_deletar (
    IN p_id INT
)
BEGIN
    DELETE FROM Contas
    WHERE id = p_id;
END $$

DROP PROCEDURE IF EXISTS conta_consultarporid;
CREATE PROCEDURE conta_consultarporid (
    IN p_id INT
)
BEGIN
    SELECT * FROM Contas
    WHERE id = p_id;
END $$

DROP PROCEDURE IF EXISTS conta_consultarporclienteid;
CREATE PROCEDURE conta_consultarporclienteid (
    IN p_cliente_id INT
)
BEGIN
    SELECT * FROM Contas
    WHERE cliente_id = p_cliente_id;
END $$

DROP PROCEDURE IF EXISTS conta_transacao_deposito;
CREATE PROCEDURE conta_transacao_deposito (
    IN p_conta_id INT,
    IN p_valor DECIMAL(15,2)
)
BEGIN
    START TRANSACTION;
        UPDATE Contas
        SET saldo = saldo + p_valor
        WHERE id = p_conta_id;
    COMMIT;
END $$

DROP PROCEDURE IF EXISTS conta_transacao_saque;
CREATE PROCEDURE conta_transacao_saque (
    IN p_conta_id INT,
    IN p_valor DECIMAL(15,2)
)
BEGIN
    DECLARE v_saldo_atual DECIMAL(15,2);
    SELECT saldo INTO v_saldo_atual FROM Contas WHERE id = p_conta_id FOR UPDATE;
    IF v_saldo_atual < p_valor THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
    ELSE
        START TRANSACTION;
            UPDATE Contas
            SET saldo = saldo - p_valor
            WHERE id = p_conta_id;
        COMMIT;
    END IF;
END $$

DELIMITER ;