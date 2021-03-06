//+------------------------------------------------------------------+
//|                                                  EnviarOrdem.mqh |
//|                           Copyright 2017, Carlos Bezerra Vilela. |
//|                                           https://www.car7os.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Bibliotecas Necessárias                                          |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Classe HorarioFuncionamento                                      |
//+------------------------------------------------------------------+
class HorarioFuncionamento{
 
   private:
      datetime horarioInicio;
      datetime horarioFim;
      datetime servidor;
      
      bool flag;

      MqlDateTime horaServidor;
      MqlDateTime abertura;
      MqlDateTime encerramento;
      
      ulong horarioServidor;
      ulong horarioAbertura;
      ulong horarioEncerramento;

      void inicializarVariaveis();
 
   public:
      void setFlag(bool);
      bool getFuncionamento();
 
 
 }; HorarioFuncionamento Funcionamento;
 
//+------------------------------------------------------------------+
//| Método setHorarioVerao                                           |
//+------------------------------------------------------------------+

bool HorarioFuncionamento::getFuncionamento(){

   // inicializar variaveis
   Funcionamento.inicializarVariaveis();

   // regras de funcionamento

   if(((horarioAbertura <= horarioServidor) && (horarioServidor <= horarioEncerramento)) && (!(flag))){

      return true;

   }else{
   
      return false;

   }

   return false;

}

//+------------------------------------------------------------------+
//| Método setHorarioVerao                                           |
//+------------------------------------------------------------------+
 
 void HorarioFuncionamento::setFlag(bool fechar){
 
 flag = fechar;
 
 }
 
 
//+------------------------------------------------------------------+
//| Método inicializarVariaveis                                      |
//+------------------------------------------------------------------+
 
 
 void HorarioFuncionamento::inicializarVariaveis(){

   // inicializando as variáveis do horário de funcionamento
   horarioInicio = D'09:00:00'+D'00:15:00'; // Inicio das Atividades
   horarioFim = D'16:00:00'+D'00:30:00'; // Fim das Atividades

   // Inicializar Variaveis
   servidor=TimeCurrent();
   TimeToStruct(horarioInicio,abertura);
   TimeToStruct(horarioFim,encerramento);
   TimeToStruct(servidor,horaServidor);
   
   // colocar todo o horario em segundos
   horarioServidor = ((horaServidor.hour*60*60)+(horaServidor.min*60)+(horaServidor.sec));
   horarioAbertura = ((abertura.hour*60*60)+(abertura.min*60)+(abertura.sec));
   horarioEncerramento = ((encerramento.hour*60*60)+(encerramento.min*60)+(encerramento.sec));

}
 
 

//+------------------------------------------------------------------+
