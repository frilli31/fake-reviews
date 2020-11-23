class Question {
  String text;
  bool allowMultipleAnswers;
  bool numericQuestion;
  List<String> possibleAnswers;

  Question({
    this.text,
    this.possibleAnswers,
    this.allowMultipleAnswers = false,
    this.numericQuestion = false,
  });
}

List<Question> questions = [
  Question(
    text: 'Sesso assegnato alla nascita',
    possibleAnswers: ['M', 'F'],
  ),
  Question(
    text: 'Età',
    numericQuestion: true,
  ),
  Question(
    text: 'Grado di istruzione',
    possibleAnswers: [
      'scuola elementare',
      'scuola media',
      'scuola superiore',
      'laurea triennale',
      'laurea magistrale (o a ciclo unico)',
      'dottorato / specializzazione / master'
    ],
  ),
  Question(
      text: 'Mediamente quanto utilizzi lo smartphone durante la giornata?',
      possibleAnswers: [
        'Non lo utilizzo',
        'massimo 15 minuti al giorno',
        'Dai 15 minuti ad 1 ora al giorno',
        '1-2 ore al giorno',
        'Più di 2 ora al giorno'
      ]),
  Question(
    text:
        'Quali sono le principali attività per le quali utilizzi lo smartphone?',
    possibleAnswers: [
      'telefonate',
      'videochiamate',
      'chat',
      'email',
      'social networks (es. Facebook, Twitter, Instagram, etc...)',
      'fotografie e video',
      'musica',
      'giochi',
      'fitness e salute',
      'acquisti online (es. Amazon, Justeat, Zalando, ecc.)',
      'prenotazioni online (es. Booking)',
      'altro'
    ],
    allowMultipleAnswers: true,
  ),
  Question(
      text: 'Quanto spesso effettui degli acquisti online?',
      possibleAnswers: [
        'Più volte a settimana',
        'Una volta a settimana',
        'Una o due volte al mese',
        'Raramente (meno di una volta al mese)',
        'Non ho mai effettuato acquisti online'
      ]),
  Question(
    text:
        'Quando effettui acquisti online, che tipo di prodotti acquisti solitamente?',
    possibleAnswers: [
      'Cibo (es. ristoranti a domicilio, spesa)',
      'Vestiti e scarpe',
      'Tecnologia',
      'Materiale per la casa',
      'Altro'
    ],
    allowMultipleAnswers: true,
  ),
  Question(
    text:
        'Dopo aver effettuato un acquisto online, sei solito lasciare una recensione?',
    possibleAnswers: ['Mai', 'Raramente', 'A volte', 'Spesso', 'Sempre'],
  ),
  Question(
    text:
        'Dopo aver usufruito di un servizio di persona (es. cena ristorante, pernotto in albergo, ecc.), sei solito lasciare una recensione?',
    possibleAnswers: ['Mai', 'Raramente', 'A volte', 'Spesso', 'Sempre'],
  ),
  Question(
    text: 'Ti è mai capitato di lasciare una recensione falsa?',
    possibleAnswers: ['Mai', 'Raramente', 'A volte', 'Spesso', 'Sempre'],
  ),
  Question(
      text: 'Se si, più frequentemente, in quale situazione?',
      possibleAnswers: [
        'Ristorante',
        'Acquisto su Amazon o simili',
        'Altri servizi (es. servizi clienti, servizi benessere, ecc.)'
      ]),
  Question(
    text:
        'Ti è mai stato offerto del denaro o un tornaconto (es. buoni regalo, sconti) in cambio di una recensione falsa?',
    possibleAnswers: ['Mai', 'Raramente', 'A volte', 'Spesso', 'Sempre'],
  ),
  Question(
    text:
        'Quanto pensi che le recensioni false costituiscano un problema per la società odierna?',
    possibleAnswers: ['Per niente', 'Poco', 'Abbastanza', 'Molto'],
  )
];
