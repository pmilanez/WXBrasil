WXBrasil
========

iOS Application to view Aviation Weather Information from Brazilian's WX Control - REDEMET

**SORRY, PORTUGUESE ONLY :/**

API da REDEMET
--------------
www.redemet.aer.mil.br/aux/consulta_msg_aut.php

 - **Argumento (local)**: Array de
   Localidades, FIR ou números sinóticos
   separados por virgula (Serão aceitas
   no máximo 10 localidade por vez).
 - **Argumento (msg)**: Array de Tipo
   Mensagem que estão disponíveis no
   banco de dados da REDEMET.
 - **Argumento (data_ini)**: Intervalo
   Inicial no formato YYYYMMDDHH (O
   intervalo entre a data inicial e
   final não pode ser superior a 1(um)
   ano).
 - **Argumento (data_fim)**: Intervalo Final
   no formato YYYYMMDDHH (O intervalo
   entre a data inicial e final não pode
   ser superior a 1(um) ano).

*Observação:* Não realizar uma consulta onde o "local" não se relacione com o tipo de mensagem, por exemplo colocar uma FIR e solicitar um METAR.

MENSAGENS DISPONIBILIZADAS
--------------------------
 - aviso_aerodromo
 - airmet 
 - ciclone
 - cinzas
 - furacao
 - gamet
 - metar
 - pilot
 - sigwx     
 - sigmet   
 - synop 
 - taf
 - temp
 - tempestade
 - tornado
 - winten