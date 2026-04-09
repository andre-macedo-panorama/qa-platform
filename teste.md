# CRITÉRIOS DE ACEITAÇÃO

## Contexto

O sistema deve permitir que usuários autorizados excluam anexos vinculados a um processo, com confirmação prévia e remoção efetiva do arquivo.

---

## F — Funcionais

**[F01]** O sistema deve exibir confirmação antes de executar a exclusão do anexo.

```gherkin
Cenário: Excluir anexo com confirmação
  Dado que o usuário está na página de detalhes de um processo
  E que o processo possui ao menos um anexo
  Quando o usuário clica em "Excluir" no anexo
  Então o sistema exibe um diálogo de confirmação com o nome do anexo
```

**[F02]** O sistema deve remover o anexo da listagem após confirmação.

```gherkin
Cenário: Confirmar exclusão de anexo
  Dado que o diálogo de confirmação está exibido
  E que o anexo ainda existe no processo
  Quando o usuário confirma a exclusão
  Então o anexo é removido da listagem do processo
  E o sistema exibe mensagem de sucesso
```

**[F03]** O arquivo não deve ser acessível via URL direta após ser excluído.

```gherkin
Cenário: Acesso à URL do anexo após exclusão
  Dado que um anexo foi excluído com sucesso
  Quando o usuário tenta acessar a URL direta do arquivo
  Então o sistema retorna erro 404
```

---

## A — Controle de Acesso

**[A01]** Usuário sem permissão de exclusão não deve visualizar a ação de excluir anexo.  
**[A02]** Requisição de exclusão enviada por usuário sem permissão deve retornar HTTP 403.  
**[A03]** Apenas o dono do anexo ou usuário com perfil administrador pode executar a exclusão.

---

## I — Integridade de Dados

**[I01]** A exclusão de um anexo não deve alterar outros campos, histórico ou demais anexos do processo.  
**[I02]** O sistema deve registrar no histórico do processo: nome do arquivo, usuário responsável e data/hora da exclusão.  
**[I03]** O processo deve permanecer acessível e íntegro após a exclusão do anexo.

---

## U — Interface

**[U01]** O botão/ação de excluir deve ser renderizado apenas para usuários com permissão.  
**[U02]** O diálogo de confirmação deve exibir o nome do anexo a ser excluído.  
**[U03]** Após exclusão bem-sucedida, a listagem deve ser atualizada sem recarregar a página inteira.

---

## R — Regras de Negócio

**[R01]** Não deve ser permitida a exclusão de anexo em processos com status bloqueado ou arquivado.  
**[R02]** O sistema deve validar que o anexo pertence ao processo indicado antes de executar a exclusão.

---

## B — Casos de Borda

**[B01]** Tentativa de excluir um anexo já excluído deve retornar mensagem de erro sem gerar exceção não tratada.  
**[B02]** Exclusão de anexo cujo nome contém caracteres especiais deve ser processada corretamente.

---

## N — Negativos / Erro

**[N01]** Se a exclusão falhar por erro interno, o anexo deve permanecer na listagem e o sistema deve exibir mensagem de erro sem perder dados.  
**[N02]** Requisição com ID de anexo inexistente deve retornar HTTP 404.

---

## RG — Regressão

**[RG01]** Após excluir um anexo, os demais anexos do mesmo processo devem permanecer acessíveis e inalterados.  
**[RG02]** A funcionalidade de upload de novo anexo ao processo deve continuar operacional após uma exclusão.