# Store API Backend

Este é o backend da API REST que fornece endpoints para consulta de produtos.

## Funcionalidades

- Lista todos os produtos
- Busca produto por ID
- Logs coloridos para melhor visualização
- Compilado para binário nativo

## Endpoints

- `GET /products` - Lista todos os produtos
- `GET /products/:id` - Busca produto específico por ID

## Variáveis de Ambiente

O backend utiliza as seguintes variáveis de ambiente:

- `PORT` - Porta em que a API irá rodar (padrão: 3000)
- `DB_HOST` - Host do banco de dados PostgreSQL
- `DB_PORT` - Porta do banco de dados PostgreSQL
- `DB_USER` - Usuário do banco de dados PostgreSQL
- `DB_PASSWORD` - Senha do banco de dados PostgreSQL
- `DB_NAME` - Nome do banco de dados PostgreSQL


Certifique-se de que as variáveis de ambiente estejam devidamente configuradas ao rodar o container.
