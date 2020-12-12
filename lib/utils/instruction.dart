class Instruction {
  final String text;
  final String image;

  Instruction({
    this.text,
    this.image,
  });
}

final instructions = [
  Instruction(
      text: 'Grazie per aver completato il questionario.',
      image: 'instruction_1.png'),
  Instruction(
      text:
          'Ora dovrai ora immaginare di acquistare dei prodotti o dei servizi.\n\nIl tuo compito sarà quello di recensire ciascuno dei prodotti e servizi acquistati.',
      image: 'instruction_2.png'),
  Instruction(
      text:
          'In alcuni casi la situazione d’acquisto ti chiederà di valutare il prodotto/servizio soltanto sulla base della sua qualità.\n\nIn altri casi dovrai invece tenere conto anche di altri elementi, che potranno influenzare in positivo o in negativo la tua recensione, spingendoti a fornire una valutazione non genuina del prodotto/servizio.',
      image: 'instruction_3.png'),
  Instruction(
      text:
          'Valuta il prodotto/servizio su una scala da 1 (per niente soddisfatto) a 5 (pienamente soddisfatto), tenendo conto di tutti gli elementi che possono influenzare la tua valutazione.',
      image: 'instruction_4.png'),
  Instruction(
      text:
          'Per effettuare la recensione trascina la matita verso la valutazione desiderata.\n\nOra ti verranno mostrati alcuni esempi in modo da mostrarti come avviene la votazione.',
      image: 'instruction_5.png'),
];
