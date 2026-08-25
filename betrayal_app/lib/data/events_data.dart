import '../models/event_card.dart';

const List<EventCard> allEvents = [
  EventCard(
    title: 'Geometria Alienígena',
    description: 'Os ângulos desta sala não batem certo. A sala é quadrada, mas tem cinco cantos. Um dos cantos está ao contrário. Você tenta chegar à porta, mas ela está sempre do outro lado da sala.',
    testType: 'Conhecimento',
    diceResults: [
      DiceResult(range: '4+', effect: 'Ganhe 1 ponto de sanidade.', flavorText: 'Começa a fazer sentido!'),
      DiceResult(range: '0-3', effect: 'Perca 1 ponto de velocidade.', flavorText: 'Você sente vertigem.'),
    ],
  ),
  EventCard(
    title: 'A Casa Mais Antiga',
    description: 'O ar parece diferente aqui... mais antigo. A distância parece arbitrária. Você perde rapidamente a noção do tempo.',
    testType: 'Velocidade ou Força',
    diceResults: [
      DiceResult(range: '5+', effect: 'Coloque seu explorador em qualquer peça.', flavorText: 'Você faz a conexão.'),
      DiceResult(range: '3-4', effect: 'Coloque seu explorador em qualquer peça do piso térreo. Receba 1 ponto de dano geral.', flavorText: 'Onde estou?'),
      DiceResult(range: '0-2', effect: 'Coloque seu explorador em qualquer peça do porão. Receba 1 ponto de dano mental.', flavorText: 'Que horas são? Que ano estamos?'),
    ],
  ),
  EventCard(
    title: 'Um Respingo de Crimson',
    description: 'Pegadas ensanguentadas aparecem no chão. Elas estão se movendo em sua direção. Rapidamente.',
    condition: 'Se a assombração ainda não tiver começado, você pode fazer um teste de assombração.',
    diceResults: [
      DiceResult(range: '5+', effect: 'Vá para o Assombração 1 no Livro do Traidor. Você é o traidor.'),
      DiceResult(range: '0-4', effect: 'Ganhe 1 de Velocidade.', flavorText: 'Você recua rapidamente.'),
    ],
    note: 'Se a assombração tiver começado, ou se você optar por não fazer um teste de assombração, receba um dado de dano físico.',
  ),
  EventCard(
    title: 'Conhecimento Proibido',
    description: 'Você sopra um pouco de poeira do chão e encontra gravuras nas tábuas. Elas descrevem segredos que é melhor manter escondidos.',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(range: '4+', effect: 'Ganhe 1 ponto de Conhecimento.', flavorText: 'Agora esses segredos são seus.'),
      DiceResult(range: '2-3', effect: 'Ganhe 1 ponto de Conhecimento e perca 1 ponto de Sanidade.', flavorText: 'O conhecimento o deixa nervoso.'),
      DiceResult(range: '0-1', effect: 'Receba 2 pontos de dano mental.', flavorText: 'Você não consegue nem se lembrar do que leu, apenas do horror que sentiu.'),
    ],
  ),
  EventCard(
    title: 'Alimento para o Cérebro',
    description: 'Uma forma de gelatina trêmula em uma bandeja de prata. O cheiro é convidativo.',
    testType: 'Força',
    diceResults: [
      DiceResult(range: '5+', effect: 'Ganhe 1 de Poder ou Velocidade.', flavorText: 'Delicioso.'),
      DiceResult(range: '1-4', effect: 'Ganhe 1 de Velocidade e perca 1 de Sanidade.', flavorText: 'Você engasga, mas consegue engolir.'),
      DiceResult(range: '0', effect: 'Receba 2 pontos de dano geral.', flavorText: 'Agora você sabe qual é o gosto de cérebro humano.'),
    ],
  ),
  EventCard(
    title: 'A Floração',
    description: 'Uma flor gigante e colorida ocupa uma parede inteira. Suas pétalas desabrocham em um grande caminho aberto.',
    additionalEffect: 'Receba 1 ponto de dano geral. Coloque seu explorador em qualquer peça do porão ou térreo. Se a peça do Conservatório tiver sido descoberta, você deve colocar seu explorador lá.',
  ),
  EventCard(
    title: 'Um Frasco de Poeira',
    description: 'Uma redoma de vidro contendo uma partícula estranha. Olhando mais de perto, você percebe que se trata de um pó fino. Ele reveste o interior do vidro.',
    condition: 'Se a assombração ainda não tiver começado, você pode fazer um teste de assombração.',
    diceResults: [
      DiceResult(range: '5+', effect: 'Vá para a assombração 3 no Livro do Traidor. Você é o revelador do fantasma.'),
      DiceResult(range: '0-4', effect: 'Ganhe 1 ponto de sanidade.', flavorText: 'Você se vira, mas não há ninguém lá.'),
    ],
    note: 'Se a assombração tiver começado, ou se você optou por não fazer um teste de assombração, perca 1 de Poder e ganhe 1 de Sanidade.',
  ),
  EventCard(
    title: 'Arquitetura Impossível',
    description: 'Esta sala é muito maior do que deveria ser. Uma cômoda aparece diante de você. Dentro dela, algo começa a tremer.',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(range: '4+', effect: 'Pegue uma carta de Item.', flavorText: 'Útil!'),
      DiceResult(range: '0-3', effect: 'Receba um dado de dano mental.', flavorText: 'Mãos e pés sem corpo rastejam para fora da cômoda.'),
    ],
  ),
  EventCard(
    title: 'Tocador de Fita Cassete',
    description: 'Há um toca-fitas sobre uma mesa nesta sala. Você o pega e aperta o botão play, e ele começa a funcionar com um chiado. Uma voz gravada sussurra: "Se você consegue ouvir isso, é tarde demais para mim, mas talvez eu ainda possa ajudá-lo."',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(range: '4+', effect: 'Ganhe 1 ponto de Conhecimento.', flavorText: 'A voz revela os segredos da casa.'),
      DiceResult(range: '0-3', effect: 'Receba 1 ponto de dano mental.', flavorText: 'A voz lhe diz como você irá morrer.'),
    ],
  ),
  EventCard(
    title: 'Uma Sensação Estranha',
    description: 'Ao cruzar a soleira, você tem uma sensação estranha no peito, como se alguém estivesse revirando seus pulmões.',
    rollInstruction: 'Jogue 2 dados.',
    diceResults: [
      DiceResult(range: '4', effect: 'Nada acontece.', flavorText: 'Isso foi estranho.'),
      DiceResult(range: '3', effect: 'Perca 1 de velocidade.'),
      DiceResult(range: '2', effect: 'Perca 1 de sanidade.'),
      DiceResult(range: '1', effect: 'Perca 1 de conhecimento.'),
      DiceResult(range: '0', effect: 'Perca 1 de poder.'),
    ],
  ),
  EventCard(
    title: 'Mão Cortada',
    description: 'A mão está segurando... alguma coisa. O que é isso?',
    additionalEffect: 'Você pode receber 2 pontos de dano físico. Se isso acontecer, compre uma carta de Item.',
  ),
  EventCard(
    title: 'Diga Xiis',
    description: 'Um clarão brilhante surge quando você entra na sala. Pontinhos dançam em seus olhos enquanto sua visão volta. Eles parecem estar levando você a algo.',
    condition: 'Se a assombração ainda não tiver começado, você pode fazer um teste de assombração.',
    diceResults: [
      DiceResult(range: '5+', effect: 'Vá até a página 33 do Livro do Traidor. Se algum herói tiver a Câmera Mágica, ele é o traidor. Caso contrário, você é o traidor.'),
      DiceResult(range: '0-4', effect: 'Compre uma carta de item.', flavorText: 'As manchas levam a um canto da sala.'),
    ],
    note: 'Se a assombração tiver começado, ou se você optou por não fazer um teste de assombração, compre uma carta de Item.',
  ),
  EventCard(
    title: 'Sala dos Palhaços',
    description: 'Todos os acessórios e móveis parecem ter pequenos rostos. Todos estão sorrindo. Todos estão olhando fixamente.',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(range: '4+', effect: 'Não acontece nada.', flavorText: 'É assustador, mas é apenas mobília.'),
      DiceResult(range: '0-3', effect: 'Receba 2 pontos de dano mental.', flavorText: 'O abajur e a cadeira começam a rir de você. Ha! Haha! HAHAHAHAHA!!!'),
    ],
  ),
  EventCard(
    title: 'Noite Escura e Tempestuosa',
    description: 'O trovão estala lá fora e o vento bate contra as paredes. Algo bate à porta. Tudo fica cada vez mais alto, até que seus ouvidos começam a doer.',
    testType: 'Conhecimento',
    diceResults: [
      DiceResult(range: '4+', effect: 'Ganhe 1 ponto de sanidade.', flavorText: 'Você se esconde debaixo de uma mesa até que o barulho pare.'),
      DiceResult(range: '0-3', effect: 'Receba 1 ponto de dano mental.', flavorText: 'Será que esse barulho nunca vai parar?'),
    ],
  ),
  EventCard(
    title: 'Frasco de Órgãos',
    description: 'Você descobre um enorme jarro contendo um estômago bem preservado e alguns órgãos menos identificáveis. O estômago está suspeitamente protuberante. Você não consegue se conter e, cautelosamente, coloca a mão dentro do jarro.',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(range: '4+', effect: 'Compre uma carta de Item.', flavorText: 'Eca, que nojento.'),
      DiceResult(range: '0-3', effect: 'Perca 1 de Força.', flavorText: 'Ácido estomacal!'),
    ],
  ),
  EventCard(
    title: 'Espelho Assustador',
    description: 'Há um espelho na parede. Alguém está atrás de você, tentando alcançá-lo.',
    condition: 'Se a assombração ainda não tiver começado, você pode fazer um teste de assombração.',
    diceResults: [
      DiceResult(range: '5+', effect: 'Vá para a assombração 7 no livro Segredos dos Sobreviventes. Esta assombração não tem traidor. Você é o revelador da assombração.'),
      DiceResult(range: '0-4', effect: 'Ganhe 1 ponto de sanidade.', flavorText: 'Você se vira, mas não há ninguém lá.'),
    ],
    note: 'Se a assombração tiver começado, ou se você optou por não fazer um teste de assombração, compre uma carta de Item.',
  ),
  EventCard(
    title: 'Fluido Misterioso',
    description: 'Brilha e reluz à luz e tem aroma de frutas vermelhas.',
    rollInstruction: 'Você pode beber o líquido. Se o fizer, jogue 3 dados.',
    diceResults: [
      DiceResult(range: '6', effect: 'Ganhe 1 em cada atributo.'),
      DiceResult(range: '5', effect: 'Ganhe 1 de Força e 1 de Velocidade.'),
      DiceResult(range: '4', effect: 'Ganhe 1 ponto de Conhecimento e 1 ponto de Sanidade.'),
      DiceResult(range: '3', effect: 'Ganhe 1 ponto de Conhecimento e perca 1 ponto de Força.'),
      DiceResult(range: '2', effect: 'Perca 1 ponto de Conhecimento e 1 ponto de Sanidade.'),
      DiceResult(range: '1', effect: 'Perca 1 ponto de Força e 1 ponto de Velocidade.'),
      DiceResult(range: '0', effect: 'Perca 1 em cada característica.'),
    ],
  ),
  EventCard(
    title: 'Atrás de Você!',
    description: 'Assim que você entra pela porta, algo lhe dá um tapinha no ombro. Você se vira para ver quem é.',
    testType: 'Velocidade',
    diceResults: [
      DiceResult(range: '4+', effect: 'Ganhe 1 ponto de sanidade.', flavorText: 'Não há ninguém aí. Deve ter sido o vento.'),
      DiceResult(range: '0-3', effect: 'Receba 1 ponto de dano físico.', flavorText: 'Garras enormes atacam seu rosto!'),
    ],
  ),
  EventCard(
    title: 'A Casa Está com Fome',
    description: 'Há um barulho ao seu redor, como um estômago vazio.',
    condition: 'Se a assombração ainda não tiver começado, você pode fazer um teste de assombração.',
    diceResults: [
      DiceResult(range: '5+', effect: 'Vá para assombração 12 no Livro do Traidor. Este fantasma não tem traidor. Você é quem revela o fantasma.'),
      DiceResult(range: '0-4', effect: 'Ganhe 1 ponto de poder.', flavorText: 'O estrondo diminui.'),
    ],
    note: 'Se a assombração tiver começado, ou se você optou por não fazer um teste de assombração, ganhe 1 em qualquer característica.',
  ),
  EventCard(
    title: 'O Armário Mais Profundo',
    description: 'Este armário é mais profundo do que a parede. Muito mais profundo. Você começa a vasculhar o interior, mas não consegue encontrar o fundo.',
    testType: 'Velocidade',
    diceResults: [
      DiceResult(range: '4+', effect: 'Compre uma carta de Item.', flavorText: 'O que é isto?'),
      DiceResult(range: '1-3', effect: 'Receba 1 ponto de dano mental.', flavorText: 'Você recua em pânico ao sentir um hálito quente em suas mãos.'),
      DiceResult(range: '0', effect: 'Receba um dado de dano físico. Coloque seu explorador no patamar do porão. Você caiu!'),
    ],
  ),
  EventCard(
    title: 'Uma Mesa Cheia',
    description: 'Uma dúzia de figuras de cera estão sentadas à mesa, que está totalmente posta. Um lugar foi reservado para você.',
    testType: 'Conhecimento ou Sanidade',
    diceResults: [
      DiceResult(range: '5+', effect: 'Ganhe 1 de velocidade.', flavorText: 'O peru está cozido na perfeição.'),
      DiceResult(range: '0-4', effect: 'Receba 1 ponto de dano geral.', flavorText: 'Você cospe uma boca cheia de cera.'),
    ],
  ),
  EventCard(
    title: 'Aranhas!',
    description: 'Devem ser milhares. Estão por toda parte — caindo, rastejando, correndo. Eles sobem pelas suas pernas, tentando te morder!',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(range: '4+', effect: 'Ganhe 1 ponto de sanidade ou 1 ponto de velocidade. Coloque seu explorador em uma peça adjacente.', flavorText: 'Você mantém a cabeça fria.'),
      DiceResult(range: '2-3', effect: 'Ganhe 1 de Velocidade e perca 1 de Sanidade.', flavorText: 'Você sai. Rapidamente.'),
      DiceResult(range: '0-1', effect: 'Perca 1 ponto de velocidade.', flavorText: 'Você fica paralisado no lugar. Eventualmente, as aranhas se afastam.'),
    ],
  ),
  EventCard(
    title: 'Dificuldades Técnicas',
    description: 'Você abre um armário e encontra um homem arrumando fios. Ele olha para você, surpreso, e diz: "Você não deveria estar aqui!" Ele puxa uma alavanca e o chão se abre sob seus pés.',
    additionalEffect: 'Coloque seu explorador na peça inicial do andar de baixo. Se você já estiver no porão, coloque seu explorador no patamar superior e receba 1 ponto de dano mental.',
  ),
  EventCard(
    title: 'Pequeno Robô',
    description: 'Um pequeno robô zumbindo fica ao lado dos seus pés. Ele emite um sinal sonoro para você.',
    testType: 'Conhecimento',
    diceResults: [
      DiceResult(range: '5+', effect: 'Pegue uma carta de Item.', flavorText: 'O robô emite um bipe alegre e entrega algo para você.'),
      DiceResult(range: '0-4', effect: 'Receba um dado de dano físico.', flavorText: 'Ele perfura suas pernas.'),
    ],
  ),
  EventCard(
    title: 'Um Morcego do Inferno',
    description: 'Um morcego em chamas voa em sua direção. Ele grita e mergulha em direção ao seu rosto!',
    testType: 'Velocidade',
    diceResults: [
      DiceResult(range: '4+', effect: 'Coloque seu explorador em uma peça adjacente.', flavorText: 'Você se esquiva para fora do caminho.'),
      DiceResult(range: '0-3', effect: 'Receba 1 ponto de dano físico.', flavorText: 'Isso queima!'),
    ],
  ),
  EventCard(
    title: 'Porta Rangindo',
    description: 'Uma porta que não estava lá antes se abre rangendo. Do outro lado, um homem segura uma lanterna. À medida que a luz tremeluz pela porta, o homem acena para você se aproximar.',
    testType: 'Conhecimento',
    diceResults: [
      DiceResult(range: '6+', effect: 'Coloque seu explorador em qualquer peça do andar superior ou térreo.', flavorText: 'Aqui?'),
      DiceResult(range: '4-5', effect: 'Coloque seu explorador em qualquer peça do piso térreo.', flavorText: 'Talvez ali?'),
      DiceResult(range: '0-3', effect: 'Coloque seu explorador na peça do patamar do porão.', flavorText: 'O que há lá embaixo?'),
    ],
  ),
  EventCard(
    title: 'As Estrelas à Noite',
    description: 'Há luzes no teto escuro, cintilando por toda a sala. São tantas que é impossível contá-las. O que são? Estrelas? Olhos?',
    rollInstruction: 'Escolha uma característica para rolar.',
    diceResults: [
      DiceResult(range: '5+', effect: 'Ganhe 1 no atributo escolhido.'),
      DiceResult(range: '4', effect: 'Perca 1 no atributo escolhido.'),
      DiceResult(range: '0-3', effect: 'Cure o atributo escolhido.'),
    ],
  ),
  EventCard(
    title: 'Figura em Chamas',
    description: 'Um homem em chamas atravessa a sala correndo. Sua pele borbulha e racha, caindo e deixando para trás uma caveira em chamas. A caveira cai no chão, rola para longe e desaparece.',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(range: '4+', effect: 'Ganhe 1 ponto de sanidade.', flavorText: 'Você se sente um pouco irritado.'),
      DiceResult(range: '2-3', effect: 'Coloque seu explorador na peça inicial do térreo.', flavorText: 'Fora, fora! Você precisa sair!'),
      DiceResult(range: '0-1', effect: 'Receba um dado de dano físico e um dado de dano mental.', flavorText: 'Você entra em chamas.'),
    ],
  ),
  EventCard(
    title: 'Musgo de Carne',
    description: 'A sala está coberta de plantas estranhas. Elas têm um aroma terroso, quase selvagem. Elas se movem sozinhas, quase como se estivessem respirando.',
    rollInstruction: 'Você pode inalar o aroma. Se o fizer, jogue 2 dados.',
    diceResults: [
      DiceResult(range: '3-4', effect: 'Ganhe 1 em qualquer atributo.', flavorText: 'Revigorante!'),
      DiceResult(range: '0-2', effect: 'Receba um dado de dano mental.', flavorText: 'Ugh! Cheira a morte.'),
    ],
  ),
  EventCard(
    title: 'Um Momento de Esperança',
    description: 'Há algo estranhamente certo nesta sala. Algo aqui resiste ao mal da casa.',
    additionalEffect: 'Coloque um token de Bênção na sua peça. (Um herói na mesma peça que o token de Bênção deve rolar um dado extra em todos os lançamentos de atributos.)',
  ),
  EventCard(
    title: 'Uma Mordida!',
    description: 'Algo salta das sombras e tenta mordê-lo!',
    testType: 'Força',
    diceResults: [
      DiceResult(range: '4+', effect: 'Nada acontece.', flavorText: 'Você luta contra o quer que fosse. Ele foge para as sombras.'),
      DiceResult(range: '2-3', effect: 'Receba 1 ponto de dano físico.', flavorText: 'Apenas um pequeno arranhão. Provavelmente nem vale a pena mencionar aos outros.'),
      DiceResult(range: '0-1', effect: 'Receba 3 pontos de dano físico.', flavorText: 'Ai! Que mordida forte.'),
    ],
  ),
  EventCard(
    title: 'Uma Passagem Secreta',
    description: 'Há algo de estranho nesta parede. Quando se bate, ela emite um som oco.',
    testType: 'Conhecimento',
    additionalEffect: 'Coloque um token de Passagem Secreta em sua peça de mapa.',
    diceResults: [
      DiceResult(range: '5+', effect: 'Coloque outro token de Passagem Secreta em qualquer outra peça de mapa. Ganhe 1 ponto de Conhecimento.'),
      DiceResult(range: '3-4', effect: 'Coloque outro token de Passagem Secreta em qualquer peça do Piso Térreo.'),
      DiceResult(range: '0-2', effect: 'Coloque outro token de Passagem Secreta em qualquer peça do Porão. Perca 1 ponto de Sanidade.'),
    ],
    note: 'Os jogadores podem se mover entre as peças marcadas com Passagens Secretas.',
  ),
  EventCard(
    title: 'A Vez de Jonah',
    description: 'Dois meninos estão brincando com um pião de madeira. "Você quer jogar, Jonah?", pergunta um deles.\n\n"Não", diz Jonah, "quero todas as voltas". Jonah pega a bola e acerta o outro menino no rosto. O menino cai. Jonah continua batendo nele, mesmo quando eles desaparecem de vista.',
    additionalEffect: 'Você pode descartar qualquer item que não seja uma arma. Se o fizer, ganhe 1 ponto de Sanidade. Caso contrário, receba um dado de dano Mental.',
  ),
  EventCard(
    title: 'Funeral',
    description: 'Você tem uma visão de um caixão aberto e está deitado nele.',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(range: '4+', effect: 'Ganhe 1 ponto de sanidade.', flavorText: 'Você pisca e ele desaparece.'),
      DiceResult(range: '2-3', effect: 'Perca 1 ponto de sanidade.', flavorText: 'A visão o perturba.'),
      DiceResult(range: '0-1', effect: 'Perca 1 ponto de Sanidade e 1 ponto de Força.', flavorText: 'Você está realmente naquele caixão.'),
    ],
    note: 'Se as peças Cemitério ou Catacumbas tiverem sido descobertas, coloque seu explorador em uma dessas peças.',
  ),
  EventCard(
    title: 'Elevador Secreto',
    description: 'Uma parede se abre para revelar um elevador de pratos. É apertado, mas você poderia rastejar para dentro se precisasse.',
    additionalEffect: 'Você pode se posicionar em qualquer peça em uma região diferente.',
  ),
  EventCard(
    title: 'Transmissão de Rádio',
    description: 'Um rádio chiando atrás de você e uma voz distorcida começa a ler notícias de anos atrás. "Neste dia, em 1980..."',
    rollInstruction: 'Jogue 2 dados.',
    diceResults: [
      DiceResult(range: '3-4', effect: 'Ganhe 1 ponto de Conhecimento.', flavorText: '"...essa música foi lançada!" Uma melodia alegre começa a tocar.'),
      DiceResult(range: '0-2', effect: 'Receba um dado de dano mental.', flavorText: '"... um ataque nuclear foi lançado sobre Washington, D.C."'),
    ],
  ),
  EventCard(
    title: 'Fantasma Errante',
    description: 'Uma figura envolta em um manto emerge da parede, estendendo uma mão translúcida. Ela está oferecendo algo a você? Convidando você para seus braços?',
    additionalEffect: 'Você pode enterrar um dos seus itens. Se o fizer, ganhe 1 em qualquer atributo. Caso contrário, faça um teste de Sanidade.',
    diceResults: [
      DiceResult(range: '4+', effect: 'Compre uma carta de Item.', flavorText: 'Deve ter sido um efeito da luz. O que é aquilo no chão?'),
      DiceResult(range: '0-3', effect: 'Receba 1 ponto de dano geral.', flavorText: 'A figura está descontente. Ela ataca.'),
    ],
  ),
  EventCard(
    title: 'Homens Enforcados',
    description: 'Uma brisa arrefece a sala. À sua frente, três homens estão pendurados em cordas desgastadas. Os seus olhos estão frios, mortos e vazios. Eles balançam silenciosamente com a brisa e depois caem numa nuvem de poeira. Você começa a sufocar.',
    rollInstruction: 'Role cada atributo, uma de cada vez.',
    diceResults: [
      DiceResult(range: '2+', effect: 'Nada acontece.'),
      DiceResult(range: '0-1', effect: 'Perca 1 ponto dessa característica.'),
    ],
    note: 'Se você rolar 2+ em todas as quatro rolagens, ganhe 1 em qualquer atributo.',
  ),
  EventCard(
    title: 'Um Grito por Socorro',
    description: 'A voz de um homem ecoa pelos corredores, chamando você pelo nome. Ela grita em agonia: "Ajude-me!"',
    testType: 'Conhecimento',
    diceResults: [
      DiceResult(range: '4+', effect: 'Coloque seu explorador em qualquer peça da sua região.', flavorText: 'De onde isso poderia estar vindo?'),
      DiceResult(range: '0-3', effect: 'Receba 1 ponto de dano mental.', flavorText: 'A voz grita e depois fica em silêncio.'),
    ],
  ),
  EventCard(
    title: 'Ligação Telefônica',
    description: 'Um telefone antigo toca na sala. Você atende e uma voz doce de uma senhora idosa fala do outro lado da linha.',
    rollInstruction: 'Jogue 2 dados.',
    diceResults: [
      DiceResult(range: '4+', effect: 'Ganhe 1 ponto de Sanidade.', flavorText: '"Chá e bolinhos, chá e bolinhos. Você sempre foi meu favorito."'),
      DiceResult(range: '3', effect: 'Ganhe 1 ponto de Conhecimento.', flavorText: '"Estou sempre aqui para você. Observando."'),
      DiceResult(range: '1-2', effect: 'Receba um dado de dano mental.', flavorText: '"Estou aqui, querida. Dê-nos um beijo."'),
      DiceResult(range: '0', effect: 'Receba dois dados de dano físico.', flavorText: '"Crianças malcriadas devem ser punidas."'),
    ],
  ),
  EventCard(
    title: 'Taxidermia',
    description: 'Uma mistura absolutamente enorme de vários animais, costurados aleatoriamente. Você dá um empurrão na coisa.',
    testType: 'Força',
    diceResults: [
      DiceResult(range: '5+', effect: 'Ganhe 1 ponto de sanidade.', flavorText: 'Quem poderia ter feito uma coisa dessas?'),
      DiceResult(range: '0-4', effect: 'Receba 1 ponto de dano físico. Coloque um token de Obstáculo nessa peça.', flavorText: 'Ele cai sobre você, explodindo em um recheio molhado.'),
    ],
  ),
  EventCard(
    title: 'Pobre Yorick',
    description: 'Um crânio sobre a mesa recita palavras de um livro aberto. "Ser ou não ser? Essa é a questão. Se é mais nobre sofrer na mente Os golpes e flechadas da sorte ultrajante..."',
    testType: 'Sanidade',
    diceResults: [
      DiceResult(range: '4+', effect: 'Ganhe 1 ponto de Conhecimento.', flavorText: 'Inspirador!'),
      DiceResult(range: '0-3', effect: 'Receba 1 ponto de dano mental.', flavorText: 'As palavras são assustadoras.'),
    ],
  ),
  EventCard(
    title: 'Luzes Piscando',
    description: 'As luzes se apagam e começam a piscar. Uma porta se abre do outro lado da sala. Entre os piscar, uma figura aparece e desaparece.',
    testType: 'Velocidade ou Força',
    diceResults: [
      DiceResult(range: '5+', effect: 'Ganhe 1 de Velocidade.', flavorText: 'Você derruba a figura no chão, e ela desaparece.'),
      DiceResult(range: '0-4', effect: 'Receba um dado de dano físico.', flavorText: 'Ele ataca!'),
    ],
  ),
];
