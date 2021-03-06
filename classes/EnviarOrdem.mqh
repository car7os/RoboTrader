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
//| Classe EnviarOrdem                                               |
//+------------------------------------------------------------------+
 
 class EnviarOrdem{
   
   // Atrinutos
   private:
   int volume;
   double preco;
   double preco_limite;
   double stopGain;
   double stopLoss;
   bool sucesso;
   
   //Métodos
   public:
   void compra(int, double, double, bool);
   void venda(int, double, double, bool);

}; EnviarOrdem Ordem;


//+------------------------------------------------------------------+
//| Método Enviar Ordem de Compra                                    |
//+------------------------------------------------------------------+

EnviarOrdem::compra(int vol, double stop_Gain, double stop_Loss, bool flag){

if(flag){


   //Zerar variaveis
   this.volume = 0;
   this.preco = 0;
   this.preco_limite = 0;
   this.stopGain = 0;
   this.stopLoss = 0;
   this.sucesso = NULL;
   
   // codigo
   
   this.volume = vol;

   printf("\nAbrindo Ordem de Compra\nAcessando Book de Ofertas");

   MqlBookInfo meuBook[];

   this.sucesso = MarketBookGet(_Symbol,meuBook);


   if(this.sucesso){
            
            printf("\nVerificando o Melhor Preco de Compra");

            
            for(int i = 0; i<=(ArraySize(meuBook)-2);i++){
               
                  if(meuBook[i].type != meuBook[i+1].type){
                           this.preco = meuBook[i+1].price; // preco = meuBook[i].price para a venda
                  }
            }
            
            printf("Calculando StopGain e StopLoss");
            
         this.stopGain = (stop_Gain);
         this.stopLoss = (stop_Loss);
         printf("StopGain = %.3f; e StopLoss = %.3f;",this.stopGain,this.stopLoss);
            
            
   printf("Book de Ofertas - Melhor Preco: %.3f",this.preco);


      CTrade *trade = new CTrade();
      if(trade.OrderOpen(_Symbol,ORDER_TYPE_BUY_LIMIT,this.volume,this.preco_limite,this.preco,this.stopLoss,this.stopGain,ORDER_TIME_DAY,NULL,"COMPRA NA PEDRA")){
      
      printf("Ordem de Compra enviada com sucesso\n(C-> %.3f; Volume -> %d; StopGain -> %.3f; StopLoss -> %.3f)", this.preco, this.volume, this.stopGain, this.stopLoss);
      }else{
      printf("ERRO no envio de Ordem de Compra");
      }

   }else{
   printf("ERRO ao acessar o Book de Ofertas");
   }
   
   }
   
}


//+------------------------------------------------------------------+
//| Método Enviar Ordem de Venda                                     |
//+------------------------------------------------------------------+

EnviarOrdem::venda(int vol, double stop_Gain, double stop_Loss, bool flag){

if(flag){


   //Zerar variaveis
   this.volume = 0;
   this.preco = 0;
   this.preco_limite = 0;
   this.stopGain = 0;
   this.stopLoss = 0;
   this.sucesso = NULL;
   
   // codigo
   
   this.volume = vol;

   printf("\nAbrindo Ordem de Venda\nAcessando Book de Ofertas");

   MqlBookInfo meuBook[];

   this.sucesso = MarketBookGet(_Symbol,meuBook);


   if(this.sucesso){
            
            printf("\nVerificando o Melhor Preco de Compra");

            
            for(int i = 0; i<=(ArraySize(meuBook)-2);i++){
               
                  if(meuBook[i].type != meuBook[i+1].type){
                           this.preco = meuBook[i].price; // preco = meuBook[i+1].price para a compra
                  }
            }
            
            printf("Calculando StopGain e StopLoss");
            
         this.stopGain = (stop_Gain);
         this.stopLoss = (stop_Loss);
         printf("StopGain = %.3f; e StopLoss = %.3f;",this.stopGain,this.stopLoss);
            
            
   printf("Book de Ofertas - Melhor Preco: %.3f",this.preco);


      CTrade *trade = new CTrade();
      if(trade.OrderOpen(_Symbol,ORDER_TYPE_SELL_LIMIT,this.volume,this.preco_limite,this.preco,this.stopLoss,this.stopGain,ORDER_TIME_DAY,NULL,"VENDA NA PEDRA")){
      
      printf("Ordem de Compra enviada com sucesso\n(V-> %.3f; Volume -> %d; StopGain -> %.3f; StopLoss -> %.3f)", this.preco, this.volume, this.stopGain, this.stopLoss);
      }else{
      printf("ERRO no envio de Ordem de Venda");
      }

   }else{
   printf("ERRO ao acessar o Book de Ofertas");
   }
   
   }
}

//+------------------------------------------------------------------+
