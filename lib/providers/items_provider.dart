import 'package:flutter/cupertino.dart';

class ItemsProvider {
  static List<Item> _itemsBag = [
    Item(name: '1.jpg', type: ItemType.product, description: [
      'Decidi di comperare un supporto per il tuo telefono su un sito di elettronica. Il prodotto risulta decisamente leggero e instabile, i gommini dove appoggia il cellulare sono incollati male e si staccano.',
      'Contrariato, comunichi al negozio la deludente esperienza. Quest\'ultimo ti promette allora, 3 articoli della categoria di accessori per la telefonia in cambio di una recensione positiva.'
    ]),
    Item(name: '2.jpg', type: ItemType.service, description: [
      'Riscontri un\'incongruenza rispetto al servizio previsto dalla promozione attiva sulla tua carta sim, decidi, quindi di chiamare l\'assistenza telefonica per chiedere spiegazioni. L\'operatore in linea è molto scortese, non da ascolto alle tue richieste e ti tratta con estrema saccenza.',
      'Amareggiato dell\'accaduto, gli comunichi che lascerai una recensione negativa al servizio. Questi, allora, chiedendoti scusa ti promette, in cambio di una valutazione positiva, un\'offerta speciale di 30 GB di internet della durata di 3 mesi.'
    ]),
    Item(
      name: '3.jpg',
      type: ItemType.service,
      description: [
        'Hai soggiornato, per una breve vacanza a Praga, in un hotel prenotato tramite il sito Trivago. Hai vissuto un incubo. La camera era scadente, sporca e per niente curata e hai trovato un bacherozzolo nella vasca da bagno. Il personale si è rivelato essere scortese e il servizio della colazione in camera non è stato rispettato.',
        'Tuttavia Trivago ti promette una disceta percentuale di guadagno di cambio di una recensione positiva all\'hotel.'
      ],
    ),
    Item(
      name: '4.png',
      type: ItemType.product,
      description:
          ['Acquisti un paio di jeans su un sito di capi d\'abbigliamento. All\'arrivo della consegna noti immediatamente che questi sono diversi dalla foto mostrata e inoltre il tessuto pare essere già consumato.','Insoddisfatto dell\'esperienza, decidi di lasciare una recensione negativa. Ma il negozio scusandosi dell\'imprevisto, ti promette un buono sconti di 50 € da utilizzare su un qualsiasi capo d\'abbigliamento a tua scelta in cambio di una buona recensione.'],
    ),
    Item(
        name: '5.png',
        type: ItemType.product,
        description:
            ['Esegui un ordine on-line di un tablet tramite Amazon. La consegna del prodotto non ha rispettato i tempi previsti. Inoltre, seppur economico, non risulta essere all\'altezza del marchio. Ha un hardware basico, che ne limita di molto l\'utilizzo, con continui rallentamenti.','A seguito delle tue lamentele, ti viene offerto un periodo di due anni di Amazon prime gratuito, chiedendoti, in cambio, una recensione positiva della tua esperienza.']),
    Item(
      name: '6.jpg',
      type: ItemType.service,
      description:
          ['Hai soggiornato per un weekend in un albergo di cui sei rimasto pienamente soddisfatto. La camera in cui hai pernottato si è presentata spaziosa e molto curata nei dettagli oltre che silenziosa. La colazione, inclusa nel soggiorno, era varia abbondante e di qualità.','Ma, un tuo conoscente, proprietario di un hotel posizionato a pochi chilometri, ti offre la possibilità di trascorrere una settimana gratis, compresi i vari servizi, in cambio di una recensione negativa dell\'albergo in cui sei stato.'],
    ),
    Item(
      name: '7.jpg',
      type: ItemType.service,
      description:
          ['Poiché è stato aperto un nuovo centro estetico a pochi chilometri dal tuo decidi di prenotare una seduta di massagio per verificarne la qualità. L\' esperienza è stata positiva, il personale gentile e disponibile. L\'ambiente è confortevole e i prodotti utilizzati ed esposti sono di ottima qualità.','Tuttavia, per favorie il profitto del beauty center di cui sei proprietaria lasci una pessima recensione.'],
    ),
    Item(
      name: '8.png',
      type: ItemType.service,
      description:
      [
        'Sei andato a cena in un ristorante che ha da poco aperto nella stessa via in cui si trova la pizzeria di un tuo carissimo amico. Ha esaudito le tue aspettative. Ottima qualità e ingredienti freschi, con molta varietà di scelta e abbondanza dei piatti serviti.',
        'Il tuo amico, però ti chiede di lasciarne una recensione negativa. Per ringraziarti del gesto, ti promette un trattamento di favore per tutte le volte che andrai a mangiare da lui.'
      ],
    ),
    Item(
        name: '9.jpg',
        type: ItemType.firm,
        description:
            ['L\'agenzia di arredamento e mobili per la casa in cui hai lavorato per 10 anni offre soluzioni diversificate degli ambienti sia nei materiali, sia nei modelli di composizione, e il rapporto qualità-prezzo è decisamente vantaggioso.','Tuttavia, poiché sei stato licenziato senza preavviso e senza alcun valido motivo, per vendicarti, decidi di lasciare una pessima valutazione su tutti i prodotti offerti dall\'impresa.']),
    Item(
      name: '10.jpg',
      type: ItemType.service,
      description:
          ['Fai una lezione di prova in una delle due palestre presenti nella tua cittadina. Gli ambienti sono disinfettati e ben curati e il personal trainer che ti ha seguito si è mostrato professionale e competente.','Però, il tuo fidanzato è proprietario dell\'altra palestra e per favorirne la crescita e il profitto economico, decidi di recensire negativamente la concorrenza'],
    ),
    Item(
      name: '11.jpg',
      type: ItemType.service,
      description:
          ['Decidi di ordinare una pizza on-line. La pizzeria rispetta l\'orario di consegna previsto. Il fattorino è gentile e cortese e la pizza è calda, dal sapore ottimo e l\'impasto è ben cucinato.','Lascia una recensione della tua esperienza.'],
    ),
    Item(
      name: '12.jpg',
      type: ItemType.service,
      description:
          ['Hai soggiornato per un weekend in una spa. Hai ricevuto una perfetta accoglienza e il personale si è presentato gentilissimo e disponibile. Inoltre la spa ha soddisfatto pienamente le tue aspettative poiché ben pulita e dall\'ambiente confortevole. Coerentemente con le foto mostrate, è fornita di un ampio e bellissimo parco tranquillo e rilassante.','Lascia la tua recensione sul sito.'],
    ),
    Item(
      name: '13.jpg',
      type: ItemType.service,
      description:
          ['Il tuo pc presenta un problema. Cerchi in ogni modo di risolverlo poiché stai preparando la tua tesi e temi di perdere il lavoro svolto. Dopo diversi tentativi, decidi di chiamare l\'assistenza. Il tecnico si mostra da subito disponibile e preparato. Sentendoti agitata ti tranquillizza, e con tono gentile e paziente ti dà le linee guida per rimettere in funzione il pc.','Fai una recensione della tua esperienza.'],
    ),
    Item(
      name: '14.png',
      type: ItemType.product,
      description:
          ['Sei un musicista e devi recarti all\'estero per un concerto. All\'arrivo, sceso dall\'aereo, ti rendi conto che ti è stato smarrito il violino. Poiché non conosci bene la città in cui ti trovi, ordini un nuovo violino da un negozio di musica on-line.','La consegna è veloce e puntuale e il prodotto si presenta in ottime condizioni. Sollevato e soddisfatto della tua esperienza con il negozio, decidi di lasciare una recensione.'],
    ),
    Item(
      name: '15.png',
      type: ItemType.product,
      description:
          ['Tieni molto al tuo aspetto esteriore e cerchi continuamente prodotti nuovi ed efficaci per il tuo corpo. Decidi, quindi di provare una gamma di creme da un sito on-line di cosmesi. La consegna degli articoli rispetta la data prevista e hai notato risultati positivi e migliorativi in breve tempo.','Lascia una recensione alla tua esperienza.'],
    ),
    Item(
      name: '16.png',
      type: ItemType.product,
      description:
          ['Fai un acquisto on-line di un abito elegante per te molto importante poiché lo dovrai indossare ad una presentazione di lavoro. Quando ricevi l\'ordine questo non cossrispone alla foto, il tessuto è scadente e inoltre è già strappato.', 'Fai una recensione.'],
    ),
    Item(
        name: '17.png',
        type: ItemType.product,
        description:
            ['Decidi di acquistare un libro on-line per fare un regalo ad una tua cara amica. La consegna non rispetta la data prevista di arrivo e la copertina è rovinata. Lascia una recensione.']),
    Item(
      name: '18.png',
      type: ItemType.product,
      description:
          ['Decidi di comperare un paio di cuffie on-line. Alla consegna trovi il prodotto mediocre, la qualità del suono molto bassa e sono già difettose.','Lascia una recensione della tua esperienza'],
    ),
    Item(
      name: '19.png',
      type: ItemType.product,
      description:
          ['Acquisti un paio di scarpe on-line. All\'arrivo della consegna noti che colore e numero non corrispondono alla tua richiesta. Inoltre, nel far notare l\'errore al fattorino, questi si rivolge con tono scontroso e infastidito nei tuoi confronti. Fai una recensione.']
    ),
    Item(
      name: '20.png',
      type: ItemType.product,
      description:
      [
        'Esegui un ordine on-line di un braccialetto. Alla consegna ti rendi conto che l\'articolo è bello a vedersi, ma qualitativamente scadente.',
        'Dopo due giorni dal suo utilizzo si sono staccate delle pietre e il gancio di bloccaggio è difettoso, si apre con estrema facilà. Lascia una recensione.'
      ],
    ),
    Item(
      name: '21.webp',
      type: ItemType.product,
      description:
      [
        'Hai bisogno di appendere alcune mensole nella tua nuova casa, ma non hai tempo per andare dal ferramenta ad acquistare un trapano. Decidi di acquistare un trapano on-line, da un sito internet che vanta utensili di buon qualità a prezzi ridotti.',
        'Il trapano ti viene consegnato a casa con molto ritardo. La plastica da cui è ricoperto pare quella di un giocattolo. Le punte non sono buone, tanto che rovini il muro di casa lasciando dei buchi grossi e mal fatti'
      ],
    ),
    Item(
      name: '22.png',
      type: ItemType.product,
      description:
      [
        'Durante la primavera un\'associazione che sostiene pazienti affetti da malattie rare è presente nelle piazze italiane per vendere delle ortensie. Hai deciso di acquistarne una per il tuo giardino, nonostante il prezzo di gran lunga superiore rispetto al normale.',
        'Al momento dell\'acquisto l\'ortensia era piuttosto sfiorita e appassita ed è morta pochi giorni dopo. La tua amica Sara, che lavora come volontaria presso l\'associazione, ti chiede di lasciare una recensione positiva sul sito dell\'associazione per aiutarli a incrementare le vendite che non stanno andando molto bene.'
      ],
    ),
  ];

  static List<Item> _testItems = [
    Item(
        name: 'test_1.jpg',
        description: ['Osserva questa immagine:'],
        question: 'Quante tazzine sono presenti nell’immagine?',
        expectedAnswer: 4,
        ),
    Item(
      name: 'test_2.jpg',
      description: ['Osserva questa immagine:'],
      question: 'Qual è il risultato dell’operazione nel palloncino?',
      expectedAnswer: 2,
    ),
    Item(
      name: 'test_3.jpg',
      description: ['Osserva questa immagine:'],
      question: 'Quanti erano i moschettieri, compagni di D’Artagnan?',
      expectedAnswer: 3,
    ),
    Item(
      name: 'test_4.jpg',
      description: ['Osserva questa immagine:'],
      question: 'Quanti anni compie questa bambina?',
      expectedAnswer: 1,
    ),
    Item(
      name: 'test_5.jpg',
      description: ['Osserva questa immagine:'],
      question: 'Quante dita ci sono in una mano?',
      expectedAnswer: 5,
    ),
    ];


  ItemsProvider() {
    _itemsBag.shuffle();
  }

  Item getOne() {
    if(_itemsBag.isNotEmpty) {
      return _itemsBag.removeLast();
    } else {
      return null;
    }
  }

  Item getOneTest() {
    if (_testItems.isNotEmpty) {
      return _testItems.removeAt(0);
    } else {
      return null;
    }
  }
}

enum ItemType { product, service, firm }

class Item {
  final String name;
  final ItemType type;
  final List<String> description;
  String question;
  final bool isTest;
  final int expectedAnswer;

  Item({
    @required this.name,
    @required this.description,
    this.type,
    this.question,
    this.expectedAnswer,
    this.isTest = false,
  }) {
    switch (this.type) {
      case ItemType.product:
        this.question = 'Come valuti il prodotto?';
        break;
      case ItemType.firm:
        this.question = 'Come valuti l\'azienda?';
        break;
      case ItemType.service:
        this.question = 'Come valuti il servizio?';
    }
  }
}
