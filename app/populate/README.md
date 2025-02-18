# Store Database Populate

Esta é a ferramenta para popular o banco de dados PostgreSQL com dados iniciais de produtos.

## Funcionalidades

- Cria tabela de produtos se não existir
- Popula banco com dados de exemplo
- Logs coloridos para acompanhamento do processo
- Compilado para binário nativo

## Variáveis de Ambiente

O populate utiliza as seguintes variáveis de ambiente:

- `DB_HOST` - Host do banco de dados PostgreSQL
- `DB_PORT` - Porta do banco de dados PostgreSQL
- `DB_USER` - Usuário do banco de dados PostgreSQL
- `DB_PASSWORD` - Senha do banco de dados PostgreSQL
- `DB_NAME` - Nome do banco de dados PostgreSQL

Certifique-se de que as variáveis de ambiente estejam devidamente configuradas ao rodar o container.
