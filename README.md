# 🚀 QA Automation Platform

Automação de geração de critérios de aceitação, BDD e base para testes a partir de tickets do Redmine.

---

# 🎯 Objetivo

Permitir que qualquer pessoa do time:

1. Copie um ticket do Redmine
2. Execute um comando simples
3. Tenha automaticamente:

   * Critérios de aceitação (8 blocos)
   * BDD (Given / When / Then)
   * Estrutura pronta para testes

---

# ⚡ Como usar (PASSO A PASSO SIMPLES)

## 1. Copiar o ticket do Redmine

Copie todo o conteúdo do ticket (Ctrl + C)

Exemplo:
Qualidade #370697 Aberta
[descrição completa...]

---

## 2. Executar automação

No VSCode:

👉 Pressione:

```
Ctrl + Shift + B
```

👉 Clique em:

```
Criar QA do Ticket
```

---

## 3. O que vai acontecer

Automaticamente:

* ✔ Um arquivo será criado com o número do ticket
  Ex: `370697.md`

* ✔ O ticket será colado dentro do arquivo

* ✔ O arquivo será aberto no VSCode

---

## 4. Gerar critérios com IA

Com o arquivo aberto:

👉 Pressione:

```
Ctrl + Enter
```

(Ou use sugestão do Copilot)

---

# 🧠 Resultado esperado

O sistema irá gerar automaticamente:

## ✔ Critérios de Aceitação

Divididos nos 8 blocos obrigatórios:

* F — Funcionais (com BDD)
* A — Acesso
* I — Integridade
* U — Interface
* R — Regras de negócio
* B — Borda
* N — Negativos
* RG — Regressão

---

## ✔ BDD automático (nos funcionais)

Exemplo:

Cenário: Excluir anexo com sucesso
Dado que o usuário possui permissão
Quando solicita a exclusão
Então o anexo é removido

---

## ✔ Estrutura pronta para testes

Incluindo base para automação:

* Nome de testes
* Organização lógica
* Base AAA (Arrange / Act / Assert)

---

# 📁 Estrutura do projeto

```
qa-platform/
│
├── docs/                 → Padrões QA
├── templates/            → Templates de critérios
├── prompts/              → Prompts para IA
├── agents/               → Configuração do agente QA
├── .github/              → Instruções do Copilot
├── .vscode/              → Automação (tasks)
├── criar-qa.ps1          → Script principal
```

---

# ⚠️ Regras importantes

* Sempre usar o fluxo padrão (Ctrl + Shift + B)
* Não editar manualmente a estrutura dos critérios
* Evitar adicionar explicações nos critérios
* Cada critério deve ser testável (verdadeiro/falso)

---

# 🚨 Problemas comuns

## ❌ Nada acontece ao rodar o comando

👉 Solução:

Executar no terminal:

```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## ❌ Arquivo não cria com número do ticket

👉 Verifique se o ticket contém:

```
#123456
```

---

## ❌ Copilot não gera BDD

👉 Certifique-se de que o arquivo contém:

```
QA
```

no topo

---

# 👥 Para o time

Este fluxo foi criado para:

* reduzir esforço manual
* padronizar QA
* acelerar entrega
* evitar erros de análise

---

# 🚀 Resultado esperado no dia a dia

Antes:

* análise manual
* critérios inconsistentes
* tempo alto

Depois:

* 1 ação simples
* padrão automático
* rapidez
* qualidade consistente

---

# 📌 Dúvidas

Em caso de dúvida, fale com o time responsável pelo QA Automation.

---
