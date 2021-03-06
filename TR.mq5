//+------------------------------------------------------------------+
//|                                                           TR.mq5 |
//|                           Copyright 2017, Carlos Bezerra Vilela. |
//|                                           https://www.car7os.com |
//+------------------------------------------------------------------+
// Informações sobre o projeto
#property copyright "Copyright 2017, Carlos Bezerra Vilela."
#property link      "https://www.car7os.com"
#property version   "1.00"
#property description "TR (Transaction Risk Management) é um Gerenciador de Riscos de Transações em Bolsa de Valores, inicialmente criado para operar Scalper em Mini Contrato Futuro de dólar"
#property description "Desenvolvido para servir como Projeto de Conclusão de Curso em Engenharia de Computação. Este sistema não tem por objetivo criar padrões de transações em Bolsa de Valores, mas sim Gerir os Riscos de uma operação."
//+------------------------------------------------------------------+
//| Bibliotecas necessárias                                          |
//+------------------------------------------------------------------+
#include "classes/EnviarOrdem.mqh"
#include "classes/ObterCotacao.mqh"
#include "classes/FecharOrdem.mqh"
#include "classes/HorarioFuncionamento.mqh"
#include "classes/GerenciadorRiscos.mqh"
//+------------------------------------------------------------------+
//| Variáveis necessárias                                            |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

      Print("TR (Transaction Risk Management): Inicializado");
      

      
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
      Print("TR (Transaction Risk Management): Encerrado");
      
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

//Ordem.compra(1,0.5,0.5); //- Funcionando Corretamente
//Ordem.venda(1,0.5,0.5); //- Funcionando Corretamente

//printf("\nAbertura => %.5f",Cotacao.getAbertura(3)); //- Funcionando Corretamente
//printf("Maximo => %.5f",Cotacao.getMaximo(3)); //- Funcionando Corretamente
//printf("Minimo => %.5f",Cotacao.getMinimo(3)); //- Funcionando Corretamente
//printf("Fechamento => %.5f",Cotacao.getFechamento(3)); //- Funcionando Corretamente

//Fechar.pendente(); //- Funcionando Corretamente
//Fechar.posicao(); //- Funcionando Corretamente
//Fechar.tudo(); //- Funcionando Corretamente

//Funcionamento.setFlag(false); //- Funcionando Corretamente
//bool H = Funcionamento.getFuncionamento(); //- Funcionando Corretamente
//Print(H); //- Funcionando Corretamente


//Print("\nTendencia de Alta -> " + Riscos.getTendencia(ALTA));

//Print("Tendencia de Baixa -> " + Riscos.getTendencia(BAIXA));

//Print("Exponencial de Alta -> " + Riscos.getMediaExponencial(5,3,ALTA));

//Print("Exponencial de Baixa -> " + Riscos.getMediaExponencial(5,3,BAIXA));

//Print("Confirmação de Alta -> " + Riscos.getConfirmacaoTendencia(ALTA));

//Print("Confirmação de Baixa -> " + Riscos.getConfirmacaoTendencia(BAIXA));

//Print("Reversão de Alta ->" + Riscos.getReversao(ALTA));

//Print("Reversão de Baixa ->" + Riscos.getReversao(BAIXA));

//Ordem.compra(1,Riscos.StopGain(COMPRA),Riscos.StopLoss(COMPRA),Riscos.flag()); //- Funcionando Corretamente
//Ordem.venda(1,Riscos.StopGain(VENDA),Riscos.StopLoss(VENDA),Riscos.flag()); //- Funcionando Corretamente
//Print("Fechamento Anterior -> "+ Cotacao.getFechamentoAnterior(PERIOD_M5,2)); //- Funcionando Corretamente




// Testando Prototipo
// Gerenciamento de Riscos

//Funcionamento.setFlag(false);
//bool hFuncionamento = Funcionamento.getFuncionamento();
/**
if(hFuncionamento){


}else{

Fechar.tudo();


};

**/


//Print("Probabilidade de Alta ou Baixa em Função do Tempo -> " + Riscos.getSentimentoCandle(ALTA) + "%");

Print("Fractal -> " + Riscos.getSuportResistencia(SUPORTE,20));

/**

if(Riscos.getReversao(ALTA)){
Ordem.compra(1,Riscos.StopGain(COMPRA),Riscos.StopLoss(COMPRA),Riscos.flag()); //- Funcionando Corretamente

}else{

if(Riscos.getReversao(BAIXA)){
Ordem.venda(1,Riscos.StopGain(VENDA),Riscos.StopLoss(VENDA),Riscos.flag()); //- Funcionando Corretamente

}


}


**/


  }
//+------------------------------------------------------------------+
