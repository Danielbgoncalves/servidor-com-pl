# 🍕 Pizzalógica - Sistema Web de Pedidos de Pizza com Prolog

**Pizzalógica** é um sistema simples de pedidos de pizza via web. A interface é feita com HTML e CSS, enquanto o processamento e armazenamento dos dados é realizado em **Prolog**, utilizando SWI-Prolog como servidor HTTP.

> Projeto acadêmico da disciplina de Programação Lógica (UFU/FACOM), explorando integração web com lógica declarativa.

---

##  Funcionalidades

-  Cadastro de pedidos com nome, telefone, email, tamanho, ingredientes, horário e observações.
-   Cancelamento de pedidos com base em nome e telefone.
-  Armazenamento em arquivo Prolog (`pedidos.pl`)
-  Interface web amigável com retorno HTML visual

---

##  Como rodar

### Pré-requisitos:
- [SWI-Prolog](https://www.swi-prolog.org/) instalado

### Passos:

1. Clone o repositório:

```bash 
git clone https://github.com/Danielbgoncalves/servidor-com-pl.git
cd pizzalogica
````
2. ?- ['processaPedido.pl'].
3. ?- servidor(8000).
4. Abra o index.html e o veja em http://localhost:8000/index.html


### O que é feito aqui
- Criar formulários HTML que se comunicam com Prolog via HTTP
- Usar http_handler, http_parameters e reply_html_page
- Gerar HTML dinâmico com library(http/html_write)
- Ler e gravar fatos em arquivos .pl
- Trabalhar com conceitos de cliente/servidor na web

## Feito com
- prolog
- HTML e CSS
- Fome

## Licensa
MIT License — fique à vontade para usar, estudar ou adaptar.

