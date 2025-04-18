:- use_module(library(http/thread_httpd)). 
:- use_module(library(http/http_dispatch)). 
:- use_module(library(http/http_parameters)). 
:- use_module(library(uri)). 
:- use_module(library(http/html_write)).
:- use_module(library(http/html_head)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_server_files)).

/* Para usar css nas paginas HTML geradas no PL*/
:- multifile user:file_search_path/2.
user:file_search_path(css, 'css').
:- http_handler(css(.), serve_files_in_directory(css), [prefix]).

:- http_handler(root(processa_pedido), processa_criacao_pedido, []).
:- http_handler(root(cancela_pedido), processa_cancelamento, []).     

:- dynamic(nomeCliente/2). 
:- dynamic(telCliente/2). 
:- dynamic(pedido/7).

 
servidor(Porta) :-                                          
        http_server(http_dispatch, [port(Porta)]). 
 
processa_criacao_pedido(R) :-
    http_parameters(R,[
        nomeCliente(C,[]), 
        telCliente(T,[]), 
        emailCliente(E,[]), 
        tamanho(S,[]), 
        ing(Is, [list(multiple)]), 
        tempo(H,[]), 
        obs(O,[]) 
        ]),
        /*assertz(pedido(C,T,E,S,Is,H,O)), Tipo 1 de fazer, reinicia o arq toda vez
        tell('pedidos.pl'),
        listing(pedido/7),*/
        /*append('pedidos.pl'), Tipo 2 de fazer, mts atributos ficam sem ''
        write(pedido(C,T,E,S,Is,H,O)),
        write('.'),nl,
        told,*/
        open('pedidos.pl', append, Stream),
        writeq(Stream, pedido(C,T,E,S,Is,H,O)),
        write(Stream, '.'),
        nl(Stream),
        close(Stream),
        mensagem_criacao_pedido_html(C,T,E,S,Is,H,O).


mensagem_criacao_pedido_txt(C,T,E,S,Is,H,O) :-                                       
  format('Content-type: text/plain~n~n'), 
  format('Listagem dos dados!~n'), 
  write('Pedido confirmado com os seguintes dados:'),nl,nl,
  write(nome(C)),nl, 
  write(telefone(T)),nl, 
  write(email(E)),nl, 
  write(tamanho(S)),nl, 
  write(ingrediente(Is)),nl, 
  write(tempo(H)),nl, 
  write(obs(O)),nl.

  mensagem_criacao_pedido_html(C,T,E,S,Is,H,O) :-
    reply_html_page(
        title('Confirmação do pedido'),
        \html_requires(css('estilo_pag_pl.css')),
        [   
            div([class('caixa-confirmacao')], [
                h1('Pedido Confirmado!!'),
                p(['Nome:', C]),
                p(['Telefone: ',T]),
                p(['Email: ', E]),
                p(['Tamanho: ', S]),
                p(['Ingredientes, ', \ingredientes_lista(Is)]),
                p(['Horario: ', H]),
                p(['Obs: ', O])
            ])
        ]
    ).
 

ingredientes_lista([]) --> [].
ingredientes_lista([H|T]) -->
    html([H, br([])]),
    ingredientes_lista(T).

processa_cancelamento(R) :-
    http_parameters(R,[
        nomeCliente(C,[]), 
        telCliente(T,[]) 
        ]),
    consult('pedidos.pl'),
    retractall(pedido(C,T,_,_,_,_,_)),
    tell('pedidos.pl'),
    listing(pedido/7),
    told,
    mensagem_cancel_pedido_html(C,T).

mensagem_cancel_pedido_txt(C,T) :-                                       
    format('Content-type: text/plain~n~n'), 
    format("Pedido de ~w com telefone ~w foi cancelado com sucesso!", [C, T]).


mensagem_cancel_pedido_html(C,T) :-
    reply_html_page(
        title('cancelamento do pedido'),
        \html_requires(css('estilo_pag_pl.css')),
        [   
            div([class('caixa-confirmacao')], [
                h1('Pedido Cancelado!!'),
                p(['Nome:', C]),
                p(['Telefone: ',T]),
                p('Esperamos ter voce de volta em breve !')
            ])
        ]
    ).