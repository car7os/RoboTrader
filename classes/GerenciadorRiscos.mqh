//+------------------------------------------------------------------+
//|                                                 ObterCotacao.mqh |
//|                           Copyright 2017, Carlos Bezerra Vilela. |
//|                                           https://www.car7os.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Bibliotecas necessárias                                          |
//+------------------------------------------------------------------+
#include "ObterCotacao.mqh"

//+------------------------------------------------------------------+
//| Enumerador                                                       |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Classe Gerenciar de Riscos                                       |
//+------------------------------------------------------------------+

class GerenciadorRiscos{

      private:
      
      // Stop
      enum {COMPRA = 1, VENDA = 2, ALTA =1, BAIXA = 2, SUPORTE = 1, RESISTENCIA = 2};
      
     // EnviarOrdens
      bool enviar;
      int totalPosicao;
      int totalPendente;
      string simboloPosicao;
      string simboloPendente;
      string simbolo;
      
      // Monitorar
      bool tendencia;
      int candles;
      double fechamentos[100];
      double mediaMovelExponencial[100];
      int periodoMediaMovel;
      int handleIMA;
      int candleTendencia;
      int ultimoCandlePreco;
      int ultimoCandleMedia;
      
      // Suporte e Resistencia
      int handleFractal;
      double suporte[];
      double resistencia[];


        
      

      public:
      
      // Stop
      double StopGain (int);
      double StopLoss (int);
      bool flag();
      
      // Monitorar
      bool getTendencia(int);
      bool getMediaExponencial(int, int, int);
      
      // Reversão de Tendencia
      bool reversao;
      bool getReversao(int);
      bool getConfirmacaoTendencia(int);
      
      // Sentimento Estatístico
      double getSentimentoCandle(int);
      double getSuportResistencia(int, int);
      


}; GerenciadorRiscos Riscos;


//+------------------------------------------------------------------+
//| Função Double que retorna o Suporte e Resistencia Fractal        |
//+------------------------------------------------------------------+

double GerenciadorRiscos::getSuportResistencia(int ENUM_SUPORTE_RESISTENCIA, int candle){

handleFractal = iFractals(_Symbol,PERIOD_M1);
CopyBuffer(handleFractal,1,0,candle,suporte);
CopyBuffer(handleFractal,0,0,candle,resistencia);

ArraySetAsSeries(suporte,true);
ArraySetAsSeries(resistencia,true);

Print("Suporte -> "+suporte[ArrayMinimum(suporte)]);
Print("Resistencia -> "+resistencia[ArrayMinimum(resistencia)]);




return 0;
}


//+------------------------------------------------------------------+
//| Função Double que retorna a probabilidade em percentual          |
//+------------------------------------------------------------------+

double GerenciadorRiscos::getSentimentoCandle(int ENUM_TENDENCIA){


return 0;
}




//+------------------------------------------------------------------+
//| Função Booleana Média Móvel Exponencial                                             |
//+------------------------------------------------------------------+

bool GerenciadorRiscos::getMediaExponencial(int periodo,int candle, int ENUM_TENDENCIA){

   candles = candle;
   ultimoCandlePreco = candles-1;
   ultimoCandleMedia = candles-2;
   periodoMediaMovel = periodo;
   candleTendencia = 0;
   tendencia = false;


   handleIMA = iMA(_Symbol,PERIOD_CURRENT,periodoMediaMovel,0,MODE_EMA,PRICE_CLOSE);
   
   CopyBuffer(handleIMA,0,0,candles,mediaMovelExponencial);
   ArraySetAsSeries(mediaMovelExponencial,true); // sempre ficará com o ultimo indice com o valor da média atual, não é o valor da anterior

  
   for (int i = 0; i<=(candles-1); i++){ // (candles-1) considerando que o indice zero é o primeiro valor do indice
   
   fechamentos[(candles-1)-i] = Cotacao.getFechamentoAnterior(PERIOD_CURRENT,(i+2));
   
   }
   
   switch(ENUM_TENDENCIA){
   
   case(ALTA):

   for (int i = 0; i<(candles-1); i++){

   if ((fechamentos[ultimoCandlePreco-i] > mediaMovelExponencial[ultimoCandleMedia-i])){ // aqui que devine a tendencia
   
   candleTendencia++;
   }
   
   }
   
   break;
   
   case(BAIXA):
   
      for (int i = 0; i<(candles-1); i++){

   if ((fechamentos[ultimoCandlePreco-i] < mediaMovelExponencial[ultimoCandleMedia-i])){ // aqui que devine a tendencia
   
   candleTendencia++;
   }
   
   }
 
   
   break;
   
   }
   
   if (candleTendencia == (candles-1)){
   
   tendencia = true;
   
   }   


   return tendencia;

}




//+------------------------------------------------------------------+
//| Função Booleana Retorna possível Reversão de Alta                |
//+------------------------------------------------------------------+

bool GerenciadorRiscos::getReversao(int ENUM_TENDENCIA){

   reversao = false;

switch(ENUM_TENDENCIA){

case(ALTA):


   if (Riscos.getTendencia(BAIXA) && Riscos.getConfirmacaoTendencia(BAIXA) && (Cotacao.getMaximo(1)>Cotacao.getMaximo(2)) && (Cotacao.getMaximo(1)>Cotacao.getMinimo(3))){

      reversao = true;

   }
   
   break;
   
   case(BAIXA):
   
      if (Riscos.getTendencia(ALTA) && Riscos.getConfirmacaoTendencia(ALTA) && (Cotacao.getMinimo(1)<Cotacao.getMinimo(2)) && (Cotacao.getMinimo(1)<Cotacao.getMinimo(3))){

      reversao = true;

   }

   
   break;
   }

return reversao;

}





//+------------------------------------------------------------------+
//| Função Booleana Tendencia de Alta                                |
//+------------------------------------------------------------------+

bool GerenciadorRiscos::getTendencia(int ENUM_TENDENCIA){



   return Riscos.getMediaExponencial(20,5, ENUM_TENDENCIA);

}


//+------------------------------------------------------------------+
//| Função Booleana Confirmação de Tendencia              |
//+------------------------------------------------------------------+

bool GerenciadorRiscos::getConfirmacaoTendencia(int ENUM_TENDENCIA){

   return Riscos.getMediaExponencial(5,3, ENUM_TENDENCIA);


}



//+------------------------------------------------------------------+
//| Método StopGain                                                  |
//+------------------------------------------------------------------+


double GerenciadorRiscos::StopGain(int operacao){

      switch(operacao){

            case(COMPRA):

                  return ((2*(Cotacao.getAbertura(1)-Cotacao.getMinimo(1)))+Cotacao.getFechamento(0));

            break;

            
            case (VENDA):

                  return (Cotacao.getFechamento(0)-(2*(Cotacao.getMaximo(1)-Cotacao.getAbertura(1))));

            break;

      }

      return -1;

}


//+------------------------------------------------------------------+
//| Método StopLoss                                                  |
//+------------------------------------------------------------------+

double GerenciadorRiscos::StopLoss(int operacao){

      switch(operacao){

            case(COMPRA):

                  return (Cotacao.getMinimo(1));

            break;

            
            case (VENDA):

                  return (Cotacao.getMaximo(1));

            break;

      }

      return -1;

}


//+------------------------------------------------------------------+
//| Método flag - Verifica se há ordens pendentes ou em posição      |
//+------------------------------------------------------------------+

bool GerenciadorRiscos::flag(){

   enviar = false;
   simbolo = _Symbol;

   simboloPosicao = ".";
   simboloPendente = ".";



   // Ordens em Posição
   totalPosicao = PositionsTotal();

   // Ordens Pendentes
   totalPendente = OrdersTotal();

   // Verificar Ativo da Ordem em Posição
   for (int i = 0; i<= totalPosicao;i++){

      if(PositionGetTicket(i)>0){
         

         simboloPosicao = PositionGetSymbol(i);
      }
   }

   // verificar Ativo da Ordem Pendente
   for (int j = 0; j<= totalPendente; j++){

      if(OrderGetTicket(j)>0){


         simboloPendente = OrderGetString(ORDER_SYMBOL);
      }

   }
   
   // se há posição ou pendente
   if (simboloPosicao == simbolo || simboloPendente == simbolo){

      enviar = false;

   }else
   {

      enviar = true;
   }



   return enviar;

}


//+------------------------------------------------------------------+
