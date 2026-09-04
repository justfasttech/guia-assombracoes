import '../models/event_card.dart';

const List<EventCard> allPennywiseEncounters = [
  EventCard(
    title: 'Luzes Flutuantes',
    description:
        '3 luzes laranjas brilhantes flutuam ao redor em formação de triângulo e seu estômago embrulha. Você viu o que elas fizeram com a mente dos seus amigos todos esses anos atrás. Você corre pela sua vida.',
    testType: 'Velocidade',
    diceResults: [
      DiceResult(
        range: '4+',
        effect: 'Ganhe 2 de Sanidade.',
        flavorText:
            'Você evita as luzes e solta um alívio silencioso enquanto elas passam.',
      ),
      DiceResult(
        range: '0-3',
        effect: 'Perca 1 de Sanidade.',
        flavorText:
            'Você não consegue resistir a tentação das luzes e encara mais do que deveria.',
      ),
    ],
    note:
        'Se a assombração ainda não começou, faça um teste de assombração. Se a assombração já começou, Pennywise usa as Luzes da Morte.',
  ),
  EventCard(
    title: 'Horrores da Cidade Natal',
    description:
        'Pennywise flutua do teto em sua direção, carregando varios balões. Ele diz "Eu sei seu segredo..." seu coração acelera enquanto ele pergunta, "Eu deveria contar a eles?" a sala derrepente se enche com rostos da sua cidade natal.',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(
        range: '4+',
        effect: 'Ganhe 1 de Sanidade e compre uma carta de Presságio.',
        flavorText: 'Você fecha seus olhos, Ele não é real. Quando você abre os olhos, ele se foi, e alguma coisa esta no seus pés.'
      ),
      DiceResult(
        range: '0-3',
        effect:
            'Receba 1 de dano Mental.',
            flavorText: 'Em vez de esperar por sua resposta, o palhaço se aproxima com infinitos dentes... então desaparece.'
      ),
    ],
    note:
        'Se a assombração ainda não começou, faça um teste de assombração. Se a assombração já começou, Pennywise usa as Luzes da Morte.',
  ),
  EventCard(
    title: 'Hora de Afundar',
    description:
        'A sala rapidamente começa a encher com água cinzenta. Você tenta alcançar a saída, mas uma mulher enorme emerge da lama e segura você. Ela tem uma pele translucida e olhos esbugalhados, tentando puxar você para baixo.',
    testType: 'Velocidade',
    diceResults: [
      DiceResult(
        range: '4+',
        effect: 'Ganhe 1 de Força.',
        flavorText:
            'Você consegue se libertar e nadar em direção à porta. Quando olha para trás, a mulher se foi.',
      ),
      DiceResult(
        range: '0-3',
        effect: 'Perca 1 de Velocidade.',
        flavorText:
            'A mulher te puxa para baixo cada vez mais e mais... até você sentir uma dor no seu tonorzelo, então ela e a agua desaparece.',
      ),
    ],
    note:
        'Se a assombração ainda não começou, faça um teste de assombração Se a assombração já começou, pegue o token de Balão Vermelho. Você agora é o alvo do Pennywise, e ele se move em sua direção.',
  ),
  EventCard(
    title: 'Bom Garoto',
    description:
        'Diante de três portas marcadas "Assustador", "Muito Assustador" e "Nada Assustador" em tinta vermelho-sangue. Um pequeno e fofo Lulu está sentado atrás da porta. É fofo! Com olhinhos de cachorrinho, você escolhe entrar. É seguro! Certo? de repente o Lulu se transforma em um monstro gigante e assustador.',
    rollInstruction:
        'Receba um teste de ataque de um inimigo com Velocidade 4 e defenda-se. Se você não receber dano, coloque sua figura em uma sala adjacente e ganha 1 de sanidade.',

    note:
        'Se a assombração não começou, faça um teste de assombração, Se a assombração já começou, pegue o token de Balões Vermelhos. Você agora é o alvo do Pennywise, e ele se move em sua direção.',
  ),
  EventCard(
    title: 'O Devorador de Mundos',
    description:
        'Uma voz uivante ecoa estranhamente das paredes. Você sente uma energia forte puxando você... será a próxima refeição dele. Você tem coragem de enfrentá-lo?',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(
        range: '4+',
        effect:
            'Coloque sua figura em uma peça adjacente e compre uma carta de Presságio.',
            flavorText: 'Embora sinta medo, você resiste. A presença desapareceu.'
      ),
      DiceResult(
        range: '0-3',
        effect:
            'Receba 1 de dano geral.',
            flavorText: 'Suas mãos começam a tremer, o chão balança e você perde o equilíbrio antes de cair no chão.'
      ),
    ],
    note:
        'Se a assombração ainda não começou, faça um teste de assombração. Se a assombração já começou, Pennywise se move em direção ao seu alvo e ataca ele, puxe outra carta de encontro.',
  ),
  EventCard(
    title: 'Faca no Escuro',
    description:
        'Você ouve passos pesados atrás de você e se vira. Você está cara a cara com o valentão da sua infância, empunhando seu canivete favorito com um sorriso maníaco.',
    rollInstruction:
        'Receba um ataque de um inimigo com Força 4 e defenda-se. Se vencer (não levar dano), ele derruba algo — compre uma carta de Presságio.',
    note:
        'Se a assombração não começou, faça um teste de assombração. Se a assombração já começou, embaralhe a pulha de discarte de encontros de volta no deck, então o pennywise faz um ataque contra um heroi em seu tile, se tiver algum.',
  ),
  EventCard(
    title: 'Um Estouro de Vermelho',
    description:
        'Um balão vermelho brilhante, cheio e prestes a estourar, está impossivelmente encaixado no canto da sala. Você puxa as cordas e... POP! Um cadáver pútrido salta de trás da borracha destruída.',
    testType: 'Força',
    diceResults: [
      DiceResult(
        range: '4+',
        effect:
            'Compre uma carta de Presságio. ',
            flavorText: 'Você rapidamente cuida da criatura nojenta. Ela derruba algo.'
      ),
      DiceResult(
        range: '0-3',
        effect:
            'Receba 1 dado de dano Físico e 1 dado de dano Mental. ',
            flavorText: 'Você reage tarde demais. A criatura afunda suas garras podres no seu ombro.'
      ),
    ],
    note:
        'Se a assombração não começou, faça um teste de assombração. Se a assombração já começou, Pennywise move em diração ao alvo e ataca ele, puxe outra carta de encontro.',
  ),
  EventCard(
    title: 'Tentáculos de Sangue',
    description:
        'Antigravidade. Sangue? Uma gosma carmesim preenche as rachaduras no chão e então sobe pelas paredes, como se gotejasse do teto. Os estranhos tentáculos preenchem a sala.',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(
        range: '4+',
        effect:
            'Compre uma carta de Presságio.',
            flavorText: 'Você desvia e serpenteia entre os tentáculos até alcançar a porta.'
      ),
      DiceResult(
        range: '0-3',
        effect:
            'Receba 1 de dano Mental.',
            flavorText: 'Congelado e com medo, você é preso pelo sangue. Ele se parte junto com você.'
      ),
    ],
    note:
        'Se a assombração ainda não começou, faça um teste de assombração. Se a assombração já começou, embaralhe a pulha de discarte de encontros de volta no deck, então o pennywise faz um ataque contra um heroi em seu tile, se tiver algum.',
  ),
  EventCard(
    title: 'Visões Giratórias',
    description:
        'Você toma um gole da sua garrafa de água... e instantaneamente sente tontura. A sala fica borrada e você cai no chão. Uma visão surreal se desdobra e você sente que algo grotesco está se formando ao redor.',
    testType: 'Conhecimento',
    diceResults: [
      DiceResult(
        range: '4+',
        effect:
            'Ganhe 1 em qualquer atributo.',
            flavorText: 'Você entende algo que não entendia antes.'
      ),
      DiceResult(
        range: '0-3',
        effect:
            'Receba 1 de dano Mental.',
            flavorText: 'Você sente náusea e acha difícil se levantar novamente.'
      ),
    ],
    note:
        'Se a assombração ainda não começou, faça um teste de assombração. Se a assombração já começou, Pennywise usa as Luzes da Morte.',
  ),
  EventCard(
    title: 'Um Corredor que se Estica',
    description:
        'Algo ondula. Você se move em direção à saída, mas conforme estica a mão, o corredor se alonga para longe e fora do seu alcance. Você olha para trás e a porta atrás de você desaparece. Você está preso em um vazio infinito.',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(
        range: '4+',
        effect:
            'Compre uma carta de Presságio. ',
        flavorText: 'Não é real. Não é real. Não é real. Quando você olha para cima, tudo volta ao normal.'
      ),
      DiceResult(
        range: '0-3',
        effect:
            'Receba 1 de dano Físico. ',
      flavorText: 'Você grita até não aguentar mais. Quando você olha para cima, as coisas parecem ter voltado ao normal.'
      ),
    ],
    note:
        'Se a assombração ainda não começou, faça um teste de assombração. Se a assombração já começou, Pennywise usa as Luzes da Morte.',
  ),
];
