## CONSLOG - Project Management

Esta é a aplicação de teste para a vaga de desenvolvedor Ruby on Rails na CONSLOG.

A aplicação é um gerenciador de projetos de arquitetura. Deverá ser uma API REST com Rails, com endpoints para as features a seguir.

### Requisitos

- O sistema deve permitir criar, editar um projeto.
- Um projeto deverá ter um nome, cliente, data de conclusão e estado.
- Um projeto poderá receber várias notas. Estas notas que poderão ou não alterar o estado do projeto.
- Deverá haver também um endpoint para marcar o estado do projeto como "concluído", e a data da conclusão deve ser guardada.
- Os projetos e suas notas nunca devem ser apagadas, mas ao remover um projeto ou uma nota ela deve ser marcada como arquivada na base de dados.
- Deve salvar data em que um projeto ou uma nota foi arquivada.
- Projetos e Notas arquivadas não devem ser incluídas na lista de projetos.
- Permitir que um ou mais projetos sejam arquivados em uma única requisição.
- A lista de projetos e a lista de notas de um projeto deve ser ordenada por data de criação em ordem decrescente.

### O que será avaliado

1. Entendimento dos requisitos
2. Clareza do código
3. Testes
4. Controle de versão utilizando git

### Prazo

- A entrega deste teste deverá ser feita em até 2 dias.
- Todos os testes devem estar passando.
- O resultado da avaliação será informado pelo recrutador em momento oportuno.
