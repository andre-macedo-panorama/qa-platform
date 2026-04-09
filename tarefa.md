# QA #387163 — Novo Padrão Pedidos Carrefour

**Módulo:** Hub (Marketplaces)
**Categoria:** Funcionalidade (Refatoração)
**Versão:** 3.66
**Foco de regressão:** Integração de pedidos Colombo

---

## CRITÉRIOS DE ACEITAÇÃO

### F — Funcionais

**[F01]** O sistema deve receber e processar pedidos do Carrefour no novo padrão refatorado sem erros de parsing ou mapeamento de campos.

```gherkin
Cenário: Recebimento de pedido Carrefour no novo padrão
  Dado que o Carrefour envia um pedido no novo formato de integração
  Quando o Hub processa o payload recebido
  Então o pedido é criado corretamente no sistema com todos os campos mapeados
  E o status inicial do pedido é registrado conforme o novo padrão
```

**[F02]** O sistema deve realizar as transições de status do pedido Carrefour (confirmação, faturamento, envio, entrega, cancelamento) conforme o novo padrão.

```gherkin
Cenário: Transição de status de pedido Carrefour
  Dado que existe um pedido Carrefour criado no novo padrão
  Quando o status do pedido é atualizado (ex: confirmado → faturado)
  Então o sistema registra a transição corretamente
  E notifica o Carrefour via retorno de integração
```

**[F03]** O sistema deve retornar ao Carrefour os callbacks no formato esperado pelo novo padrão, sem rejeição pela plataforma marketplace.

```gherkin
Cenário: Callback de pedido para o Carrefour
  Dado que um pedido Carrefour sofreu atualização de status
  Quando o Hub envia o retorno ao Carrefour
  Então a resposta está no formato do novo padrão
  E o Carrefour confirma o recebimento sem erro de schema
```

---

### A — Controle de Acesso

**[A01]** Somente sistemas com credenciais válidas do Carrefour podem submeter pedidos ao Hub.
**[A02]** Token ou chave de integração inválidos devem resultar em HTTP 401/403, sem processamento do payload.

---

### I — Integridade de Dados

**[I01]** Todos os campos obrigatórios do pedido (itens, valores, endereço, ID externo) devem ser persistidos corretamente após o processamento.
**[I02]** Pedidos com ID externo duplicado não devem ser criados; o sistema deve identificar e rejeitar a duplicidade.
**[I03]** A refatoração não deve alterar dados de pedidos Carrefour já existentes na base.

---

### U — Interface

**[U01]** Os pedidos recebidos devem ser exibidos corretamente no BO com os dados mapeados pelo novo padrão.
**[U02]** Erros de integração devem ser exibidos no painel de monitoramento/log do Hub com descrição legível.

---

### R — Regras de Negócio

**[R01]** O novo padrão deve suportar todos os tipos de pedido praticados pelo Carrefour (normal, com frete, cancelamento parcial) sem quebra de fluxo.
**[R02]** Pedidos com divergência de itens ou estoque devem seguir o fluxo de tratamento de erro definido no novo padrão, sem silenciar a falha.
**[R03]** O cálculo de valores (subtotal, frete, desconto, total) deve estar correto conforme os campos do novo padrão Carrefour.

---

### B — Casos de Borda

**[B01]** Payload com campos opcionais ausentes deve ser processado sem erro, aplicando valores padrão onde cabível.
**[B02]** Pedido com múltiplos itens e diferentes SKUs deve ter cada item mapeado individualmente sem perda de dados.

---

### N — Negativos / Erro

**[N01]** Payload malformado deve ser rejeitado com mensagem de erro descritiva, sem criar pedido parcial no sistema.
**[N02]** Falha de comunicação durante callback deve acionar mecanismo de retry sem duplicar o pedido.

---

### RG — Regressão

**[RG01]** A refatoração do padrão Carrefour não deve impactar o fluxo de integração da Colombo — criação, atualização de status e callbacks devem funcionar conforme o comportamento anterior.
**[RG02]** Os demais marketplaces integrados ao Hub não devem apresentar regressão após o deploy (smoke test por integração).

---

## PROMPT DE TESTE

```
Contexto:
Você é analista de QA revisando a refatoração do padrão de pedidos do marketplace Carrefour
no módulo Hub (Marketplaces), versão 3.66. A refatoração alterou o formato de recebimento,
mapeamento de campos e retorno (callbacks) dos pedidos Carrefour.
O foco de regressão prioritário é a integração de pedidos da Colombo.

Referências: Ticket #387163 | Desenvolvimento #356507#note-10

---

FLUXOS A VALIDAR:

1. RECEBIMENTO DE PEDIDO
   - Enviar payload Carrefour no novo padrão (simular chamada do marketplace)
   - Verificar criação do pedido com todos os campos mapeados (ID externo, itens, valores, endereço, status inicial)
   - Testar payload com campos opcionais ausentes → esperado: processado sem erro
   - Testar payload malformado → esperado: rejeitado com mensagem de erro, sem pedido parcial criado

2. TRANSIÇÕES DE STATUS
   - Percorrer fluxo completo: criação → confirmação → faturamento → envio → entrega
   - Testar cancelamento (total e parcial, se suportado)
   - Verificar se cada transição é registrada corretamente e refletida no BO

3. CALLBACKS / RETORNO AO CARREFOUR
   - Verificar se os payloads de retorno estão no formato do novo padrão
   - Confirmar que não há rejeição de schema pela plataforma Carrefour
   - Simular falha de callback → verificar retry sem duplicação de pedido

4. INTEGRIDADE DE DADOS
   - Confirmar que pedidos anteriores à refatoração não foram alterados
   - Enviar pedido com ID externo duplicado → esperado: rejeitado sem criar duplicata
   - Verificar cálculo de valores (subtotal, frete, desconto, total)

5. CONTROLE DE ACESSO
   - Submeter pedido com credencial inválida → esperado: HTTP 401 ou 403
   - Confirmar que apenas sistemas autorizados processam pedidos

6. REGRESSÃO — COLOMBO (PRIORITÁRIO)
   - Executar fluxo completo de pedido Colombo: criação, atualização de status, callback
   - Comparar comportamento com baseline pré-refatoração conforme #356507#note-10
   - Verificar logs do Hub em busca de erros inesperados após o deploy relacionados à Colombo

7. REGRESSÃO — DEMAIS MARKETPLACES
   - Smoke test nos demais marketplaces integrados ao Hub
   - Verificar criação e atualização de ao menos um pedido por integração

---

CRITÉRIOS DE ACEITE DA VALIDAÇÃO:
- Todos os fluxos Carrefour executados sem erro
- Nenhuma regressão na integração Colombo
- Smoke test dos demais marketplaces sem falhas
- Logs do Hub sem erros novos relacionados ao deploy

Ambiente: Homologação / Staging | Versão: 3.66
```