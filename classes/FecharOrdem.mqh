//+------------------------------------------------------------------+
//|                                                  EnviarOrdem.mqh |
//|                           Copyright 2017, Carlos Bezerra Vilela. |
//|                                           https://www.car7os.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Bibliotecas Necessárias                                          |
//+------------------------------------------------------------------+

 #include <Trade\Trade.mqh>

//+------------------------------------------------------------------+
//| Classe FecharOrdem                                               |
//+------------------------------------------------------------------+
 
 class FecharOrdem{
 
 private:
 //--- variáveis ​​para retornar valores das propriedades de ordem
   datetime HoraAtual;

   ulong    ticket;
   uint     total;
   string   ativoCorrente;
   string   ativoPendente;

   double   precoAbertura;
   double   volumeAbertura;
   string   tipoOperacao;
   datetime dataEnvio;
   long     ID;
   
   string enviado;
   
 public:
  
   void pendente(int);
   void posicao();
   void tudo(); 
 
 
 
 }; FecharOrdem Fechar;
 
//+------------------------------------------------------------------+
//| Método Pendente                                                  |
//+------------------------------------------------------------------+

 
 
 void FecharOrdem::pendente(int emXsegundos)
  {
  
   // Hora Corrente do Servidor
   HoraAtual=TimeCurrent();
   
   //--- Numero de ordens atuais pendentes
   total=OrdersTotal();
   
   int x =emXsegundos; // segundos

   
   //--- fazer um loop pesquisando as ordens pendentes
   for(uint i=0;i<total;i++)
     {
     
      //--- Procurar ticket de ordem por sua posição na lista
      if(((ticket=OrderGetTicket(i))>0))
        {
        
        // Simbolo do Ativo pendente e do Ativo Corrente do Gráfico
        ativoPendente = OrderGetString(ORDER_SYMBOL);
        ativoCorrente = _Symbol;
        
        
        if(ativoPendente == ativoCorrente)
        {
         //--- retorna propriedades de uma Ordem
         precoAbertura = OrderGetDouble(ORDER_PRICE_OPEN);
         volumeAbertura = OrderGetDouble(ORDER_VOLUME_INITIAL);
         tipoOperacao = EnumToString(ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE)));
         dataEnvio = (datetime)OrderGetInteger(ORDER_TIME_SETUP);
         ID = OrderGetInteger(ORDER_POSITION_ID);
         enviado = TimeToString(dataEnvio);

         //--- preparar e apresentar informações sobre a ordem
         MqlDateTime Posicao; TimeToStruct(dataEnvio,Posicao);
         MqlDateTime Servidor; TimeToStruct(HoraAtual,Servidor);
         // Fechar Ordem pendente se estivar pendurada a mais de X segundos
         if((((Posicao.sec)<(Servidor.sec-x)) || (Posicao.min!=Servidor.min)))
         {
         CTrade *trade=new CTrade();
         trade.OrderDelete(ticket);
         delete trade;
         
         printf("Encerrado: ID: %d; Ativo: %s; Preço: %.5f; Volume: %.2f; Tipo: %s; Ordem Enviada em: %s", ID, ativoPendente, precoAbertura, volumeAbertura, tipoOperacao, enviado);
         
         }

        }
        }
     }
  }
  
  
//+------------------------------------------------------------------+
//| Método Aberto                                                    |
//+------------------------------------------------------------------+

void FecharOrdem::posicao(){

   CTrade trade = new CTrade();

   trade.PositionClose(_Symbol);

   Print("Encerrando toda posição de "+_Symbol);

}

//+------------------------------------------------------------------+
//| Método Tudo                                                      |
//+------------------------------------------------------------------+


void FecharOrdem::tudo(){

   Fechar.pendente(0);
   Fechar.posicao();

   Print("Encerrando Posição e Pendentes de "+_Symbol);

}

//+------------------------------------------------------------------+
