//+------------------------------------------------------------------+
//|                                                 ObterCotacao.mqh |
//|                           Copyright 2017, Carlos Bezerra Vilela. |
//|                                           https://www.car7os.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Classe ObterCotacao                                              |
//+------------------------------------------------------------------+

class ObterCotacao{

   // Atributos
   private:
   double Abertura[];
   double Fechamento[];
   double Maximo[];
   double Minimo[];
   int carregarBarras; // Carregar N barras / Máximo de barras que terá acesso
   double fechamentoAnterior[];

   // Método
   public:
   double getAbertura (int);
   double getFechamento (int);
   double getMaximo (int);
   double getMinimo (int);
   double getFechamentoAnterior(ENUM_TIMEFRAMES, int);
   
}; ObterCotacao Cotacao;

//+------------------------------------------------------------------+
//| possiveis valores da variável candleStick da função              |
//|                                                                  |
//| candleStick  = 0 => cotação Atual                                |
//| candleStick  = 1 => Candle imediatamente anterior                |
//| candleStick  = 2 => Segundo Candle contando do Atual para trás   |
//|                                                                  |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Método Obter valor de Abertura do Candle                         |
//+------------------------------------------------------------------+

double ObterCotacao::getAbertura(int candleStick){
   
   this.carregarBarras = 21; // Carregar N barras / Máximo de barras que terá acesso

   ArraySetAsSeries(Abertura, true);
   
   CopyOpen(_Symbol,_Period,0,this.carregarBarras,Abertura);


return this.Abertura[candleStick];

}

//+------------------------------------------------------------------+
//| Método Obter valor de Fechamento do Candle                         |
//+------------------------------------------------------------------+

double ObterCotacao::getFechamento(int candleStick){
   
   this.carregarBarras = 21; // Carregar N barras / Máximo de barras que terá acesso

   ArraySetAsSeries(this.Fechamento, true);
   
   CopyClose(_Symbol,_Period,0,this.carregarBarras,this.Fechamento);


return this.Fechamento[candleStick];

}

//+------------------------------------------------------------------+
//| Método Obter valor Máximo do Candle                              |
//+------------------------------------------------------------------+

double ObterCotacao::getMaximo(int candleStick){
   
   this.carregarBarras = 21; // Carregar N barras / Máximo de barras que terá acesso

   ArraySetAsSeries(this.Maximo, true);
   
   CopyHigh(_Symbol,_Period,0,this.carregarBarras,this.Maximo);


return this.Maximo[candleStick];

}

//+------------------------------------------------------------------+
//| Método Obter valor Mínimo do Candle                              |
//+------------------------------------------------------------------+

double ObterCotacao::getMinimo(int candleStick){
   
   this.carregarBarras = 21; // Carregar N barras / Máximo de barras que terá acesso

   ArraySetAsSeries(this.Minimo, true);
   
   CopyLow(_Symbol,_Period,0,this.carregarBarras,this.Minimo);


return this.Minimo[candleStick];

}

//+------------------------------------------------------------------+
//| Método Obter valor do fechamento do dia anterior                 |
//+------------------------------------------------------------------+

// Sabendo que o Candle 1 é o candle atual, o 2 é o primeiro anterior e assim por diante

double ObterCotacao::getFechamentoAnterior(ENUM_TIMEFRAMES periodo, int candle){

CopyClose(_Symbol,periodo,0,candle,fechamentoAnterior);


return fechamentoAnterior[0];

}

//+------------------------------------------------------------------+
