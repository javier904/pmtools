// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get smartTodoListOrigin => 'Lista de origem';

  @override
  String get smartTodoSortTooltip => 'Opções de Ordenação';

  @override
  String get smartTodoSortManual => 'Manual';

  @override
  String get smartTodoSortDate => 'Recentes';

  @override
  String get smartTodoActionSortPriority => 'Reordenar por Prioridade';

  @override
  String get smartTodoActionSortDeadline => 'Reordenar por Prazo';

  @override
  String get smartTodoOrderUpdated => 'Ordem atualizada manualmente';

  @override
  String get newRetro => 'Nova Retro';

  @override
  String get appTitle => 'Keisen';

  @override
  String get goToHome => 'Ir para a Home';

  @override
  String get actionSave => 'Salvar';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionDelete => 'Excluir';

  @override
  String get actionEdit => 'Editar';

  @override
  String get actionCreate => 'Criar';

  @override
  String get actionAdd => 'Adicionar';

  @override
  String get actionClose => 'Fechar';

  @override
  String get agileSprint => 'Sprint';

  @override
  String get actionHide => 'Ocultar Cartas';

  @override
  String get actionRetry => 'Tentar novamente';

  @override
  String get exportAllData => 'Exportar Todos os Dados (Relatório Completo)';

  @override
  String get actionConfirm => 'Confirmar';

  @override
  String get actionSearch => 'Pesquisar';

  @override
  String get actionFilter => 'Filtrar';

  @override
  String get actionExport => 'Exportar';

  @override
  String get actionExportCsv => 'Exportar CSV';

  @override
  String get retroBoard => 'Elementos do Board';

  @override
  String get actionCopy => 'Copiar';

  @override
  String get actionShare => 'Compartilhar';

  @override
  String get actionDone => 'Concluído';

  @override
  String get actionReset => 'Reset';

  @override
  String get actionOpen => 'Abrir';

  @override
  String get stateLoading => 'Carregando...';

  @override
  String get stateEmpty => 'Nenhum elemento';

  @override
  String get stateError => 'Erro';

  @override
  String get stateSuccess => 'Sucesso';

  @override
  String get subscriptionCurrent => 'ATUAL';

  @override
  String get subscriptionRecommended => 'RECOMENDADO';

  @override
  String get subscriptionFree => 'Grátis';

  @override
  String get subscriptionPerMonth => '/mês';

  @override
  String get subscriptionPerYear => '/ano';

  @override
  String subscriptionSaveYearly(String amount) {
    return 'Você economiza €$amount/ano';
  }

  @override
  String subscriptionTrialDays(int days) {
    return '$days dias de teste gratuito';
  }

  @override
  String get subscriptionUnlimitedProjects => 'Projetos ilimitados';

  @override
  String subscriptionProjectsActive(int count) {
    return '$count projetos ativos';
  }

  @override
  String get subscriptionUnlimitedLists => 'Listas ilimitadas';

  @override
  String subscriptionSmartTodoLists(int count) {
    return 'Listas Smart Todo';
  }

  @override
  String get subscriptionActiveProjectsLabel => 'Projetos ativos';

  @override
  String get subscriptionSmartTodoListsLabel => 'Listas Smart Todo';

  @override
  String get subscriptionUnlimitedTasks => 'Tasks ilimitados';

  @override
  String subscriptionTasksPerProject(int count) {
    return '$count tasks por projeto';
  }

  @override
  String get subscriptionUnlimitedInvites => 'Convites ilimitados';

  @override
  String subscriptionInvitesPerProject(int count) {
    return '$count convites por projeto';
  }

  @override
  String get subscriptionWithAds => 'Com publicidade';

  @override
  String get subscriptionWithoutAds => 'Sem publicidade';

  @override
  String get authSignInGoogle => 'Entrar com Google';

  @override
  String get authSignOut => 'Sair';

  @override
  String get authLogoutConfirm => 'Tem certeza de que deseja sair?';

  @override
  String get formNameRequired => 'Insira seu nome';

  @override
  String get authError => 'Erro de autenticação';

  @override
  String get authUserNotFound => 'Usuário não encontrado';

  @override
  String get authWrongPassword => 'Senha incorreta';

  @override
  String get authEmailInUse => 'E-mail já em uso';

  @override
  String get authWeakPassword => 'Senha muito fraca';

  @override
  String get authInvalidEmail => 'E-mail inválido';

  @override
  String get appSubtitle => 'Keisen para Times';

  @override
  String get authOr => 'ou';

  @override
  String get authPassword => 'Senha';

  @override
  String get authRegister => 'Cadastrar';

  @override
  String get authLogin => 'Entrar';

  @override
  String get authHaveAccount => 'Já tem uma conta?';

  @override
  String get authNoAccount => 'Não tem uma conta?';

  @override
  String get authForgotPassword => 'Esqueceu a senha?';

  @override
  String get authResetPasswordSent =>
      'E-mail de redefinição enviado. Verifique sua caixa de entrada.';

  @override
  String get authVerifyEmail => 'Verifique seu e-mail';

  @override
  String authVerifyEmailDesc(String email) {
    return 'Enviamos um e-mail de verificação para $email. Clique no link para ativar sua conta.';
  }

  @override
  String get authResendVerification => 'Reenviar e-mail de verificação';

  @override
  String get authVerificationSent => 'E-mail de verificação enviado!';

  @override
  String get authEmailVerified => 'E-mail verificado!';

  @override
  String get authIVerified => 'Já verifiquei meu e-mail';

  @override
  String get authWaitingVerification => 'Aguardando verificação...';

  @override
  String get authChangePassword => 'Alterar senha';

  @override
  String get authCurrentPassword => 'Senha atual';

  @override
  String get authNewPassword => 'Nova senha';

  @override
  String get authConfirmNewPassword => 'Confirmar nova senha';

  @override
  String get authPasswordChanged => 'Senha alterada com sucesso';

  @override
  String get authPasswordMismatch => 'As senhas não coincidem';

  @override
  String get authPasswordTooShort => 'Mínimo de 6 caracteres';

  @override
  String get authReauthRequired => 'Confirme sua identidade';

  @override
  String get authReauthDesc =>
      'Por segurança, confirme sua identidade para continuar.';

  @override
  String get authSignInWithEmail => 'Entrar com E-mail';

  @override
  String get authWrongCurrentPassword => 'A senha atual não está correta';

  @override
  String get profileSecurity => 'Segurança';

  @override
  String authCooldownWait(int seconds) {
    return 'Aguarde ${seconds}s antes de reenviar';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navProfile => 'Perfil';

  @override
  String get navSettings => 'Configurações';

  @override
  String get eisenhowerTitle => 'Matriz de Eisenhower';

  @override
  String get eisenhowerYourMatrices => 'Suas matrizes';

  @override
  String get eisenhowerNoMatrices => 'Nenhuma matriz criada';

  @override
  String get eisenhowerNewMatrix => 'Nova Matriz';

  @override
  String get eisenhowerViewGrid => 'Grade';

  @override
  String get eisenhowerViewChart => 'Gráfico';

  @override
  String get eisenhowerViewList => 'Lista';

  @override
  String get eisenhowerViewRaci => 'RACI';

  @override
  String get quadrantUrgent => 'URGENTE';

  @override
  String get quadrantNotUrgent => 'NÃO URGENTE';

  @override
  String get quadrantImportant => 'IMPORTANTE';

  @override
  String get quadrantNotImportant => 'NÃO IMPORTANTE';

  @override
  String get quadrantQ1Title => 'FAÇA AGORA';

  @override
  String get quadrantQ2Title => 'PLANEJE';

  @override
  String get quadrantQ3Title => 'DELEGUE';

  @override
  String get quadrantQ4Title => 'ELIMINE';

  @override
  String get quadrantQ1Subtitle => 'Urgente e Importante';

  @override
  String get quadrantQ2Subtitle => 'Importante, Não Urgente';

  @override
  String get quadrantQ3Subtitle => 'Urgente, Não Importante';

  @override
  String get quadrantQ4Subtitle => 'Não Urgente, Não Importante';

  @override
  String get eisenhowerNoActivities => 'Nenhuma atividade';

  @override
  String get eisenhowerNewActivity => 'Nova Atividade';

  @override
  String get eisenhowerExportSheets => 'Exportar para Google Sheets';

  @override
  String get eisenhowerInviteParticipants => 'Convidar Participantes';

  @override
  String get eisenhowerDeleteMatrix => 'Excluir Matriz';

  @override
  String get eisenhowerDeleteMatrixConfirm =>
      'Tem certeza de que deseja excluir esta matriz?';

  @override
  String get eisenhowerActivityTitle => 'Título da atividade';

  @override
  String get eisenhowerActivityNotes => 'Notas';

  @override
  String get eisenhowerDueDate => 'Data de vencimento';

  @override
  String get eisenhowerPriority => 'Prioridade';

  @override
  String get eisenhowerAssignee => 'Responsável';

  @override
  String get eisenhowerCompleted => 'Concluída';

  @override
  String get eisenhowerMoveToQuadrant => 'Mover para o quadrante';

  @override
  String get eisenhowerMatrixSettings => 'Configurações da Matriz';

  @override
  String get eisenhowerBackToList => 'Lista';

  @override
  String get eisenhowerPriorityList => 'Lista de Prioridades';

  @override
  String get eisenhowerAllActivities => 'Todas as atividades';

  @override
  String get eisenhowerToVote => 'A votar';

  @override
  String get eisenhowerVoted => 'Votadas';

  @override
  String get eisenhowerTotal => 'Totais';

  @override
  String get eisenhowerEditParticipants => 'Editar participantes';

  @override
  String eisenhowerActivityCountLabel(int count) {
    return '$count atividades';
  }

  @override
  String eisenhowerVoteCountLabel(int count) {
    return '$count votos';
  }

  @override
  String get eisenhowerModifyVotes => 'Modificar votos';

  @override
  String get eisenhowerVote => 'Votar';

  @override
  String get eisenhowerQuadrant => 'Quadrante';

  @override
  String get eisenhowerUrgencyAvg => 'Urgência média';

  @override
  String get eisenhowerImportanceAvg => 'Importância média';

  @override
  String get eisenhowerVotesLabel => 'Votos:';

  @override
  String get eisenhowerNoVotesYet => 'Nenhum voto coletado ainda';

  @override
  String get eisenhowerEditMatrix => 'Editar Matriz';

  @override
  String get eisenhowerAddActivity => 'Adicionar Atividade';

  @override
  String get eisenhowerDeleteActivity => 'Excluir Atividade';

  @override
  String eisenhowerDeleteActivityConfirm(String title) {
    return 'Tem certeza de que deseja excluir \"$title\"?';
  }

  @override
  String get eisenhowerMatrixCreated => 'Matriz criada com sucesso';

  @override
  String get eisenhowerMatrixUpdated => 'Matriz atualizada';

  @override
  String get eisenhowerMatrixDeleted => 'Matriz excluída';

  @override
  String get eisenhowerActivityAdded => 'Atividade adicionada';

  @override
  String get eisenhowerActivityDeleted => 'Atividade excluída';

  @override
  String get eisenhowerVotesSaved => 'Votos salvos';

  @override
  String get eisenhowerExportCompleted => 'Exportação concluída!';

  @override
  String get eisenhowerExportAll => 'Exportar Todos os Dados';

  @override
  String get eisenhowerExportCompletedDialog => 'Exportação Concluída';

  @override
  String get eisenhowerExportDialogContent =>
      'A planilha Google Sheets foi criada.\nDeseja abri-la no navegador?';

  @override
  String get eisenhowerOpen => 'Abrir';

  @override
  String get eisenhowerAddParticipantsFirst =>
      'Adicione participantes à matriz primeiro';

  @override
  String get eisenhowerSearchLabel => 'Pesquisa:';

  @override
  String get eisenhowerSearchHint => 'Pesquisar matrizes...';

  @override
  String get eisenhowerNoMatrixFound => 'Nenhuma matriz encontrada';

  @override
  String get eisenhowerCreateFirstMatrix =>
      'Crie sua primeira Matriz de Eisenhower\npara organizar suas prioridades';

  @override
  String get eisenhowerCreateMatrix => 'Criar Matriz';

  @override
  String get eisenhowerClickToOpen => 'Matriz Eisenhower\nClique para abrir';

  @override
  String get eisenhowerTotalActivities => 'Atividades totais na matriz';

  @override
  String get eisenhowerVotedActivities => 'Atividades votadas';

  @override
  String get eisenhowerPendingVoting => 'Atividades a serem votadas';

  @override
  String get eisenhowerStartVoting => 'Iniciar Votação Independente';

  @override
  String eisenhowerStartVotingDesc(String title) {
    return 'Deseja iniciar uma sessão de votação independente para \"$title\"?\n\nCada participante votará sem ver os votos dos outros, até que todos tenham votado e os votos sejam revelados.';
  }

  @override
  String get eisenhowerStart => 'Iniciar';

  @override
  String get eisenhowerVotingStarted => 'Votação iniciada';

  @override
  String get eisenhowerResetVoting => 'Resetar Votação?';

  @override
  String get eisenhowerResetVotingDesc => 'Todos os votos serão apagados.';

  @override
  String get eisenhowerVotingReset => 'Votação resetada';

  @override
  String get eisenhowerMinVotersRequired =>
      'São necessários pelo menos 2 votantes para a votação independente';

  @override
  String eisenhowerDeleteMatrixWithActivities(int count) {
    return 'Todas as $count atividades também serão excluídas.';
  }

  @override
  String eisenhowerYourMatricesCount(int filtered, int total) {
    return 'Suas matrizes ($filtered/$total)';
  }

  @override
  String get formTitleRequired => 'Insira um título';

  @override
  String get formTitleHint => 'Ex: Prioridades Q1 2025';

  @override
  String get formDescriptionHint => 'Descrição opcional';

  @override
  String get formParticipantHint => 'Nome do participante';

  @override
  String get formAddParticipantHint =>
      'Adicione pelo menos um participante para poder votar';

  @override
  String get formActivityTitleHint => 'Ex: Concluir documentação da API';

  @override
  String get errorCreatingMatrix => 'Erro ao criar matriz';

  @override
  String get errorUpdatingMatrix => 'Erro ao atualizar';

  @override
  String get errorDeletingMatrix => 'Erro ao excluir';

  @override
  String get errorAddingActivity => 'Erro ao adicionar atividade';

  @override
  String get errorSavingVotes => 'Erro ao salvar votos';

  @override
  String get errorExport => 'Erro durante a exportação';

  @override
  String get errorStartingVoting => 'Erro ao iniciar votação';

  @override
  String get errorResetVoting => 'Erro ao resetar';

  @override
  String get errorLoadingActivities => 'Erro ao carregar atividades';

  @override
  String get eisenhowerWaitingForVotes => 'Aguardando votos';

  @override
  String eisenhowerVotedParticipants(int ready, int total) {
    return '$ready/$total votos';
  }

  @override
  String get eisenhowerVoteSubmit => 'VOTAR';

  @override
  String get eisenhowerVotedSuccess => 'Você votou';

  @override
  String get eisenhowerRevealVotes => 'REVELAR VOTOS';

  @override
  String get eisenhowerQuickVote => 'Voto Rápido';

  @override
  String get eisenhowerTeamVote => 'Voto da Equipe';

  @override
  String get eisenhowerUrgency => 'URGÊNCIA';

  @override
  String get eisenhowerImportance => 'IMPORTÂNCIA';

  @override
  String get eisenhowerUrgencyShort => 'U:';

  @override
  String get eisenhowerImportanceShort => 'I:';

  @override
  String get eisenhowerVoting => 'Votação';

  @override
  String get eisenhowerVotingInProgress => 'VOTAÇÃO EM ANDAMENTO';

  @override
  String get eisenhowerWaitingForOthers =>
      'Aguardando que todos votem. O facilitador revelará os votos.';

  @override
  String get eisenhowerReady => 'Pronto';

  @override
  String get eisenhowerWaiting => 'Aguardando';

  @override
  String get eisenhowerIndividualVotes => 'VOTOS INDIVIDUAIS';

  @override
  String get eisenhowerResult => 'RESULTADO';

  @override
  String get eisenhowerAverage => 'MÉDIA';

  @override
  String get eisenhowerVotesRevealed => 'Votos Revelados';

  @override
  String get eisenhowerNextActivity => 'Próxima Atividade';

  @override
  String get eisenhowerNoVotesRecorded => 'Nenhum voto registrado';

  @override
  String get eisenhowerWaitingForStart => 'Aguardando';

  @override
  String get eisenhowerPreVotesTooltip =>
      'Votos antecipados que serão contabilizados quando o facilitador iniciar a votação';

  @override
  String get eisenhowerObserverWaiting =>
      'Aguardando o facilitador iniciar a votação coletiva';

  @override
  String get eisenhowerPreVoteTooltip =>
      'Expresse seu voto antecipadamente. Será contabilizado quando a votação for iniciada.';

  @override
  String get eisenhowerPreVote => 'Pré-votar';

  @override
  String get eisenhowerPreVoted => 'Você pré-votou';

  @override
  String get eisenhowerStartVotingTooltip =>
      'Inicie a sessão de votação coletiva. Os pré-votos existentes serão preservados.';

  @override
  String get eisenhowerResetVotingTooltip =>
      'Resete a votação apagando todos os votos';

  @override
  String get eisenhowerObserverWaitingVotes =>
      'Observando a votação em andamento...';

  @override
  String get eisenhowerWaitingForAllVotes =>
      'Aguardando que todos os participantes votem';

  @override
  String get eisenhowerRevealTooltipReady =>
      'Todos votaram! Clique para revelar os resultados.';

  @override
  String eisenhowerRevealTooltipNotReady(int count) {
    return 'Faltam ainda $count votos';
  }

  @override
  String get eisenhowerVotingLocked => 'Votação encerrada';

  @override
  String get eisenhowerVotingLockedTooltip =>
      'Os votos foram revelados. Não é mais possível votar nesta atividade.';

  @override
  String eisenhowerOnlineParticipants(int online, int total) {
    return '$online de $total participantes online';
  }

  @override
  String get eisenhowerAllActivitiesVoted =>
      'Todas as atividades foram votadas!';

  @override
  String get eisenhowerAlreadyVotedError =>
      'Questa attività è già stata votata. Il facilitatore deve riaprire la votazione per modificarla.';

  @override
  String eisenhowerYourVote(Object urgency, Object importance) {
    return 'Il tuo voto: U=$urgency, I=$importance';
  }

  @override
  String eisenhowerVoterName(Object name) {
    return 'Voto di $name';
  }

  @override
  String get eisenhowerUrgencyLow => 'Non urgente';

  @override
  String get eisenhowerUrgencyHigh => 'Molto urgente';

  @override
  String get eisenhowerImportanceLow => 'Non importante';

  @override
  String get eisenhowerImportanceHigh => 'Molto importante';

  @override
  String eisenhowerQuadrantLabel(Object name) {
    return 'Quadrante: $name';
  }

  @override
  String get eisenhowerQ1Name => 'Q1 - FAI SUBITO';

  @override
  String get eisenhowerQ1Desc => 'Urgente + Importante';

  @override
  String get eisenhowerQ2Name => 'Q2 - PIANIFICA';

  @override
  String get eisenhowerQ2Desc => 'Non Urgente + Importante';

  @override
  String get eisenhowerQ3Name => 'Q3 - DELEGA';

  @override
  String get eisenhowerQ3Desc => 'Urgente + Non Importante';

  @override
  String get eisenhowerQ4Name => 'Q4 - ELIMINA';

  @override
  String get eisenhowerQ4Desc => 'Non Urgente + Non Importante';

  @override
  String eisenhowerPreVotes(Object count) {
    return '$count pre-voti';
  }

  @override
  String get eisenhowerVotesVisibleAfterReveal =>
      'I voti saranno visibili quando il facilitatore farà \"Rivela voti\"';

  @override
  String eisenhowerNextActivityError(Object error) {
    return 'Errore avvio prossima votazione: $error';
  }

  @override
  String get eisenhowerReopenVotes => 'Riapri votazioni';

  @override
  String get eisenhowerReopenVotesTooltip =>
      'Riavvia la votazione formale a partire dalle stime attuali';

  @override
  String get eisenhowerReopenVotesConfirm => 'Riaprire tutte le votazioni?';

  @override
  String get eisenhowerReopenVotesDesc =>
      'Questa operazione riavvierà una sessione di voto formale per tutte le attività, mantenendo le stime attuali come punto di partenza. Vuoi procedere?';

  @override
  String get estimationTitle => 'Estimation Room';

  @override
  String get estimationYourSessions => 'Suas sessões';

  @override
  String get estimationNoSessions => 'Nenhuma sessão criada';

  @override
  String get estimationNewSession => 'Nova Sessão';

  @override
  String get estimationEditSession => 'Editar Sessão';

  @override
  String get estimationJoinSession => 'Entrar em sessão';

  @override
  String get estimationSessionCode => 'Código da sessão';

  @override
  String get estimationEnterCode => 'Insira o código';

  @override
  String get sessionStatusDraft => 'Rascunho';

  @override
  String get sessionStatusActive => 'Ativa';

  @override
  String get sessionStatusCompleted => 'Concluída';

  @override
  String get sessionName => 'Nome da sessão';

  @override
  String get sessionNameRequired => 'Nome da Sessão *';

  @override
  String get sessionNameHint => 'Ex: Sprint 15 - Estimativa User Stories';

  @override
  String get sessionDescription => 'Descrição';

  @override
  String get sessionCardSet => 'Conjunto de Cartas';

  @override
  String get cardSetFibonacci =>
      'Fibonacci (0, 1, 2, 3, 5, 8, 13, 20, 40, 100, ?, ?)';

  @override
  String get cardSetSimplified => 'Simplificado (1, 2, 3, 5, 8, 13, ?, ?)';

  @override
  String get sessionEstimationMode => 'Modo de Estimativa';

  @override
  String get sessionEstimationModeLocked =>
      'Não é possível alterar o modo após o início da votação';

  @override
  String get sessionAutoReveal => 'Auto-reveal';

  @override
  String get sessionAutoRevealDesc => 'Revelar quando todos votarem';

  @override
  String get sessionAllowObservers => 'Observadores';

  @override
  String get sessionAllowObserversDesc => 'Permitir participantes não votantes';

  @override
  String get sessionConfiguration => 'Configuração';

  @override
  String get voteConsensus => 'Consenso alcançado!';

  @override
  String get voteResults => 'Resultados da Votação';

  @override
  String get voteRevote => 'Revotar';

  @override
  String get voteReveal => 'Revelar';

  @override
  String get voteHide => 'Ocultar';

  @override
  String get voteAverage => 'Média';

  @override
  String get voteMedian => 'Mediana';

  @override
  String get voteMode => 'Moda';

  @override
  String get voteVoters => 'Votantes';

  @override
  String get voteDistribution => 'Distribuição de votos';

  @override
  String get voteFinalEstimate => 'Estimativa final';

  @override
  String get voteSelectFinal => 'Selecionar estimativa final';

  @override
  String get voteAverageTooltip => 'Média aritmética dos votos numéricos';

  @override
  String get voteMedianTooltip =>
      'Valor central quando os votos estão ordenados';

  @override
  String get voteModeTooltip =>
      'Voto mais frequente (o valor escolhido mais vezes)';

  @override
  String get voteVotersTooltip => 'Número total de participantes que votaram';

  @override
  String get voteWaiting => 'Aguardando votos...';

  @override
  String get voteSubmitted => 'Voto enviado';

  @override
  String get voteNotSubmitted => 'Não votou';

  @override
  String get storyToEstimate => 'Story para estimar';

  @override
  String get storyTitle => 'Título da story';

  @override
  String get storyDescription => 'Descrição da story';

  @override
  String get storyAddNew => 'Adicionar story';

  @override
  String get storyNoStories => 'Nenhuma story para estimar';

  @override
  String get retrospectivesVoted => 'Votato';

  @override
  String get storyComplete => 'Story concluída';

  @override
  String get storySkip => 'Pular story';

  @override
  String get estimationModeFibonacci => 'Fibonacci';

  @override
  String get estimationModeTshirt => 'Tamanhos T-Shirt';

  @override
  String get estimationModeDecimal => 'Decimal';

  @override
  String get estimationModeThreePoint => 'Three-Point (PERT)';

  @override
  String get estimationModeDotVoting => 'Dot Voting';

  @override
  String get estimationModeBucketSystem => 'Bucket System';

  @override
  String get estimationModeFiveFingers => 'Five Fingers';

  @override
  String get estimationVotesRevealed => 'Votos Revelados';

  @override
  String get estimationVotingInProgress => 'Votação em Andamento';

  @override
  String estimationVotesCountFormatted(int count, int total) {
    return '$count/$total votos';
  }

  @override
  String get estimationConsensusReached => 'Consenso alcançado!';

  @override
  String get estimationVotingResults => 'Resultados da Votação';

  @override
  String get estimationRevote => 'Revotar';

  @override
  String get estimationAverage => 'Média';

  @override
  String get estimationAverageTooltip => 'Média aritmética dos votos numéricos';

  @override
  String get estimationMedian => 'Mediana';

  @override
  String get estimationMedianTooltip =>
      'Valor central quando os votos estão ordenados';

  @override
  String get estimationMode => 'Moda';

  @override
  String get estimationModeTooltip =>
      'Voto mais frequente (o valor escolhido mais vezes)';

  @override
  String get estimationVoters => 'Votantes';

  @override
  String get estimationVotersTooltip =>
      'Número total de participantes que votaram';

  @override
  String get estimationVoteDistribution => 'Distribuição de votos';

  @override
  String get estimationSelectFinalEstimate => 'Selecionar estimativa final';

  @override
  String get estimationFinalEstimate => 'Estimativa final';

  @override
  String get eisenhowerChartTitle => 'Distribuição de Atividades';

  @override
  String get quadrantLabelDo => 'Q1 - FAÇA';

  @override
  String get quadrantLabelPlan => 'Q2 - PLANEJE';

  @override
  String get quadrantLabelDelegate => 'Q3 - DELEGUE';

  @override
  String get quadrantLabelEliminate => 'Q4 - ELIMINE';

  @override
  String get eisenhowerNoRatedActivities => 'Nenhuma atividade votada';

  @override
  String get eisenhowerVoteToSeeChart =>
      'Vote nas atividades para visualizá-las no gráfico';

  @override
  String get eisenhowerChartCardTitle => 'Gráfico de Distribuição';

  @override
  String get raciAddColumnTitle => 'Adicionar Coluna RACI';

  @override
  String get raciColumnType => 'Tipo';

  @override
  String get raciTypePerson => 'Pessoa (Participante)';

  @override
  String get raciTypeCustom => 'Personalizado (Equipe/Outro)';

  @override
  String get raciSelectParticipant => 'Selecionar participante';

  @override
  String get raciColumnName => 'Nome da coluna';

  @override
  String get raciColumnNameHint => 'Ex.: Equipe de Desenvolvimento';

  @override
  String get raciDeleteColumnTitle => 'Excluir Coluna';

  @override
  String raciDeleteColumnConfirm(String name) {
    return 'Deseja excluir a coluna \'$name\'? As atribuições relacionadas serão perdidas.';
  }

  @override
  String estimationOnlineParticipants(int online, int total) {
    return '$online de $total participantes online';
  }

  @override
  String get estimationNewStoryTitle => 'Nova Story';

  @override
  String get estimationStoryTitleLabel => 'Título *';

  @override
  String get estimationStoryTitleHint => 'Ex: US-123: Como usuário eu quero...';

  @override
  String get estimationStoryDescriptionLabel => 'Descrição';

  @override
  String get estimationStoryDescriptionHint =>
      'Critérios de aceitação, notas...';

  @override
  String get estimationEnterTitleAlert => 'Insira um título';

  @override
  String get estimationParticipantsHeader => 'Participantes';

  @override
  String get estimationRoleFacilitator => 'Facilitador';

  @override
  String get estimationRoleVoters => 'Votantes';

  @override
  String get estimationRoleObservers => 'Observadores';

  @override
  String get estimationYouSuffix => '(você)';

  @override
  String get estimationDecimalTitle => 'Estimativa Decimal';

  @override
  String get estimationDecimalHint =>
      'Insira sua estimativa em dias (ex: 1.5, 2.25)';

  @override
  String get estimationQuickSelect => 'Seleção rápida:';

  @override
  String get estimationDaysSuffix => 'dias';

  @override
  String estimationVoteValue(String value) {
    return 'Voto: $value dias';
  }

  @override
  String get estimationEnterValueAlert => 'Insira um valor';

  @override
  String get estimationInvalidValueAlert => 'Valor inválido';

  @override
  String estimationMinAlert(double value) {
    return 'Mín: $value';
  }

  @override
  String estimationMaxAlert(double value) {
    return 'Máx: $value';
  }

  @override
  String get retroTitle => 'Retrospectiva';

  @override
  String get retroNoRetros => 'Nenhuma retrospectiva';

  @override
  String get retroNoRetrosFound => 'Nenhuma retrospectiva encontrada';

  @override
  String get retroCreateNew => 'Criar nova';

  @override
  String get retroContinueAction => 'Continuar';

  @override
  String get retroCurrentPhase => 'Fase atual';

  @override
  String get retroNoCompletedRetros => 'Nenhuma retrospectiva concluída';

  @override
  String get retroStandalone => 'Independente';

  @override
  String get retroCompletedOn => 'Concluída em';

  @override
  String get retroSummaryDetails => 'Detalhes';

  @override
  String get retroSummaryCompleted => 'Concluída';

  @override
  String get retroSummaryFacilitator => 'Facilitador';

  @override
  String get retroSummaryNotAvailable => 'Não disponível';

  @override
  String get retroSummarySprint => 'Sprint';

  @override
  String get retroSummaryFeedback => 'Feedback';

  @override
  String get retroSummaryNoCards => 'Nenhum card';

  @override
  String get retroChooseMode => 'Escolha o modo';

  @override
  String get retroQuickForm => 'Formulário Rápido';

  @override
  String get retroInteractiveBoard => 'Board Interativo';

  @override
  String get retroQuickModeDesc =>
      'Modo simplificado com formulário rápido para feedback';

  @override
  String get retroInteractiveModeDesc =>
      'Modo completo com board interativo, votação e fases guiadas';

  @override
  String get retroNoOperationsReview => 'Nenhuma revisão de operações';

  @override
  String get retroOperationsReview => 'Revisão de Operações';

  @override
  String get retroOperationsReviewDesc => 'Revisão das operações do sprint';

  @override
  String get retroWentWell => 'Funcionou bem';

  @override
  String get retroToImprove => 'A melhorar';

  @override
  String get retroWentWellHint => 'O que funcionou bem neste sprint?';

  @override
  String get retroToImproveHint => 'O que podemos melhorar?';

  @override
  String get retroActionItemHint => 'O que deve ser feito?';

  @override
  String get retroSave => 'Salvar';

  @override
  String get agileEstimate => 'ESTIMATIVA';

  @override
  String get agileAssign => 'Assegna';

  @override
  String get agileCardMenuTooltip => 'Opzioni (Priorità, Stima, ecc.)';

  @override
  String get kanbanPolicyHelpTitle => 'Policies di Colonna (Regole)';

  @override
  String get kanbanPolicyHelpIntro =>
      'Le policies sono regole esplicite che definiscono quando una card può entrare o lasciare una colonna. Garantiscono la qualità e il flusso. Attivale dall\'icona \'Impostazioni\' nell\'intestazione della colonna.';

  @override
  String get kanbanPolicyRule1Title => '1. Richiede Criteri di Accettazione';

  @override
  String get kanbanPolicyRule1Desc =>
      'La card deve avere almeno un criterio di accettazione definito per procedere. Utile per assicurarsi che i requisiti siano chiari prima dello sviluppo.';

  @override
  String get kanbanPolicyRule2Title => '2. Stima completata';

  @override
  String get kanbanPolicyRule2Desc =>
      'La card deve avere una stima in Story Points (o altro metodo) > 0. Fondamentale per il Planning e la Velocity.';

  @override
  String get kanbanPolicyRule3Title => '3. Max 2 giorni nella colonna';

  @override
  String get kanbanPolicyRule3Desc =>
      'Segnala se una card rimane ferma nello stesso stato per più di 48 ore. Aiuta a identificare colli di bottiglia o task bloccati.';

  @override
  String get kanbanPolicyRule4Title => '4. Tutti i criteri soddisfatti';

  @override
  String get kanbanPolicyRule4Desc =>
      'Blocca il passaggio a \'Done\' se non tutti i criteri di accettazione sono spuntati. Garantisce la Definition of Done.';

  @override
  String get retroOpenInteractiveBoard => 'Abrir board interativo';

  @override
  String get retroSentimentTeam => 'Sentimento do time';

  @override
  String get retroExcellent => 'Excelente';

  @override
  String get retroGood => 'Bom';

  @override
  String get retroNormal => 'Normal';

  @override
  String get retroNeedsImprovement => 'Precisa melhorar';

  @override
  String get retroCritical => 'Crítico';

  @override
  String get retroNoElements => 'Nenhum elemento';

  @override
  String get retroNoActionItemsFound => 'Nenhum item de ação encontrado';

  @override
  String retroAssignedTo(String email) {
    return 'Atribuído a';
  }

  @override
  String retroVotesCount(int count) {
    return 'Contagem de votos';
  }

  @override
  String get retroGuidance => 'Orientação';

  @override
  String retroResultLabel(String score, String label) {
    return 'Resultado';
  }

  @override
  String get retroSearchHint => 'Buscar retrospectivas...';

  @override
  String get agileProgressManual => 'Manuale';

  @override
  String get agileProgress => 'Avanzamento';

  @override
  String get agileProgressAuto => 'Automatico';

  @override
  String agileProgressTooltipManual(int percent) {
    return 'Impostato manualmente al $percent%';
  }

  @override
  String agileProgressTooltipCriteria(int completed, int total) {
    return 'Completati $completed/$total criteri';
  }

  @override
  String agileProgressTooltipStatus(String status) {
    return 'Stimato in base allo stato: $status';
  }

  @override
  String get agileProcessTitle => 'Agile Process Manager';

  @override
  String get agileSearchProjects => 'Buscar projetos...';

  @override
  String get agileMethodologyGuide => 'Guia de Metodologias';

  @override
  String get agileMethodologyGuideTitle => 'Guia de Metodologias Ágeis';

  @override
  String get agileMethodologyGuideSubtitle =>
      'Escolha a metodologia mais adequada ao seu projeto';

  @override
  String get agileNewProject => 'Novo Projeto';

  @override
  String get agileRoles => 'PAPÉIS';

  @override
  String get agileProcessFlow => 'FLUXO DO PROCESSO';

  @override
  String get agileArtifacts => 'ARTEFATOS';

  @override
  String get agileBestPractices => 'Melhores Práticas';

  @override
  String get agileAntiPatterns => 'Anti-Patterns a Evitar';

  @override
  String get agileFAQ => 'Perguntas Frequentes';

  @override
  String get agileScrumShortDesc =>
      'Sprints com tempo fixo, Velocity, Burndown. Ideal para produtos com requisitos que';

  @override
  String get agileKanbanShortDesc =>
      'Fluxo contínuo, WIP Limits, Lead Time. Ideal para suporte e solicitações contínuas';

  @override
  String get agileScrumbanShortDesc =>
      'Mix de Sprint e fluxo contínuo. Ideal para times que querem flexibilidade.';

  @override
  String get agileRolePODesc => 'Gerencia o backlog e as prioridades';

  @override
  String get agileRoleSMDesc => 'Facilita o processo e remove obstáculos';

  @override
  String get agileRoleDevTeamDesc => 'Os membros que desenvolvem o produto';

  @override
  String get agileRoleStakeholdersDesc => 'Fornecem feedback e requisitos';

  @override
  String get agileRoleSRMDesc => 'Gerencia as solicitações de entrada';

  @override
  String get agileRoleSDMDesc => 'Otimiza o fluxo de trabalho';

  @override
  String get agileRoleTeamDesc => 'Executa o trabalho respeitando os WIP';

  @override
  String get agileRoleFlowMasterDesc => 'Otimiza o fluxo e facilita';

  @override
  String get agileRoleTeamHybridDesc => 'Cross-funcional, auto-organizado';

  @override
  String get scrumOverview =>
      'Scrum é um framework ágil para desenvolver produtos complexos, baseado em sprints de tempo fixo com cerimônias definidas.';

  @override
  String get scrumRolesTitle => 'Papéis Scrum';

  @override
  String get scrumRolesContent =>
      'O Scrum define três papéis fundamentais que juntos são responsáveis pelo sucesso do produto.';

  @override
  String get scrumRolesPO => 'Product Owner';

  @override
  String get scrumRolesSM => 'Scrum Master';

  @override
  String get scrumRolesDev => 'Dev Team';

  @override
  String get scrumEventsTitle => 'Eventos Scrum';

  @override
  String get scrumEventsContent =>
      'Os eventos do Scrum criam regularidade e minimizam a necessidade de reuniões não planejadas.';

  @override
  String get scrumEventsPlanning => 'Sprint Planning';

  @override
  String get scrumEventsDaily => 'Daily Scrum';

  @override
  String get scrumEventsRetro => 'Sprint Retrospective';

  @override
  String get scrumEventsRetroContent =>
      'Momento de inspeção e adaptação do processo, focando em melhorias para o próximo sprint.';

  @override
  String get scrumEventsReview => 'Sprint Review';

  @override
  String get scrumArtifactsTitle => 'Artefatos Scrum';

  @override
  String get scrumArtifactsContent =>
      'Os artefatos do Scrum representam trabalho ou valor e são projetados para maximizar a transparência.';

  @override
  String get scrumArtifactsPB => 'Product Backlog';

  @override
  String get scrumArtifactsSB => 'Sprint Backlog';

  @override
  String get scrumArtifactsIncrement => 'Incremento';

  @override
  String get scrumStoryPointsTitle => 'Story Points';

  @override
  String get scrumStoryPointsContent =>
      'Story Points são uma unidade de medida relativa para estimar a complexidade e o esforço de User Stories.';

  @override
  String get scrumBP1 => 'Manter sprints curtos (1-2 semanas)';

  @override
  String get scrumBP2 => 'Definir Sprint Goals claros';

  @override
  String get scrumBP3 => 'Daily Scrum de no máximo 15 minutos';

  @override
  String get scrumBP4 => 'Sprint Review com stakeholders';

  @override
  String get scrumBP5 => 'Retrospectiva focada em melhorias';

  @override
  String get scrumBP6 => 'Product Backlog sempre priorizado';

  @override
  String get scrumBP7 => 'Time cross-funcional e auto-organizado';

  @override
  String get scrumBP8 => 'Definition of Done clara e compartilhada';

  @override
  String get scrumAP1 => 'Sprints muito longos (> 4 semanas)';

  @override
  String get scrumAP2 => 'Não ter Sprint Goal definido';

  @override
  String get scrumAP3 => 'Pular a Daily Scrum';

  @override
  String get scrumAP4 => 'Não fazer Sprint Review';

  @override
  String get scrumAP5 => 'Ignorar a Retrospectiva';

  @override
  String get scrumAP6 => 'Product Owner ausente';

  @override
  String get scrumAP7 => 'Scrum Master controlador';

  @override
  String get scrumAP8 => 'Time sem autonomia';

  @override
  String get scrumFAQ1Q => 'O que é o Sprint Goal?';

  @override
  String get scrumFAQ1A =>
      'O Sprint Goal é o objetivo que o time se compromete a atingir durante o sprint. Dá foco e direção ao trabalho.';

  @override
  String get scrumFAQ2Q => 'Como calcular a Velocity?';

  @override
  String get scrumFAQ2A =>
      'A Velocity é a quantidade média de Story Points que o time entrega por sprint. Serve para previsões.';

  @override
  String get scrumFAQ3Q => 'Como o Product Owner prioriza o backlog?';

  @override
  String get scrumFAQ3A =>
      'O PO define a ordem dos itens do backlog com base no valor de negócio, risco e dependências.';

  @override
  String get scrumFAQ4Q => 'O escopo do sprint pode mudar durante o sprint?';

  @override
  String get scrumFAQ4A =>
      'O Sprint Backlog pertence ao time. O escopo pode ser negociado com o PO sem alterar o Sprint Goal.';

  @override
  String get kanbanOverview =>
      'Kanban é um método para gerenciar o fluxo de trabalho, visualizando tarefas e limitando o trabalho em andamento.';

  @override
  String get kanbanPrinciplesTitle => 'Princípios Kanban';

  @override
  String get kanbanPrinciplesContent =>
      'Os princípios fundamentais do método Kanban guiam a implementação e melhoria contínua.';

  @override
  String get kanbanPrinciple1 => 'Comece com o que você faz agora';

  @override
  String get kanbanPrinciple2 =>
      'Concorde em buscar melhorias incrementais e evolutivas';

  @override
  String get kanbanPrinciple3 =>
      'Respeite os processos, papéis e responsabilidades atuais';

  @override
  String get kanbanPrinciple4 =>
      'Incentive atos de liderança em todos os níveis';

  @override
  String get kanbanPrinciple5 => 'Visualize o fluxo de trabalho';

  @override
  String get kanbanPrinciple6 => 'Limite o trabalho em andamento';

  @override
  String get kanbanBoardTitle => 'Kanban Board';

  @override
  String get kanbanBoardContent =>
      'O Board Kanban visualiza o fluxo de trabalho com colunas representando cada fase do processo.';

  @override
  String get kanbanWIPTitle => 'WIP (Work In Progress)';

  @override
  String get kanbanWIPContent =>
      'Limitar o trabalho em andamento é uma prática fundamental do Kanban para melhorar o fluxo.';

  @override
  String get kanbanMetricsTitle => 'Métricas Kanban';

  @override
  String get kanbanMetricsContent =>
      'Métricas Kanban essenciais para monitorar e melhorar o fluxo de trabalho.';

  @override
  String get kanbanMetric1 => 'Lead Time';

  @override
  String get kanbanMetric2 => 'Cycle Time';

  @override
  String get kanbanMetric3 => 'Throughput';

  @override
  String get kanbanMetric4 => 'WIP';

  @override
  String get kanbanMetric5 => 'Flow Efficiency';

  @override
  String get kanbanCadencesTitle => 'Cadências';

  @override
  String get kanbanCadencesContent =>
      'Cadências são reuniões regulares para revisão e melhoria do processo Kanban.';

  @override
  String get kanbanSwimlanesTitle => 'Swimlanes';

  @override
  String get kanbanSwimlanesContent =>
      'Swimlanes são divisões horizontais no board para categorizar diferentes tipos de trabalho.';

  @override
  String kanbanPoliciesTitle(String columnName) {
    return 'Políticas';
  }

  @override
  String get kanbanPoliciesContent =>
      'Políticas explícitas definem regras claras para como o trabalho flui pelo sistema.';

  @override
  String get kanbanBP1 => 'Visualizar o fluxo de trabalho';

  @override
  String get kanbanBP2 => 'Limitar o trabalho em andamento (WIP)';

  @override
  String get kanbanBP3 => 'Gerenciar o fluxo ativamente';

  @override
  String get kanbanBP4 => 'Tornar as políticas explícitas';

  @override
  String get kanbanBP5 => 'Implementar ciclos de feedback';

  @override
  String get kanbanBP6 => 'Melhorar colaborativamente';

  @override
  String get kanbanBP7 => 'Medir e otimizar o Lead Time';

  @override
  String get kanbanBP8 => 'Focar na conclusão, não no início';

  @override
  String get kanbanAP1 => 'Ignorar WIP limits';

  @override
  String get kanbanAP2 => 'Não visualizar o fluxo de trabalho';

  @override
  String get kanbanAP3 => 'Não medir Lead Time';

  @override
  String get kanbanAP4 => 'Permitir multitasking excessivo';

  @override
  String get kanbanAP5 => 'Não fazer retrospectivas';

  @override
  String get kanbanAP6 => 'Não definir políticas explícitas';

  @override
  String get kanbanAP7 => 'Ignorar gargalos';

  @override
  String get kanbanAP8 => 'Não limitar trabalho em andamento';

  @override
  String get kanbanFAQ1Q => 'Por que limitar o trabalho em andamento?';

  @override
  String get kanbanFAQ1A =>
      'WIP limits ajudam a identificar gargalos e melhorar o fluxo, reduzindo o tempo de entrega.';

  @override
  String get kanbanFAQ2Q => 'Qual é a diferença entre Lead Time e Cycle Time?';

  @override
  String get kanbanFAQ2A =>
      'Lead Time é o tempo total desde a solicitação até a entrega. Cycle Time é o tempo de trabalho ativo.';

  @override
  String get kanbanFAQ3Q => 'Como definir WIP limits adequados?';

  @override
  String get kanbanFAQ3A =>
      'Comece com um limit igual ao número de membros do time, depois ajuste com base nos dados.';

  @override
  String get kanbanFAQ4Q => 'Posso usar Kanban com sprints?';

  @override
  String get kanbanFAQ4A =>
      'Sim, o Kanban pode ser combinado com sprints (Scrumban) para times que precisam de ambos.';

  @override
  String get hybridOverview =>
      'Scrumban combina o melhor do Scrum e do Kanban, oferecendo a estrutura dos sprints com a flexibilidade do fluxo contínuo.';

  @override
  String get hybridFromScrumTitle => 'Do Scrum para Scrumban';

  @override
  String get hybridFromScrumContent =>
      'Transição gradual do Scrum para Scrumban mantendo as cerimônias.';

  @override
  String get hybridFromScrum1 => 'Adicione WIP limits às colunas do board';

  @override
  String get hybridFromScrum2 => 'Permita puxar novos itens durante o sprint';

  @override
  String get hybridFromScrum3 => 'Meça Lead Time além da Velocity';

  @override
  String get hybridFromScrum4 => 'Flexibilize o escopo do sprint';

  @override
  String get hybridFromScrum5 => 'Mantenha as cerimônias Scrum';

  @override
  String get hybridFromKanbanTitle => 'Do Kanban para Scrumban';

  @override
  String get hybridFromKanbanContent =>
      'Transição gradual do Kanban para Scrumban mantendo o fluxo contínuo.';

  @override
  String get hybridFromKanban1 =>
      'Adicione cadências fixas (sprints) para planejamento';

  @override
  String get hybridFromKanban2 => 'Introduza Sprint Planning e Review';

  @override
  String get hybridFromKanban3 => 'Defina Sprint Goals para foco';

  @override
  String get hybridFromKanban4 => 'Mantenha os WIP limits existentes';

  @override
  String get hybridFromKanban5 =>
      'Adicione retrospectivas ao final de cada sprint';

  @override
  String get hybridOnDemandTitle => 'Planejamento On-Demand';

  @override
  String get hybridOnDemandContent =>
      'Novos itens podem ser adicionados ao sprint conforme necessário, respeitando os WIP limits.';

  @override
  String get hybridWhenTitle => 'Quando usar Scrumban';

  @override
  String get hybridWhenContent =>
      'Ideal quando o time precisa de flexibilidade para lidar com solicitações urgentes mantendo ciclos de planejamento.';

  @override
  String get hybridBP1 => 'Manter os WIP limits do Kanban nos sprints';

  @override
  String get hybridBP2 => 'Usar sprints para planejamento, fluxo para execução';

  @override
  String get hybridBP3 => 'Medir tanto Velocity quanto Lead Time';

  @override
  String get hybridBP4 => 'Retrospectivas regulares para calibrar o processo';

  @override
  String get hybridBP5 => 'Adaptar o comprimento do sprint conforme necessário';

  @override
  String get hybridBP6 => 'Visualizar o fluxo mesmo durante os sprints';

  @override
  String get hybridBP7 => 'Definir políticas explícitas para cada fase';

  @override
  String get hybridBP8 => 'Equilibrar flexibilidade e estrutura';

  @override
  String get hybridAP1 => 'Evitar trocar entre Scrum e Kanban frequentemente';

  @override
  String get hybridAP2 => 'Não ter WIP limits claros';

  @override
  String get hybridAP3 => 'Ignorar as cerimônias Scrum';

  @override
  String get hybridAP4 => 'Não medir métricas de fluxo';

  @override
  String get hybridAP5 => 'Manter sprints muito longos';

  @override
  String get hybridAP6 => 'Não adaptar o processo ao contexto';

  @override
  String get hybridAP7 => 'Ignorar o feedback do time';

  @override
  String get hybridAP8 => 'Não definir critérios de transição claros';

  @override
  String get hybridFAQ1Q => 'Qual é a diferença entre Scrumban e Scrum puro?';

  @override
  String get hybridFAQ1A =>
      'Scrumban combina a estrutura dos sprints do Scrum com o fluxo contínuo do Kanban, oferecendo mais flexibilidade.';

  @override
  String get hybridFAQ2Q => 'Quando devo adotar Scrumban?';

  @override
  String get hybridFAQ2A =>
      'Quando o time precisa de mais flexibilidade do que o Scrum oferece, mas ainda quer manter alguma estrutura de sprints.';

  @override
  String get hybridFAQ3Q => 'Posso adicionar itens durante o sprint?';

  @override
  String get hybridFAQ3A =>
      'Sim, o Scrumban permite adicionar itens durante o sprint, respeitando os WIP limits.';

  @override
  String get hybridFAQ4Q => 'Como faço a transição para Scrumban?';

  @override
  String get hybridFAQ4A =>
      'Comece com sprints curtos e WIP limits relaxados, depois ajuste conforme o time amadurece.';

  @override
  String get retroNoResults => 'Nenhum resultado';

  @override
  String get retroFilterAll => 'Todas';

  @override
  String get retroFilterActive => 'Ativas';

  @override
  String get retroFilterCompleted => 'Concluídas';

  @override
  String get retroFilterDraft => 'Rascunho';

  @override
  String get retroDeleteTitle => 'Excluir';

  @override
  String retroDeleteConfirm(String title) {
    return 'Tem certeza de que deseja excluir?';
  }

  @override
  String get retroDeleteSuccess => 'Excluído com sucesso';

  @override
  String retroDeleteError(String error) {
    return 'Erro ao excluir';
  }

  @override
  String get retroDeleteConfirmAction => 'Excluir';

  @override
  String get retroNewRetroTitle => 'Nova Retrospectiva';

  @override
  String get retroLinkToSprint => 'Vincular ao sprint';

  @override
  String get retroNoProjectFound => 'Nenhum projeto encontrado';

  @override
  String get retroSelectProject => 'Selecionar projeto';

  @override
  String get retroSelectSprint => 'Selecionar sprint';

  @override
  String retroSprintLabel(int number, String name) {
    return 'Sprint';
  }

  @override
  String retroSprintOnlyLabel(int number) {
    return 'Apenas sprint';
  }

  @override
  String get retroOwner => 'Responsável';

  @override
  String get retroGuest => 'Convidado';

  @override
  String get retroSessionTitle => 'Título da sessão';

  @override
  String get retroSessionTitleHint => 'Ex: Retro Sprint 10';

  @override
  String get retroTemplateLabel => 'Template';

  @override
  String get retroVotesPerUser => 'Votos por usuário';

  @override
  String get retroActionClose => 'Fechar';

  @override
  String get retroActionCreate => 'Criar ação';

  @override
  String get retroStatusDraft => 'Rascunho';

  @override
  String get retroStatusActive => 'Ativa';

  @override
  String get agileBurndownInfoTitle => 'Come leggere il Burndown Chart';

  @override
  String get agileBurndownInfoIdeal =>
      'La linea **Ideale** (tratteggiata) mostra il progresso target se il lavoro fosse completato in modo uniforme.';

  @override
  String get agileBurndownInfoActual =>
      'La linea **Effettiva** (continua) mostra il lavoro rimanente. Le storie completate abbassano questa linea.';

  @override
  String get agileBurndownInfoGoal =>
      'Il tuo obiettivo è mantenere la linea Effettiva al di sotto di quella Ideale per finire in tempo.';

  @override
  String get guideToolsTitle => 'Strumenti & Integrazioni';

  @override
  String get guideJiraContent =>
      'L\'app si integra con Jira per mantenere sincronizzato il lavoro.\n\nFunzionalità principali:\n• **Import**: Le storie create in Jira appaiono qui.\n• **Link**: Cliccando sull\'ID della storia (es. PROJ-123) si apre direttamente Jira.\n• **Sync**: Lo stato si aggiorna bidirezionalmente (se configurato).';

  @override
  String get guideWorkflowTitle => 'Workflow & Qualità';

  @override
  String get guideAcceptanceCriteriaContent =>
      'Per garantire la qualità, ogni storia deve avere Criteri di Accettazione chiari.\n\n• **Aggiunta Rapida**: Puoi aggiungere criteri direttamente dal dettaglio della storia.\n• **Verifica**: Spunta i criteri man mano che vengono soddisfatti.\n• **Definition of Done**: Una storia è \'Done\' solo quando tutti i criteri sono soddisfatti.';

  @override
  String get scrumWorkflowStatusContent =>
      'In Scrum, il ciclo di vita di una storia segue questi stati:\n\n1. **Product Backlog**: Dove nascono le idee. L\'etichetta \'Refinement\' indica che la storia è in fase di analisi/dettaglio (non è una colonna della board, ma un indicatore).\n2. **Ready**: La storia è pronta per essere lavorata (rispetta la Definition of Ready).\n3. **In Sprint**: Durante il Planning, le storie \'Ready\' vengono spostate nello Sprint.\n4. **In Progress**: La storia è in lavorazione attiva.\n5. **In Review**: La storia è in fase di revisione/code review.\n6. **Done**: La storia è completata e verificata.';

  @override
  String get kanbanWorkflowStatusContent =>
      'In Kanban, il flusso è continuo:\n\n1. **Refinement**: Colonna dedicata per analizzare le richieste in ingresso.\n2. **Ready**: Code di attesa per il lavoro pronto (pull system).\n3. **Active Board**: Le storie fluiscono attraverso le colonne di lavoro.\n4. **WIP Limits**: Ogni colonna ha un limite per evitare colli di bottiglia.';

  @override
  String get hybridWorkflowStatusContent =>
      'Scrumban usa un approccio ibrido:\n\n• Puoi usare Sprint per la pianificazione, ma gestire il flusso giornaliero come Kanban.\n• Le storie \'Ready\' possono essere tirate (pull) quando c\'è capacità, indipendentemente dallo Sprint planning, se il team lo preferisce.';

  @override
  String get contextualHelpButton => 'Aiuto';

  @override
  String get contextualHelpTips => 'Suggerimenti';

  @override
  String get contextualHelpBacklogTitle => 'Product Backlog';

  @override
  String get contextualHelpBacklogDesc =>
      'Il backlog è la lista prioritizzata di tutto il lavoro da fare. Le storie in alto sono le più importanti.';

  @override
  String get contextualHelpBacklogTip1 =>
      'Mantieni il backlog ordinato per priorità';

  @override
  String get contextualHelpBacklogTip2 =>
      'Fai refinement regolare per dettagliare le storie';

  @override
  String get contextualHelpBacklogTip3 =>
      'Una storia è \'Ready\' quando soddisfa la Definition of Ready';

  @override
  String get contextualHelpSprintTitle => 'Sprint';

  @override
  String get contextualHelpSprintDesc =>
      'Lo sprint è un periodo di tempo fisso (1-4 settimane) durante il quale il team lavora sulle storie selezionate.';

  @override
  String get contextualHelpSprintTip1 => 'Non cambiare scope durante lo sprint';

  @override
  String get contextualHelpSprintTip2 =>
      'Monitora il burndown per verificare il progresso';

  @override
  String get contextualHelpSprintTip3 =>
      'Fai daily standup per allineare il team';

  @override
  String get contextualHelpKanbanTitle => 'Kanban Board';

  @override
  String get contextualHelpKanbanDescFlow =>
      'La board Kanban visualizza il flusso di lavoro. Gli item si muovono da sinistra a destra attraverso le colonne.';

  @override
  String get contextualHelpKanbanDescScrum =>
      'In Scrum, la board mostra lo stato delle storie dello sprint corrente.';

  @override
  String get contextualHelpKanbanTip1 =>
      'Rispetta i WIP limits per evitare colli di bottiglia';

  @override
  String get contextualHelpKanbanTip2 =>
      'Tira (pull) nuovo lavoro solo quando c\'è capacità';

  @override
  String get contextualHelpKanbanTip3 =>
      'Monitora l\'età degli item per identificare blocchi';

  @override
  String get contextualHelpKanbanTipScrum1 =>
      'Muovi le card da sinistra a destra mentre lavori';

  @override
  String get contextualHelpKanbanTipScrum2 =>
      'Completa una storia prima di iniziarne un\'altra';

  @override
  String get contextualHelpTeamTitle => 'Team';

  @override
  String get contextualHelpTeamDesc =>
      'Qui puoi gestire i membri del team, i loro ruoli e le competenze.';

  @override
  String get contextualHelpTeamTip1 => 'Assegna ruoli chiari a ogni membro';

  @override
  String get contextualHelpTeamTip2 =>
      'Bilancia il carico di lavoro tra i membri';

  @override
  String get contextualHelpMetricsTitle => 'Metriche';

  @override
  String get contextualHelpMetricsDescScrum =>
      'Monitora velocity, burndown e accuratezza delle stime per migliorare la prevedibilità.';

  @override
  String get contextualHelpMetricsDescKanban =>
      'Monitora Lead Time, Cycle Time e Throughput per ottimizzare il flusso.';

  @override
  String get contextualHelpMetricsDescHybrid =>
      'Combina metriche Scrum e Kanban per un quadro completo.';

  @override
  String get contextualHelpMetricsTipScrum1 =>
      'Usa la velocity media per pianificare gli sprint futuri';

  @override
  String get contextualHelpMetricsTipScrum2 =>
      'Analizza le stime per migliorare la precisione';

  @override
  String get contextualHelpMetricsTipKanban1 =>
      'Riduci il Lead Time per consegnare valore più velocemente';

  @override
  String get contextualHelpMetricsTipKanban2 =>
      'Monitora il Throughput settimanale per la prevedibilità';

  @override
  String get contextualHelpMetricsTipKanban3 =>
      'Usa l\'età degli item per identificare blocchi';

  @override
  String get contextualHelpMetricsTipHybrid1 =>
      'Bilancia velocity e flow metrics';

  @override
  String get contextualHelpMetricsTipHybrid2 =>
      'Adatta le metriche al tuo modo di lavorare';

  @override
  String get contextualHelpRetroTitle => 'Retrospettiva';

  @override
  String get contextualHelpRetroDescScrum =>
      'La retrospettiva è un motore di miglioramento continuo progettato per trasformare i feedback del team in una crescita misurabile attraverso 4 aree distinte.';

  @override
  String get contextualHelpRetroDescKanban =>
      'In Kanban, la Retrospettiva (Operations Review) si concentra sull\'analisi del flusso di consegna, identificando i colli di bottiglia e ottimizzando i lead time.';

  @override
  String get contextualHelpRetroTabActiveTitle => 'Tab Active: Sessione Core';

  @override
  String get contextualHelpRetroTabActive =>
      'Gestisci i brainstorm correnti. Durante la fase \'Writing\', le card sono nascoste per evitare l\'ancoraggio (anchoring bias). Usa la funzione \'Carry Forward\' all\'inizio di una sessione per selezionare i miglioramenti non risolti dai cicli precedenti e mantenere lo slancio.';

  @override
  String get contextualHelpRetroTabHistoryTitle =>
      'Tab History: Trend & Insight';

  @override
  String get contextualHelpRetroTabHistory =>
      'Revisiona le sessioni completate tramite un grafico dei trend. Analizza il \'Sentiment del Team\' (felicità) rispetto al \'Tasso di Completamento\' (efficacia). Se il sentiment è alto ma il completamento basso, focalizzati sul rendere le azioni più raggiungibili.';

  @override
  String get contextualHelpRetroTabActionItemsTitle => 'Action Items Tracker';

  @override
  String get contextualHelpRetroTabActionItems =>
      'Dashboard di esecuzione strategica. Ogni azione dovrebbe seguire i criteri SMART (Specifico, Misurabile, Raggiungibile, Rilevante, Temporizzato). Usa i filtri per verificare gli item scaduti durante i check-in di metà sprint.';

  @override
  String get contextualHelpRetroTabLessonsLearnedTitle =>
      'Lessons Learned register';

  @override
  String get contextualHelpRetroTabLessonsLearned =>
      'Repository in stile PMBOK per la conoscenza istituzionale. Mentre gli Action Item sono tattici (risolvi ora), le Lessons Learned sono strategiche (non ripetere mai più l\'errore). Usa l\'import per sfruttare i successi da altri progetti.';

  @override
  String get contextualHelpRetroIntegrationTitle => 'Il Ciclo di Miglioramento';

  @override
  String get contextualHelpRetroIntegration =>
      'Le card del board vengono distillate in Action Item. Questi item sono tracciati nella dashboard e il loro tasso di completamento alimenta i trend della History, mentre i pattern ricorrenti vengono formalizzati come Lessons Learned.';

  @override
  String get contextualHelpRetroModeQuickTitle =>
      'Quick Form vs Board Interattiva';

  @override
  String get contextualHelpRetroModeQuick =>
      'La Quick Form permette a un singolo utente di registrare highlight e Action Item direttamente. Usala se il brainstorming è avvenuto offline o se devi registrare rapidamente un riassunto. Effetto: Popola direttamente History e Action Item senza collaborazione in tempo reale.';

  @override
  String get contextualHelpRetroModeInteractiveTitle => 'Sessione Interattiva';

  @override
  String get contextualHelpRetroModeInteractive =>
      'Guida il team attraverso Icebreaker, Brainstorming (Scrittura), Raggruppamento e Votazione. Effetto: Garantisce che la voce di tutti sia ascoltata, riduce i bias tramite card nascoste durante la scrittura e crea consenso sui miglioramenti prioritari.';

  @override
  String get contextualHelpRetroTip1 =>
      'Assegna un proprietario chiaro e una scadenza a ogni Action Item';

  @override
  String get contextualHelpRetroTip2 =>
      'Celebra i \'Punti di Forza\' nel tab Lessons Learned per costruire su ciò che funziona';

  @override
  String get contextualHelpRetroTip3 =>
      'Usa la \'Quick Form\' per digitalizzare i risultati di workshop fisici o riunioni di stato ad alto livello';

  @override
  String get retroStatusCompleted => 'Concluída';

  @override
  String get profileIntegrations => 'Integrações';

  @override
  String get profileJiraIntegration => 'Integração JIRA';

  @override
  String get profileJiraIntegrationDesc => 'Conecte ao JIRA para sincronização';

  @override
  String get jiraDomain => 'Domínio';

  @override
  String get jiraEmail => 'E-mail';

  @override
  String get jiraApiToken => 'Token da API';

  @override
  String get jiraConnect => 'Conectar';

  @override
  String get jiraDisconnect => 'Desconectar';

  @override
  String get jiraSettingsSaved => 'Configurações JIRA salvas';

  @override
  String get jiraSettingsCleared => 'Configurações JIRA removidas';

  @override
  String get retroTemplateStartStopContinue => 'Start Stop Continue';

  @override
  String get retroTemplateSailboat => 'Sailboat';

  @override
  String get retroTemplate4Ls => '4Ls';

  @override
  String get retroTemplateStarfish => 'Starfish';

  @override
  String get retroTemplateMadSadGlad => 'Mad Sad Glad';

  @override
  String get retroTemplateDAKI => 'DAKI';

  @override
  String get retroDescStartStopContinue => 'Começar, Parar, Continuar';

  @override
  String get retroDescSailboat =>
      'Metáfora do veleiro: Vento, Âncora, Rochas, Objetivo';

  @override
  String get retroDesc4Ls => 'Gostei, Aprendi, Fez Falta, Desejado';

  @override
  String get retroDescStarfish =>
      'Mais de, Menos de, Continuar, Começar, Parar';

  @override
  String get retroDescMadSadGlad => 'Irritado, Triste, Contente';

  @override
  String get retroDescDAKI => 'Abandonar, Manter, Melhorar, Iniciar';

  @override
  String get retroUsageStartStopContinue =>
      'Framework clássico para melhorias incrementais simples.';

  @override
  String get retroUsageSailboat =>
      'Perfeito para visualizar forças, obstáculos e riscos do projeto.';

  @override
  String get retroUsage4Ls =>
      'Ideal para sprints onde o time quer refletir sobre aprendizados e desejos.';

  @override
  String get retroUsageStarfish =>
      'Ideal para análise detalhada de práticas existentes.';

  @override
  String get retroUsageMadSadGlad =>
      'Eficaz para entender o estado emocional do time e identificar problemas.';

  @override
  String get retroUsageDAKI =>
      'Útil para identificar práticas a abandonar, manter, melhorar ou iniciar.';

  @override
  String get retroIcebreakerSentiment => 'Sentimento';

  @override
  String get retroIcebreakerOneWord => 'Uma Palavra';

  @override
  String get retroIcebreakerWeather => 'Clima';

  @override
  String get retroIcebreakerSentimentDesc =>
      'Compartilhe como está se sentindo';

  @override
  String get retroIcebreakerOneWordDesc => 'Descreva o sprint em uma palavra';

  @override
  String get retroIcebreakerWeatherDesc =>
      'Escolha o clima que representa seu sprint';

  @override
  String get retroPhaseIcebreaker => 'Icebreaker';

  @override
  String get retroPhaseWriting => 'Escrita';

  @override
  String get retroPhaseVoting => 'Votação';

  @override
  String get retroPhaseDiscuss => 'Discutir';

  @override
  String get retroActionItemsLabel => 'Itens de Ação';

  @override
  String get retroActionDragToCreate => 'Arraste para criar';

  @override
  String get retroNoActionItems => 'Nenhum item de ação';

  @override
  String get facilitatorGuideNextColumn => 'Próxima coluna';

  @override
  String get collectionRationaleSSC =>
      'Começar, Parar, Continuar: framework clássico para melhorias incrementais.';

  @override
  String get collectionRationaleMSG =>
      'Expressa emoções: Irritado, Triste, Contente. Útil para entender o estado emocional do time.';

  @override
  String get collectionRationale4Ls =>
      'Ajuda a refletir sobre o que foi aprendido, o que fez falta, o que foi apreciado e o que se desejava.';

  @override
  String get collectionRationaleSailboat =>
      'Metáfora do veleiro: Vento (o que impulsiona), Âncora (o que freia), Rochas (riscos), Objetivo.';

  @override
  String get collectionRationaleStarfish =>
      'Modelo estrela do mar: Mais de, Menos de, Continuar, Começar, Parar.';

  @override
  String get collectionRationaleDAKI =>
      'Organiza as ações em: Abandonar, Manter, Melhorar, Iniciar.';

  @override
  String get missingSuggestionSSCStop => 'O que o time deveria parar de fazer?';

  @override
  String get missingSuggestionSSCStart =>
      'Que novas práticas o time deveria começar a adotar?';

  @override
  String get missingSuggestionMSGMad =>
      'O que frustrou o time neste sprint? Expresse o que deixou insatisfeito.';

  @override
  String get missingSuggestionMSGSad =>
      'O que causou desapontamento? Compartilhe para que possamos melhorar.';

  @override
  String get missingSuggestion4LsLacked =>
      'Pense no que fez falta neste sprint. O que você gostaria de ter tido?';

  @override
  String get missingSuggestion4LsLonged =>
      'Reflita sobre o que você desejou durante o sprint. O que traria mais satisfação?';

  @override
  String get missingSuggestionSailboatAnchor =>
      'O que está freando o time? Identifique as âncoras.';

  @override
  String get missingSuggestionSailboatRock =>
      'Quais são os riscos à frente? Identifique as rochas.';

  @override
  String get missingSuggestionStarfishStop =>
      'O que o time deveria parar de fazer completamente?';

  @override
  String get missingSuggestionStarfishStart =>
      'Que novas atividades o time deveria começar?';

  @override
  String get missingSuggestionDAKIDrop =>
      'O que não está mais funcionando e poderia ser abandonado?';

  @override
  String get missingSuggestionDAKIAdd =>
      'Que novas práticas ou ferramentas o time poderia adotar?';

  @override
  String get missingSuggestionGeneric =>
      'Adicione pelo menos um card a esta coluna para uma retrospectiva mais completa.';

  @override
  String get facilitatorGuideAllCovered => 'Todas as colunas foram cobertas';

  @override
  String get facilitatorGuideMissing => 'Faltando';

  @override
  String get retroPhaseStart => 'Iniciar';

  @override
  String get retroPhaseStop => 'Parar';

  @override
  String get retroPhaseContinue => 'Continuar';

  @override
  String get retroColumnMad => 'Irritado';

  @override
  String get retroColumnSad => 'Triste';

  @override
  String get retroColumnGlad => 'Contente';

  @override
  String get retroColumnLiked => 'Gostei';

  @override
  String get retroColumnLearned => 'Aprendido';

  @override
  String get retroColumnLacked => 'Fez Falta';

  @override
  String get retroColumnLonged => 'Desejado';

  @override
  String get retroColumnWind => 'Vento';

  @override
  String get retroColumnAnchor => 'Âncora';

  @override
  String get retroColumnRock => 'Risco';

  @override
  String get retroColumnGoal => 'Objetivo';

  @override
  String get retroColumnKeep => 'Manter';

  @override
  String get retroColumnMore => 'Mais de';

  @override
  String get retroColumnLess => 'Menos de';

  @override
  String get retroColumnDrop => 'Abandonar';

  @override
  String get retroColumnAdd => 'Adicionar';

  @override
  String get retroColumnImprove => 'Melhorar';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Escuro';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get formTitle => 'Título';

  @override
  String get formDescription => 'Descrição';

  @override
  String get formName => 'Nome';

  @override
  String get formRequired => 'Obrigatório';

  @override
  String get formHint => 'Digite aqui...';

  @override
  String get formOptional => 'Opcional';

  @override
  String errorGeneric(String error) {
    return 'Ocorreu um erro';
  }

  @override
  String get errorLoading => 'Erro ao carregar';

  @override
  String get errorSaving => 'Erro ao salvar';

  @override
  String get errorNetwork => 'Erro de rede';

  @override
  String get errorPermission => 'Permissão negada';

  @override
  String get errorNotFound => 'Não encontrado';

  @override
  String get successSaved => 'Salvato con successo';

  @override
  String get successDeleted => 'Eliminato con successo';

  @override
  String get successCopied => 'Copiato negli appunti';

  @override
  String get filterAll => 'Todos';

  @override
  String get filterRemove => 'Remover filtro';

  @override
  String get filterActive => 'Ativo';

  @override
  String get filterCompleted => 'Concluído';

  @override
  String get participants => 'Participantes';

  @override
  String get agileAcceptanceCriteria => 'Critérios de Aceitação';

  @override
  String agileAcceptanceCriteriaCount(int completed, int total) {
    return '$completed de $total itens';
  }

  @override
  String get agileEstimateRequired =>
      'Estimativa necessária (clique para estimar)';

  @override
  String get agileNoActiveSprint => 'Nenhum Sprint Ativo';

  @override
  String get agileKanbanBoardHint =>
      'O Kanban Board mostra as stories do sprint ativo.\nPara visualizar as stories';

  @override
  String get agileStartSprintFromTab => 'Inicie um sprint na aba Sprint';

  @override
  String get agileDisableFilterHint =>
      'Ou desative o filtro para ver todas as stories';

  @override
  String get agileShowAllStories => 'Mostrar todas as stories';

  @override
  String get agileFilterActiveSprint => 'Filtro Sprint Ativo: ';

  @override
  String get agileFilterActive => 'Ativo';

  @override
  String get agileFilterAll => 'Tudo';

  @override
  String get agileActionInvite => 'Convidar';

  @override
  String agileTeamTitle(int count) {
    return 'Time';
  }

  @override
  String get agileNoMembers => 'Nenhum membro no time';

  @override
  String get agileYouBadge => 'Você';

  @override
  String agileStatsPlannedCount(int count) {
    return 'Planejados';
  }

  @override
  String agileStatsTotalCount(int count) {
    return 'Total';
  }

  @override
  String get agileStatsPtsPerSprint => 'pts/sprint';

  @override
  String get agileStatsWorkInProgress => 'Em Andamento';

  @override
  String get agileStatsItemsPerWeek => 'itens/semana';

  @override
  String get agileStatsCompletedTooltip =>
      'Número de sprints com status \'Concluído\'.\nClique em \'Concluir Sprint\' para finalizar';

  @override
  String get agileAverageVelocityTooltip =>
      'Média dos Story Points concluídos por sprint.\nCalculada a partir dos sprints concluídos';

  @override
  String get agileStatsStoriesCompletedTooltip =>
      'Stories concluídas em todos os sprints.\nRepresenta a capacidade total do time';

  @override
  String get agileStatsPointsTooltip =>
      'Total de Story Points concluídos nos sprints.\nRepresenta a Velocity acumulada do time';

  @override
  String get agileItemsCompletedTooltip =>
      'Número de Work Items com status \'Done\'.\nMova os itens para a coluna \'Done\' para';

  @override
  String get agileInProgressTooltip =>
      'Itens atualmente em andamento (WIP).\nMantenha esse número baixo para melhorar';

  @override
  String get agileCycleTimeTooltip =>
      'Tempo médio do início do trabalho à conclusão.\nRequer itens com datas \'Inicia\'';

  @override
  String get agileThroughputTooltip =>
      'Número de itens concluídos por unidade de tempo.\nMédia calculada por semana';

  @override
  String get agileHybridSprintTooltip =>
      'Sprints concluídos em relação ao total.';

  @override
  String get agileHybridCompletedTooltip =>
      'Itens com status \'Done\' em relação ao total.\nMova itens para a coluna \'Done\' para';

  @override
  String get agileAddSkillsHint => 'Adicione competências aos membros do time';

  @override
  String get agileSkillMatrixTitle => 'Matriz de Competências';

  @override
  String get agileCriticalSkills => 'Competências críticas';

  @override
  String agileCriticalSkillsWarning(String skills) {
    return 'Apenas 1 pessoa cobre: $skills';
  }

  @override
  String get agileSkills => 'Competências';

  @override
  String get agileNoSkills => 'Nenhuma competência';

  @override
  String get agileAddSkill => 'Adicionar competência';

  @override
  String get agileNewSkill => 'Nova competência...';

  @override
  String get agileNewSkillDialogTitle => 'Nova Competência';

  @override
  String get agileNewSkillName => 'Nome da competência';

  @override
  String get agileNewSkillHint => 'Ex: Flutter, Python, AWS...';

  @override
  String get agileSkillCoverage => 'Cobertura de Competências';

  @override
  String get agileNoSkillsAvailable => 'Nenhuma skill disponível';

  @override
  String agileBasedOnCompletedItems(int count) {
    return 'Baseado em $count itens concluídos';
  }

  @override
  String get agileNoAcceptanceCriteria =>
      'Nenhum critério de aceitação definido';

  @override
  String get agileDescription => 'Descrição';

  @override
  String get agileNoDescription => 'Nenhuma descrição';

  @override
  String get agileTags => 'Tags';

  @override
  String get agileEstimates => 'Estimativas';

  @override
  String get agileFinalEstimate => 'Estimativa Final';

  @override
  String agileEstimatesReceived(int count) {
    return '$count estimativas recebidas';
  }

  @override
  String get agileInformation => 'Informações';

  @override
  String get agileBusinessValue => 'Business Value';

  @override
  String get agileAssignee => 'Responsável';

  @override
  String get agileNoAssignee => 'Não atribuído';

  @override
  String get agileCreatedBy => 'Criado por';

  @override
  String get agileCreatedAt => 'Criado em';

  @override
  String get agileStartedAt => 'Iniciado em';

  @override
  String get agileCompletedAt => 'Concluído em';

  @override
  String get agileSprintTitle => 'Sprint';

  @override
  String get agileNewSprint => 'Novo Sprint';

  @override
  String get agileNoSprints => 'Nenhum sprint';

  @override
  String get agileCreateFirstSprint => 'Crie o primeiro sprint para começar';

  @override
  String get agileSprintStatusPlanning => 'Planning';

  @override
  String get agileSprintStatusActive => 'Ativo';

  @override
  String get agileSprintStatusReview => 'Review';

  @override
  String get agileSprintStatusCompleted => 'Concluído';

  @override
  String get agileStartSprint => 'Iniciar Sprint';

  @override
  String get agileCompleteSprint => 'Concluir Sprint';

  @override
  String get agileDeleteSprint => 'Excluir';

  @override
  String get agileSprintName => 'Nome do Sprint';

  @override
  String get agileSprintGoal => 'Sprint Goal';

  @override
  String get agileSprintGoalHint => 'Objetivo do sprint';

  @override
  String get agileStartDate => 'Data Início';

  @override
  String get agileEndDate => 'Data Fim';

  @override
  String get agileStatsStories => 'Stories';

  @override
  String get agileStatsPoints => 'Pontos';

  @override
  String get agileStatsCompleted => 'concluídos';

  @override
  String get agileStatsVelocity => 'Velocity';

  @override
  String agileDaysRemainingCount(String count) {
    return '$count dias restantes';
  }

  @override
  String get agileAverageVelocity => 'Velocity média';

  @override
  String agileTeamMembersCount(String count) {
    return 'Membros do time';
  }

  @override
  String get agileActionCancel => 'Cancelar';

  @override
  String get agileActionSave => 'Salvar';

  @override
  String get agileActionCreate => 'Criar';

  @override
  String get agileSprintPlanningTitle => 'Sprint Planning';

  @override
  String get agileSprintPlanningSubtitle =>
      'Selecione as stories para concluir neste sprint';

  @override
  String get agileBurndownChart => 'Burndown Chart';

  @override
  String get agileBurndownIdeal => 'Ideal';

  @override
  String get agileBurndownActual => 'Real';

  @override
  String get agileBurndownPlanned => 'Planejados';

  @override
  String get agileBurndownRemaining => 'Restantes';

  @override
  String get agileBurndownNoData => 'Nenhum dado de burndown';

  @override
  String get agileBurndownNoDataHint =>
      'Os dados aparecerão quando o sprint estiver ativo';

  @override
  String get agileVelocityTrend => 'Trend de Velocity';

  @override
  String get agileVelocityNoData => 'Nenhum dado de velocity';

  @override
  String get agileVelocityNoDataHint =>
      'Conclua sprints para ver o trend de velocity';

  @override
  String get agileTeamCapacity => 'Capacidade do Time';

  @override
  String get agileTeamCapacityScrum => 'Capacidade do Time Scrum';

  @override
  String get agileTeamCapacityHours => 'Horas de capacidade do time';

  @override
  String get agileThroughput => 'Throughput';

  @override
  String get agileSuggestedCapacity => 'Capacidade sugerida';

  @override
  String get agileSuggestedCapacityHint =>
      'Baseada na velocity dos últimos sprints';

  @override
  String get agileSuggestedCapacityNoData =>
      'Conclua sprints para obter sugestões de capacidade';

  @override
  String get agileScrumGuideNote =>
      'O Scrum Guide recomenda basear o planejamento na Velocity histórica, não';

  @override
  String get agileHoursAvailable => 'Disponível';

  @override
  String get agileHoursAssigned => 'Atribuído';

  @override
  String get agileHoursOverloaded => 'Sobrecarregado';

  @override
  String get agileHoursTotal => 'Capacidade Total';

  @override
  String get agileHoursUtilization => 'Utilização';

  @override
  String agileMetricsTitle(String framework) {
    return 'Métricas $framework';
  }

  @override
  String get agileItemsCompleted => 'Itens Concluídos';

  @override
  String get agileInProgress => 'Em Andamento';

  @override
  String get agileCycleTime => 'Cycle Time';

  @override
  String get agileLeadTime => 'Lead Time';

  @override
  String get agileDistribution => 'Distribuição de Stories';

  @override
  String get agileCompletionRate => 'Completion Rate';

  @override
  String get agileAccuracy => 'Precisão das Estimativas';

  @override
  String get agileEfficiency => 'Flow Efficiency';

  @override
  String get removeParticipant => 'Remover participante';

  @override
  String get noParticipants => 'Nenhum participante';

  @override
  String get participantJoined => 'Entrou';

  @override
  String get participantLeft => 'Saiu';

  @override
  String get participantRole => 'Papel';

  @override
  String get participantVoter => 'Votante';

  @override
  String get participantObserver => 'Observador';

  @override
  String get participantModerator => 'Moderador';

  @override
  String get confirmDelete => 'Confirmar exclusão';

  @override
  String get confirmDeleteMessage => 'Tem certeza de que deseja excluir?';

  @override
  String get yes => 'Si';

  @override
  String get no => 'Não';

  @override
  String get ok => 'OK';

  @override
  String get today => 'Oggi';

  @override
  String get yesterday => 'Ieri';

  @override
  String get tomorrow => 'Domani';

  @override
  String daysAgo(int count) {
    return 'dias atrás';
  }

  @override
  String hoursAgo(int count) {
    return 'horas atrás';
  }

  @override
  String minutesAgo(int count) {
    return 'minutos atrás';
  }

  @override
  String itemCount(int count) {
    return 'Contagem de itens';
  }

  @override
  String get welcomeBack => 'Bentornato';

  @override
  String greeting(String name) {
    return 'Olá';
  }

  @override
  String get copyLink => 'Copiar link';

  @override
  String get shareSession => 'Compartilhar sessão';

  @override
  String get inviteByEmail => 'Convidar por e-mail';

  @override
  String get inviteByLink => 'Convidar por link';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileEmail => 'E-mail';

  @override
  String get profileDisplayName => 'Nome de exibição';

  @override
  String get profilePhotoUrl => 'URL da foto';

  @override
  String get profileEditProfile => 'Editar perfil';

  @override
  String get profileReload => 'Recarregar';

  @override
  String get profilePersonalInfo => 'Informações pessoais';

  @override
  String get profileLastName => 'Sobrenome';

  @override
  String get profileCompany => 'Empresa';

  @override
  String get profileJobTitle => 'Cargo';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileSubscription => 'Assinatura';

  @override
  String get profilePlan => 'Plano';

  @override
  String get profileBillingCycle => 'Ciclo de cobrança';

  @override
  String get profilePrice => 'Preço';

  @override
  String get profileActivationDate => 'Data de ativação';

  @override
  String get profileTrialEnd => 'Fim do período de avaliação';

  @override
  String get profileNextRenewal => 'Próxima renovação';

  @override
  String get profileDaysRemaining => 'Dias restantes';

  @override
  String get profileUpgrade => 'Upgrade';

  @override
  String get profileUpgradePlan => 'Fazer upgrade do plano';

  @override
  String get planFree => 'Gratuito';

  @override
  String get planPremium => 'Premium';

  @override
  String get planElite => 'Elite';

  @override
  String get statusActive => 'Attivo';

  @override
  String get statusTrialing => 'In prova';

  @override
  String get statusPastDue => 'Pagamento scaduto';

  @override
  String get statusPaused => 'In pausa';

  @override
  String get statusCancelled => 'Cancellato';

  @override
  String get statusExpired => 'Scaduto';

  @override
  String get cycleMonthly => 'Mensal';

  @override
  String get cycleQuarterly => 'Trimestral';

  @override
  String get cycleYearly => 'Anual';

  @override
  String get cycleLifetime => 'Vitalício';

  @override
  String get pricePerMonth => 'por mês';

  @override
  String get pricePerQuarter => 'por trimestre';

  @override
  String get pricePerYear => 'por ano';

  @override
  String get priceForever => 'Para sempre';

  @override
  String get priceFree => 'Grátis';

  @override
  String get profileGeneralSettings => 'Configurações gerais';

  @override
  String get profileAnimations => 'Animações';

  @override
  String get profileAnimationsDesc => 'Habilite animações na interface';

  @override
  String get profileFeatures => 'Funcionalidades';

  @override
  String get profileCalendarIntegration => 'Integração com Calendário';

  @override
  String get profileCalendarIntegrationDesc =>
      'Sincronize eventos com o calendário';

  @override
  String get profileExportSheets => 'Exportar para Sheets';

  @override
  String get profileExportSheetsDesc => 'Exporte dados para Google Sheets';

  @override
  String get profileBetaFeatures => 'Funcionalidades Beta';

  @override
  String get profileBetaFeaturesDesc =>
      'Acesse funcionalidades em fase de testes';

  @override
  String get profileAdvancedMetrics => 'Métricas avançadas';

  @override
  String get profileAdvancedMetricsDesc =>
      'Habilite métricas avançadas para análise detalhada';

  @override
  String get profileNotifications => 'Notificações';

  @override
  String get profileEmailNotifications => 'Notificações por e-mail';

  @override
  String get profileEmailNotificationsDesc => 'Receba notificações por e-mail';

  @override
  String get profilePushNotifications => 'Notificações push';

  @override
  String get profilePushNotificationsDesc => 'Receba notificações push';

  @override
  String get profileSprintReminders => 'Lembretes de sprint';

  @override
  String get profileSprintRemindersDesc => 'Receba lembretes sobre sprints';

  @override
  String get profileSessionInvites => 'Convites de sessão';

  @override
  String get profileSessionInvitesDesc =>
      'Gerencie convites de sessão recebidos';

  @override
  String get profileWeeklySummary => 'Resumo semanal';

  @override
  String get profileWeeklySummaryDesc => 'Receba um resumo semanal por e-mail';

  @override
  String get profileDangerZone => 'Zona de Perigo';

  @override
  String get profileDeleteAccount => 'Excluir conta';

  @override
  String get profileDeleteAccountDesc =>
      'Exclua permanentemente sua conta e todos os dados associados';

  @override
  String get profileDeleteAccountRequest => 'Solicitar exclusão de conta';

  @override
  String get profileDeleteAccountIrreversible => 'Esta ação é irreversível';

  @override
  String get profileDeleteAccountReason => 'Motivo da exclusão';

  @override
  String get profileDeleteAccountReasonHint =>
      'Conte-nos por que deseja excluir sua conta (opcional)';

  @override
  String get profileRequestDeletion => 'Solicitar exclusão';

  @override
  String get profileDeletionInProgress => 'Exclusão em andamento';

  @override
  String profileDeletionRequestedAt(String date) {
    return 'Exclusão solicitada em';
  }

  @override
  String get profileCancelRequest => 'Cancelar solicitação';

  @override
  String get profileDeletionRequestSent => 'Solicitação de exclusão enviada';

  @override
  String get profileDeletionRequestCancelled =>
      'Solicitação de exclusão cancelada';

  @override
  String get profileUpdated => 'Perfil atualizado';

  @override
  String get profileLogout => 'Sair';

  @override
  String get profileLogoutDesc => 'Saia da sua conta';

  @override
  String get profileLogoutConfirm => 'Tem certeza de que deseja sair?';

  @override
  String get profileSubscriptionCancelled => 'Assinatura cancelada';

  @override
  String get profileCancelSubscription => 'Cancelar assinatura';

  @override
  String get profileCancelSubscriptionConfirm =>
      'Tem certeza de que deseja cancelar sua assinatura?';

  @override
  String get profileKeepSubscription => 'Manter assinatura';

  @override
  String get profileYesCancel => 'Sim, cancelar';

  @override
  String profileUpgradeComingSoon(String plan) {
    return 'Upgrade em breve';
  }

  @override
  String get profileFree => 'Gratuito';

  @override
  String get profileMonthly => 'Mensal';

  @override
  String get profileUser => 'Usuário';

  @override
  String profileErrorPrefix(String error) {
    return 'Erro';
  }

  @override
  String get stateSaving => 'Salvataggio...';

  @override
  String get cardCoffee => 'Café';

  @override
  String get cardQuestion => 'Dúvida';

  @override
  String get toolEisenhower => 'Matrice Eisenhower';

  @override
  String get toolEisenhowerDesc =>
      'Organizza le attivita in base a urgenza e importanza. Quadranti per decidere cosa fare subito, pianificare, delegare o eliminare.';

  @override
  String get toolEisenhowerDescShort => 'Prioritizza per urgenza e importanza';

  @override
  String get toolEstimation => 'Estimation Room';

  @override
  String get toolEstimationDesc =>
      'Sessioni di stima collaborative per il team. Planning Poker, T-Shirt sizing e altri metodi per stimare user stories.';

  @override
  String get toolEstimationDescShort => 'Sessioni di stima collaborative';

  @override
  String get toolSmartTodo => 'Smart Todo';

  @override
  String get toolSmartTodoDesc =>
      'Liste intelligenti e collaborative. Importa da CSV/testo, invita partecipanti e gestisci task con filtri avanzati.';

  @override
  String get toolSmartTodoDescShort =>
      'Liste intelligenti e collaborative. Importa da CSV, invita e gestisci.';

  @override
  String get toolAgileProcess => 'Agile Process Manager';

  @override
  String get toolAgileProcessDesc =>
      'Gestisci progetti agili completi con backlog, sprint planning, kanban board, metriche e retrospettive.';

  @override
  String get toolAgileProcessDescShort =>
      'Gestisci progetti agili con backlog, sprint, kanban e metriche.';

  @override
  String get toolRetro => 'Retrospective Board';

  @override
  String get toolRetroDesc =>
      'Raccogli feedback dal team su cosa e andato bene, cosa migliorare e le azioni da intraprendere.';

  @override
  String get toolRetroDescShort =>
      'Raccogli feedback dal team su cosa e andato bene e cosa migliorare.';

  @override
  String get homeUtilities => 'Utilitários';

  @override
  String get homeSelectTool => 'Selecione uma ferramenta';

  @override
  String get statusOnline => 'Online';

  @override
  String get comingSoon => 'Em breve';

  @override
  String get featureComingSoon => 'Em breve';

  @override
  String get featureSmartImport => 'Importação Inteligente';

  @override
  String get featureCollaboration => 'Colaboração';

  @override
  String get featureFilters => 'Filtros';

  @override
  String get feature4Quadrants => '4 Quadrantes';

  @override
  String get featureDragDrop => 'Arrastar e soltar';

  @override
  String get featureCollaborative => 'Colaborativo';

  @override
  String get featurePlanningPoker => 'Planning Poker';

  @override
  String get featureTshirtSize => 'Tamanhos T-Shirt';

  @override
  String get featureRealtime => 'Tempo real';

  @override
  String get featureScrum => 'Scrum';

  @override
  String get featureKanban => 'Kanban';

  @override
  String get featureHybrid => 'Híbrido';

  @override
  String get featureWentWell => 'Funcionou bem';

  @override
  String get featureToImprove => 'A melhorar';

  @override
  String get featureActions => 'Ações';

  @override
  String get themeLightMode => 'Tema Chiaro';

  @override
  String get themeDarkMode => 'Tema Scuro';

  @override
  String get estimationBackToSessions => 'Voltar às sessões';

  @override
  String get estimationSessionSettings => 'Configurações da sessão';

  @override
  String get estimationList => 'Lista';

  @override
  String estimationSessionsCount(int filtered, int total) {
    return 'Sessões';
  }

  @override
  String get estimationNoSessionFound => 'Nenhuma sessão encontrada';

  @override
  String get estimationCreateFirstSession => 'Crie a primeira sessão';

  @override
  String get estimationStoriesTotal => 'Stories totais';

  @override
  String get estimationStoriesCompleted => 'Stories concluídas';

  @override
  String get estimationParticipantsActive => 'Participantes ativos';

  @override
  String estimationProgress(int completed, int total, String percent) {
    return 'Progresso';
  }

  @override
  String get estimationStart => 'Iniciar';

  @override
  String get estimationComplete => 'Concluir';

  @override
  String get estimationAllStoriesEstimated =>
      'Todas as stories foram estimadas';

  @override
  String get estimationNoVotingInProgress => 'Nenhuma votação em andamento';

  @override
  String estimationCompletedLabel(
    int completed,
    int total,
    String total_estimate,
  ) {
    return 'Concluída';
  }

  @override
  String estimationVoteStory(String title) {
    return 'Votar story';
  }

  @override
  String get estimationAddStoriesToStart => 'Adicione stories para começar';

  @override
  String get estimationInVoting => 'Em votação';

  @override
  String get estimationReveal => 'Revelar';

  @override
  String get estimationSkip => 'Pular';

  @override
  String get estimationStories => 'Stories';

  @override
  String get estimationAddStory => 'Adicionar Story';

  @override
  String get estimationStartVoting => 'Iniciar Votação';

  @override
  String get estimationViewVotes => 'Ver votos';

  @override
  String get estimationViewDetail => 'Ver detalhe';

  @override
  String get estimationFinalEstimateLabel => 'Estimativa final';

  @override
  String estimationVotesOf(String title) {
    return 'votos de';
  }

  @override
  String get estimationParticipantVotes => 'Votos dos participantes';

  @override
  String get estimationPointsOrDays => 'Pontos ou dias';

  @override
  String get estimationEstimateRationale => 'Justificativa da estimativa';

  @override
  String get estimationExplainRationale => 'Explique sua justificativa';

  @override
  String get estimationRationaleHelp => 'Ajuda sobre justificativa';

  @override
  String get estimationConfirmFinalEstimate => 'Confirmar estimativa final';

  @override
  String get estimationEnterValidEstimate => 'Insira uma estimativa válida';

  @override
  String get estimationHintEstimate => 'Selecione um valor para sua estimativa';

  @override
  String get estimationStatus => 'Status';

  @override
  String get estimationOrder => 'Ordem';

  @override
  String get estimationVotesReceived => 'Votos recebidos';

  @override
  String get estimationAverageVotes => 'Média dos votos';

  @override
  String get estimationConsensus => 'Consenso';

  @override
  String get storyStatusPending => 'In attesa';

  @override
  String get storyStatusVoting => 'In votazione';

  @override
  String get storyStatusRevealed => 'Voti rivelati';

  @override
  String get participantManagement => 'Gerenciar participantes';

  @override
  String get participantCopySessionLink => 'Copiar link da sessão';

  @override
  String get participantInvitesTab => 'Convites';

  @override
  String get participantSessionLink => 'Link da sessão';

  @override
  String get participantAddDirect => 'Adicionar diretamente';

  @override
  String get participantEmailRequired => 'E-mail obrigatório';

  @override
  String get participantEmailHint => 'E-mail do participante';

  @override
  String get participantNameHint => 'Nome do participante';

  @override
  String participantVotersAndObservers(int voters, int observers) {
    return 'Votantes e Observadores';
  }

  @override
  String get participantYou => 'Você';

  @override
  String get participantMakeVoter => 'Tornar votante';

  @override
  String get participantMakeObserver => 'Tornar observador';

  @override
  String get participantRemoveTitle => 'Remover Participante';

  @override
  String participantRemoveConfirm(String name) {
    return 'Tem certeza de que deseja remover este participante?';
  }

  @override
  String participantAddedToSession(String email) {
    return 'Participante adicionado à sessão';
  }

  @override
  String participantRemovedFromSession(String name) {
    return 'Participante removido da sessão';
  }

  @override
  String participantRoleUpdated(String email) {
    return 'Papel atualizado';
  }

  @override
  String get participantFacilitator => 'Facilitador';

  @override
  String get inviteSendNew => 'Enviar novo convite';

  @override
  String get inviteRecipientEmail => 'E-mail do destinatário';

  @override
  String get inviteCreate => 'Criar convite';

  @override
  String get invitesSent => 'Convites enviados';

  @override
  String get inviteNoInvites => 'Nenhum convite';

  @override
  String inviteCreatedFor(String email) {
    return 'Convite criado para';
  }

  @override
  String inviteSentTo(String email) {
    return 'Convite enviado para';
  }

  @override
  String inviteExpiresIn(int days) {
    return 'Expira em';
  }

  @override
  String get inviteCopyLink => 'Copiar link';

  @override
  String get inviteRevokeAction => 'Revogar';

  @override
  String get inviteDeleteAction => 'Excluir';

  @override
  String get inviteRevokeTitle => 'Revogar Convite';

  @override
  String inviteRevokeConfirm(String email) {
    return 'Tem certeza de que deseja revogar este convite?';
  }

  @override
  String get inviteRevoke => 'Revogar';

  @override
  String inviteRevokedFor(String email) {
    return 'Convite revogado para';
  }

  @override
  String get inviteDeleteTitle => 'Excluir Convite';

  @override
  String inviteDeleteConfirm(String email) {
    return 'Tem certeza de que deseja excluir este convite?';
  }

  @override
  String inviteDeletedFor(String email) {
    return 'Convite excluído para';
  }

  @override
  String get inviteLinkCopied => 'Link copiado';

  @override
  String get linkCopied => 'Link copiado';

  @override
  String get enterValidEmail => 'Insira um e-mail válido';

  @override
  String get sessionCreatedSuccess => 'Sessão criada com sucesso';

  @override
  String get sessionUpdated => 'Sessão atualizada';

  @override
  String get sessionDeleted => 'Sessão excluída';

  @override
  String get sessionStarted => 'Sessão iniciada';

  @override
  String get sessionCompletedSuccess => 'Sessão concluída com sucesso';

  @override
  String get sessionNotFound => 'Sessão não encontrada';

  @override
  String get storyAdded => 'Story aggiunta';

  @override
  String get storyDeleted => 'Story eliminata';

  @override
  String estimateSaved(String estimate) {
    return 'Estimativa salva';
  }

  @override
  String get deleteSessionTitle => 'Excluir Sessão';

  @override
  String deleteSessionConfirm(String name, int count) {
    return 'Tem certeza de que deseja excluir esta sessão?';
  }

  @override
  String get deleteStoryTitle => 'Excluir Story';

  @override
  String deleteStoryConfirm(String title) {
    return 'Tem certeza de que deseja excluir esta story?';
  }

  @override
  String get errorLoadingSession => 'Erro ao carregar sessão';

  @override
  String get errorLoadingStories => 'Erro ao carregar stories';

  @override
  String get errorCreatingSession => 'Erro ao criar sessão';

  @override
  String get errorUpdatingSession => 'Erro ao atualizar sessão';

  @override
  String get errorDeletingSession => 'Erro ao excluir sessão';

  @override
  String get errorAddingStory => 'Erro ao adicionar story';

  @override
  String get errorStartingSession => 'Erro ao iniciar sessão';

  @override
  String get errorCompletingSession => 'Erro ao concluir sessão';

  @override
  String get errorSubmittingVote => 'Erro ao enviar voto';

  @override
  String get errorRevealingVotes => 'Erro ao revelar votos';

  @override
  String get errorSavingEstimate => 'Erro ao salvar estimativa';

  @override
  String get errorSkipping => 'Erro ao pular';

  @override
  String get retroIcebreakerTitle => 'Icebreaker';

  @override
  String get retroIcebreakerQuestion => 'Pergunta do icebreaker';

  @override
  String retroParticipantsVoted(int count) {
    return 'Participantes que votaram';
  }

  @override
  String get retroEndIcebreakerStartWriting =>
      'Encerrar icebreaker e iniciar escrita';

  @override
  String get retroMoodTerrible => 'Péssimo';

  @override
  String get retroMoodBad => 'Ruim';

  @override
  String get retroMoodNeutral => 'Neutro';

  @override
  String get retroMoodGood => 'Bom';

  @override
  String get retroMoodExcellent => 'Excelente';

  @override
  String get actionSubmit => 'Enviar';

  @override
  String get retroIcebreakerOneWordTitle => 'Uma Palavra';

  @override
  String get retroIcebreakerOneWordQuestion =>
      'Descreva este sprint em uma única palavra';

  @override
  String get retroIcebreakerOneWordHint => 'Uma palavra que resume o sprint...';

  @override
  String get retroIcebreakerSubmitted => 'Resposta enviada';

  @override
  String retroIcebreakerWordsSubmitted(int count) {
    return 'Palavras enviadas';
  }

  @override
  String get retroIcebreakerWeatherTitle => 'Previsão do Sprint';

  @override
  String get retroIcebreakerWeatherQuestion =>
      'Qual clima representa este sprint para você?';

  @override
  String get retroWeatherSunny => 'Ensolarado';

  @override
  String get retroWeatherPartlyCloudy => 'Parcialmente nublado';

  @override
  String get retroWeatherCloudy => 'Nublado';

  @override
  String get retroWeatherRainy => 'Chuvoso';

  @override
  String get retroWeatherStormy => 'Tempestuoso';

  @override
  String get retroAgileCoach => 'Agile Coach';

  @override
  String get retroCoachSetup => 'Configuração';

  @override
  String get retroCoachIcebreaker => 'Icebreaker';

  @override
  String get retroCoachWriting => 'Escrita';

  @override
  String get retroCoachVoting => 'Votação';

  @override
  String get retroCoachDiscuss => 'Discutir';

  @override
  String get retroCoachCompleted => 'Concluído';

  @override
  String retroStep(int step, String title) {
    return 'Etapa';
  }

  @override
  String retroCurrentFocus(String title) {
    return 'Foco atual';
  }

  @override
  String get retroCanvasMinColumns => 'Mínimo de colunas para o canvas';

  @override
  String retroAddTo(String title) {
    return 'Adicionar a';
  }

  @override
  String get retroNoColumnsConfigured => 'Nenhuma coluna configurada';

  @override
  String get retroNewActionItem => 'Novo item de ação';

  @override
  String get retroEditActionItem => 'Editar item de ação';

  @override
  String get retroActionWhatToDo => 'O que fazer';

  @override
  String get retroActionDescriptionHint => 'Descreva a ação a ser realizada...';

  @override
  String get retroActionRequired => 'Ação obrigatória';

  @override
  String get retroActionLinkedCard => 'Card vinculado';

  @override
  String get retroActionNone => 'Nenhuma ação';

  @override
  String get retroActionType => 'Tipo de ação';

  @override
  String get retroActionNoType => 'Sem tipo';

  @override
  String get retroActionAssignee => 'Responsável';

  @override
  String get retroActionNoAssignee => 'Sem responsável';

  @override
  String get retroActionPriority => 'Prioridade';

  @override
  String get retroActionDueDate => 'Data limite';

  @override
  String get retroActionSelectDate => 'Selecionar data';

  @override
  String get retroActionSupportResources => 'Recursos de apoio';

  @override
  String get retroActionResourcesHint => 'Recursos necessários para esta ação';

  @override
  String get retroActionMonitoring => 'Monitoramento';

  @override
  String get retroActionMonitoringHint => 'Como será monitorada esta ação?';

  @override
  String get retroActionResourcesShort => 'Recursos';

  @override
  String get retroTableRef => 'Ref.';

  @override
  String get retroTableSourceColumn => 'Coluna de origem';

  @override
  String get retroTableDescription => 'Descrição';

  @override
  String get retroTableOwner => 'Responsável';

  @override
  String get retroTablePriority => 'Prioridade';

  @override
  String get retroTableDueDate => 'Data limite';

  @override
  String get retroIcebreakerTwoTruths => 'Duas Verdades';

  @override
  String get retroDescTwoTruths => 'Duas verdades e uma mentira';

  @override
  String get retroIcebreakerCheckin => 'Check-in';

  @override
  String get retroDescCheckin => 'Perguntas de aquecimento para o time';

  @override
  String get retroTableActions => 'Ações';

  @override
  String get retroSupportResources => 'Recursos de apoio';

  @override
  String get retroMonitoringMethod => 'Método de monitoramento';

  @override
  String get retroUnassigned => 'Não atribuído';

  @override
  String get retroDeleteActionItem => 'Excluir item de ação';

  @override
  String get retroChooseMethodology => 'Escolha a metodologia';

  @override
  String get retroHidingWhileTyping => 'Cards ocultos durante a escrita';

  @override
  String retroVoteLimitReached(int max) {
    return 'Limite de votos atingido';
  }

  @override
  String get retroAddCardHint => 'Escreva seu pensamento aqui...';

  @override
  String get retroAddCard => 'Adicionar card';

  @override
  String get retroTimeUp => 'Tempo esgotado';

  @override
  String get retroTimeUpMessage => 'O tempo para esta fase acabou!';

  @override
  String get retroTimeUpOk => 'OK';

  @override
  String get retroStopTimer => 'Parar timer';

  @override
  String get retroStartTimer => 'Iniciar timer';

  @override
  String retroTimerMinutes(int minutes) {
    return 'Minutos';
  }

  @override
  String get retroAddCardButton => 'Adicionar Card';

  @override
  String get retroDeleteRetro => 'Excluir retrospectiva';

  @override
  String get retroParticipantsLabel => 'Participantes';

  @override
  String get retroNotesCreated => 'Notas criadas';

  @override
  String retroStatusLabel(String status) {
    return 'Status';
  }

  @override
  String retroDateLabel(String date) {
    return 'Data';
  }

  @override
  String retroSprintDefault(int number) {
    return 'Sprint padrão';
  }

  @override
  String get smartTodoNoTasks => 'Nenhuma tarefa';

  @override
  String get smartTodoNoTasksInColumn => 'Nenhuma tarefa nesta coluna';

  @override
  String smartTodoCompletionStats(int completed, int total) {
    return 'Estatísticas de conclusão';
  }

  @override
  String get smartTodoCreatedDate => 'Data de criação';

  @override
  String get smartTodoParticipantRole => 'Papel do participante';

  @override
  String get smartTodoUnassigned => 'Não atribuído';

  @override
  String get smartTodoNewTask => 'Nova tarefa';

  @override
  String get smartTodoEditTask => 'Editar tarefa';

  @override
  String get smartTodoTaskTitle => 'Título da tarefa';

  @override
  String get smartTodoDescription => 'Descrição';

  @override
  String get smartTodoDescriptionHint => 'Adicione uma descrição...';

  @override
  String get smartTodoChecklist => 'Checklist';

  @override
  String get smartTodoAddChecklistItem => 'Adicionar item ao checklist';

  @override
  String get smartTodoAttachments => 'Anexos';

  @override
  String get smartTodoAddLink => 'Adicionar link';

  @override
  String get smartTodoComments => 'Comentários';

  @override
  String get smartTodoWriteComment => 'Escrever comentário...';

  @override
  String get smartTodoAddImageTooltip => 'Anexar uma imagem à tarefa';

  @override
  String get smartTodoStatus => 'Status';

  @override
  String get smartTodoPriority => 'Prioridade';

  @override
  String get smartTodoAssignees => 'Responsáveis';

  @override
  String get smartTodoNoAssignee => 'Sem responsável';

  @override
  String get smartTodoTags => 'Tags';

  @override
  String get smartTodoNoTags => 'Sem tags';

  @override
  String get smartTodoDueDate => 'Data limite';

  @override
  String get smartTodoSetDate => 'Definir data';

  @override
  String get smartTodoEffort => 'Esforço';

  @override
  String get smartTodoEffortHint => 'Horas estimadas';

  @override
  String get smartTodoAssignTo => 'Atribuir a';

  @override
  String get smartTodoSelectTags => 'Selecionar tags';

  @override
  String get smartTodoNoTagsAvailable => 'Nenhuma tag disponível';

  @override
  String get smartTodoNewSubtask => 'Nova subtarefa';

  @override
  String get smartTodoAddLinkTitle => 'Adicionar Link';

  @override
  String get smartTodoLinkName => 'Nome do link';

  @override
  String get smartTodoLinkUrl => 'URL do link';

  @override
  String get smartTodoCannotOpenLink => 'Não foi possível abrir o link';

  @override
  String get smartTodoPasteImage => 'Colar imagem';

  @override
  String get smartTodoPasteImageFound =>
      'Imagem encontrada na área de transferência';

  @override
  String get smartTodoPasteImageConfirm => 'Confirmar colagem de imagem';

  @override
  String get smartTodoYesAdd => 'Sim, adicionar';

  @override
  String get smartTodoAddImage => 'Adicionar imagem';

  @override
  String get smartTodoImageUrlHint => 'Cole a URL da imagem';

  @override
  String get smartTodoImageUrl => 'URL da imagem';

  @override
  String get smartTodoPasteFromClipboard => 'Colar da área de transferência';

  @override
  String get smartTodoEditComment => 'Editar comentário';

  @override
  String get smartTodoSortBy => 'Ordenar por';

  @override
  String get smartTodoColumnSortTitle => 'Ordenar colunas';

  @override
  String get smartTodoPendingTasks => 'Tarefas pendentes';

  @override
  String get smartTodoCompletedTasks => 'Tarefas concluídas';

  @override
  String get smartTodoEnterTitle => 'Digite um título';

  @override
  String get smartTodoUser => 'Usuário';

  @override
  String get smartTodoImportTasks => 'Importar tarefas';

  @override
  String get smartTodoImportStep1 => 'Fonte de dados';

  @override
  String get smartTodoImportStep2 => 'Mapeamento';

  @override
  String get smartTodoImportStep3 => 'Confirmação';

  @override
  String get smartTodoImportRetry => 'Tentar novamente';

  @override
  String get smartTodoImportPasteText => 'Colar texto';

  @override
  String get smartTodoImportUploadFile => 'Enviar arquivo';

  @override
  String get smartTodoImportPasteHint =>
      'Cole uma lista de tarefas, uma por linha';

  @override
  String get smartTodoImportPasteExample => 'Cole texto aqui...';

  @override
  String get smartTodoImportSelectFile => 'Selecionar arquivo';

  @override
  String smartTodoImportFileSelected(String fileName) {
    return 'Arquivo selecionado';
  }

  @override
  String smartTodoImportFileError(String error) {
    return 'Erro ao ler arquivo';
  }

  @override
  String get smartTodoImportNoData => 'Nenhum dado encontrado';

  @override
  String get smartTodoImportColumnMapping => 'Mapeamento de colunas';

  @override
  String smartTodoImportColumnLabel(int index, String value) {
    return 'Coluna';
  }

  @override
  String smartTodoImportSampleValue(String value) {
    return 'Valor de exemplo';
  }

  @override
  String smartTodoImportFoundTasks(int count) {
    return 'Tarefas encontradas';
  }

  @override
  String get smartTodoImportDestinationColumn => 'Coluna de destino';

  @override
  String get smartTodoImportBack => 'Voltar';

  @override
  String get smartTodoImportNext => 'Avançar';

  @override
  String smartTodoImportButton(int count) {
    return 'Importar';
  }

  @override
  String get smartTodoImportEnterText => 'Digite o texto';

  @override
  String get smartTodoImportNoValidRows => 'Nenhuma linha válida encontrada';

  @override
  String get smartTodoImportMapTitle => 'Mapear colunas';

  @override
  String smartTodoImportParsingError(String error) {
    return 'Erro ao processar dados';
  }

  @override
  String smartTodoImportSuccess(int count) {
    return 'Importação concluída com sucesso';
  }

  @override
  String smartTodoImportError(String error) {
    return 'Erro na importação';
  }

  @override
  String get smartTodoImportHelpTitle => 'Ajuda para importação';

  @override
  String get smartTodoImportHelpSimpleTitle => 'Importação Simples';

  @override
  String get smartTodoImportHelpSimpleDesc =>
      'Cole uma lista de tarefas, uma por linha.';

  @override
  String get smartTodoImportHelpSimpleExample => 'Tarefa 1\nTarefa 2\nTarefa 3';

  @override
  String get smartTodoImportHelpCsvTitle => 'Importação CSV';

  @override
  String get smartTodoImportHelpCsvDesc =>
      'Importe tarefas a partir de um arquivo CSV com colunas mapeadas.';

  @override
  String get smartTodoImportHelpCsvExample =>
      'título,descrição,prioridade,status\nTarefa 1,Descrição,Alta,A Fazer';

  @override
  String get smartTodoImportHelpFieldsTitle => 'Campos disponíveis';

  @override
  String get smartTodoImportHelpFieldTitle => 'Título da tarefa (obrigatório)';

  @override
  String get smartTodoImportHelpFieldDesc => 'Descrição detalhada da tarefa';

  @override
  String get smartTodoImportHelpFieldPriority =>
      'Prioridade: Alta, Média, Baixa';

  @override
  String get smartTodoImportHelpFieldStatus =>
      'Status: A Fazer, Em Andamento, Concluído';

  @override
  String get smartTodoImportHelpFieldAssignee => 'Responsável pela tarefa';

  @override
  String get smartTodoImportHelpFieldEffort => 'Esforço estimado em horas';

  @override
  String get smartTodoImportHelpFieldTags => 'Tags separadas por vírgula';

  @override
  String smartTodoImportStatusHint(String columns) {
    return 'Status inicial das tarefas importadas';
  }

  @override
  String get smartTodoImportEmptyColumn => 'Coluna vazia';

  @override
  String get smartTodoImportFieldIgnore => 'Ignorar';

  @override
  String get smartTodoImportFieldTitle => 'Título';

  @override
  String get smartTodoImportFieldDescription => 'Descrição';

  @override
  String get smartTodoImportFieldPriority => 'Prioridade';

  @override
  String get smartTodoImportFieldStatus => 'Status';

  @override
  String get smartTodoImportFieldAssignee => 'Responsável';

  @override
  String get smartTodoImportFieldEffort => 'Esforço';

  @override
  String get smartTodoImportFieldTags => 'Tags';

  @override
  String get smartTodoDeleteTaskTitle => 'Excluir Tarefa';

  @override
  String get smartTodoDeleteTaskContent =>
      'Tem certeza de que deseja excluir esta tarefa?';

  @override
  String get smartTodoDeleteNoPermission =>
      'Você não tem permissão para excluir';

  @override
  String get smartTodoSheetsExportTitle => 'Exportar para Google Sheets';

  @override
  String get smartTodoSheetsExportExists => 'A exportação já existe';

  @override
  String get smartTodoSheetsOpen => 'Abrir planilha';

  @override
  String get smartTodoSheetsUpdate => 'Atualizar planilha';

  @override
  String get smartTodoSheetsUpdating => 'Atualizando planilha...';

  @override
  String get smartTodoSheetsCreating => 'Criando planilha...';

  @override
  String get smartTodoSheetsUpdated => 'Planilha atualizada';

  @override
  String get smartTodoSheetsCreated => 'Planilha criada';

  @override
  String get smartTodoSheetsError => 'Erro ao criar planilha';

  @override
  String get error => 'Erro';

  @override
  String smartTodoAuditLogTitle(String title) {
    return 'Log de Atividades';
  }

  @override
  String get smartTodoAuditFilterUser => 'Filtrar por usuário';

  @override
  String get smartTodoAuditFilterType => 'Filtrar por tipo';

  @override
  String get smartTodoAuditFilterAction => 'Filtrar por ação';

  @override
  String get smartTodoAuditFilterTag => 'Filtrar por tag';

  @override
  String get smartTodoAuditFilterSearch => 'Buscar';

  @override
  String get smartTodoAuditFilterAll => 'Todos';

  @override
  String get smartTodoAuditFilterAllFemale => 'Todas';

  @override
  String get smartTodoAuditPremiumRequired => 'Funcionalidade Premium';

  @override
  String smartTodoAuditLastDays(int days) {
    return 'Últimos dias';
  }

  @override
  String get smartTodoAuditClearFilters => 'Limpar filtros';

  @override
  String get smartTodoAuditViewTimeline => 'Visualizar timeline';

  @override
  String get smartTodoAuditViewColumns => 'Visualizar colunas';

  @override
  String get smartTodoAuditNoActivity => 'Nenhuma atividade';

  @override
  String get smartTodoAuditNoResults => 'Nenhum resultado';

  @override
  String smartTodoAuditActivities(int count) {
    return 'Atividades';
  }

  @override
  String get smartTodoAuditNoUserActivity => 'Nenhuma atividade do usuário';

  @override
  String get smartTodoAuditLoadMore => 'Carregar mais';

  @override
  String get smartTodoAuditEmptyValue => 'Valor vazio';

  @override
  String get smartTodoAuditEntityList => 'Lista';

  @override
  String get smartTodoAuditEntityTask => 'Tarefa';

  @override
  String get smartTodoAuditEntityInvite => 'Convite';

  @override
  String get smartTodoAuditEntityParticipant => 'Participante';

  @override
  String get smartTodoAuditEntityColumn => 'Coluna';

  @override
  String get smartTodoAuditEntityTag => 'Tag';

  @override
  String get smartTodoAuditActionCreate => 'Criar';

  @override
  String get smartTodoAuditActionUpdate => 'Atualizar';

  @override
  String get smartTodoAuditActionDelete => 'Excluir';

  @override
  String get smartTodoAuditActionArchive => 'Arquivar';

  @override
  String get smartTodoAuditActionRestore => 'Restaurar';

  @override
  String get smartTodoAuditActionMove => 'Mover';

  @override
  String get smartTodoAuditActionAssign => 'Atribuir';

  @override
  String get smartTodoAuditActionInvite => 'Convidar';

  @override
  String get smartTodoAuditActionJoin => 'Entrar';

  @override
  String get smartTodoAuditActionRevoke => 'Revogar';

  @override
  String get smartTodoAuditActionReorder => 'Reordenar';

  @override
  String get smartTodoAuditActionBatchCreate => 'Criação em lote';

  @override
  String get smartTodoAuditTimeNow => 'Agora';

  @override
  String smartTodoAuditTimeMinutesAgo(int count) {
    return 'minutos atrás';
  }

  @override
  String smartTodoAuditTimeHoursAgo(int count) {
    return 'horas atrás';
  }

  @override
  String smartTodoAuditTimeDaysAgo(int count) {
    return 'dias atrás';
  }

  @override
  String get smartTodoCfdTitle => 'Cumulative Flow Diagram';

  @override
  String get smartTodoCfdTooltip => 'Diagrama de fluxo cumulativo';

  @override
  String get smartTodoCfdDateRange => 'Período';

  @override
  String get smartTodoCfd7Days => '7 dias';

  @override
  String get smartTodoCfd14Days => '14 dias';

  @override
  String get smartTodoCfd30Days => '30 dias';

  @override
  String get smartTodoCfd90Days => '90 dias';

  @override
  String get smartTodoCfdError => 'Erro ao carregar dados';

  @override
  String get smartTodoCfdRetry => 'Tentar novamente';

  @override
  String get smartTodoCfdNoData => 'Nenhum dado disponível';

  @override
  String get smartTodoCfdNoDataHint =>
      'Adicione tarefas e mova-as entre colunas para ver os dados';

  @override
  String get smartTodoCfdKeyMetrics => 'Métricas Principais';

  @override
  String get smartTodoCfdLeadTime => 'Lead Time';

  @override
  String get smartTodoCfdLeadTimeTooltip =>
      'Tempo total da criação à conclusão';

  @override
  String get smartTodoCfdCycleTime => 'Cycle Time';

  @override
  String get smartTodoCfdCycleTimeTooltip => 'Tempo médio de trabalho ativo';

  @override
  String get smartTodoCfdThroughput => 'Throughput';

  @override
  String get smartTodoCfdThroughputTooltip => 'Itens concluídos por período';

  @override
  String get smartTodoCfdWip => 'WIP';

  @override
  String get smartTodoCfdWipTooltip => 'Trabalho em andamento';

  @override
  String get smartTodoCfdLimit => 'Limite';

  @override
  String get smartTodoCfdCompleted => 'Concluídos';

  @override
  String get smartTodoCfdFlowAnalysis => 'Análise de Fluxo';

  @override
  String get smartTodoCfdArrived => 'Chegaram';

  @override
  String get smartTodoCfdBacklogShrinking => 'Backlog diminuindo';

  @override
  String get smartTodoCfdBacklogGrowing => 'Backlog crescendo';

  @override
  String get smartTodoCfdBottlenecks => 'Gargalos';

  @override
  String get smartTodoCfdNoBottlenecks => 'Nenhum gargalo identificado';

  @override
  String get smartTodoCfdTasks => 'Tarefas';

  @override
  String get smartTodoCfdAvgAge => 'Idade média';

  @override
  String get smartTodoCfdAgingWip => 'Envelhecimento WIP';

  @override
  String get smartTodoCfdTask => 'Tarefa';

  @override
  String get smartTodoCfdColumn => 'Coluna';

  @override
  String get smartTodoCfdAge => 'Idade';

  @override
  String get smartTodoCfdDays => 'dias';

  @override
  String get smartTodoCfdHowCalculated => 'Como é calculado';

  @override
  String get smartTodoCfdMedian => 'Mediana';

  @override
  String get smartTodoCfdP85 => 'P85';

  @override
  String get smartTodoCfdP95 => 'P95';

  @override
  String get smartTodoCfdMin => 'Mín';

  @override
  String get smartTodoCfdMax => 'Máx';

  @override
  String get smartTodoCfdSample => 'Amostra';

  @override
  String get smartTodoCfdVsPrevious => 'vs. anterior';

  @override
  String get smartTodoCfdArrivalRate => 'Taxa de Chegada';

  @override
  String get smartTodoCfdCompletionRate => 'Taxa de Conclusão';

  @override
  String get smartTodoCfdNetFlow => 'Fluxo Líquido';

  @override
  String get smartTodoCfdPerDay => 'Por dia';

  @override
  String get smartTodoCfdPerWeek => 'Por semana';

  @override
  String get smartTodoCfdSeverity => 'Severidade';

  @override
  String get smartTodoCfdAssignee => 'Responsável';

  @override
  String get smartTodoCfdUnassigned => 'Não atribuído';

  @override
  String get smartTodoCfdLeadTimeExplanation =>
      'Lead Time mede o tempo total desde a criação de um item até sua conclusão.';

  @override
  String get smartTodoCfdCycleTimeExplanation =>
      'Cycle Time mede o tempo de trabalho ativo em um item, excluindo tempo de espera.';

  @override
  String get smartTodoCfdThroughputExplanation =>
      'Throughput mede a quantidade de itens concluídos por unidade de tempo.';

  @override
  String get smartTodoCfdWipExplanation =>
      'WIP (Work In Progress) é o número de itens sendo trabalhados simultaneamente.';

  @override
  String get smartTodoCfdFlowExplanation =>
      'A análise de fluxo mostra como os itens se movem pelo sistema ao longo do tempo.';

  @override
  String get smartTodoCfdBottleneckExplanation =>
      'Gargalos ocorrem quando itens se acumulam em uma coluna, indicando problemas de fluxo.';

  @override
  String get smartTodoCfdAgingExplanation =>
      'O envelhecimento mede há quanto tempo um item está na coluna atual.';

  @override
  String get smartTodoCfdTeamBalance => 'Equilíbrio do Time';

  @override
  String get smartTodoCfdTeamBalanceExplanation =>
      'Mostra como o trabalho está distribuído entre os membros do time.';

  @override
  String get smartTodoCfdBalanced => 'Equilibrado';

  @override
  String get smartTodoCfdUneven => 'Desigual';

  @override
  String get smartTodoCfdImbalanced => 'Desequilibrado';

  @override
  String get smartTodoCfdMember => 'Membro';

  @override
  String get smartTodoCfdTotal => 'Total';

  @override
  String get smartTodoCfdToDo => 'A Fazer';

  @override
  String get smartTodoCfdInProgress => 'Em Andamento';

  @override
  String get smartTodoCfdDone => 'Concluído';

  @override
  String get smartTodoNewTaskDefault => 'Nova tarefa';

  @override
  String get smartTodoRename => 'Renomear';

  @override
  String get smartTodoAddActivity => 'Adicionar atividade';

  @override
  String get smartTodoAddColumn => 'Adicionar coluna';

  @override
  String get smartTodoParticipantManagement => 'Gerenciar participantes';

  @override
  String get smartTodoParticipantsTab => 'Participantes';

  @override
  String get smartTodoInvitesTab => 'Convites';

  @override
  String get smartTodoAddParticipant => 'Adicionar participante';

  @override
  String smartTodoMembers(int count) {
    return 'Membros';
  }

  @override
  String get smartTodoNoInvitesPending => 'Nenhum convite pendente';

  @override
  String smartTodoRoleLabel(String role) {
    return 'Papel';
  }

  @override
  String get smartTodoExpired => 'Expirado';

  @override
  String smartTodoSentBy(String name) {
    return 'Enviado por';
  }

  @override
  String get smartTodoResendEmail => 'Reenviar e-mail';

  @override
  String get smartTodoRevoke => 'Revogar';

  @override
  String get smartTodoSendingEmail => 'Enviando e-mail...';

  @override
  String get smartTodoEmailResent => 'E-mail reenviado';

  @override
  String get smartTodoEmailSendError => 'Erro ao enviar e-mail';

  @override
  String get smartTodoInvalidSession => 'Sessão inválida';

  @override
  String get smartTodoEmail => 'E-mail';

  @override
  String get smartTodoRole => 'Papel';

  @override
  String get smartTodoInviteCreated => 'Convite criado';

  @override
  String get smartTodoInviteCreatedNoEmail => 'Convite criado sem e-mail';

  @override
  String get smartTodoUserAlreadyInvited => 'Usuário já convidado';

  @override
  String get smartTodoInviteCollaborator => 'Convidar colaborador';

  @override
  String get smartTodoEditorRole => 'Editor';

  @override
  String get smartTodoViewerRole => 'Visualizador';

  @override
  String get smartTodoSendEmailNotification => 'Enviar notificação por e-mail';

  @override
  String get smartTodoSend => 'Enviar';

  @override
  String get smartTodoInvalidEmail => 'E-mail inválido';

  @override
  String get smartTodoUserNotAuthenticated => 'Usuário não autenticado';

  @override
  String get smartTodoGoogleLoginRequired => 'Login com Google necessário';

  @override
  String smartTodoInviteSent(String email) {
    return 'Convite enviado';
  }

  @override
  String get smartTodoUserAlreadyInvitedOrPending =>
      'Usuário já convidado ou com convite pendente';

  @override
  String get smartTodoFilterToday => 'Hoje';

  @override
  String get smartTodoFilterMyTasks => 'Minhas tarefas';

  @override
  String get smartTodoFilterOwner => 'Filtrar por responsável';

  @override
  String get smartTodoViewGlobalTasks => 'Ver tarefas globais';

  @override
  String get smartTodoViewLists => 'Ver listas';

  @override
  String get smartTodoNewListDialogTitle => 'Nova Lista';

  @override
  String get smartTodoTitleLabel => 'Título';

  @override
  String get smartTodoDescriptionLabel => 'Descrição';

  @override
  String get smartTodoCancel => 'Cancelar';

  @override
  String get smartTodoCreate => 'Criar';

  @override
  String get smartTodoSave => 'Salvar';

  @override
  String get smartTodoNoListsPresent => 'Nenhuma lista presente';

  @override
  String get smartTodoCreateFirstList => 'Crie sua primeira lista';

  @override
  String smartTodoMembersCount(int count) {
    return 'Contagem de membros';
  }

  @override
  String get smartTodoRenameListTitle => 'Renomear Lista';

  @override
  String get smartTodoNewNameLabel => 'Novo nome';

  @override
  String get smartTodoDeleteListTitle => 'Excluir Lista';

  @override
  String get smartTodoDeleteListConfirm =>
      'Tem certeza de que deseja excluir esta lista?';

  @override
  String get smartTodoDelete => 'Excluir';

  @override
  String get smartTodoEdit => 'Editar';

  @override
  String get smartTodoSearchHint => 'Buscar...';

  @override
  String get smartTodoSearchTasksHint => 'Buscar tarefas...';

  @override
  String smartTodoNoSearchResults(String query) {
    return 'Nenhum resultado encontrado';
  }

  @override
  String get smartTodoColumnTodo => 'A Fazer';

  @override
  String get smartTodoColumnInProgress => 'Em Andamento';

  @override
  String get smartTodoColumnDone => 'Concluído';

  @override
  String get smartTodoAllPeople => 'Todas as pessoas';

  @override
  String smartTodoPeopleCount(int count) {
    return 'Contagem de pessoas';
  }

  @override
  String get smartTodoFilterByPerson => 'Filtrar por pessoa';

  @override
  String get smartTodoApplyFilters => 'Aplicar filtros';

  @override
  String get smartTodoAllTags => 'Todas as tags';

  @override
  String smartTodoTagsCount(int count) {
    return 'Contagem de tags';
  }

  @override
  String get smartTodoFilterByTag => 'Filtrar por tag';

  @override
  String get smartTodoTagAlreadyExists => 'Tag já existe';

  @override
  String smartTodoError(String error) {
    return 'Erro';
  }

  @override
  String get profileMenuTitle => 'Menu do perfil';

  @override
  String get profileMenuLogout => 'Sair';

  @override
  String get profileLogoutDialogTitle => 'Sair';

  @override
  String get profileLogoutDialogConfirm => 'Confirmar saída';

  @override
  String get agileAddToSprint => 'Adicionar ao Sprint';

  @override
  String get agileEstimated => 'Estimada';

  @override
  String get agilePoints => 'pts';

  @override
  String agilePointsValue(int points) {
    return '$points pts';
  }

  @override
  String get agileGuide => 'Guia';

  @override
  String get backlogProductBacklog => 'Product Backlog';

  @override
  String get backlogArchiveCompleted => 'Arquivar concluídas';

  @override
  String get backlogStories => 'Stories';

  @override
  String get backlogEstimated => 'Estimada';

  @override
  String get backlogShowActive => 'Mostrar ativas';

  @override
  String backlogShowArchive(int count) {
    return 'Mostrar arquivo';
  }

  @override
  String get backlogTab => 'Backlog';

  @override
  String backlogArchiveTab(int count) {
    return 'Arquivo';
  }

  @override
  String get backlogFilters => 'Filtros';

  @override
  String get backlogNewStory => 'Nova Story';

  @override
  String get backlogSearchHint => 'Buscar stories...';

  @override
  String get backlogStatusFilter => 'Filtro de status';

  @override
  String get backlogPriorityFilter => 'Filtro de prioridade';

  @override
  String get backlogTagFilter => 'Filtro de tags';

  @override
  String get backlogAllStatuses => 'Todos os status';

  @override
  String get backlogAllPriorities => 'Todas as prioridades';

  @override
  String get backlogRemoveFilters => 'Remover filtros';

  @override
  String get backlogNoStoryFound => 'Nenhuma story encontrada';

  @override
  String get sprintBacklog => 'Sprint Backlog';

  @override
  String get agileStatusRefinement => 'Refining';

  @override
  String get agileStatusReady => 'Pronto';

  @override
  String get agileStatusInProgress => 'In Corso';

  @override
  String get agileStatusInReview => 'In Revisione';

  @override
  String get agileStatusDone => 'Fatto';

  @override
  String get backlog => 'Backlog';

  @override
  String get kanbanPolicySortPriority => 'Ordina per priorità business';

  @override
  String get kanbanPolicyMax2Days => 'Max 2 giorni in questa colonna';

  @override
  String get kanbanPolicyReqAcceptance =>
      'Richiede criteri di accettazione definiti';

  @override
  String get kanbanPolicyItemReady => 'Item pronto per essere lavorato';

  @override
  String get kanbanPolicyEstimationsDone => 'Stima completata (se richiesta)';

  @override
  String get kanbanPolicyMax1PerPerson => 'Max 1 item per persona';

  @override
  String get kanbanPolicyDailyUpdate => 'Daily update obbligatorio';

  @override
  String get kanbanPolicyMax24h => 'Max 24h in questa colonna';

  @override
  String get kanbanPolicyReqCodeReview => 'Richiede code review approvata';

  @override
  String get kanbanPolicyAllAcceptanceMet =>
      'Tutti i criteri di accettazione soddisfatti';

  @override
  String get kanbanPolicyCheckTitle => 'Controllo Policy';

  @override
  String get kanbanPolicyCheckMessage =>
      'Questa azione viola le seguenti policy:';

  @override
  String get kanbanPolicyCheckProceed => 'Procedi comunque';

  @override
  String get kanbanPolicyCheckCancel => 'Annulla e correggi';

  @override
  String get kanbanPolicyActiveLabel => 'Controllo Attivo';

  @override
  String get kanbanPolicyViolationTitle => 'Violazione Policy';

  @override
  String get kanbanPolicyViolationMessage => 'Spostando ';

  @override
  String get kanbanPolicyViolationTo => ' in ';

  @override
  String get kanbanPolicyViolationViolations => ' stai violando:';

  @override
  String get kanbanPolicyMovingTip =>
      'Puoi procedere se ritieni che sia un\'eccezione valida.';

  @override
  String get kanbanMoveAnyway => 'Mover mesmo assim';

  @override
  String get backlogEmpty => 'Backlog vazio';

  @override
  String get backlogAddFirstStory => 'Adicione a primeira story';

  @override
  String get kanbanWipExceeded => 'WIP excedido';

  @override
  String get kanbanInfo => 'Informações';

  @override
  String get kanbanConfigureWip => 'Configurar WIP';

  @override
  String kanbanWipTooltip(int current, int max) {
    return 'Trabalho em andamento - itens ativos nesta coluna';
  }

  @override
  String get kanbanNoWipLimit => 'Sem limite WIP';

  @override
  String get kanbanWipWhyTitle => 'Perché usarli?';

  @override
  String get kanbanWipReasonFocus =>
      'Riducono il multitasking e aumentano il focus';

  @override
  String get kanbanWipReasonBottlenecks => 'Evidenziano i colli di bottiglia';

  @override
  String get kanbanWipReasonFlow => 'Migliorano il flusso di lavoro';

  @override
  String get kanbanWipReasonSpeed => 'Accelerano il completamento degli item';

  @override
  String get kanbanWipOverLimitTitle => 'Cosa fare se un limite è superato?';

  @override
  String get kanbanWipOverLimitStep1 =>
      '1. Completa o sposta item esistenti prima di iniziarne di nuovi';

  @override
  String get kanbanWipOverLimitStep2 =>
      '2. Aiuta i colleghi a sbloccare item in review';

  @override
  String get kanbanWipOverLimitStep3 =>
      '3. Analizza perché il limite è stato superato';

  @override
  String get kanbanWipMovingTip =>
      'Suggerimento: completa o sposta altri item prima di iniziarne di nuovi per mantenere un flusso di lavoro ottimale.';

  @override
  String kanbanItems(int count) {
    return 'itens';
  }

  @override
  String get kanbanEmpty => 'Board vazio';

  @override
  String kanbanWipLimitTitle(String column) {
    return 'Limite WIP';
  }

  @override
  String get kanbanWipLimitDesc => 'Limite máximo de itens nesta coluna';

  @override
  String get kanbanWipLimitLabel => 'Limite WIP';

  @override
  String get kanbanWipLimitHint => 'Ex: 3';

  @override
  String kanbanWipLimitSuggestion(int count) {
    return 'Sugestão: comece com um limite igual ao número de membros do time';
  }

  @override
  String get kanbanRemoveLimit => 'Remover limite';

  @override
  String get kanbanWipExceededTitle => 'Limite WIP Excedido';

  @override
  String get kanbanWipExceededMessage =>
      'A coluna já atingiu o limite WIP. Deseja mover mesmo assim?';

  @override
  String get kanbanWipExceededIn => 'WIP excedido em';

  @override
  String get kanbanWipExceededWillExceed =>
      'Mover este item excederá o limite WIP';

  @override
  String kanbanColumnLabel(String name) {
    return 'Coluna';
  }

  @override
  String kanbanCurrentCount(int current, int limit) {
    return 'Contagem atual';
  }

  @override
  String kanbanAfterMove(int count) {
    return 'Após mover';
  }

  @override
  String get kanbanSuggestion => 'Sugestão';

  @override
  String get kanbanWipExplanationTitle => 'Sobre WIP Limits';

  @override
  String get kanbanWipWhat => 'O que é WIP?';

  @override
  String get kanbanWipWhatDesc =>
      'WIP (Work In Progress) é a quantidade de trabalho sendo realizado simultaneamente.';

  @override
  String get kanbanWipWhy => 'Por que limitar o WIP?';

  @override
  String get kanbanWipBenefit1 => 'Reduz o tempo de entrega';

  @override
  String get kanbanWipBenefit2 => 'Melhora a qualidade';

  @override
  String get kanbanWipBenefit3 => 'Aumenta a previsibilidade';

  @override
  String get kanbanWipBenefit4 => 'Identifica gargalos rapidamente';

  @override
  String get kanbanWipWhatToDo => 'O que fazer?';

  @override
  String get kanbanWipWhatToDoDesc =>
      'Conclua itens em andamento antes de iniciar novos trabalhos.';

  @override
  String get kanbanUnderstood => 'Entendido';

  @override
  String sprintTitle(int count) {
    return 'Sprint ($count)';
  }

  @override
  String get sprintNew => 'Nuovo Sprint';

  @override
  String get sprintNoSprints => 'Nessuno sprint';

  @override
  String get sprintCreateFirst => 'Crea il primo sprint per iniziare';

  @override
  String sprintNumber(int number) {
    return 'Sprint $number';
  }

  @override
  String get sprintStart => 'Avvia Sprint';

  @override
  String get sprintComplete => 'Completa Sprint';

  @override
  String sprintDays(int days) {
    return '${days}g';
  }

  @override
  String sprintStoriesCount(int count) {
    return '$count';
  }

  @override
  String get sprintStoriesLabel => 'stories';

  @override
  String get sprintPointsPlanned => 'pts';

  @override
  String get sprintPointsCompleted => 'completati';

  @override
  String get sprintVelocity => 'velocity';

  @override
  String sprintDaysRemaining(int days) {
    return '${days}g rimanenti';
  }

  @override
  String get sprintStartButton => 'Avvia';

  @override
  String get sprintCompleteActiveFirst =>
      'Completa lo sprint attivo prima di avviarne un altro';

  @override
  String get sprintEditTitle => 'Modifica Sprint';

  @override
  String get sprintNewTitle => 'Nuovo Sprint';

  @override
  String get sprintNameLabel => 'Nome Sprint';

  @override
  String get sprintNameHint => 'es. Sprint 1 - MVP';

  @override
  String get sprintNameRequired => 'Inserisci un nome';

  @override
  String get sprintGoalLabel => 'Sprint Goal';

  @override
  String get sprintGoalHint => 'Obiettivo dello sprint';

  @override
  String get sprintStartDateLabel => 'Data Inizio';

  @override
  String get sprintEndDateLabel => 'Data Fine';

  @override
  String sprintDuration(int days) {
    return 'Durata: $days giorni';
  }

  @override
  String sprintAverageVelocity(String velocity) {
    return 'Velocity media: $velocity pts/sprint';
  }

  @override
  String sprintTeamMembers(int count) {
    return 'Team: $count membri';
  }

  @override
  String get sprintPlanningTitle => 'Sprint Planning';

  @override
  String get sprintPlanningSubtitle =>
      'Seleziona le storie da completare in questo sprint';

  @override
  String get sprintPlanningSelected => 'Selezionati';

  @override
  String get sprintPlanningSuggested => 'Suggeriti';

  @override
  String get sprintPlanningCapacity => 'Capacita';

  @override
  String get sprintPlanningBasedOnVelocity => 'basato su velocity media';

  @override
  String sprintPlanningDays(int days) {
    return '$days giorni';
  }

  @override
  String get sprintPlanningExceeded =>
      'Attenzione: superata la velocity suggerita';

  @override
  String get sprintPlanningNoStories => 'Nessuna story disponibile nel backlog';

  @override
  String get sprintPlanningNotEstimated => 'Non stimata';

  @override
  String sprintPlanningConfirm(int count) {
    return 'Conferma ($count stories)';
  }

  @override
  String get storyFormEditTitle => 'Modifica Story';

  @override
  String get storyFormNewTitle => 'Nuova User Story';

  @override
  String get storyFormDetailsTab => 'Dettagli';

  @override
  String get storyFormAcceptanceTab => 'Acceptance Criteria';

  @override
  String get storyFormOtherTab => 'Altro';

  @override
  String get storyFormTitleLabel => 'Titolo *';

  @override
  String get storyFormTitleHint => 'Ex: Como usuário eu quero...';

  @override
  String get storyFormTitleRequired => 'Inserisci un titolo';

  @override
  String get storyFormUseTemplate => 'Usar template User Story';

  @override
  String get storyFormTemplateSubtitle => 'As a... I want... So that...';

  @override
  String get storyFormAsA => 'As a...';

  @override
  String get storyFormAsAHint => 'usuário, admin, cliente...';

  @override
  String get storyFormIWant => 'I want...';

  @override
  String get storyFormIWantHint => 'poder fazer algo...';

  @override
  String get storyFormIWantRequired => 'Inserisci cosa vuole l\'utente';

  @override
  String get storyFormSoThat => 'So that...';

  @override
  String get storyFormSoThatHint => 'obter um benefício...';

  @override
  String get storyFormDescriptionLabel => 'Descrizione';

  @override
  String get storyFormDescriptionHint =>
      'Critérios de aceitação, notas técnicas...';

  @override
  String get storyFormDescriptionRequired => 'Inserisci una descrizione';

  @override
  String get storyFormPreview => 'Pré-visualização:';

  @override
  String get storyFormEmptyDescription => '(descrizione vuota)';

  @override
  String get storyFormAcceptanceCriteriaTitle => 'Acceptance Criteria';

  @override
  String get storyFormAcceptanceCriteriaSubtitle =>
      'Definisci quando la story puo considerarsi completata';

  @override
  String get storyFormAddCriterionHint =>
      'Aggiungi criterio di accettazione...';

  @override
  String get storyFormNoCriteria => 'Nenhum critério definido';

  @override
  String get storyFormSuggestions => 'Suggerimenti:';

  @override
  String get storyFormSuggestion1 => 'O sistema valida os dados de entrada';

  @override
  String get storyFormSuggestion2 => 'O usuário recebe uma confirmação visual';

  @override
  String get storyFormSuggestion3 => 'Os dados são salvos corretamente';

  @override
  String get storyFormSuggestion4 => 'A funcionalidade é acessível via mobile';

  @override
  String get storyFormPriorityLabel => 'Prioridade (MoSCoW)';

  @override
  String get storyFormBusinessValueLabel => 'Business Value';

  @override
  String get storyFormBusinessValueHigh => 'Alto valor de negócio';

  @override
  String get storyFormBusinessValueMedium => 'Valor médio';

  @override
  String get storyFormBusinessValueLow => 'Baixo valor de negócio';

  @override
  String get storyFormStoryPointsLabel => 'Estimada em Story Points';

  @override
  String get storyFormStoryPointsTooltip =>
      'Os Story Points representam a complexidade relativa do trabalho.\nUse a sequência de Fibonacci: 1 (simples) -> 21 (muito complexa).';

  @override
  String get storyFormNoPoints => 'Nenhuma';

  @override
  String get storyFormPointsSimple => 'Tarefa rápida e simples';

  @override
  String get storyFormPointsMedium => 'Tarefa de média complexidade';

  @override
  String get storyFormPointsComplex => 'Tarefa complexa, requer análise';

  @override
  String get storyFormPointsVeryComplex =>
      'Muito complexa, considere dividir a story';

  @override
  String get storyFormTagsLabel => 'Tags';

  @override
  String get storyFormAddTagHint => 'Adicionar tag...';

  @override
  String get storyFormExistingTags => 'Tags existentes:';

  @override
  String get storyFormAssigneeLabel => 'Atribuir a';

  @override
  String get storyFormAssigneeHint => 'Selecione um membro da equipe';

  @override
  String get storyFormNotAssigned => 'Não atribuído';

  @override
  String storyDetailPointsLabel(int points) {
    return '$points pontos';
  }

  @override
  String get storyDetailDescriptionTitle => 'Descrição';

  @override
  String get storyDetailNoDescription => 'Nenhuma descrição';

  @override
  String storyDetailAcceptanceCriteria(int completed, int total) {
    return 'Acceptance Criteria ($completed/$total)';
  }

  @override
  String get storyDetailNoCriteria => 'Nenhum critério definido';

  @override
  String get storyDetailEstimationTitle => 'Estimativa';

  @override
  String get storyDetailFinalEstimate => 'Estimativa final: ';

  @override
  String storyDetailEstimatesReceived(int count) {
    return '$count estimativas recebidas';
  }

  @override
  String get storyDetailInfoTitle => 'Informações';

  @override
  String get storyDetailBusinessValue => 'Business Value';

  @override
  String get storyDetailAssignedTo => 'Atribuído a';

  @override
  String get storyDetailSprint => 'Sprint';

  @override
  String get storyDetailCreatedAt => 'Criado em';

  @override
  String get storyDetailStartedAt => 'Iniciado em';

  @override
  String get storyDetailCompletedAt => 'Concluído em';

  @override
  String get landingBadge => 'Ferramentas para times ágeis';

  @override
  String get landingHeroTitle => 'Build better products\nwith Keisen';

  @override
  String get landingHeroSubtitle =>
      'Priorize, estime e gerencie seus projetos com ferramentas colaborativas. Tudo em um só lugar, grátis.';

  @override
  String get landingStartFree => 'Comece Grátis';

  @override
  String get landingEverythingNeed => 'Tudo o que você precisa';

  @override
  String get landingModernTools => 'Ferramentas projetadas para times modernos';

  @override
  String get landingSmartTodoBadge => 'Produtividade';

  @override
  String get landingSmartTodoTitle => 'Smart Todo List';

  @override
  String get landingSmartTodoSubtitle =>
      'Gestão de tarefas inteligente e colaborativa para times modernos';

  @override
  String get landingSmartTodoCollaborativeTitle =>
      'Listas de Tarefas Colaborativas';

  @override
  String get landingSmartTodoCollaborativeDesc =>
      'Smart Todo transforma a gestão das atividades diárias em um processo fluido e colaborativo. Crie listas, atribua tarefas aos membros da equipe e monitore o progresso em tempo real.\n\nIdeal para times distribuídos que precisam de sincronização contínua nas atividades a serem concluídas.';

  @override
  String get landingSmartTodoImportTitle => 'Importação Flexível';

  @override
  String get landingSmartTodoImportDesc =>
      'Importe suas atividades de fontes externas em poucos cliques. Suporte para arquivos CSV, copiar/colar do Excel ou texto livre. O sistema reconhece automaticamente a estrutura dos dados.\n\nMigre facilmente de outras ferramentas sem perder informações ou ter que reinserir manualmente cada tarefa.';

  @override
  String get landingSmartTodoShareTitle => 'Compartilhamento e Convites';

  @override
  String get landingSmartTodoShareDesc =>
      'Convide colegas e colaboradores para suas listas por e-mail. Cada participante pode visualizar, comentar e atualizar o status das tarefas atribuídas.\n\nPerfeito para gerenciar projetos transversais com stakeholders externos ou times multifuncionais.';

  @override
  String get landingSmartTodoFeaturesTitle => 'Funcionalidades Smart Todo';

  @override
  String get landingEisenhowerBadge => 'Priorização';

  @override
  String get landingEisenhowerSubtitle =>
      'O método decisório usado por líderes para gerenciar o tempo';

  @override
  String get landingEisenhowerUrgentImportantTitle => 'Urgente vs Importante';

  @override
  String get landingEisenhowerUrgentImportantDesc =>
      'A Matriz de Eisenhower, criada pelo 34º Presidente dos Estados Unidos Dwight D. Eisenhower, divide as atividades em quatro quadrantes baseados em dois critérios: urgência e importância.\n\nEste framework decisório ajuda a distinguir o que requer atenção imediata do que contribui para os objetivos de longo prazo.';

  @override
  String get landingEisenhowerDecisionsTitle => 'Melhores Decisões';

  @override
  String get landingEisenhowerDecisionsDesc =>
      'Aplicando constantemente a matriz, você desenvolve uma mentalidade orientada a resultados. Aprende a dizer \"não\" às distrações e a se concentrar no que gera valor real.\n\nNossa ferramenta digital torna este processo imediato: arraste as atividades para o quadrante correto e obtenha uma visão clara de suas prioridades.';

  @override
  String get landingEisenhowerBenefitsTitle =>
      'Por que usar a Matriz de Eisenhower?';

  @override
  String get landingEisenhowerBenefitsDesc =>
      'Estudos mostram que 80% das atividades diárias se enquadram nos quadrantes 3 e 4 (não importantes). A matriz ajuda você a identificá-las e liberar tempo para o que realmente importa.';

  @override
  String get landingEisenhowerQuadrants =>
      'Quadrante 1: Urgente + Importante → Faça agora\nQuadrante 2: Não urgente + Importante → Planeje\nQuadrante 3: Urgente + Não importante → Delegue\nQuadrante 4: Não urgente + Não importante → Elimine';

  @override
  String get landingAgileBadge => 'Metodologias';

  @override
  String get landingAgileTitle => 'Agile & Scrum Framework';

  @override
  String get landingAgileSubtitle =>
      'Implemente as melhores práticas de desenvolvimento de software iterativo';

  @override
  String get landingAgileIterativeTitle =>
      'Desenvolvimento Iterativo e Incremental';

  @override
  String get landingAgileIterativeDesc =>
      'A abordagem Agile divide o trabalho em ciclos curtos chamados Sprint, tipicamente de 1-4 semanas. Cada iteração produz um incremento funcional do produto.\n\nCom Keisen você pode gerenciar seu backlog, planejar sprints e monitorar a velocity do time em tempo real.';

  @override
  String get landingAgileScrumTitle => 'Framework Scrum';

  @override
  String get landingAgileScrumDesc =>
      'Scrum é o framework Agile mais difundido. Define papéis (Product Owner, Scrum Master, Time), eventos (Sprint Planning, Daily, Review, Retrospective) e artefatos (Product Backlog, Sprint Backlog).\n\nKeisen suporta todos os eventos Scrum com ferramentas dedicadas para cada cerimônia.';

  @override
  String get landingAgileKanbanTitle => 'Kanban Board';

  @override
  String get landingAgileKanbanDesc =>
      'O método Kanban visualiza o fluxo de trabalho através de colunas que representam os estados do processo. Limita o Work In Progress (WIP) para maximizar o throughput.\n\nNosso Kanban board suporta personalização de colunas, WIP limits e métricas de fluxo.';

  @override
  String get landingEstimationBadge => 'Estimation';

  @override
  String get landingEstimationTitle => 'Técnicas de Estimativa Colaborativas';

  @override
  String get landingEstimationSubtitle =>
      'Escolha o método mais adequado para seu time para estimativas precisas';

  @override
  String get landingEstimationFeaturesTitle => 'Estimation Room Features';

  @override
  String get landingRetroBadge => 'Retrospective';

  @override
  String get landingRetroTitle => 'Retrospectivas Interativas';

  @override
  String get landingRetroSubtitle =>
      'Ferramentas colaborativas em tempo real: timer, votação anônima, action items e relatório com IA.';

  @override
  String get landingRetroActionTitle => 'Action Items Tracking';

  @override
  String get landingRetroActionDesc =>
      'Cada retrospectiva gera action items rastreáveis com responsável, prazo e status. Monitore o acompanhamento ao longo do tempo.';

  @override
  String get landingWorkflowBadge => 'Workflow';

  @override
  String get landingWorkflowTitle => 'Como funciona';

  @override
  String get landingWorkflowSubtitle => 'Comece em 3 passos simples';

  @override
  String get landingStep1Title => 'Crie um projeto';

  @override
  String get landingStep1Desc =>
      'Crie seu projeto Agile e convide a equipe. Configure sprints, backlog e board.';

  @override
  String get landingStep2Title => 'Colabore';

  @override
  String get landingStep2Desc =>
      'Estime as user stories juntos, organize sprints e acompanhe o progresso em tempo real.';

  @override
  String get landingStep3Title => 'Melhore';

  @override
  String get landingStep3Desc =>
      'Analise as métricas, conduza retrospectivas e melhore continuamente o processo.';

  @override
  String get landingCtaTitle => 'Ready to start?';

  @override
  String get landingCtaDesc =>
      'Acesse gratuitamente e comece a colaborar com sua equipe.';

  @override
  String get landingFooterBrandDesc =>
      'Ferramentas colaborativas para times ágeis.\nPlaneje, estime e melhore juntos.';

  @override
  String get landingFooterProduct => 'Produto';

  @override
  String get landingFooterResources => 'Recursos';

  @override
  String get landingFooterCompany => 'Empresa';

  @override
  String get landingFooterLegal => 'Legal';

  @override
  String get landingCopyright => '© 2026 Keisen. Todos os direitos reservados.';

  @override
  String get featureSmartImportDesc =>
      'Criação rápida de tarefas com descrição\nAtribuição a membros da equipe\nPrioridade e prazo configuráveis\nNotificações de conclusão';

  @override
  String get featureImportDesc =>
      'Importação de arquivo CSV\nCopiar/colar do Excel\nParsing de texto inteligente\nMapeamento automático de campos';

  @override
  String get featureShareDesc =>
      'Convites por e-mail\nPermissões configuráveis\nComentários nas tarefas\nHistórico de alterações';

  @override
  String get featureSmartTaskCreation => 'Criação rápida de tarefas';

  @override
  String get featureTeamAssignment => 'Atribuição à equipe';

  @override
  String get featurePriorityDeadline => 'Prioridade e Prazos';

  @override
  String get featureCompletionNotifications => 'Notificações de conclusão';

  @override
  String get featureCsvImport => 'Importação CSV';

  @override
  String get featureExcelPaste => 'Copiar/Colar Excel';

  @override
  String get featureSmartParsing => 'Parsing Inteligente';

  @override
  String get featureAutoMapping => 'Mapeamento Automático';

  @override
  String get featureEmailInvites => 'Convites por E-mail';

  @override
  String get featurePermissions => 'Permissões Configuráveis';

  @override
  String get featureTaskComments => 'Comentários nas Tarefas';

  @override
  String get featureHistory => 'Histórico de Alterações';

  @override
  String get featureAdvancedFilters => 'Filtros Avançados';

  @override
  String get featureFullTextSearch => 'Pesquisa Full-text';

  @override
  String get featureSorting => 'Ordenação';

  @override
  String get featureTagsCategories => 'Tags & Categorias';

  @override
  String get featureArchiving => 'Arquivamento';

  @override
  String get featureSort => 'Ordenação';

  @override
  String get featureDataExport => 'Exportação de Dados';

  @override
  String get landingIntroFeatures =>
      'Sprint Planning com capacidade da equipe\nBacklog priorizado com drag & drop\nVelocity tracking e burndown chart\nDaily standup facilitado';

  @override
  String get landingAgileScrumFeatures =>
      'Product Backlog com story points\nSprint Backlog com task breakdown\nRetrospective board integrado\nMétricas Scrum automáticas';

  @override
  String get landingAgileKanbanFeatures =>
      'Colunas personalizáveis\nWIP limits por coluna\nDrag & drop intuitivo\nLead time e cycle time';

  @override
  String get landingEstimationPokerDesc =>
      'O método clássico: cada membro escolhe uma carta (1, 2, 3, 5, 8...). As estimativas são reveladas simultaneamente para evitar viés.';

  @override
  String get landingEstimationTShirtTitle => 'T-Shirt Size';

  @override
  String get landingEstimationTShirtSubtitle => 'Tamanhos relativos';

  @override
  String get landingEstimationTShirtDesc =>
      'Estimativa rápida usando tamanhos: XS, S, M, L, XL, XXL. Ideal para backlog grooming inicial ou quando se precisa de uma estimativa aproximada.';

  @override
  String get landingEstimationPertTitle => 'Three-Point (PERT)';

  @override
  String get landingEstimationPertSubtitle =>
      'Otimista / Provável / Pessimista';

  @override
  String get landingEstimationPertDesc =>
      'Técnica estatística: cada membro fornece 3 estimativas (O, M, P). A fórmula PERT calcula a estimativa ponderada: (O + 4M + P) / 6.';

  @override
  String get landingEstimationBucketTitle => 'Bucket System';

  @override
  String get landingEstimationBucketSubtitle => 'Categorização rápida';

  @override
  String get landingEstimationBucketDesc =>
      'As user stories são atribuídas a \"buckets\" predefinidos. Ótimo para estimar grandes quantidades de itens rapidamente em sessões de refinement.';

  @override
  String get landingEstimationChipHiddenVote => 'Voto oculto';

  @override
  String get landingEstimationChipTimer => 'Timer configurável';

  @override
  String get landingEstimationChipStats => 'Estatísticas em tempo real';

  @override
  String get landingEstimationChipParticipants => 'Até 20 participantes';

  @override
  String get landingEstimationChipHistory => 'Histórico de estimativas';

  @override
  String get landingEstimationChipExport => 'Exportar resultados';

  @override
  String get landingRetroTemplateStartStopTitle => 'Start / Stop / Continue';

  @override
  String get landingRetroTemplateStartStopDesc =>
      'O formato clássico: o que começar a fazer, o que parar de fazer, o que continuar fazendo.';

  @override
  String get landingRetroTemplateMadSadTitle => 'Mad / Sad / Glad';

  @override
  String get landingRetroTemplateMadSadDesc =>
      'Retrospectiva emocional: o que nos irritou, entristeceu ou alegrou.';

  @override
  String get landingRetroTemplate4LsTitle => '4L\'s';

  @override
  String get landingRetroTemplate4LsDesc =>
      'Liked, Learned, Lacked, Longed For - análise completa do sprint.';

  @override
  String get landingRetroTemplateSailboatTitle => 'Sailboat';

  @override
  String get landingRetroTemplateSailboatDesc =>
      'Metáfora visual: vento (ajudas), âncora (obstáculos), rochas (riscos), ilha (objetivos).';

  @override
  String get landingRetroTemplateWentWellTitle => 'Went Well / To Improve';

  @override
  String get landingRetroTemplateWentWellDesc =>
      'Formato simples e direto: o que deu certo e o que melhorar.';

  @override
  String get landingRetroTemplateDakiTitle => 'DAKI';

  @override
  String get landingRetroTemplateDakiDesc =>
      'Drop, Add, Keep, Improve - decisões concretas para o próximo sprint.';

  @override
  String get landingRetroFeatureTrackingTitle => 'Action Items Tracking';

  @override
  String get landingRetroFeatureTrackingDesc =>
      'Cada retrospectiva gera action items rastreáveis com responsável, prazo e status. Monitore o acompanhamento ao longo do tempo.';

  @override
  String get landingAgileSectionBadge => 'Metodologias';

  @override
  String get landingAgileSectionTitle => 'Agile & Scrum Framework';

  @override
  String get landingAgileSectionSubtitle =>
      'Implemente as melhores práticas de desenvolvimento de software iterativo';

  @override
  String get landingSmartTodoCollabTitle => 'Listas de Tarefas Colaborativas';

  @override
  String get landingSmartTodoCollabDesc =>
      'Smart Todo transforma a gestão das atividades diárias em um processo fluido e colaborativo. Crie listas, atribua tarefas aos membros da equipe e monitore o progresso em tempo real.\n\nIdeal para times distribuídos que precisam de sincronização contínua nas atividades a serem concluídas.';

  @override
  String get landingSmartTodoCollabFeatures =>
      'Criação rápida de tarefas com descrição\nAtribuição a membros da equipe\nPrioridade e prazo configuráveis\nNotificações de conclusão';

  @override
  String get landingSmartTodoImportFeatures =>
      'Importação de arquivo CSV\nCopiar/colar do Excel\nParsing de texto inteligente\nMapeamento automático de campos';

  @override
  String get landingSmartTodoSharingTitle => 'Compartilhamento e Convites';

  @override
  String get landingSmartTodoSharingDesc =>
      'Convide colegas e colaboradores para suas listas por e-mail. Cada participante pode visualizar, comentar e atualizar o status das tarefas atribuídas.\n\nPerfeito para gerenciar projetos transversais com stakeholders externos ou times multifuncionais.';

  @override
  String get landingSmartTodoSharingFeatures =>
      'Convites por e-mail\nPermissões configuráveis\nComentários nas tarefas\nHistórico de alterações';

  @override
  String get landingSmartTodoChipFilters => 'Filtros avançados';

  @override
  String get landingSmartTodoChipSearch => 'Pesquisa full-text';

  @override
  String get landingSmartTodoChipSort => 'Ordenação';

  @override
  String get landingSmartTodoChipTags => 'Tags e categorias';

  @override
  String get landingSmartTodoChipArchive => 'Arquivamento';

  @override
  String get landingSmartTodoChipExport => 'Exportação de dados';

  @override
  String get landingEisenhowerTitle => 'Matriz de Eisenhower';

  @override
  String get landingEisenhowerUrgentTitle => 'Urgente vs Importante';

  @override
  String get landingEisenhowerUrgentDesc =>
      'A Matriz de Eisenhower, criada pelo 34º Presidente dos Estados Unidos Dwight D. Eisenhower, divide as atividades em quatro quadrantes baseados em dois critérios: urgência e importância.\n\nEste framework decisório ajuda a distinguir o que requer atenção imediata do que contribui para os objetivos de longo prazo.';

  @override
  String get landingEisenhowerUrgentFeatures =>
      'Quadrante 1: Urgente + Importante → Faça agora\nQuadrante 2: Não urgente + Importante → Planeje\nQuadrante 3: Urgente + Não importante → Delegue\nQuadrante 4: Não urgente + Não importante → Elimine';

  @override
  String get landingEisenhowerDecisionsFeatures =>
      'Drag & drop intuitivo\nColaboração em equipe em tempo real\nEstatísticas de distribuição\nExportação para relatórios';

  @override
  String get landingEisenhowerUrgentLabel => 'URGENTE';

  @override
  String get landingEisenhowerNotUrgentLabel => 'NÃO URGENTE';

  @override
  String get landingEisenhowerImportantLabel => 'IMPORTANTE';

  @override
  String get landingEisenhowerNotImportantLabel => 'NÃO IMPORTANTE';

  @override
  String get landingEisenhowerDoLabel => 'FAÇA';

  @override
  String get landingEisenhowerDoDesc => 'Crises, prazos, emergências';

  @override
  String get landingEisenhowerPlanLabel => 'PLANEJE';

  @override
  String get landingEisenhowerPlanDesc =>
      'Estratégia, crescimento, relacionamentos';

  @override
  String get landingEisenhowerDelegateLabel => 'DELEGUE';

  @override
  String get landingEisenhowerDelegateDesc => 'Interrupções, reuniões, e-mails';

  @override
  String get landingEisenhowerEliminateLabel => 'ELIMINE';

  @override
  String get landingEisenhowerEliminateDesc =>
      'Distrações, redes sociais, perda de tempo';

  @override
  String get landingFooterFeatures => 'Funcionalidades';

  @override
  String get landingFooterPricing => 'Preços';

  @override
  String get landingFooterChangelog => 'Notas de Lançamento';

  @override
  String get landingFooterRoadmap => 'Roadmap';

  @override
  String get landingFooterDocs => 'Documentação';

  @override
  String jiraConnectedSuccess(String name) {
    return 'Connesso come $name';
  }

  @override
  String get landingFooterAgileGuides => 'Guias Agile';

  @override
  String get landingFooterBlog => 'Blog';

  @override
  String get landingFooterCommunity => 'Comunidade';

  @override
  String get landingFooterAbout => 'Sobre nós';

  @override
  String get landingFooterContact => 'Contato';

  @override
  String get landingFooterJobs => 'Trabalhe conosco';

  @override
  String get landingFooterPress => 'Press Kit';

  @override
  String get landingFooterPrivacy => 'Política de Privacidade';

  @override
  String get landingFooterTerms => 'Termos de Serviço';

  @override
  String get landingFooterCookies => 'Política de Cookies';

  @override
  String get landingFooterGdpr => 'LGPD';

  @override
  String get legalCookieTitle => 'Utilizamos cookies';

  @override
  String get legalCookieMessage =>
      'Utilizamos cookies para melhorar sua experiência e para fins analíticos. Ao continuar, você aceita o uso de cookies.';

  @override
  String get legalCookieAccept => 'Aceitar todos';

  @override
  String get legalCookieRefuse => 'Apenas necessários';

  @override
  String get legalCookiePolicy => 'Política de Cookies';

  @override
  String get legalPrivacyPolicy => 'Política de Privacidade';

  @override
  String get legalTermsOfService => 'Termos de Serviço';

  @override
  String get legalGDPR => 'LGPD';

  @override
  String get legalLastUpdatedLabel => 'Última atualização';

  @override
  String get legalLastUpdatedDate => '18 de janeiro de 2026';

  @override
  String get legalAcceptTerms =>
      'Aceito os Termos de Serviço e a Política de Privacidade';

  @override
  String get legalMustAcceptTerms =>
      'Você deve aceitar os termos para continuar';

  @override
  String get legalPrivacyContent =>
      '## 1. Introdução\nBem-vindo ao **Keisen** (\"nós\", \"nosso\", \"a Plataforma\"). Sua privacidade é importante para nós. Esta Política de Privacidade explica como coletamos, utilizamos, divulgamos e protegemos suas informações quando você utiliza nossa aplicação web.\n\n## 2. Dados que coletamos\nColetamos dois tipos de dados e informações:\n\n### 2.1 Informações fornecidas pelo usuário\n- **Dados da Conta:** Quando você acessa via Google Sign-In ou cria uma conta, coletamos seu nome, endereço de e-mail e imagem do perfil.\n- **Conteúdos do Usuário:** Coletamos os dados que você insere voluntariamente na plataforma, incluindo tarefas, estimativas, retrospectivas, comentários e configurações de equipes.\n\n### 2.2 Informações coletadas automaticamente\n- **Logs de sistema:** Endereços IP, tipo de navegador, páginas visitadas e timestamps.\n- **Cookies:** Utilizamos cookies técnicos essenciais para manter a sessão ativa.\n\n## 3. Como utilizamos seus dados\nUtilizamos as informações coletadas para:\n- Fornecer, gerenciar e manter nossos Serviços.\n- Melhorar, personalizar e expandir nossa Plataforma.\n- Analisar como você utiliza o site para melhorar a experiência do usuário.\n- Enviar e-mails de serviço (ex. convites para equipes, atualizações importantes).\n\n## 4. Compartilhamento de dados\nNão vendemos seus dados pessoais. Compartilhamos informações apenas com:\n- **Provedores de Serviço:** Utilizamos **Google Firebase** (Google LLC) para hospedagem, autenticação e banco de dados. Os dados são tratados de acordo com a [Política de Privacidade do Google](https://policies.google.com/privacy).\n- **Obrigações Legais:** Se exigido por lei ou para proteger nossos direitos.\n\n## 5. Segurança dos dados\nImplementamos medidas de segurança técnicas e organizacionais padrão do setor (como criptografia em trânsito) para proteger seus dados. No entanto, nenhum método de transmissão na Internet é 100% seguro.\n\n## 6. Seus direitos\nVocê tem o direito de:\n- Acessar seus dados pessoais.\n- Solicitar a correção de dados imprecisos.\n- Solicitar a exclusão de seus dados (\"Direito ao esquecimento\").\n- Opor-se ao tratamento de seus dados.\n\nPara exercer esses direitos, entre em contato conosco em: suppkesien@gmail.com.\n\n## 7. Alterações nesta Política\nPodemos atualizar esta Política de Privacidade periodicamente. Notificaremos você sobre quaisquer alterações publicando a nova Política nesta página.';

  @override
  String get legalTermsContent =>
      '## 1. Aceitação dos Termos\nAo acessar ou utilizar o **Keisen**, você concorda em estar vinculado a estes Termos de Serviço (\"Termos\"). Se não concordar com estes Termos, você não deve utilizar nossos Serviços.\n\n## 2. Descrição do Serviço\nKeisen é uma plataforma de colaboração para times ágeis que oferece ferramentas como Smart Todo, Matriz de Eisenhower, Estimation Room e Gestão de Processos Ágeis. Reservamo-nos o direito de modificar ou descontinuar o serviço a qualquer momento.\n\n## 3. Conta do Usuário\nVocê é responsável por manter a confidencialidade das credenciais de sua conta e por todas as atividades que ocorram sob sua conta. Reservamo-nos o direito de suspender ou cancelar contas que violem estes Termos.\n\n## 4. Conduta do Usuário\nVocê concorda em não utilizar o Serviço para:\n- Violar leis locais, nacionais ou internacionais.\n- Carregar conteúdos ofensivos, difamatórios ou ilegais.\n- Tentar acesso não autorizado aos sistemas da Plataforma.\n\n## 5. Propriedade Intelectual\nTodos os direitos de propriedade intelectual relativos à Plataforma e seus conteúdos originais (excluindo conteúdos fornecidos pelos usuários) são de propriedade exclusiva de Leonardo Torella.\n\n## 6. Limitação de Responsabilidade\nNa máxima extensão permitida por lei, Keisen é fornecido \"como está\" e \"conforme disponível\". Não garantimos que o serviço será ininterrupto ou livre de erros. Não seremos responsáveis por danos indiretos, incidentais ou consequenciais decorrentes do uso do serviço.\n\n## 7. Lei Aplicável\nEstes Termos são regidos pelas leis do Estado Italiano.\n\n## 8. Contato\nPara perguntas sobre estes Termos, entre em contato conosco em: suppkesien@gmail.com.';

  @override
  String get legalCookiesContent =>
      '## 1. O que são Cookies?\nCookies são pequenos arquivos de texto que são salvos em seu dispositivo quando você visita um site. São amplamente utilizados para fazer os sites funcionarem de forma mais eficiente e fornecer informações aos proprietários do site.\n\n## 2. Como utilizamos os Cookies\nUtilizamos cookies para diversos fins:\n\n### 2.1 Cookies Técnicos (Essenciais)\nEstes cookies são necessários para o funcionamento do site e não podem ser desativados em nossos sistemas. Geralmente são configurados apenas em resposta a ações realizadas por você que constituem uma solicitação de serviços, como configuração de preferências de privacidade, login ou preenchimento de formulários.\n*Exemplo:* Cookie de sessão Firebase Auth para manter o usuário logado.\n\n### 2.2 Cookies de Análise\nEstes cookies nos permitem contar visitas e fontes de tráfego, para que possamos medir e melhorar o desempenho do nosso site. Todas as informações coletadas por estes cookies são agregadas e, portanto, anônimas.\n\n## 3. Gerenciamento de Cookies\nA maioria dos navegadores permite controlar a maioria dos cookies através das configurações do navegador. No entanto, se você desativar os cookies essenciais, algumas partes do nosso Serviço podem não funcionar corretamente (por exemplo, você não poderá fazer login).\n\n## 4. Cookies de Terceiros\nUtilizamos serviços de terceiros como **Google Firebase** que podem configurar seus próprios cookies. Convidamos você a consultar suas respectivas políticas de privacidade para mais detalhes.';

  @override
  String get legalGdprContent =>
      '## Compromisso com a Proteção de Dados (LGPD/GDPR)\nEm conformidade com o Regulamento Geral de Proteção de Dados (GDPR) da União Europeia e a Lei Geral de Proteção de Dados (LGPD) do Brasil, Keisen se compromete a proteger os dados pessoais dos usuários e a garantir a transparência em seu tratamento.\n\n## Controlador dos Dados\nO Controlador do Tratamento dos dados é:\n**Keisen Team**\nE-mail: suppkesien@gmail.com\n\n## Base Legal do Tratamento\nTratamos seus dados pessoais apenas quando temos uma base legal para fazê-lo. Isto inclui:\n- **Consentimento:** Você nos deu permissão para tratar seus dados para uma finalidade específica.\n- **Execução de contrato:** O tratamento é necessário para fornecer os Serviços que você solicitou (ex. uso da plataforma).\n- **Interesse legítimo:** O tratamento é necessário para nossos interesses legítimos (ex. segurança, melhoria do serviço), a menos que prevaleçam seus direitos e liberdades fundamentais.\n\n## Transferência de Dados\nSeus dados são armazenados em servidores seguros fornecidos pelo Google Cloud Platform (Google Firebase). O Google adere aos padrões internacionais de segurança e é compatível com o GDPR através das Cláusulas Contratuais Padrão (SCC).\n\n## Seus Direitos\nComo usuário, você tem os seguintes direitos:\n1. **Direito de acesso:** Você tem o direito de solicitar cópias de seus dados pessoais.\n2. **Direito de retificação:** Você tem o direito de solicitar a correção de informações que considere imprecisas.\n3. **Direito à exclusão (\"Direito ao esquecimento\"):** Você tem o direito de solicitar a exclusão de seus dados pessoais, sob determinadas condições.\n4. **Direito à limitação do tratamento:** Você tem o direito de solicitar a limitação do tratamento de seus dados.\n5. **Direito à portabilidade dos dados:** Você tem o direito de solicitar a transferência dos dados que coletamos para outra organização ou diretamente para você.\n\n## Exercício dos Direitos\nSe deseja exercer algum destes direitos, entre em contato conosco em: suppkesien@gmail.com. Responderemos à sua solicitação dentro de um mês.';

  @override
  String get profilePrivacy => 'Privacidade';

  @override
  String get profileExportData => 'Exportar meus dados';

  @override
  String get profileDeleteAccountConfirm =>
      'Tem certeza de que deseja excluir permanentemente sua conta? Esta ação é irreversível.';

  @override
  String get subscriptionTitle => 'Assinatura';

  @override
  String get subscriptionTabPlans => 'Planos';

  @override
  String get subscriptionTabUsage => 'Uso';

  @override
  String get subscriptionTabBilling => 'Faturamento';

  @override
  String subscriptionActiveProjects(int count) {
    return '$count projetos ativos';
  }

  @override
  String subscriptionActiveLists(int count) {
    return '$count listas Smart Todo';
  }

  @override
  String get subscriptionCurrentPlan => 'Plano atual';

  @override
  String subscriptionUpgradeTo(String plan) {
    return 'Upgrade para $plan';
  }

  @override
  String subscriptionDowngradeTo(String plan) {
    return 'Downgrade para $plan';
  }

  @override
  String subscriptionChoose(String plan) {
    return 'Escolher $plan';
  }

  @override
  String get subscriptionMonthly => 'Mensal';

  @override
  String get subscriptionYearly => 'Anual (-17%)';

  @override
  String get subscriptionLimitReached => 'Limite atingido';

  @override
  String get subscriptionLimitProjects =>
      'Você atingiu o limite máximo de projetos para seu plano. Mude para Premium para criar mais projetos.';

  @override
  String get subscriptionLimitLists =>
      'Você atingiu o limite máximo de listas para seu plano. Mude para Premium para criar mais listas.';

  @override
  String get subscriptionLimitTasks =>
      'Você atingiu o limite máximo de tarefas para este projeto. Mude para Premium para adicionar mais tarefas.';

  @override
  String get subscriptionLimitInvites =>
      'Você atingiu o limite máximo de convites para este projeto. Mude para Premium para convidar mais pessoas.';

  @override
  String get subscriptionLimitEstimations =>
      'Você atingiu o limite máximo de sessões de estimativa. Mude para Premium para criar mais.';

  @override
  String get subscriptionLimitRetrospectives =>
      'Você atingiu o limite máximo de retrospectivas. Mude para Premium para criar mais.';

  @override
  String get subscriptionLimitAgileProjects =>
      'Você atingiu o limite máximo de projetos Agile. Mude para Premium para criar mais.';

  @override
  String get subscriptionLimitDefault =>
      'Você atingiu o limite do seu plano atual.';

  @override
  String get subscriptionCurrentUsage => 'Uso atual';

  @override
  String get subscriptionUpgradeToPremium => 'Mudar para Premium';

  @override
  String get subscriptionBenefitProjects => '30 projetos ativos';

  @override
  String get subscriptionBenefitLists => '30 listas Smart Todo';

  @override
  String get subscriptionBenefitTasks => '100 tarefas por projeto';

  @override
  String get subscriptionBenefitNoAds => 'Sem publicidade';

  @override
  String get subscriptionStartingFrom => 'A partir de €4.99/mês';

  @override
  String get subscriptionLater => 'Mais tarde';

  @override
  String get subscriptionViewPlans => 'Ver planos';

  @override
  String get subscriptionContactDeveloper => 'Contatta lo sviluppatore';

  @override
  String get subscriptionOfficialEmail => 'leonardo.torella@gmail.com';

  @override
  String subscriptionCanCreateOne(String entity) {
    return 'Você ainda pode criar 1 $entity';
  }

  @override
  String subscriptionCanCreateMany(int count, String entity) {
    return 'Você ainda pode criar $count $entity';
  }

  @override
  String get subscriptionUpgrade => 'UPGRADE';

  @override
  String subscriptionUsed(int count) {
    return 'Utilizados: $count';
  }

  @override
  String get subscriptionUnlimited => 'Ilimitados';

  @override
  String subscriptionLimit(int count) {
    return 'Limite: $count';
  }

  @override
  String get subscriptionPlanUsage => 'Uso do plano';

  @override
  String get subscriptionRefresh => 'Atualizar';

  @override
  String get subscriptionAdsActive => 'Publicidade ativa';

  @override
  String get subscriptionRemoveAds =>
      'Mude para Premium para remover a publicidade';

  @override
  String get subscriptionNoAds => 'Sem publicidade';

  @override
  String get subscriptionLoadError =>
      'Não foi possível carregar os dados de uso';

  @override
  String get subscriptionAdLabel => 'AD';

  @override
  String get subscriptionAdPlaceholder => 'Ad Placeholder';

  @override
  String get subscriptionDevEnvironment => '(Ambiente de desenvolvimento)';

  @override
  String get subscriptionRemoveAdsUnlock =>
      'Remova a publicidade e desbloqueie funcionalidades avançadas';

  @override
  String get subscriptionUpgradeButton => 'Upgrade';

  @override
  String subscriptionLoadingError(String error) {
    return 'Erro ao carregar: $error';
  }

  @override
  String get subscriptionCompletePayment =>
      'Complete o pagamento na janela aberta';

  @override
  String subscriptionError(String error) {
    return 'Erro: $error';
  }

  @override
  String get subscriptionConfirmDowngrade => 'Confirmar downgrade';

  @override
  String get subscriptionDowngradeMessage =>
      'Tem certeza de que deseja mudar para o plano Free?\n\nSua assinatura permanecerá ativa até o final do período atual, após o qual você passará automaticamente para o plano Free.\n\nVocê não perderá seus dados, mas algumas funcionalidades podem ficar limitadas.';

  @override
  String get subscriptionCancel => 'Cancelar';

  @override
  String get subscriptionConfirmDowngradeButton => 'Confirmar downgrade';

  @override
  String get subscriptionCancelled =>
      'Assinatura cancelada. Permanecerá ativa até o final do período.';

  @override
  String subscriptionPortalError(String error) {
    return 'Erro ao abrir portal: $error';
  }

  @override
  String get subscriptionRetry => 'Tentar novamente';

  @override
  String get subscriptionChooseRightPlan => 'Escolha o plano certo para você';

  @override
  String get subscriptionStartFree =>
      'Comece grátis, faça upgrade quando quiser';

  @override
  String subscriptionPlan(String plan) {
    return 'Plano $plan';
  }

  @override
  String subscriptionPlanName(String plan) {
    return 'Plano Atual: $plan';
  }

  @override
  String subscriptionTrialUntil(String date) {
    return 'Trial até $date';
  }

  @override
  String subscriptionRenewal(String date) {
    return 'Renovação: $date';
  }

  @override
  String get subscriptionManage => 'Gerenciar';

  @override
  String get subscriptionLoginRequired => 'Faça login para ver o uso';

  @override
  String get subscriptionSuggestion => 'Sugestão';

  @override
  String get subscriptionSuggestionText =>
      'Mude para Premium para desbloquear mais projetos, remover a publicidade e aumentar os limites. Teste grátis por 7 dias!';

  @override
  String get subscriptionPaymentManagement => 'Gestão de pagamentos';

  @override
  String get subscriptionNoActiveSubscription => 'Nenhuma assinatura ativa';

  @override
  String get subscriptionUsingFreePlan => 'Você está usando o plano Free';

  @override
  String get subscriptionViewPaidPlans => 'Ver planos pagos';

  @override
  String get subscriptionPaymentMethod => 'Método de pagamento';

  @override
  String get subscriptionEditPaymentMethod =>
      'Editar cartão ou método de pagamento';

  @override
  String get subscriptionInvoices => 'Faturas';

  @override
  String get subscriptionViewInvoices => 'Visualizar e baixar faturas';

  @override
  String get subscriptionCancelSubscription => 'Cancelar assinatura';

  @override
  String get subscriptionAccessUntilEnd =>
      'O acesso permanecerá ativo até o final do período';

  @override
  String get subscriptionPaymentHistory => 'Histórico de pagamentos';

  @override
  String get subscriptionNoPayments => 'Nenhum pagamento registrado';

  @override
  String get subscriptionCompleted => 'Concluído';

  @override
  String get subscriptionDateNotAvailable => 'Data não disponível';

  @override
  String get subscriptionFaq => 'Perguntas frequentes';

  @override
  String get subscriptionFaqCancel => 'Posso cancelar a qualquer momento?';

  @override
  String get subscriptionFaqCancelAnswer =>
      'Sim, você pode cancelar sua assinatura a qualquer momento. O acesso permanecerá ativo até o final do período pago.';

  @override
  String get subscriptionFaqTrial => 'Como funciona o teste gratuito?';

  @override
  String get subscriptionFaqTrialAnswer =>
      'Com o teste gratuito você tem acesso completo a todas as funcionalidades do plano escolhido. Ao término do período de teste, a assinatura paga será iniciada automaticamente.';

  @override
  String get subscriptionFaqChange => 'Posso mudar de plano?';

  @override
  String get subscriptionFaqChangeAnswer =>
      'Você pode fazer upgrade ou downgrade a qualquer momento. O valor será calculado proporcionalmente.';

  @override
  String get subscriptionFaqData => 'Meus dados estão seguros?';

  @override
  String get subscriptionFaqDataAnswer =>
      'Absolutamente sim. Você nunca perderá seus dados, mesmo se mudar para um plano inferior. Algumas funcionalidades podem ficar limitadas, mas os dados permanecem sempre acessíveis.';

  @override
  String get subscriptionStatusActive => 'Ativo';

  @override
  String get subscriptionStatusTrialing => 'Em teste';

  @override
  String get subscriptionStatusPastDue => 'Pagamento em atraso';

  @override
  String get subscriptionStatusCancelled => 'Cancelado';

  @override
  String get subscriptionStatusExpired => 'Expirado';

  @override
  String get subscriptionStatusPaused => 'Pausado';

  @override
  String get subscriptionStatus => 'Status';

  @override
  String get subscriptionStarted => 'Iniciado';

  @override
  String get subscriptionNextRenewal => 'Próxima renovação';

  @override
  String get subscriptionTrialEnd => 'Fim do trial';

  @override
  String get toolSectionTitle => 'Ferramentas';

  @override
  String get deadlineTitle => 'Prazos';

  @override
  String get deadlineNoUpcoming => 'Nenhum prazo próximo';

  @override
  String get deadlineAll => 'Todos';

  @override
  String get deadlineToday => 'Hoje';

  @override
  String get deadlineTomorrow => 'Amanhã';

  @override
  String get deadlineSprint => 'Sprint';

  @override
  String get deadlineTask => 'Tarefa';

  @override
  String get favTitle => 'Favoritos';

  @override
  String get favFilterAll => 'Todos';

  @override
  String get favFilterTodo => 'Listas Todo';

  @override
  String get favFilterMatrix => 'Matrizes';

  @override
  String get favFilterProject => 'Projetos';

  @override
  String get favFilterPoker => 'Estimativas';

  @override
  String get actionRemoveFromFavorites => 'Remover dos favoritos';

  @override
  String get favFilterRetro => 'Retro';

  @override
  String get favNoFavorites => 'Nenhum favorito encontrado';

  @override
  String get favTypeTodo => 'Lista Todo';

  @override
  String get favTypeMatrix => 'Matriz Eisenhower';

  @override
  String get favTypeProject => 'Projeto Agile';

  @override
  String get favTypeRetro => 'Retrospective';

  @override
  String get favTypePoker => 'Planning Poker';

  @override
  String get favTypeTool => 'Ferramenta';

  @override
  String get deadline2Days => '2 Dias';

  @override
  String get deadline3Days => '3 Dias';

  @override
  String get deadline5Days => '5 Dias';

  @override
  String get deadlineConfigTitle => 'Configurar Atalhos';

  @override
  String get deadlineConfigDesc =>
      'Escolha os intervalos de tempo a serem exibidos no cabeçalho.';

  @override
  String get smartTodoClose => 'Fechar';

  @override
  String get smartTodoDone => 'Concluído';

  @override
  String get smartTodoAdd => 'Adicionar';

  @override
  String get smartTodoEmailLabel => 'E-mail';

  @override
  String get exceptionLoginGoogleRequired =>
      'Login Google necessário para enviar e-mails';

  @override
  String get exceptionUserNotAuthenticated => 'Usuário não autenticado';

  @override
  String errorLoginFailed(String error) {
    return 'Erro no login: $error';
  }

  @override
  String retroParticipantsTitle(int count) {
    return 'Participantes ($count)';
  }

  @override
  String get actionReopen => 'Reabrir';

  @override
  String get retroWaitingForFacilitator =>
      'Aguardando o facilitador iniciar a sessão...';

  @override
  String get retroGeneratingSheet => 'Gerando Google Sheet...';

  @override
  String get retroExportSuccess => 'Exportação concluída!';

  @override
  String get retroExportSuccessMessage =>
      'Sua retrospectiva foi exportada para o Google Sheets.';

  @override
  String get retroExportError => 'Erro durante a exportação para Sheets.';

  @override
  String get retroReportCopied =>
      'Relatório copiado para a área de transferência! Cole no Excel ou Notas.';

  @override
  String get retroReopenTitle => 'Reabrir Retrospectiva';

  @override
  String get retroReopenConfirm =>
      'Tem certeza de que deseja reabrir a retrospectiva? Ela voltará para a fase de Discussão.';

  @override
  String get errorAuthRequired => 'Autenticação necessária';

  @override
  String get errorRetroIdMissing => 'ID da Retrospectiva ausente';

  @override
  String get pokerInviteAccepted =>
      'Convite aceito! Você será redirecionado para a sessão.';

  @override
  String get pokerInviteRefused => 'Convite recusado';

  @override
  String get pokerConfirmRefuseTitle => 'Recusar Convite';

  @override
  String get pokerConfirmRefuseContent =>
      'Tem certeza de que deseja recusar este convite?';

  @override
  String get pokerVerifyingInvite => 'Verificando convite...';

  @override
  String get actionBackHome => 'Voltar para a Home';

  @override
  String get actionSignin => 'Entrar';

  @override
  String get exceptionStoryNotFound => 'Story não encontrada';

  @override
  String get exceptionNoTasksInProject =>
      'Nenhuma tarefa encontrada no projeto';

  @override
  String get exceptionInvitePending =>
      'Já existe um convite pendente para este e-mail';

  @override
  String get exceptionAlreadyParticipant => 'O usuário já é um participante';

  @override
  String get exceptionInviteInvalid => 'Convite inválido ou expirado';

  @override
  String get exceptionInviteCalculated => 'Convite expirado';

  @override
  String get exceptionInviteWrongUser => 'Convite destinado a outro usuário';

  @override
  String get todoImportTasks => 'Importar Tarefas';

  @override
  String get todoExportSheets => 'Exportar para Sheets';

  @override
  String get todoDeleteColumnTitle => 'Excluir Coluna';

  @override
  String get todoDeleteColumnConfirm =>
      'Tem certeza? As tarefas nesta coluna serão perdidas.';

  @override
  String get exceptionListNotFound => 'Lista não encontrada';

  @override
  String get langItalian => 'Italiano';

  @override
  String get langEnglish => 'English';

  @override
  String get langFrench => 'Français';

  @override
  String get langSpanish => 'Español';

  @override
  String get jsonExportLabel => 'Baixe uma cópia JSON dos seus dados';

  @override
  String errorExporting(String error) {
    return 'Erro durante a exportação: $error';
  }

  @override
  String get smartTodoViewKanban => 'Kanban';

  @override
  String get smartTodoViewList => 'Lista';

  @override
  String get smartTodoViewResource => 'Por Recurso';

  @override
  String get smartTodoInviteTooltip => 'Convidar';

  @override
  String get smartTodoOptionsTooltip => 'Mais Opções';

  @override
  String get smartTodoActionImport => 'Importar Tarefas';

  @override
  String get smartTodoActionExportSheets => 'Exportar para Sheets';

  @override
  String get smartTodoDeleteColumnTitle => 'Excluir Coluna';

  @override
  String get smartTodoDeleteColumnContent =>
      'Tem certeza? As tarefas nesta coluna não serão mais visíveis.';

  @override
  String get smartTodoNewColumn => 'Nova Coluna';

  @override
  String get smartTodoColumnNameHint => 'Nome da Coluna';

  @override
  String get smartTodoColorLabel => 'COR';

  @override
  String get smartTodoMarkAsDone => 'Marcar como concluído';

  @override
  String get smartTodoColumnDoneDescription =>
      'As tarefas nesta coluna serão consideradas \'Concluídas\' (riscadas).';

  @override
  String get smartTodoListSettingsTitle => 'Configurações da Lista';

  @override
  String get smartTodoRenameList => 'Renomear Lista';

  @override
  String get smartTodoManageTags => 'Gerenciar Tags';

  @override
  String get smartTodoDeleteList => 'Excluir Lista';

  @override
  String get smartTodoEditPermissionError =>
      'Você só pode editar tarefas atribuídas a você';

  @override
  String errorDeletingAccount(String error) {
    return 'Erro ao excluir a conta: $error';
  }

  @override
  String get errorRecentLoginRequired =>
      'É necessário ter feito login recentemente. Por favor, saia e entre novamente antes de excluir a conta.';

  @override
  String actionGuide(String framework) {
    return 'Guia $framework';
  }

  @override
  String get actionExportSheets => 'Exportar para Google Sheets';

  @override
  String get actionAuditLog => 'Audit Log';

  @override
  String get actionInviteMember => 'Convidar Membro';

  @override
  String get actionSettings => 'Configurações';

  @override
  String get retroSelectIcebreakerTooltip =>
      'Selecione a atividade para quebrar o gelo';

  @override
  String get retroIcebreakerLabel => 'Atividade inicial';

  @override
  String get retroTimePhasesOptional => 'Timer das Fases (Opcional)';

  @override
  String get retroTimePhasesDesc =>
      'Defina a duração em minutos para cada fase:';

  @override
  String get retroIcebreakerSectionTitle => 'Icebreaker';

  @override
  String get retroBoardTitle => 'Painel de Retrospectivas';

  @override
  String get searchPlaceholder => 'Pesquisar em todo lugar...';

  @override
  String get searchResultsTitle => 'Resultados da Pesquisa';

  @override
  String searchNoResults(Object query) {
    return 'Nenhum resultado para \'$query\'';
  }

  @override
  String get searchResultTypeProject => 'Projeto';

  @override
  String get searchResultTypeTodo => 'Lista ToDo';

  @override
  String get searchResultTypeRetro => 'Retrospectiva';

  @override
  String get searchResultTypeEisenhower => 'Matriz Eisenhower';

  @override
  String get searchResultTypeEstimation => 'Estimation Room';

  @override
  String get searchBackToDashboard => 'Voltar para o Dashboard';

  @override
  String get smartTodoAddItem => 'Adicionar item';

  @override
  String get smartTodoAddImageUrl => 'Adicionar Imagem (URL)';

  @override
  String get smartTodoNone => 'Nenhum';

  @override
  String get smartTodoPointsHint => 'Pontos (ex. 5)';

  @override
  String get smartTodoNewItem => 'Novo item';

  @override
  String get smartTodoDeleteComment => 'Excluir';

  @override
  String get priorityHigh => 'ALTA';

  @override
  String get priorityMedium => 'MÉDIA';

  @override
  String get priorityLow => 'BAIXA';

  @override
  String get exportToEstimation => 'Enviar para Estimation';

  @override
  String get exportToEstimationDesc =>
      'Criar uma sessão de estimativa com estas tarefas';

  @override
  String get exportToEisenhower => 'Enviar para Eisenhower';

  @override
  String get exportToEisenhowerDesc =>
      'Criar uma matriz Eisenhower com estas tarefas';

  @override
  String get selectTasksToExport => 'Selecionar Tarefas';

  @override
  String get selectTasksToExportDesc => 'Escolha quais tarefas incluir';

  @override
  String get noTasksSelected => 'Nenhuma tarefa selecionada';

  @override
  String get selectAtLeastOne => 'Selecione pelo menos uma tarefa';

  @override
  String get createEstimationSession => 'Criar Sessão de Estimativa';

  @override
  String tasksSelectedCount(int count) {
    return '$count tarefas selecionadas';
  }

  @override
  String get exportSuccess => 'Exportado com sucesso';

  @override
  String get exportFromEstimation => 'Exportar para Lista';

  @override
  String get exportFromEstimationDesc =>
      'Exporte as stories estimadas para uma lista Smart Todo';

  @override
  String get selectDestinationList => 'Selecione a lista de destino';

  @override
  String get createNewList => 'Criar nova lista';

  @override
  String get existingList => 'Lista existente';

  @override
  String get listName => 'Nome da lista';

  @override
  String get listNameHint => 'Insira um nome para a nova lista';

  @override
  String get selectList => 'Selecionar lista';

  @override
  String get selectListHint => 'Escolha uma lista';

  @override
  String get noListsAvailable =>
      'Nenhuma lista disponível. Uma nova será criada.';

  @override
  String storiesSelectedCount(int count) {
    return '$count stories selecionadas';
  }

  @override
  String get selectAll => 'Selecionar todos';

  @override
  String get deselectAll => 'Desselecionar todos';

  @override
  String get importStories => 'Importar Stories';

  @override
  String storiesImportedCount(int count) {
    return '$count stories importadas';
  }

  @override
  String get noEstimatedStories =>
      'Nenhuma story com estimativas para importar';

  @override
  String get selectDestinationMatrix => 'Selecionar Matriz de Destino';

  @override
  String get existingMatrix => 'Matriz Existente';

  @override
  String get createNewMatrix => 'Criar Nova Matriz';

  @override
  String get matrixName => 'Nome da Matriz';

  @override
  String get matrixNameHint => 'Insira um nome para a nova matriz';

  @override
  String get selectMatrix => 'Selecionar Matriz';

  @override
  String get selectMatrixHint => 'Escolha uma matriz de destino';

  @override
  String get noMatricesAvailable => 'Nenhuma matriz disponível. Crie uma nova.';

  @override
  String activitiesCreated(int count) {
    return '$count atividades criadas';
  }

  @override
  String get importFromEisenhower => 'Importar do Eisenhower';

  @override
  String get importFromEisenhowerDesc =>
      'Adicione as tarefas priorizadas a esta lista';

  @override
  String get quadrantQ1 => 'Urgente & Importante';

  @override
  String get quadrantQ2 => 'Não Urgente & Importante';

  @override
  String get quadrantQ3 => 'Urgente & Não Importante';

  @override
  String get quadrantQ4 => 'Não Urgente & Não Importante';

  @override
  String get warningQ4Tasks =>
      'As tarefas Q4 geralmente não valem a pena. Tem certeza?';

  @override
  String get priorityMappingInfo =>
      'Mapeamento de prioridade: Q1=Alta, Q2=Média, Q3/Q4=Baixa';

  @override
  String get selectColumns => 'Selecionar Colunas';

  @override
  String get allTasks => 'Todas as Tarefas';

  @override
  String get filterByColumn => 'Filtrar por coluna';

  @override
  String get exportFromEisenhower => 'Enviar para lista Todo';

  @override
  String get exportFromEisenhowerDesc =>
      'Selecione as atividades para exportar para Smart Todo';

  @override
  String get filterByQuadrant => 'Filtrar por quadrante:';

  @override
  String get allActivities => 'Todas';

  @override
  String activitiesSelectedCount(int count) {
    return '$count atividades selecionadas';
  }

  @override
  String get noActivitiesSelected => 'Nenhuma atividade neste filtro';

  @override
  String get unvoted => 'NÃO VOTADA';

  @override
  String tasksCreated(int count) {
    return '$count tarefas criadas';
  }

  @override
  String get exportToUserStories => 'Enviar para projeto Agile';

  @override
  String get exportToUserStoriesDesc =>
      'Enviar user stories para um projeto Agile';

  @override
  String get selectDestinationProject => 'Selecionar Projeto de Destino';

  @override
  String get existingProject => 'Projeto Existente';

  @override
  String get createNewProject => 'Criar Novo Projeto';

  @override
  String get projectName => 'Nome do Projeto';

  @override
  String get projectNameHint => 'Insira um nome para o novo projeto';

  @override
  String get selectProject => 'Selecionar Projeto';

  @override
  String get selectProjectHint => 'Escolha um projeto de destino';

  @override
  String get noProjectsAvailable => 'Nenhum projeto disponível. Crie um novo.';

  @override
  String get userStoryFieldMappingInfo =>
      'Mapeamento: Título → Título da story, Descrição → Descrição da story, Esforço → Story points, Prioridade → Business value';

  @override
  String storiesCreated(int count) {
    return '$count stories criadas';
  }

  @override
  String get configureNewProject => 'Configurar Novo Projeto';

  @override
  String get exportToAgileSprint => 'Enviar para Sprint';

  @override
  String get actionSend => 'Enviar';

  @override
  String get exportToAgileSprintDesc =>
      'Adicionar stories estimadas a um projeto Agile';

  @override
  String get selectSprint => 'Selecionar Sprint';

  @override
  String get selectSprintHint => 'Escolha um sprint de destino';

  @override
  String get noSprintsAvailable =>
      'Nenhum sprint disponível. Crie primeiro um sprint em planejamento.';

  @override
  String get sprintExportFieldMappingInfo =>
      'Mapeamento: Título → Título da story, Descrição → Descrição, Estimativa → Story points';

  @override
  String get exportToSprint => 'Exportar para Agile Project';

  @override
  String totalStoryPoints(int count) {
    return '$count story points totais';
  }

  @override
  String storiesAddedToSprint(int count, String sprintName) {
    return '$count stories adicionadas a $sprintName';
  }

  @override
  String storiesAddedToProject(int count, String projectName) {
    return '$count stories adicionadas ao projeto $projectName';
  }

  @override
  String get exportEisenhowerToSprintDesc =>
      'Transforme as atividades Eisenhower em User Stories no projeto Agile';

  @override
  String get exportEisenhowerToEstimationDesc =>
      'Crie uma sessão de estimativa a partir das atividades';

  @override
  String get selectedActivities => 'atividades selecionadas';

  @override
  String get noActivitiesToExport => 'Nenhuma atividade para exportar';

  @override
  String get hiddenQ4Activities => 'Ocultas';

  @override
  String get q4Activities => 'atividades Q4 (Eliminar)';

  @override
  String get showQ4 => 'Mostrar Q4';

  @override
  String get hideQ4 => 'Ocultar Q4';

  @override
  String get showingAllActivities => 'Mostrando todas as atividades';

  @override
  String get eisenhowerMappingInfo =>
      'Q1→Must, Q2→Should, Q3→Could, Q4→Won\'t. Importância→Business Value.';

  @override
  String get estimationExportInfo =>
      'As atividades serão adicionadas como stories para estimar. As atividades Q4 não serão transferidas.';

  @override
  String get createSession => 'Criar Sessão';

  @override
  String get estimationType => 'Tipo de estimativa';

  @override
  String activitiesAddedToSprint(int count, String sprintName) {
    return '$count atividades adicionadas a $sprintName';
  }

  @override
  String activitiesAddedToProject(int count, String projectName) {
    return '$count atividades adicionadas ao projeto $projectName';
  }

  @override
  String estimationSessionCreated(int count) {
    return 'Sessão de estimativa criada com $count atividades';
  }

  @override
  String activitiesExportedToSprint(int count, String sprintName) {
    return '$count atividades exportadas para o sprint $sprintName';
  }

  @override
  String activitiesExportedToEstimation(int count, String sessionName) {
    return '$count atividades exportadas para a sessão de estimativa $sessionName';
  }

  @override
  String get archiveAction => 'Arquivar';

  @override
  String get archiveRestoreAction => 'Restaurar';

  @override
  String get archiveShowArchived => 'Mostrar Arquivados';

  @override
  String get archiveHideArchived => 'Ocultar Arquivados';

  @override
  String archiveConfirmTitle(String itemType) {
    return 'Arquivar $itemType';
  }

  @override
  String get archiveConfirmMessage =>
      'Tem certeza de que deseja arquivar este elemento? Ele podera ser restaurado depois.';

  @override
  String archiveRestoreConfirmTitle(String itemType) {
    return 'Restaurar $itemType';
  }

  @override
  String get archiveRestoreConfirmMessage =>
      'Deseja restaurar este elemento do arquivo?';

  @override
  String get archiveSuccessMessage => 'Projeto arquivado';

  @override
  String get archiveRestoreSuccessMessage => 'Projeto restaurado';

  @override
  String get archiveErrorMessage => 'Erro ao arquivar projeto';

  @override
  String get archiveRestoreErrorMessage => 'Erro ao restaurar projeto';

  @override
  String get archiveFilterLabel => 'Arquivo';

  @override
  String get archiveFilterActive => 'Ativos';

  @override
  String get archiveFilterArchived => 'Arquivados';

  @override
  String get archiveFilterAll => 'Todos';

  @override
  String get archiveBadge => 'ARQUIVO';

  @override
  String get archiveEmptyMessage => 'Nenhum elemento arquivado';

  @override
  String get completeAction => 'Concluir';

  @override
  String get reopenAction => 'Reabrir';

  @override
  String completeConfirmTitle(String itemType) {
    return 'Concluir $itemType';
  }

  @override
  String get completeConfirmMessage =>
      'Tem certeza de que deseja concluir este elemento?';

  @override
  String get completeSuccessMessage => 'Elemento concluido com sucesso';

  @override
  String get reopenSuccessMessage => 'Elemento reaberto com sucesso';

  @override
  String get completedBadge => 'Concluido';

  @override
  String get inviteNewInvite => 'NOVO CONVITE';

  @override
  String get inviteRole => 'Papel:';

  @override
  String get inviteSendEmailNotification => 'Enviar e-mail de notificacao';

  @override
  String get inviteSendInvite => 'Enviar Convite';

  @override
  String get inviteLink => 'Link do convite:';

  @override
  String get inviteList => 'CONVITES';

  @override
  String get inviteResend => 'Reenviar';

  @override
  String get inviteRevokeMessage => 'O convite nao sera mais valido.';

  @override
  String get inviteResent => 'Convite reenviado';

  @override
  String inviteSentByEmail(String email) {
    return 'Convite enviado por e-mail para $email';
  }

  @override
  String get inviteStatusPending => 'Pendente';

  @override
  String get inviteStatusAccepted => 'Aceito';

  @override
  String get inviteStatusDeclined => 'Recusado';

  @override
  String get inviteStatusExpired => 'Expirado';

  @override
  String get inviteStatusRevoked => 'Revogado';

  @override
  String get inviteGmailAuthTitle => 'Autorizacao Gmail';

  @override
  String get inviteGmailAuthMessage =>
      'Para enviar e-mails de convite, e necessario reautenticar-se com o Google.\n\nDeseja prosseguir?';

  @override
  String get inviteGmailAuthNo => 'Nao, apenas link';

  @override
  String get inviteGmailAuthYes => 'Autorizar';

  @override
  String get inviteGmailNotAvailable =>
      'Autorizacao Gmail nao disponivel. Tente fazer logout e login.';

  @override
  String get inviteGmailNoPermission => 'Permissao Gmail nao concedida.';

  @override
  String get inviteEnterEmail => 'Insira um e-mail';

  @override
  String get inviteInvalidEmail => 'E-mail invalido';

  @override
  String get pendingInvites => 'Convites Pendentes';

  @override
  String get noPendingInvites => 'Nenhum convite pendente';

  @override
  String invitedBy(String name) {
    return 'Convidado por $name';
  }

  @override
  String get inviteOpenInstance => 'Abrir';

  @override
  String get inviteAcceptFirst => 'Aceite o convite para abrir';

  @override
  String get inviteAccept => 'Aceitar';

  @override
  String get inviteDecline => 'Recusar';

  @override
  String get inviteAcceptedSuccess => 'Convite aceito com sucesso!';

  @override
  String get inviteAcceptedError => 'Erro ao aceitar o convite';

  @override
  String get inviteDeclinedSuccess => 'Convite recusado';

  @override
  String get inviteDeclinedError => 'Erro ao recusar o convite';

  @override
  String get inviteDeclineTitle => 'Recusar o convite?';

  @override
  String get inviteDeclineMessage =>
      'Tem certeza de que deseja recusar este convite?';

  @override
  String expiresInHours(int hours) {
    return 'Expira em ${hours}h';
  }

  @override
  String expiresInDays(int days) {
    return 'Expira em ${days}d';
  }

  @override
  String get close => 'Fechar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get raciTitle => 'Matriz RACI';

  @override
  String get raciNoActivities => 'Nenhuma atividade disponivel';

  @override
  String get raciAddActivity => 'Adicionar Atividade';

  @override
  String get raciAddColumn => 'Adicionar Coluna';

  @override
  String get raciActivities => 'ATIVIDADES';

  @override
  String get raciAssignRole => 'Atribuir papel';

  @override
  String get raciNone => 'Nenhum';

  @override
  String get raciSaving => 'Salvando...';

  @override
  String get raciSaveChanges => 'Salvar Alteracoes';

  @override
  String get raciSavedSuccessfully => 'Alteracoes salvas com sucesso';

  @override
  String get raciErrorSaving => 'Erro ao salvar';

  @override
  String get raciMissingAccountable => 'Falta Accountable (A)';

  @override
  String get raciOnlyOneAccountable => 'Apenas um Accountable por atividade';

  @override
  String get raciDuplicateRoles => 'Papeis duplicados';

  @override
  String get raciNoResponsible => 'Nenhum Responsible (R) atribuido';

  @override
  String get raciTooManyInformed => 'Muitos Informed (I): considere reduzir';

  @override
  String get raciNewColumn => 'Nova Coluna';

  @override
  String get raciRemoveColumn => 'Remover coluna';

  @override
  String raciRemoveColumnConfirm(String name) {
    return 'Remover a coluna \"$name\"? Todas as atribuicoes de papel desta coluna serao eliminadas.';
  }

  @override
  String get votingDialogTitle => 'Votar';

  @override
  String votingDialogVoteOf(String participant) {
    return 'Voto de $participant';
  }

  @override
  String get votingDialogUrgency => 'URGENCIA';

  @override
  String get votingDialogImportance => 'IMPORTANCIA';

  @override
  String get votingDialogNotUrgent => 'Nao urgente';

  @override
  String get votingDialogVeryUrgent => 'Muito urgente';

  @override
  String get votingDialogNotImportant => 'Nao importante';

  @override
  String get votingDialogVeryImportant => 'Muito importante';

  @override
  String get votingDialogConfirmVote => 'Confirmar Voto';

  @override
  String get votingDialogQuadrant => 'Quadrante:';

  @override
  String get voteCollectionTitle => 'Coletar Votos';

  @override
  String get voteCollectionParticipants => 'participantes';

  @override
  String get voteCollectionResult => 'Resultado:';

  @override
  String get voteCollectionAverage => 'Media:';

  @override
  String get voteCollectionSaveVotes => 'Salvar Votos';

  @override
  String get scatterChartTitle => 'Distribuicao de Atividades';

  @override
  String get scatterChartNoActivities => 'Nenhuma atividade votada';

  @override
  String get scatterChartVoteToShow =>
      'Vote nas atividades para visualiza-las no grafico';

  @override
  String get scatterChartUrgencyLabel => 'Urgencia:';

  @override
  String get scatterChartImportanceLabel => 'Importancia:';

  @override
  String get scatterChartAxisUrgency => 'URGENCIA';

  @override
  String get scatterChartAxisImportance => 'IMPORTANCIA';

  @override
  String get scatterChartQ1Label => 'Q1 - FACA';

  @override
  String get scatterChartQ2Label => 'Q2 - PLANEJE';

  @override
  String get scatterChartQ3Label => 'Q3 - DELEGUE';

  @override
  String get scatterChartQ4Label => 'Q4 - ELIMINE';

  @override
  String get scatterChartCardTitle => 'Grafico de Distribuicao';

  @override
  String get votingStatusYou => 'Voce';

  @override
  String get votingStatusReset => 'Reset';

  @override
  String get estimationDecimalHintPlaceholder => 'Ex: 2.5';

  @override
  String get estimationDecimalSuffixDays => 'dias';

  @override
  String get estimationDecimalVote => 'Votar';

  @override
  String estimationDecimalVoteValue(String value) {
    return 'Voto: $value dias';
  }

  @override
  String get estimationDecimalQuickSelect => 'Selecao rapida:';

  @override
  String get estimationDecimalEnterValue => 'Insira um valor';

  @override
  String get estimationDecimalInvalidValue => 'Valor invalido';

  @override
  String estimationDecimalMinValue(String value) {
    return 'Min: $value';
  }

  @override
  String estimationDecimalMaxValue(String value) {
    return 'Max: $value';
  }

  @override
  String get estimationThreePointTitle => 'Estimativa a Tres Pontos (PERT)';

  @override
  String get estimationThreePointOptimistic => 'Otimista (O)';

  @override
  String get estimationThreePointRealistic => 'Realista (M)';

  @override
  String get estimationThreePointPessimistic => 'Pessimista (P)';

  @override
  String get estimationThreePointBestCase => 'Melhor caso';

  @override
  String get estimationThreePointMostLikely => 'Mais provavel';

  @override
  String get estimationThreePointWorstCase => 'Pior caso';

  @override
  String get estimationThreePointAllFieldsRequired =>
      'Todos os campos sao obrigatorios';

  @override
  String get estimationThreePointInvalidValues => 'Valores invalidos';

  @override
  String get estimationThreePointOptMustBeLteReal =>
      'Otimista deve ser <= Realista';

  @override
  String get estimationThreePointRealMustBeLtePess =>
      'Realista deve ser <= Pessimista';

  @override
  String get estimationThreePointOptMustBeLtePess =>
      'Otimista deve ser <= Pessimista';

  @override
  String get estimationThreePointGuide => 'Guia:';

  @override
  String get estimationThreePointGuideO =>
      'O: Estimativa no melhor caso (tudo corre bem)';

  @override
  String get estimationThreePointGuideM =>
      'M: Estimativa mais provavel (condicoes normais)';

  @override
  String get estimationThreePointGuideP =>
      'P: Estimativa no pior caso (imprevistos)';

  @override
  String get estimationThreePointStdDev => 'Desv. Pad.';

  @override
  String get estimationThreePointDaysSuffix => 'dd';

  @override
  String get storyFormNewStory => 'Nova Story';

  @override
  String get storyFormEnterTitle => 'Insira um titulo';

  @override
  String get sessionSearchHint => 'Pesquisar sessoes...';

  @override
  String get sessionSearchFilters => 'Filtros';

  @override
  String get sessionSearchFiltersTooltip => 'Filtros';

  @override
  String get sessionSearchStatusLabel => 'Status: ';

  @override
  String get sessionSearchStatusAll => 'Todos';

  @override
  String get sessionSearchStatusDraft => 'Rascunho';

  @override
  String get sessionSearchStatusActive => 'Ativa';

  @override
  String get sessionSearchStatusCompleted => 'Concluida';

  @override
  String get sessionSearchModeLabel => 'Modalidade: ';

  @override
  String get sessionSearchModeAll => 'Todas';

  @override
  String get sessionSearchRemoveFilters => 'Remover filtros';

  @override
  String get sessionSearchActiveFilters => 'Filtros ativos:';

  @override
  String get sessionSearchRemoveAllFilters => 'Remover todos';

  @override
  String participantsTitle(int count) {
    return 'Participantes ($count)';
  }

  @override
  String get participantRoleFacilitator => 'Facilitador';

  @override
  String get participantRoleVoters => 'Votantes';

  @override
  String get participantRoleObservers => 'Observadores';

  @override
  String get votingBoardVotesRevealed => 'Votos Revelados';

  @override
  String get votingBoardVotingInProgress => 'Votacao em Andamento';

  @override
  String votingBoardVotesCount(int voted, int total) {
    return '$voted/$total votos';
  }

  @override
  String get estimationSelectYourEstimate => 'Selecione sua estimativa';

  @override
  String estimationVoteSelected(String value) {
    return 'Voto selecionado: $value';
  }

  @override
  String get estimationDotVotingTitle => 'Dot Voting';

  @override
  String get estimationDotVotingDesc =>
      'Modalidade de votacao com alocacao de pontos.\nEm breve...';

  @override
  String get estimationBucketSystemTitle => 'Bucket System';

  @override
  String get estimationBucketSystemDesc =>
      'Estimativa por afinidade com agrupamento.\nEm breve...';

  @override
  String get estimationModeTitle => 'Modalidade de Estimativa';

  @override
  String get statisticsTitle => 'Estatisticas da Votacao';

  @override
  String get statisticsAverage => 'Media';

  @override
  String get statisticsMedian => 'Mediana';

  @override
  String get statisticsMode => 'Moda';

  @override
  String get statisticsVoters => 'Votantes';

  @override
  String get statisticsPertStats => 'Estatisticas PERT';

  @override
  String get statisticsPertAvg => 'Media PERT';

  @override
  String get statisticsStdDev => 'Desv. Pad.';

  @override
  String get statisticsVariance => 'Variancia';

  @override
  String get statisticsRange => 'Intervalo:';

  @override
  String get statisticsConsensusReached => 'Consenso alcancado!';

  @override
  String get retroGuideTooltip => 'Guia de Retrospectivas';

  @override
  String get retroSearchPlaceholder => 'Pesquisar retrospectiva...';

  @override
  String get retroNoSearchResults => 'Nenhum resultado para a pesquisa';

  @override
  String get retroNewRetro => 'Nova Retrospectiva';

  @override
  String get retroNoProjectsFound => 'Nenhum projeto encontrado.';

  @override
  String retroDeleteMessage(String retroName) {
    return 'Tem certeza de que deseja excluir permanentemente a retrospectiva \"$retroName\"?\n\nEsta acao e irreversivel e excluira todos os dados associados (cards, votos, action items).';
  }

  @override
  String get retroDeletePermanently => 'Excluir permanentemente';

  @override
  String get retroDeletedSuccess => 'Retrospectiva excluida com sucesso';

  @override
  String retroDeleteActionItemsWarning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Questo eliminerà anche $count action item collegati.',
      one: 'Questo eliminerà anche 1 action item collegato.',
    );
    return '$_temp0';
  }

  @override
  String get actionIrreversible => 'Questa azione non può essere annullata.';

  @override
  String get lessonsLearnedSearchPlaceholder => 'Cerca lezioni...';

  @override
  String errorPrefix(String error) {
    return 'Erro: $error';
  }

  @override
  String get loaderProjectIdMissing => 'ID do projeto ausente';

  @override
  String get loaderProjectNotFound => 'Projeto nao encontrado';

  @override
  String get loaderLoadError => 'Erro ao carregar';

  @override
  String get loaderError => 'Erro';

  @override
  String get loaderUnknownError => 'Erro desconhecido';

  @override
  String get actionGoBack => 'Voltar';

  @override
  String get authRequired => 'Autenticacao necessaria';

  @override
  String get retroIdMissing => 'ID da retrospectiva ausente';

  @override
  String get pokerInviteStatusAccepted => 'ja foi aceito';

  @override
  String get pokerInviteStatusDeclined => 'foi recusado';

  @override
  String get pokerInviteStatusExpired => 'expirou';

  @override
  String get pokerInviteStatusRevoked => 'foi revogado';

  @override
  String get pokerInviteStatusPending => 'esta pendente';

  @override
  String get pokerInviteYouAreInvited => 'Voce Foi Convidado!';

  @override
  String pokerInviteInvitedBy(String name) {
    return '$name convidou voce para participar';
  }

  @override
  String get pokerInviteSessionLabel => 'Sessao';

  @override
  String get pokerInviteProjectLabel => 'Projeto';

  @override
  String get pokerInviteRoleLabel => 'Papel Atribuido';

  @override
  String get pokerInviteExpiryLabel => 'Validade do Convite';

  @override
  String pokerInviteExpiryDays(int days) {
    return 'Em $days dias';
  }

  @override
  String get pokerInviteDecline => 'Recusar';

  @override
  String get pokerInviteAccept => 'Aceitar Convite';

  @override
  String loadingMatrixError(String error) {
    return 'Erro ao carregar matriz: $error';
  }

  @override
  String loadingDataError(String error) {
    return 'Erro ao carregar dados: $error';
  }

  @override
  String loadingActivitiesError(String error) {
    return 'Erro ao carregar atividades: $error';
  }

  @override
  String smartTodoSprintDays(int days) {
    return '$days dias/sprint';
  }

  @override
  String smartTodoHoursPerDay(int hours) {
    return '${hours}h/dia';
  }

  @override
  String get smartTodoImageFromClipboardFound =>
      'Imagem encontrada na area de transferencia';

  @override
  String get smartTodoAddImageFromClipboard =>
      'Adicionar imagem da area de transferencia';

  @override
  String get smartTodoInviteCreatedAndSent => 'Convite criado e enviado';

  @override
  String get retroColumnDropDesc =>
      'O que nao agrega valor e deveria ser eliminado?';

  @override
  String get retroColumnAddDesc =>
      'Quais novas praticas deveriamos introduzir?';

  @override
  String get retroColumnKeepDesc =>
      'O que esta funcionando bem e deveria continuar?';

  @override
  String get retroColumnImproveDesc => 'O que podemos fazer melhor?';

  @override
  String get retroColumnStart => 'Iniciar';

  @override
  String get retroColumnStartDesc =>
      'Quais novas atividades ou processos deveriamos iniciar para melhorar?';

  @override
  String get retroColumnStop => 'Parar';

  @override
  String get retroColumnStopDesc =>
      'O que nao esta agregando valor e deveriamos parar de fazer?';

  @override
  String get retroColumnContinue => 'Continuar';

  @override
  String get retroColumnContinueDesc =>
      'O que esta funcionando bem e devemos continuar fazendo?';

  @override
  String get retroColumnLongedFor => 'Desejado';

  @override
  String get retroColumnLikedDesc => 'O que voce gostou neste sprint?';

  @override
  String get retroColumnLearnedDesc => 'O que voce aprendeu de novo?';

  @override
  String get retroColumnLackedDesc => 'O que faltou neste sprint?';

  @override
  String get retroColumnLongedForDesc =>
      'O que voce desejaria ter no futuro proximo?';

  @override
  String get retroColumnMadDesc => 'O que irritou ou frustrou voce?';

  @override
  String get retroColumnSadDesc => 'O que decepcionou ou entristeceu voce?';

  @override
  String get retroColumnGladDesc => 'O que deixou voce feliz ou satisfeito?';

  @override
  String get retroColumnWindDesc =>
      'O que nos impulsionou? Pontos fortes e apoio.';

  @override
  String get retroColumnAnchorDesc =>
      'O que nos atrasou? Obstaculos e bloqueios.';

  @override
  String get retroColumnRockDesc => 'Quais riscos futuros vemos no horizonte?';

  @override
  String get retroColumnGoalDesc => 'Qual e nosso destino ideal?';

  @override
  String get retroColumnMoreDesc => 'O que deveriamos fazer mais?';

  @override
  String get retroColumnLessDesc => 'O que deveriamos fazer menos?';

  @override
  String get actionTypeMaintain => 'Manter';

  @override
  String get actionTypeStop => 'Parar';

  @override
  String get actionTypeBegin => 'Iniciar';

  @override
  String get actionTypeIncrease => 'Aumentar';

  @override
  String get actionTypeDecrease => 'Diminuir';

  @override
  String get actionTypePrevent => 'Prevenir';

  @override
  String get actionTypeCelebrate => 'Celebrar';

  @override
  String get actionTypeReplicate => 'Replicar';

  @override
  String get actionTypeShare => 'Compartilhar';

  @override
  String get actionTypeProvide => 'Fornecer';

  @override
  String get actionTypePlan => 'Planejar';

  @override
  String get actionTypeLeverage => 'Aproveitar';

  @override
  String get actionTypeRemove => 'Remover';

  @override
  String get actionTypeMitigate => 'Mitigar';

  @override
  String get actionTypeAlign => 'Alinhar';

  @override
  String get actionTypeEliminate => 'Eliminar';

  @override
  String get actionTypeImplement => 'Implementar';

  @override
  String get actionTypeEnhance => 'Aprimorar';

  @override
  String get actionItemStatus => 'Status';

  @override
  String get actionStatusOpen => 'Aberto';

  @override
  String get actionStatusInProgress => 'Em Andamento';

  @override
  String get actionStatusCompleted => 'Concluido';

  @override
  String get actionStatusDeferred => 'Adiado';

  @override
  String get retroSectionActive => 'Ativa';

  @override
  String get retroSectionHistory => 'Historico';

  @override
  String get retroSectionActionTracker => 'Action Items';

  @override
  String get retroSectionLessonsLearned => 'Lessons Learned';

  @override
  String get retroNoActiveRetro => 'Nenhuma retrospectiva ativa';

  @override
  String get retroStartNew => 'Nova Retrospectiva';

  @override
  String get retroHistoryEmpty => 'Nenhuma retrospectiva concluida';

  @override
  String get retroViewSummary => 'Ver Resumo';

  @override
  String get retroSummaryTitle => 'Resumo da Retrospectiva';

  @override
  String retroSummaryCards(Object count) {
    return 'Cards ($count)';
  }

  @override
  String retroSummaryActions(Object count) {
    return 'Action Items ($count)';
  }

  @override
  String get retroSummarySentiment => 'Sentimento da Equipe';

  @override
  String get actionTrackerTitle => 'Tracker de Action Items';

  @override
  String get actionTrackerEmpty => 'Nenhum action item nas retrospectivas';

  @override
  String get actionTrackerFilterByAssignee => 'Filtrar por responsavel';

  @override
  String get actionTrackerFilterByStatus => 'Filtrar por status';

  @override
  String get actionTrackerFilterByRetro => 'Filtrar por retrospectiva';

  @override
  String get actionTrackerCompletionRate => 'Taxa de Conclusao';

  @override
  String get actionTrackerCarryForward => 'Levar adiante';

  @override
  String get actionTrackerCarryForwardDesc =>
      'Estes action items de retrospectivas anteriores ainda estao abertos:';

  @override
  String get actionTrackerCarryForwardConfirm =>
      'Levar adiante os elementos selecionados';

  @override
  String get lessonsLearnedTitle => 'Registro de Lessons Learned';

  @override
  String get lessonsLearnedEmpty => 'Nenhuma lesson learned registrada';

  @override
  String get lessonsLearnedCreate => 'Adicionar Lesson Learned';

  @override
  String get lessonsLearnedEdit => 'Editar Lesson Learned';

  @override
  String get lessonsLearnedDelete => 'Excluir Lesson Learned';

  @override
  String get lessonsLearnedDeleteConfirm =>
      'Tem certeza de que deseja excluir esta lesson?';

  @override
  String get lessonCategoryProcess => 'Processo';

  @override
  String get lessonCategoryTechnical => 'Tecnico';

  @override
  String get lessonCategoryTeam => 'Equipe';

  @override
  String get lessonCategoryCommunication => 'Comunicacao';

  @override
  String get lessonCategoryTools => 'Ferramentas';

  @override
  String get lessonCategoryQuality => 'Qualidade';

  @override
  String get lessonCategoryEstimation => 'Estimativa';

  @override
  String get lessonTypeStrength => 'Ponto Forte';

  @override
  String get lessonTypeWeakness => 'Fraqueza';

  @override
  String get lessonTypeRecommendation => 'Recomendacao';

  @override
  String get lessonFieldTitle => 'Titulo';

  @override
  String get lessonFieldDescription => 'Descricao';

  @override
  String get lessonFieldRootCause => 'Causa Raiz';

  @override
  String get lessonFieldRecommendation => 'Recomendacao';

  @override
  String get lessonFieldTags => 'Tags';

  @override
  String get lessonIsRecurring => 'Padrao Recorrente';

  @override
  String lessonOccurrenceCount(Object count) {
    return 'Ocorrencias: $count';
  }

  @override
  String get lessonIsResolved => 'Resolvida';

  @override
  String get generateLessonsTitle => 'Gerar Lessons Learned';

  @override
  String get generateLessonsDesc =>
      'Revise os insights desta retrospectiva e salve-os como lessons learned.';

  @override
  String get generateLessonsFromCards => 'Sugeridos pelos cards';

  @override
  String get generateLessonsFromActions => 'Sugeridos pelos action items';

  @override
  String get generateLessonsSelectToSave =>
      'Selecione os elementos para salvar';

  @override
  String get generateLessonsSave => 'Salvar Lessons Selecionadas';

  @override
  String get retroTrendTitle => 'Tendencia de Melhoria da Equipe';

  @override
  String get retroTrendSentiment => 'Sentimento ao Longo do Tempo';

  @override
  String get retroTrendActionCompletion => 'Taxa de Conclusao de Acoes';

  @override
  String get retroTrendImproving => 'A equipe esta melhorando!';

  @override
  String get retroTrendStable => 'Desempenho estavel';

  @override
  String get retroTrendDeclining => 'Atencao necessaria';

  @override
  String get crossProjectImport => 'Importar de Outros Projetos';

  @override
  String get crossProjectImportActions => 'Importar Action Items';

  @override
  String get crossProjectImportLessons => 'Importar Lessons Learned';

  @override
  String get crossProjectSelectProject => 'Selecionar Projeto';

  @override
  String get crossProjectNoProjects => 'Nenhum outro projeto encontrado';

  @override
  String crossProjectImportSuccess(Object count) {
    return '$count elementos importados com sucesso';
  }

  @override
  String get crossProjectAggregatedView => 'Lessons Cross-Projeto';

  @override
  String get tooltipTrackerStatusClick => 'Clique para alterar o status';

  @override
  String get tooltipTrackerFilterStatus => 'Filtre as acoes pelo status atual';

  @override
  String get tooltipTrackerFilterAssignee =>
      'Filtre por pessoa responsavel pela acao';

  @override
  String get tooltipTrackerFilterRetro => 'Filtre por retrospectiva de origem';

  @override
  String get tooltipTrackerCompletionRate =>
      'Porcentagem de todas as acoes concluidas';

  @override
  String get tooltipTrackerOverdue =>
      'Esta acao ultrapassou a data de vencimento';

  @override
  String get tooltipPriorityCritical =>
      'Critica: Deve ser tratada imediatamente';

  @override
  String get tooltipPriorityHigh => 'Alta: Deve ser tratada dentro do sprint';

  @override
  String get tooltipPriorityMedium =>
      'Media: Deve ser planejada para os proximos sprints';

  @override
  String get tooltipPriorityLow => 'Baixa: Deve ser tratada quando possivel';

  @override
  String get tooltipLessonCategoryFilter =>
      'Filtre as licoes por area de impacto';

  @override
  String get tooltipLessonTypeFilter =>
      'Filtre por tipo: ponto forte, fraqueza ou recomendacao';

  @override
  String get tooltipLessonResolvedFilter =>
      'Mostre todas, apenas nao resolvidas ou apenas resolvidas';

  @override
  String get tooltipLessonRecurring =>
      'Esta licao foi observada varias vezes nas retrospectivas';

  @override
  String get tooltipLessonResolved => 'Esta licao foi tratada e resolvida';

  @override
  String get tooltipLessonImport =>
      'Importe licoes aprendidas de outros projetos dos quais voce e proprietario';

  @override
  String get tooltipLessonAdd =>
      'Registre uma nova licao aprendida para este projeto';

  @override
  String get tooltipLessonLongPressDelete =>
      'Mantenha pressionado em uma licao para exclui-la';

  @override
  String get tooltipCarryForwardDesc =>
      'Leve as acoes nao concluidas das retrospectivas anteriores para a nova';

  @override
  String get tooltipCarryForwardSelectAll =>
      'Selecione ou desselecione todas as acoes pendentes';

  @override
  String get tooltipCrossProjectImportDesc =>
      'As licoes serao copiadas para o projeto atual com referencia a fonte';

  @override
  String get tooltipTrendSentiment =>
      'Pontuacao media do sentimento da equipe (1-5) ao longo do tempo';

  @override
  String get tooltipTrendCompletion =>
      'Porcentagem de acoes concluidas por retrospectiva ao longo do tempo';

  @override
  String get tooltipTrendImproving => 'As metricas da equipe estao melhorando';

  @override
  String get tooltipTrendDeclining =>
      'As metricas da equipe estao em declinio - considere tratar as causas';

  @override
  String get tooltipTrendStable =>
      'As metricas da equipe estao estaveis nas retrospectivas recentes';

  @override
  String get tooltipHistoryRetroCard =>
      'Clique para ver o resumo completo da retrospectiva';

  @override
  String get tooltipHistorySentiment =>
      'Sentimento medio da equipe para esta retrospectiva';

  @override
  String get tooltipHistoryActionCount =>
      'Acoes concluidas vs totais desta retrospectiva';

  @override
  String get tooltipFormRootCause =>
      'Descreva a causa subjacente que levou a esta observacao';

  @override
  String get tooltipFormRecommendation =>
      'Sugira acoes concretas para tratar ou replicar esta descoberta';

  @override
  String get tooltipFormTags =>
      'Adicione tags separadas por virgula para categorizar e pesquisar';

  @override
  String get tooltipFormRecurring =>
      'Ative se esta licao apareceu em varias retrospectivas';

  @override
  String get tooltipFormResolved =>
      'Marque como resolvida quando a equipe tiver tratado esta licao';

  @override
  String get guideActionTrackingTitle => 'Melhores Praticas para Acoes';

  @override
  String get guideActionTrackingDesc =>
      'Use os criterios SMART: Especifico, Mensuravel, Atingivel, Relevante, Temporal. Atribua um unico responsavel, defina um prazo dentro do sprint e verifique o progresso na proxima retrospectiva.';

  @override
  String get guideLessonsLearnedTitle => 'Framework de Licoes Aprendidas';

  @override
  String get guideLessonsLearnedDesc =>
      'Capture tanto os pontos fortes (para replicar) quanto as fraquezas (para melhorar). Documente as causas raiz e as recomendacoes. Tagueie as licoes para reutilizacao cross-projeto e marque como resolvidas quando tratadas.';

  @override
  String get guideContinuousImprovementTitle => 'Ciclo de Melhoria Continua';

  @override
  String get guideContinuousImprovementDesc =>
      'Monitore as tendencias nas retrospectivas para medir o progresso. Leve adiante as acoes nao concluidas. Importe licoes de outros projetos. Concentre-se em mudancas sistemicas em vez de correcoes individuais.';

  @override
  String get guideCarryForwardTitle => 'Processo de Carry Forward';

  @override
  String get guideCarryForwardDesc =>
      'Ao criar uma nova retrospectiva, revise as acoes abertas e em andamento das anteriores. Leve adiante os itens ainda relevantes e repriorize-os no novo contexto.';

  @override
  String retroFromSprint(Object name) {
    return 'De: Sprint $name';
  }

  @override
  String actionItemsCompleted(Object completed, Object total) {
    return '$completed/$total concluidos';
  }

  @override
  String get coachTipSSCWriting =>
      'Concentre-se em comportamentos concretos e observaveis. Cada item deve ser algo em que a equipe possa agir diretamente. Evite afirmacoes vagas.';

  @override
  String get coachTipSSCVoting =>
      'Vote com base no impacto e na viabilidade. Os itens mais votados se tornarao os compromissos do proximo sprint.';

  @override
  String get coachTipSSCDiscuss =>
      'Para cada item mais votado, defina QUEM fara O QUE ate QUANDO. Transforme insights em acoes especificas.';

  @override
  String get coachTipMSGWriting =>
      'Crie um espaco seguro para emocoes. Todos os sentimentos sao validos. Concentre-se na situacao, nao na pessoa. Use afirmacoes do tipo \'Eu sinto...\'.';

  @override
  String get coachTipMSGVoting =>
      'Vote para identificar experiencias compartilhadas. Os padroes nas emocoes revelam dinamicas de equipe que precisam de atencao.';

  @override
  String get coachTipMSGDiscuss =>
      'Reconheca as emocoes antes de resolver problemas. Pergunte \'O que ajudaria?\' em vez de pular para solucoes. Ouca ativamente.';

  @override
  String get coachTip4LsWriting =>
      'Reflita sobre os aprendizados, nao apenas sobre os eventos. Pense em quais insights voce levara adiante. Cada L representa uma perspectiva diferente.';

  @override
  String get coachTip4LsVoting =>
      'Priorize os aprendizados que podem melhorar os sprints futuros. Concentre-se no conhecimento transferivel.';

  @override
  String get coachTip4LsDiscuss =>
      'Transforme os aprendizados em documentacao ou mudancas de processo. Pergunte \'Como podemos compartilhar este conhecimento com outros?\'';

  @override
  String get coachTipSailboatWriting =>
      'Use a metafora: o Vento nos impulsiona (habilitadores), as Ancoras nos atrasam (bloqueadores), as Rochas sao riscos futuros, a Ilha e nosso objetivo.';

  @override
  String get coachTipSailboatVoting =>
      'Priorize com base no impacto do risco e no potencial dos habilitadores. Equilibre tratar bloqueadores com aproveitar pontos fortes.';

  @override
  String get coachTipSailboatDiscuss =>
      'Crie um registro de riscos para as rochas. Defina estrategias de mitigacao. Aproveite os ventos para superar as ancoras.';

  @override
  String get coachTipDAKIWriting =>
      'Seja decisivo: Elimine o que despertica tempo, Adicione o que falta, Mantenha o que funciona, Melhore o que poderia ser melhor.';

  @override
  String get coachTipDAKIVoting =>
      'Vote pragmaticamente. Concentre-se nas mudancas que terao impacto imediato e mensuravel.';

  @override
  String get coachTipDAKIDiscuss =>
      'Tome decisoes claras como equipe. Para cada item, comprometa-se com uma acao especifica ou decida explicitamente nao agir.';

  @override
  String get coachTipStarfishWriting =>
      'Use as graduacoes: Manter (como esta), Mais (aumentar), Menos (diminuir), Parar (eliminar), Iniciar (comecar). Isso permite feedback com nuances.';

  @override
  String get coachTipStarfishVoting =>
      'Considere esforco vs impacto. Itens \'Mais\' e \'Menos\' podem ser mais faceis de implementar do que \'Iniciar\' e \'Parar\'.';

  @override
  String get coachTipStarfishDiscuss =>
      'Defina metricas especificas para \'mais\' e \'menos\'. Quanto mais? Como mediremos? Estabeleca metas de calibracao claras.';

  @override
  String get discussPromptSSCStart =>
      'Qual nova pratica deveriamos comecar? Pense nas lacunas no nosso processo que um novo habito poderia preencher.';

  @override
  String get discussPromptSSCStop =>
      'O que despertica nosso tempo ou energia? Considere atividades que nao trazem valor proporcional ao seu custo.';

  @override
  String get discussPromptSSCContinue =>
      'O que esta funcionando bem? Reconheca e reforca as praticas eficazes.';

  @override
  String get discussPromptMSGMad =>
      'O que frustrou voce? Lembre-se, estamos discutindo situacoes, nao culpando individuos.';

  @override
  String get discussPromptMSGSad =>
      'O que decepcionou voce? Quais expectativas nao foram atendidas?';

  @override
  String get discussPromptMSGGlad =>
      'O que deixou voce feliz? Quais momentos trouxeram satisfacao neste sprint?';

  @override
  String get discussPrompt4LsLiked =>
      'O que voce gostou? O que tornou o trabalho agradavel?';

  @override
  String get discussPrompt4LsLearned =>
      'Qual nova competencia, insight ou conhecimento voce adquiriu?';

  @override
  String get discussPrompt4LsLacked =>
      'O que faltou? Quais recursos, apoio ou clareza teriam ajudado?';

  @override
  String get discussPrompt4LsLonged =>
      'O que voce deseja? O que tornaria os sprints futuros melhores?';

  @override
  String get discussPromptSailboatWind =>
      'O que nos impulsionou? Quais sao nossos pontos fortes e apoio externo?';

  @override
  String get discussPromptSailboatAnchor =>
      'O que nos atrasou? Quais obstaculos internos ou externos nos frearam?';

  @override
  String get discussPromptSailboatRock =>
      'Quais riscos vemos no horizonte? O que poderia nos desviar se nao for tratado?';

  @override
  String get discussPromptSailboatGoal =>
      'Qual e nosso destino? Estamos alinhados sobre para onde estamos indo?';

  @override
  String get discussPromptDAKIDrop =>
      'O que deveriamos eliminar? O que nao agrega valor?';

  @override
  String get discussPromptDAKIAdd =>
      'O que deveriamos introduzir? O que esta faltando no nosso toolkit?';

  @override
  String get discussPromptDAKIKeep =>
      'O que devemos preservar? O que e essencial para nosso sucesso?';

  @override
  String get discussPromptDAKIImprove =>
      'O que poderia ser melhor? Onde podemos melhorar?';

  @override
  String get discussPromptStarfishKeep =>
      'O que deveriamos manter exatamente como esta?';

  @override
  String get discussPromptStarfishMore =>
      'O que deveriamos aumentar? Fazer mais?';

  @override
  String get discussPromptStarfishLess =>
      'O que deveriamos reduzir? Fazer menos?';

  @override
  String get discussPromptStarfishStop =>
      'O que deveriamos eliminar completamente?';

  @override
  String get discussPromptStarfishStart =>
      'Qual nova coisa deveriamos comecar?';

  @override
  String get discussPromptGeneric =>
      'Quais insights surgiram desta coluna? Quais padroes voce ve?';

  @override
  String get smartPromptSSCStartQuestion =>
      'Qual pratica nova especifica voce comecara, e como medira sua adocao?';

  @override
  String get smartPromptSSCStartExample =>
      'ex., \'Comecar standup diario de 15 min as 9:30, rastrear presencas por 2 semanas\'';

  @override
  String get smartPromptSSCStartPlaceholder =>
      'Comecaremos [pratica especifica] ate [data], medida por [metrica]';

  @override
  String get smartPromptSSCStopQuestion =>
      'O que voce vai parar de fazer, e o que fara no lugar?';

  @override
  String get smartPromptSSCStopExample =>
      'ex., \'Parar de enviar atualizacoes de status por e-mail, usar o canal Slack #updates\'';

  @override
  String get smartPromptSSCStopPlaceholder =>
      'Pararemos de fazer [pratica] e em vez disso [alternativa]';

  @override
  String get smartPromptSSCContinueQuestion =>
      'Qual pratica voce continuara, e como garantira que nao desapareca?';

  @override
  String get smartPromptSSCContinueExample =>
      'ex., \'Continuar code review em 4 horas, adicionar a Definition of Done\'';

  @override
  String get smartPromptSSCContinuePlaceholder =>
      'Continuaremos [pratica], reforcada por [mecanismo]';

  @override
  String get smartPromptMSGMadQuestion =>
      'Qual acao trataria desta frustracao e quem a liderara?';

  @override
  String get smartPromptMSGMadExample =>
      'ex., \'Agendar reuniao com PM para esclarecer processo de requisitos - Maria ate sexta\'';

  @override
  String get smartPromptMSGMadPlaceholder =>
      '[Acao para tratar frustracao], responsavel: [nome], ate: [data]';

  @override
  String get smartPromptMSGSadQuestion =>
      'Qual mudanca impediria que esta decepcao se repetisse?';

  @override
  String get smartPromptMSGSadExample =>
      'ex., \'Criar checklist de comunicacao para atualizacoes de stakeholders - revisao semanal\'';

  @override
  String get smartPromptMSGSadPlaceholder =>
      '[Acao preventiva], rastreada via [metodo]';

  @override
  String get smartPromptMSGGladQuestion =>
      'Como podemos replicar ou amplificar o que nos deixou felizes?';

  @override
  String get smartPromptMSGGladExample =>
      'ex., \'Documentar formato de sessao de pair e compartilhar com outras equipes ate fim da semana\'';

  @override
  String get smartPromptMSGGladPlaceholder =>
      '[Acao para replicar/amplificar], compartilhar com [audiencia]';

  @override
  String get smartPrompt4LsLikedQuestion =>
      'Como podemos garantir que esta experiencia positiva continue?';

  @override
  String get smartPrompt4LsLikedExample =>
      'ex., \'Tornar a sessao de mob programming um evento recorrente semanal no calendario\'';

  @override
  String get smartPrompt4LsLikedPlaceholder =>
      '[Acao para preservar experiencia positiva]';

  @override
  String get smartPrompt4LsLearnedQuestion =>
      'Como voce documentara e compartilhara este aprendizado?';

  @override
  String get smartPrompt4LsLearnedExample =>
      'ex., \'Escrever artigo wiki sobre nova abordagem de testes, apresentar em tech talk no proximo mes\'';

  @override
  String get smartPrompt4LsLearnedPlaceholder =>
      'Documentar em [local], compartilhar via [metodo] ate [data]';

  @override
  String get smartPrompt4LsLackedQuestion =>
      'Quais recursos ou apoio especificos voce solicitara e a quem?';

  @override
  String get smartPrompt4LsLackedExample =>
      'ex., \'Solicitar orcamento de treinamento CI/CD ao gerente - enviar ate proximo planning\'';

  @override
  String get smartPrompt4LsLackedPlaceholder =>
      'Solicitar [recurso] de [pessoa/equipe], prazo: [data]';

  @override
  String get smartPrompt4LsLongedQuestion =>
      'Qual primeiro passo concreto te aproximara deste desejo?';

  @override
  String get smartPrompt4LsLongedExample =>
      'ex., \'Rascunho de proposta para 20% tempo para projetos paralelos - compartilhar com team lead na segunda\'';

  @override
  String get smartPrompt4LsLongedPlaceholder =>
      'Primeiro passo para [desejo]: [acao] ate [data]';

  @override
  String get smartPromptSailboatWindQuestion =>
      'Como voce aproveitara este habilitador para acelerar o progresso?';

  @override
  String get smartPromptSailboatWindExample =>
      'ex., \'Usar forte competencia QA para mentoring de juniores - agendar primeira sessao esta semana\'';

  @override
  String get smartPromptSailboatWindPlaceholder =>
      'Aproveitar [habilitador] com [acao especifica]';

  @override
  String get smartPromptSailboatAnchorQuestion =>
      'Qual acao especifica removera ou reduzira este bloqueador?';

  @override
  String get smartPromptSailboatAnchorExample =>
      'ex., \'Escalar problema de infraestrutura ao CTO - preparar brief ate quarta\'';

  @override
  String get smartPromptSailboatAnchorPlaceholder =>
      'Remover [bloqueador] com [acao], escalar para [pessoa] se necessario';

  @override
  String get smartPromptSailboatRockQuestion =>
      'Qual estrategia de mitigacao voce implementara para este risco?';

  @override
  String get smartPromptSailboatRockExample =>
      'ex., \'Adicionar plano de contingencia para dependencia de fornecedor - documentar alternativas ate fim do sprint\'';

  @override
  String get smartPromptSailboatRockPlaceholder =>
      'Mitigar [risco] com [estrategia], gatilho: [condicao]';

  @override
  String get smartPromptSailboatGoalQuestion =>
      'Qual marco confirmara o progresso em direcao a este objetivo?';

  @override
  String get smartPromptSailboatGoalExample =>
      'ex., \'Demo do MVP para stakeholders ate 15 Fev, coletar feedback via pesquisa\'';

  @override
  String get smartPromptSailboatGoalPlaceholder =>
      'Marco para [objetivo]: [entregavel] ate [data]';

  @override
  String get smartPromptDAKIDropQuestion =>
      'O que voce eliminara e como garantira que nao volte?';

  @override
  String get smartPromptDAKIDropExample =>
      'ex., \'Remover etapas manuais de deploy - automatizar ate fim do sprint\'';

  @override
  String get smartPromptDAKIDropPlaceholder =>
      'Eliminar [pratica], prevenir retorno com [mecanismo]';

  @override
  String get smartPromptDAKIAddQuestion =>
      'Qual nova pratica voce introduzira e como validara que funciona?';

  @override
  String get smartPromptDAKIAddExample =>
      'ex., \'Adicionar sistema de feature flag - testar em 2 features, revisar resultados em 2 semanas\'';

  @override
  String get smartPromptDAKIAddPlaceholder =>
      'Adicionar [pratica], validar sucesso via [metrica]';

  @override
  String get smartPromptDAKIKeepQuestion =>
      'Como voce protegera esta pratica de ser despriorizada?';

  @override
  String get smartPromptDAKIKeepExample =>
      'ex., \'Manter padrao de code review - adicionar ao team charter, auditoria mensal\'';

  @override
  String get smartPromptDAKIKeepPlaceholder =>
      'Proteger [pratica] com [mecanismo]';

  @override
  String get smartPromptDAKIImproveQuestion =>
      'Qual melhoria especifica voce fara e como medira o progresso?';

  @override
  String get smartPromptDAKIImproveExample =>
      'ex., \'Melhorar cobertura de testes de 60% para 80% - foco no modulo de pagamentos primeiro\'';

  @override
  String get smartPromptDAKIImprovePlaceholder =>
      'Melhorar [pratica] de [atual] para [meta] ate [data]';

  @override
  String get smartPromptStarfishKeepQuestion =>
      'Qual pratica voce mantera e quem e o responsavel para garantir consistencia?';

  @override
  String get smartPromptStarfishKeepExample =>
      'ex., \'Manter demo de sexta - Tom garante sala reservada, agenda compartilhada ate quinta\'';

  @override
  String get smartPromptStarfishKeepPlaceholder =>
      'Manter [pratica], responsavel: [nome]';

  @override
  String get smartPromptStarfishMoreQuestion =>
      'O que voce aumentara e em quanto?';

  @override
  String get smartPromptStarfishMoreExample =>
      'ex., \'Aumentar pair programming de 2h para 6h por semana por desenvolvedor\'';

  @override
  String get smartPromptStarfishMorePlaceholder =>
      'Aumentar [pratica] de [nivel atual] para [nivel meta]';

  @override
  String get smartPromptStarfishLessQuestion =>
      'O que voce reduzira e em quanto?';

  @override
  String get smartPromptStarfishLessExample =>
      'ex., \'Reduzir reunioes de 10h para 6h por semana - cancelar review recorrente\'';

  @override
  String get smartPromptStarfishLessPlaceholder =>
      'Reduzir [pratica] de [nivel atual] para [nivel meta]';

  @override
  String get smartPromptStarfishStopQuestion =>
      'O que voce parara completamente de fazer e o que substitui (se algo)?';

  @override
  String get smartPromptStarfishStopExample =>
      'ex., \'Parar rastreamento detalhado de tempo em tarefas - estimativas baseadas em confianca\'';

  @override
  String get smartPromptStarfishStopPlaceholder =>
      'Parar [pratica], substituir por [alternativa] ou nada';

  @override
  String get smartPromptStarfishStartQuestion =>
      'Qual nova pratica voce comecara e quando sera a primeira ocorrencia?';

  @override
  String get smartPromptStarfishStartExample =>
      'ex., \'Comecar tech debt Tuesday - primeira sessao proxima semana, 2h tempo protegido\'';

  @override
  String get smartPromptStarfishStartPlaceholder =>
      'Comecar [pratica], primeira ocorrencia: [data/hora]';

  @override
  String get smartPromptGenericQuestion =>
      'Qual acao especifica tratara deste item?';

  @override
  String get smartPromptGenericExample =>
      'ex., \'Definir acao especifica com responsavel, prazo e criterios de sucesso\'';

  @override
  String get smartPromptGenericPlaceholder =>
      '[Acao], responsavel: [nome], ate: [data]';

  @override
  String get methodologyFocusAction =>
      'Orientado a acao: concentra-se em mudancas comportamentais concretas';

  @override
  String get methodologyFocusEmotion =>
      'Focado em emocoes: explora os sentimentos da equipe para construir seguranca psicologica';

  @override
  String get methodologyFocusLearning =>
      'Reflexivo sobre aprendizado: enfatiza a captura e compartilhamento de conhecimento';

  @override
  String get methodologyFocusRisk =>
      'Risco e Objetivo: equilibra habilitadores, bloqueadores, riscos e objetivos';

  @override
  String get methodologyFocusCalibration =>
      'Calibracao: usa graduacoes (mais/menos) para ajustes com nuances';

  @override
  String get methodologyFocusDecision =>
      'Decisorio: guia decisoes claras da equipe sobre praticas';

  @override
  String get exportSheetOverview => 'Panorama';

  @override
  String get exportSheetActionItems => 'Acoes';

  @override
  String get exportSheetBoardItems => 'Elementos do Board';

  @override
  String get exportSheetTeamHealth => 'Saude da Equipe';

  @override
  String get exportSheetLessonsLearned => 'Licoes Aprendidas';

  @override
  String get exportSheetRiskRegister => 'Registro de Riscos';

  @override
  String get exportSheetCalibrationMatrix => 'Matriz de Calibracao';

  @override
  String get exportSheetDecisionLog => 'Registro de Decisoes';

  @override
  String get exportHeaderRetrospectiveReport => 'RELATORIO DA RETROSPECTIVA';

  @override
  String get exportHeaderTitle => 'Titulo:';

  @override
  String get exportHeaderDate => 'Data:';

  @override
  String get exportHeaderTemplate => 'Template:';

  @override
  String get exportHeaderMethodology => 'Foco Metodologico:';

  @override
  String get exportHeaderSentiments => 'Sentimentos (Media):';

  @override
  String get exportHeaderParticipants => 'PARTICIPANTES';

  @override
  String get exportHeaderSummary => 'RESUMO';

  @override
  String get exportHeaderTotalItems => 'Elementos Totais:';

  @override
  String get exportHeaderActionItems => 'Acoes:';

  @override
  String get exportHeaderSuggestedFollowUp => 'Acompanhamento Sugerido:';

  @override
  String get exportTeamHealthTitle => 'ANALISE DE SAUDE DA EQUIPE';

  @override
  String get exportTeamHealthEmotionalDistribution => 'Distribuicao Emocional';

  @override
  String get exportTeamHealthMadCount => 'Elementos Mad:';

  @override
  String get exportTeamHealthSadCount => 'Elementos Sad:';

  @override
  String get exportTeamHealthGladCount => 'Elementos Glad:';

  @override
  String get exportTeamHealthMadItems => 'FRUSTRACOES (Mad)';

  @override
  String get exportTeamHealthSadItems => 'DECEPCOES (Sad)';

  @override
  String get exportTeamHealthGladItems => 'CELEBRACOES (Glad)';

  @override
  String get exportTeamHealthRecommendation =>
      'Recomendacao de Saude da Equipe:';

  @override
  String get exportTeamHealthHighFrustration =>
      'Alto nivel de frustracao detectado. Considere facilitar uma sessao focada na resolucao de problemas.';

  @override
  String get exportTeamHealthBalanced =>
      'Estado emocional equilibrado. A equipe demonstra capacidades saudaveis de reflexao.';

  @override
  String get exportTeamHealthPositive =>
      'Moral da equipe positivo. Aproveite essa energia para melhorias desafiadoras.';

  @override
  String get exportLessonsLearnedTitle => 'REGISTRO DE LICOES APRENDIDAS';

  @override
  String get exportLessonsLearnedWhatWorked => 'O QUE FUNCIONOU (Liked)';

  @override
  String get exportLessonsLearnedNewSkills =>
      'NOVAS COMPETENCIAS E INSIGHTS (Learned)';

  @override
  String get exportLessonsLearnedGaps =>
      'LACUNAS E ELEMENTOS FALTANTES (Lacked)';

  @override
  String get exportLessonsLearnedWishes => 'ASPIRACOES FUTURAS (Longed For)';

  @override
  String get exportLessonsLearnedKnowledgeActions =>
      'Acoes de Compartilhamento de Conhecimento';

  @override
  String get exportLessonsLearnedDocumentationNeeded =>
      'Documentacao Necessaria:';

  @override
  String get exportLessonsLearnedTrainingNeeded =>
      'Treinamento/Compartilhamento Necessario:';

  @override
  String get exportRiskRegisterTitle => 'REGISTRO DE RISCOS E HABILITADORES';

  @override
  String get exportRiskRegisterEnablers => 'HABILITADORES (Vento)';

  @override
  String get exportRiskRegisterBlockers => 'BLOQUEADORES (Ancora)';

  @override
  String get exportRiskRegisterRisks => 'RISCOS (Rochas)';

  @override
  String get exportRiskRegisterGoals => 'OBJETIVOS (Ilha)';

  @override
  String get exportRiskRegisterRiskItem => 'Risco';

  @override
  String get exportRiskRegisterImpact => 'Impacto Potencial';

  @override
  String get exportRiskRegisterMitigation => 'Acao de Mitigacao';

  @override
  String get exportRiskRegisterStatus => 'Status';

  @override
  String get exportRiskRegisterGoalAlignment =>
      'Verificacao de Alinhamento com Objetivos:';

  @override
  String get exportRiskRegisterGoalAlignmentNote =>
      'Verificar se as acoes atuais estao alinhadas com os objetivos declarados.';

  @override
  String get exportCalibrationTitle => 'MATRIZ DE CALIBRACAO';

  @override
  String get exportCalibrationKeepDoing => 'CONTINUAR FAZENDO';

  @override
  String get exportCalibrationDoMore => 'FAZER MAIS';

  @override
  String get exportCalibrationDoLess => 'FAZER MENOS';

  @override
  String get exportCalibrationStopDoing => 'PARAR DE FAZER';

  @override
  String get exportCalibrationStartDoing => 'COMECAR A FAZER';

  @override
  String get exportCalibrationPractice => 'Pratica';

  @override
  String get exportCalibrationCurrentState => 'Estado Atual';

  @override
  String get exportCalibrationTargetState => 'Estado Objetivo';

  @override
  String get exportCalibrationAdjustment => 'Ajuste';

  @override
  String get exportCalibrationNote =>
      'A calibracao se concentra no ajuste fino das praticas existentes em vez de mudancas radicais.';

  @override
  String get exportDecisionLogTitle => 'REGISTRO DE DECISOES';

  @override
  String get exportDecisionLogDrop => 'DECISOES A ABANDONAR';

  @override
  String get exportDecisionLogAdd => 'DECISOES A ADICIONAR';

  @override
  String get exportDecisionLogKeep => 'DECISOES A MANTER';

  @override
  String get exportDecisionLogImprove => 'DECISOES A MELHORAR';

  @override
  String get exportDecisionLogDecision => 'Decisao';

  @override
  String get exportDecisionLogRationale => 'Justificativa';

  @override
  String get exportDecisionLogOwner => 'Responsavel';

  @override
  String get exportDecisionLogDeadline => 'Prazo';

  @override
  String get exportDecisionLogPrioritizationNote =>
      'Recomendacao de Prioridade:';

  @override
  String get exportDecisionLogPrioritizationHint =>
      'Concentrar-se primeiro nas decisoes DROP para liberar capacidade, depois adicionar novas praticas.';

  @override
  String get exportNoItems => 'Nenhum elemento registrado';

  @override
  String get exportNoActionItems => 'Nenhuma acao';

  @override
  String get exportNotApplicable => 'N/D';

  @override
  String get facilitatorGuideTitle => 'Guia de Coleta de Acoes';

  @override
  String get facilitatorGuideCoverage => 'Cobertura';

  @override
  String get facilitatorGuideComplete => 'Completa';

  @override
  String get facilitatorGuideIncomplete => 'Incompleta';

  @override
  String get facilitatorGuideSuggestedOrder => 'Ordem Sugerida:';

  @override
  String get facilitatorGuideMissingRequired => 'Acoes obrigatorias faltando';

  @override
  String get facilitatorGuideColumnHasAction => 'Tem acao';

  @override
  String get facilitatorGuideColumnNoAction => 'Nenhuma acao';

  @override
  String get facilitatorGuideRequired => 'Obrigatorio';

  @override
  String get facilitatorGuideOptional => 'Opcional';

  @override
  String get agileEdit => 'Editar';

  @override
  String get agileSettings => 'Configuracoes';

  @override
  String get agileDelete => 'Excluir';

  @override
  String get agileDeleteProjectTitle => 'Excluir Projeto';

  @override
  String agileDeleteProjectConfirm(String projectName) {
    return 'Tem certeza de que deseja excluir \"$projectName\"?';
  }

  @override
  String get agileDeleteProjectWarning => 'Esta acao excluira permanentemente:';

  @override
  String agileDeleteWarningUserStories(int count) {
    return '$count user stories';
  }

  @override
  String agileDeleteWarningSprints(int count) {
    return '$count sprints';
  }

  @override
  String get agileDeleteProjectData => 'Todos os dados do projeto';

  @override
  String get agileProjectSettingsTitle => 'Configuracoes do Projeto';

  @override
  String get agileKeyRoles => 'Papeis Chave';

  @override
  String get agileKeyRolesSubtitle =>
      'Atribua os papeis principais da equipe Scrum';

  @override
  String get agileRoleProductOwner => 'Product Owner';

  @override
  String get agileRoleProductOwnerDesc =>
      'Gerencia o backlog e define as prioridades do produto';

  @override
  String get agileRoleScrumMaster => 'Scrum Master';

  @override
  String get agileRoleScrumMasterDesc =>
      'Facilita o processo Scrum e remove obstaculos';

  @override
  String get agileRoleDevTeam => 'Development Team';

  @override
  String get agileNoDevTeamMembers =>
      'Nenhum membro na equipe. Clique + para adicionar.';

  @override
  String get agileRolesInfo =>
      'Os papeis serao exibidos com icones dedicados na lista de projetos. Voce pode adicionar outros participantes a partir da Equipe do projeto.';

  @override
  String agileAssignedTo(String name) {
    return 'Atribuido a $name';
  }

  @override
  String get agileUnassigned => 'Nao atribuido';

  @override
  String get agileAssignableLater => 'Atribuivel apos a criacao';

  @override
  String get agileAddToTeam => 'Adicionar a Equipe';

  @override
  String get agileAllMembersAssigned =>
      'Todos os participantes ja estao atribuidos a um papel.';

  @override
  String get agileClose => 'Fechar';

  @override
  String get agileProjectNameLabel => 'Nome do Projeto *';

  @override
  String get agileProjectNameHint => 'Ex: Fashion PMO v2';

  @override
  String get agileEnterProjectName => 'Insira o nome do projeto';

  @override
  String get agileProjectDescLabel => 'Descricao';

  @override
  String get agileProjectDescHint => 'Descricao opcional do projeto';

  @override
  String get agileFrameworkLabel => 'Framework Agile';

  @override
  String get agileDiscoverDifferences => 'Descubra as diferencas';

  @override
  String get agileSprintConfig => 'Configuracao do Sprint';

  @override
  String get agileSprintDuration => 'Duracao do Sprint (dias)';

  @override
  String get agileHoursPerDay => 'Horas/Dia';

  @override
  String get agileCreateProjectTitle => 'Novo Projeto Agile';

  @override
  String get agileEditProjectTitle => 'Editar Projeto';

  @override
  String get agileSelectParticipant => 'Selecionar participante';

  @override
  String get agileAssignRolesHint =>
      'Atribua os papeis principais.\nVoce podera modifica-los tambem nas configuracoes.';

  @override
  String get agileArchiveAction => 'Arquivar';

  @override
  String get agileRestoreAction => 'Restaurar';

  @override
  String get agileSetupTitle => 'Setup do Projeto';

  @override
  String agileStepComplete(int completed, int total) {
    return '$completed de $total passos concluidos';
  }

  @override
  String get agileSetupCompleteTitle => 'Setup Concluido!';

  @override
  String get agileSetupCompleteMessage =>
      'Seu projeto esta pronto para comecar.';

  @override
  String get agileChecklistAddMembers => 'Adicionar membros a equipe';

  @override
  String get agileChecklistAddMembersDesc =>
      'Convide membros da equipe para colaborar';

  @override
  String get agileChecklistInvite => 'Convidar';

  @override
  String agileChecklistCreateStories(String itemType) {
    return 'Criar as primeiras $itemType';
  }

  @override
  String get agileChecklistAddItems => 'Adicione pelo menos 3 itens ao backlog';

  @override
  String get agileChecklistAdd => 'Adicionar';

  @override
  String get agileChecklistWipLimits => 'Configurar os WIP limits';

  @override
  String get agileChecklistWipLimitsDesc =>
      'Defina limites para cada coluna Kanban';

  @override
  String get agileChecklistConfigure => 'Configurar';

  @override
  String agileChecklistEstimate(String itemType) {
    return 'Estimar as $itemType';
  }

  @override
  String get agileChecklistEstimateDesc =>
      'Atribua Story Points para planejar melhor';

  @override
  String get agileChecklistCreateSprint => 'Criar o primeiro Sprint';

  @override
  String get agileChecklistSprintDesc =>
      'Selecione as stories e comece a trabalhar';

  @override
  String get agileChecklistCreateSprintAction => 'Criar Sprint';

  @override
  String get agileChecklistStartWork => 'Comecar a trabalhar';

  @override
  String get agileChecklistStartWorkDesc => 'Mova um item para em andamento';

  @override
  String get agileTipStartSprintTitle => 'Pronto para um Sprint?';

  @override
  String get agileTipStartSprintMessage =>
      'Voce tem stories suficientes no backlog. Considere planejar o primeiro Sprint.';

  @override
  String get agileTipWipTitle => 'Configure os WIP Limits';

  @override
  String get agileTipWipMessage =>
      'Os WIP limits sao fundamentais no Kanban. Limite o trabalho em andamento para melhorar o fluxo.';

  @override
  String get agileTipHybridTitle => 'Configure seu Scrumban';

  @override
  String get agileTipHybridMessage =>
      'Voce pode usar Sprints para cadencia ou WIP limits para fluxo continuo. Experimente!';

  @override
  String get agileTipDiscover => 'Descobrir';

  @override
  String get agileTipClose => 'Fechar';

  @override
  String get agileNextStepInviteTitle => 'Convide a Equipe';

  @override
  String get agileNextStepInviteDesc =>
      'Adicione membros para colaborar no projeto.';

  @override
  String get agileNextStepBacklogTitle => 'Crie o Backlog';

  @override
  String agileNextStepBacklogDesc(String itemType) {
    return 'Adicione as primeiras $itemType ao backlog.';
  }

  @override
  String get agileNextStepSprintTitle => 'Planeje um Sprint';

  @override
  String agileNextStepSprintDesc(int count) {
    return 'Voce tem $count itens prontos. Crie o primeiro Sprint!';
  }

  @override
  String get agileNextStepWipTitle => 'Configure os WIP Limits';

  @override
  String get agileNextStepWipDesc =>
      'Limite o trabalho em andamento para melhorar o fluxo.';

  @override
  String get agileNextStepWorkTitle => 'Comece a Trabalhar';

  @override
  String get agileNextStepWorkDesc =>
      'Mova um item para \"In Progress\" para comecar.';

  @override
  String get agileNextStepGoToKanban => 'Ir para o Kanban';

  @override
  String get agileActionNewStory => 'Nova Story';

  @override
  String get agileBacklogTitle => 'Product Backlog';

  @override
  String get agileBacklogArchiveTitle => 'Arquivo de Concluidas';

  @override
  String get agileBacklogToggleActive => 'Mostrar Backlog ativo';

  @override
  String agileBacklogToggleArchive(int count) {
    return 'Mostrar Arquivo ($count concluidas)';
  }

  @override
  String agileBacklogArchiveBadge(int count) {
    return 'Arquivo ($count)';
  }

  @override
  String get agileBacklogSearchHint =>
      'Pesquisar por titulo, descricao ou ID...';

  @override
  String agileBacklogStatsStories(int count) {
    return '$count stories';
  }

  @override
  String agileBacklogStatsPoints(int points) {
    return '$points pt';
  }

  @override
  String agileBacklogStatsEstimated(int count) {
    return '$count estimadas';
  }

  @override
  String get agileFiltersStatus => 'Status:';

  @override
  String get agileFiltersPriority => 'Prioridade:';

  @override
  String get agileFiltersTags => 'Tags:';

  @override
  String get agileFiltersAll => 'Todos';

  @override
  String get agileFiltersClear => 'Remover filtros';

  @override
  String get agileEmptyBacklogMatch => 'Nenhuma story encontrada';

  @override
  String get agileEmptyBacklog => 'Backlog vazio';

  @override
  String get agileEmptyBacklogHint => 'Adicione a primeira User Story';

  @override
  String get agileEstTitle => 'Estimar Story';

  @override
  String get agileEstMethod => 'Metodo de estimativa';

  @override
  String get agileEstSelectValue => 'Selecione um valor';

  @override
  String get agileEstSubmit => 'Confirmar Estimativa';

  @override
  String get agileEstCancel => 'Cancelar';

  @override
  String get agileEstPokerTitle => 'Planning Poker (Fibonacci)';

  @override
  String get agileEstPokerDesc =>
      'Selecione a complexidade da story em story points';

  @override
  String get agileEstTShirtTitle => 'T-Shirt Sizing';

  @override
  String get agileEstTShirtDesc => 'Selecione o tamanho relativo da story';

  @override
  String get agileEstThreePointTitle => 'Estimativa a Tres Pontos (PERT)';

  @override
  String get agileEstThreePointDesc =>
      'Insira tres valores para calcular a estimativa PERT';

  @override
  String get agileEstBucketTitle => 'Bucket System';

  @override
  String get agileEstBucketDesc => 'Posicione a story no bucket apropriado';

  @override
  String get agileEstBucketHint =>
      'Os buckets maiores indicam stories mais complexas';

  @override
  String get agileEstReference => 'Referencia:';

  @override
  String get agileEstRefXS => 'XS = Poucas horas';

  @override
  String get agileEstRefS => 'S = ~1 dia';

  @override
  String get agileEstRefM => 'M = ~2-3 dias';

  @override
  String get agileEstRefL => 'L = ~1 semana';

  @override
  String get agileEstRefXL => 'XL = ~2 semanas';

  @override
  String get agileEstRefXXL => 'XXL = Grande demais, dividir';

  @override
  String get agileEstOptimistic => 'Otimista (O)';

  @override
  String get agileEstOptimisticHint => 'Melhor caso';

  @override
  String get agileEstMostLikely => 'Mais Provavel (M)';

  @override
  String get agileEstMostLikelyHint => 'Caso provavel';

  @override
  String get agileEstPessimistic => 'Pessimista (P)';

  @override
  String get agileEstPessimisticHint => 'Pior caso';

  @override
  String get agileEstPointsSuffix => 'pt';

  @override
  String get agileEstFormula => 'Formula PERT: (O + 4M + P) / 6';

  @override
  String agileEstResult(String value) {
    return 'Estimativa: $value pontos';
  }

  @override
  String get agileEstErrorThreePoint => 'Insira todos os tres valores';

  @override
  String get agileEstErrorSelect => 'Selecione um valor';

  @override
  String agileEstExisting(int count) {
    return 'Estimativas existentes ($count)';
  }

  @override
  String get agileEstYou => 'Voce';

  @override
  String get scrumPermBacklogTitle => 'Permissoes do Backlog';

  @override
  String get scrumPermBacklogDesc =>
      'Apenas o Product Owner pode criar, editar, excluir e priorizar stories';

  @override
  String get scrumPermSprintTitle => 'Permissoes do Sprint';

  @override
  String get scrumPermSprintDesc =>
      'Apenas o Scrum Master pode criar, iniciar e concluir sprints';

  @override
  String get scrumPermEstimateTitle => 'Permissoes de Estimativa';

  @override
  String get scrumPermEstimateDesc =>
      'Apenas o Development Team pode estimar stories';

  @override
  String get scrumPermKanbanTitle => 'Permissoes do Kanban';

  @override
  String get scrumPermKanbanDesc =>
      'O Development Team pode mover suas stories, PO e SM podem mover qualquer story';

  @override
  String get scrumPermTeamTitle => 'Permissoes da Equipe';

  @override
  String get scrumPermTeamDesc =>
      'PO e SM podem convidar membros, apenas o PO pode modificar os papeis';

  @override
  String get scrumPermDeniedBacklogCreate =>
      'Apenas o Product Owner pode criar novas stories';

  @override
  String get scrumPermDeniedBacklogEdit =>
      'Apenas o Product Owner pode editar stories';

  @override
  String get scrumPermDeniedBacklogDelete =>
      'Apenas o Product Owner pode excluir stories';

  @override
  String get scrumPermDeniedBacklogPrioritize =>
      'Apenas o Product Owner pode reordenar o backlog';

  @override
  String get scrumPermDeniedSprintCreate =>
      'Apenas o Scrum Master pode criar novos sprints';

  @override
  String get scrumPermDeniedSprintStart =>
      'Apenas o Scrum Master pode iniciar sprints';

  @override
  String get scrumPermDeniedSprintComplete =>
      'Apenas o Scrum Master pode concluir sprints';

  @override
  String get scrumPermDeniedEstimate =>
      'Apenas o Development Team pode estimar stories';

  @override
  String get scrumPermDeniedInvite =>
      'Apenas PO e SM podem convidar novos membros';

  @override
  String get scrumPermDeniedRoleChange =>
      'Apenas o Product Owner pode modificar os papeis da equipe';

  @override
  String get scrumPermDeniedWipConfig =>
      'Apenas o Scrum Master pode configurar os limites WIP';

  @override
  String get scrumRoleProductOwner => 'Product Owner';

  @override
  String get scrumRoleScrumMaster => 'Scrum Master';

  @override
  String get scrumRoleDeveloper => 'Developer';

  @override
  String get scrumRoleDesigner => 'Designer';

  @override
  String get scrumRoleQA => 'QA';

  @override
  String get scrumRoleStakeholder => 'Stakeholder';

  @override
  String get scrumMatrixTitle => 'Matriz de Permissoes Scrum';

  @override
  String get scrumMatrixSubtitle =>
      'Quem pode fazer o que segundo o Scrum Guide 2020';

  @override
  String get scrumMatrixLegend => 'Legenda';

  @override
  String get scrumMatrixLegendFull => 'Gerencia';

  @override
  String get scrumMatrixLegendPartial => 'Parcial';

  @override
  String get scrumMatrixLegendView => 'Visualiza';

  @override
  String get scrumMatrixLegendNone => 'Nenhum';

  @override
  String get scrumMatrixCategoryBacklog => 'BACKLOG';

  @override
  String get scrumMatrixCategorySprint => 'SPRINT';

  @override
  String get scrumMatrixCategoryEstimation => 'ESTIMATIVA';

  @override
  String get scrumMatrixCategoryKanban => 'KANBAN';

  @override
  String get scrumMatrixCategoryTeam => 'EQUIPE';

  @override
  String get scrumMatrixCategoryRetro => 'RETROSPECTIVA';

  @override
  String get scrumMatrixActionCreateStory => 'Criar Story';

  @override
  String get scrumMatrixActionEditStory => 'Editar Story';

  @override
  String get scrumMatrixActionDeleteStory => 'Excluir Story';

  @override
  String get scrumMatrixActionPrioritize => 'Priorizar Backlog';

  @override
  String get scrumMatrixActionAddAcceptance => 'Definir Criterios de Aceitacao';

  @override
  String get scrumMatrixActionCreateSprint => 'Criar Sprint';

  @override
  String get scrumMatrixActionStartSprint => 'Iniciar Sprint';

  @override
  String get scrumMatrixActionCompleteSprint => 'Concluir Sprint';

  @override
  String get scrumMatrixActionConfigWip => 'Configurar Limites WIP';

  @override
  String get scrumMatrixActionEstimate => 'Estimar Story Points';

  @override
  String get scrumMatrixActionFinalEstimate => 'Definir Estimativa Final';

  @override
  String get scrumMatrixActionMoveOwn => 'Mover proprias Stories';

  @override
  String get scrumMatrixActionMoveAny => 'Mover qualquer Story';

  @override
  String get scrumMatrixActionSelfAssign => 'Autoatribuir-se';

  @override
  String get scrumMatrixActionAssignOthers => 'Atribuir outros';

  @override
  String get scrumMatrixActionChangeStatus => 'Alterar status da Story';

  @override
  String get scrumMatrixActionInvite => 'Convidar membros';

  @override
  String get scrumMatrixActionRemove => 'Remover membros';

  @override
  String get scrumMatrixActionChangeRole => 'Alterar papeis';

  @override
  String get scrumMatrixActionFacilitateRetro => 'Facilitar Retrospectiva';

  @override
  String get scrumMatrixActionParticipateRetro => 'Participar da Retrospectiva';

  @override
  String get scrumMatrixActionAddRetroItem => 'Adicionar item na Retro';

  @override
  String get scrumMatrixActionVoteRetro => 'Votar em itens';

  @override
  String get scrumMatrixColPO => 'PO';

  @override
  String get scrumMatrixColSM => 'SM';

  @override
  String get scrumMatrixColDev => 'Dev';

  @override
  String get scrumMatrixColStake => 'Stake';

  @override
  String get agileInviteTitle => 'Convidar para a Equipe';

  @override
  String get agileInviteNew => 'NOVO CONVITE';

  @override
  String get agileInviteEmailLabel => 'E-mail';

  @override
  String get agileInviteEmailHint => 'nome@exemplo.com';

  @override
  String get agileInviteEnterEmail => 'Insira um e-mail';

  @override
  String get agileInviteInvalidEmail => 'E-mail invalido';

  @override
  String get agileInviteProjectRole => 'Papel no Projeto';

  @override
  String get agileInviteTeamRole => 'Papel na Equipe';

  @override
  String get agileInviteSendEmail => 'Enviar e-mail de notificacao';

  @override
  String get agileInviteSendBtn => 'Enviar Convite';

  @override
  String get agileInviteLink => 'Link do convite:';

  @override
  String get agileInviteLinkCopied => 'Link copiado!';

  @override
  String get agileInviteListTitle => 'CONVITES';

  @override
  String get agileInviteClose => 'Fechar';

  @override
  String get agileInviteGmailAuthTitle => 'Autorizacao Gmail';

  @override
  String get agileInviteGmailAuthContent =>
      'Para enviar e-mails de convite, e necessario reautenticar-se com o Google.\n\nDeseja prosseguir?';

  @override
  String get agileInviteGmailAuthNo => 'Nao, apenas link';

  @override
  String get agileInviteGmailAuthYes => 'Autorizar';

  @override
  String agileInviteSentEmail(String email) {
    return 'Convite enviado por e-mail para $email';
  }

  @override
  String agileInviteCreated(String email) {
    return 'Convite criado para $email';
  }

  @override
  String get agileInviteRevokeTitle => 'Revogar convite?';

  @override
  String get agileInviteRevokeContent => 'O convite nao sera mais valido.';

  @override
  String get agileInviteRevokeBtn => 'Revogar';

  @override
  String get agileInviteResend => 'Reenviar';

  @override
  String get agileInviteResent => 'Convite reenviado';

  @override
  String get agileInviteStatusPending => 'Pendente';

  @override
  String get agileInviteStatusAccepted => 'Aceito';

  @override
  String get agileInviteStatusDeclined => 'Recusado';

  @override
  String get agileInviteStatusExpired => 'Expirado';

  @override
  String get agileInviteStatusRevoked => 'Revogado';

  @override
  String get agileRoleMember => 'Membro';

  @override
  String get agileRoleAdmin => 'Admin';

  @override
  String get agileRoleViewer => 'Observador';

  @override
  String get agileRoleOwner => 'Proprietario';

  @override
  String get agileEditStory => 'Editar Story';

  @override
  String get agileNewStory => 'Nova User Story';

  @override
  String get agileDetailsTab => 'Detalhes';

  @override
  String get agileAcceptanceCriteriaTab => 'Acceptance Criteria';

  @override
  String get agileOtherTab => 'Outro';

  @override
  String get agileTitleLabel => 'Titulo';

  @override
  String get agileTitleHint => 'Breve descricao da funcionalidade';

  @override
  String get agileUseStoryTemplate => 'Usar template User Story';

  @override
  String get agileStoryTemplateSubtitle => 'As a... I want... So that...';

  @override
  String get agileAsA => 'As a...';

  @override
  String get agileAsAHint => 'usuario, admin, cliente...';

  @override
  String get agileIWant => 'I want...';

  @override
  String get agileIWantHint => 'poder fazer algo...';

  @override
  String get agileSoThat => 'So that...';

  @override
  String get agileSoThatHint => 'obter um beneficio...';

  @override
  String get agileDescriptionLabel => 'Descricao';

  @override
  String get agileDescriptionHint => 'Descricao livre da story';

  @override
  String get agilePreview => 'Pre-visualizacao:';

  @override
  String get agileEmptyDescription => '(descricao vazia)';

  @override
  String get agileDefineComplete =>
      'Defina quando a story pode ser considerada concluida';

  @override
  String get agileAddCriterionHint => 'Adicionar criterio de aceitacao...';

  @override
  String get agileNoCriteria => 'Nenhum criterio definido';

  @override
  String get agileSuggestions => 'Sugestoes:';

  @override
  String get agilePriorityMoscow => 'Prioridade (MoSCoW)';

  @override
  String get agileBusinessValueLow => 'Baixo valor de negocio';

  @override
  String get agileBusinessValueMedium => 'Valor medio';

  @override
  String get agileBusinessValueHigh => 'Alto valor de negocio';

  @override
  String get agileEstimatedStoryPoints => 'Estimada em Story Points';

  @override
  String get agileStoryPointsTooltip =>
      'Os Story Points representam a complexidade relativa do trabalho.\nUse a sequencia de Fibonacci: 1 (simples) -> 21 (muito complexa).';

  @override
  String get agileNoPoints => 'Nenhuma';

  @override
  String get agileAddTagHint => 'Adicionar tag...';

  @override
  String get agileExistingTags => 'Tags existentes:';

  @override
  String get agileAssignTo => 'Atribuir a';

  @override
  String get agileSelectMemberHint => 'Selecione um membro da equipe';

  @override
  String get agilePointsComplexityVeryLow => 'Tarefa rapida e simples';

  @override
  String get agilePointsComplexityLow => 'Tarefa de media complexidade';

  @override
  String get agilePointsComplexityMedium => 'Tarefa complexa, requer analise';

  @override
  String get agilePointsComplexityHigh =>
      'Muito complexa, considere dividir a story';

  @override
  String agileDurationDays(Object days) {
    return 'Duracao: $days dias';
  }

  @override
  String get agilePriorityMust => 'Must Have';

  @override
  String get agilePriorityShould => 'Should Have';

  @override
  String get agilePriorityCould => 'Could Have';

  @override
  String get agilePriorityWont => 'Won\'t Have';

  @override
  String get agileSelectedPoints => 'Pontos Selecionados';

  @override
  String get agileSuggestedPoints => 'Pontos Sugeridos';

  @override
  String agileDaysRemaining(Object days) {
    return '${days}d restantes';
  }

  @override
  String get agileSelectAtLeastOne => 'Selecione pelo menos uma story';

  @override
  String agileConfirmStories(String count) {
    return 'Confirmar $count stories';
  }

  @override
  String get kanbanPoliciesDescription =>
      'As politicas explicitas definem as regras para esta coluna (Kanban Practice #4)';

  @override
  String get kanbanPoliciesEmpty => 'Nenhuma politica definida';

  @override
  String get kanbanPoliciesAdd => 'Adicionar politica';

  @override
  String get kanbanPoliciesHint => 'Ex: Max 24h nesta coluna';

  @override
  String kanbanPoliciesIndicator(int count) {
    return 'Politicas ativas: $count';
  }

  @override
  String get sprintReviewTitle => 'Sprint Review';

  @override
  String get sprintReviewSubtitle =>
      'Revisao do trabalho concluido com os stakeholders';

  @override
  String get sprintReviewConductBy => 'Conduzido por';

  @override
  String get sprintReviewDate => 'Data da Review';

  @override
  String get sprintReviewAttendees => 'Participantes';

  @override
  String get sprintReviewSelectAttendees => 'Selecionar participantes';

  @override
  String get sprintReviewDemoNotes => 'Notas da Demo';

  @override
  String get sprintReviewDemoNotesHint =>
      'Descreva as funcionalidades demonstradas';

  @override
  String get sprintReviewFeedback => 'Feedback Recebido';

  @override
  String get sprintReviewFeedbackHint => 'Feedback dos stakeholders';

  @override
  String get sprintReviewBacklogUpdates => 'Atualizacoes do Backlog';

  @override
  String get sprintReviewBacklogUpdatesHint =>
      'Alteracoes no backlog discutidas';

  @override
  String get sprintReviewNextFocus => 'Foco do Proximo Sprint';

  @override
  String get sprintReviewNextFocusHint => 'Prioridades para o proximo sprint';

  @override
  String get sprintReviewMarketNotes => 'Notas de Mercado/Orcamento';

  @override
  String get sprintReviewMarketNotesHint =>
      'Condicoes de mercado, prazos, orcamento';

  @override
  String get sprintReviewStoriesCompleted => 'Stories Concluidas';

  @override
  String get sprintReviewStoriesNotCompleted => 'Stories Nao Concluidas';

  @override
  String get sprintReviewPointsCompleted => 'Pontos Concluidos';

  @override
  String get sprintReviewSave => 'Salvar Review';

  @override
  String get sprintReviewWarning => 'Atencao: Sprint Review';

  @override
  String get sprintReviewWarningMessage =>
      'A Sprint Review ainda nao foi realizada. Segundo o Scrum Guide 2020, a Sprint Review e um evento obrigatorio antes de concluir o sprint.';

  @override
  String get sprintReviewCompleteAnyway => 'Concluir mesmo assim';

  @override
  String get sprintReviewDoReview => 'Realizar Review';

  @override
  String get sprintReviewCompleted => 'Sprint Review concluida';

  @override
  String get swimlaneTitle => 'Swimlanes';

  @override
  String get swimlaneDescription => 'Agrupe os cards por atributo';

  @override
  String get swimlaneTypeNone => 'Nenhuma';

  @override
  String get swimlaneTypeNoneDesc => 'Visualizacao padrao sem agrupamento';

  @override
  String get swimlaneTypeClassOfService => 'Classe de Servico';

  @override
  String get swimlaneTypeClassOfServiceDesc => 'Agrupe por prioridade/urgencia';

  @override
  String get swimlaneTypeAssignee => 'Responsavel';

  @override
  String get swimlaneTypeAssigneeDesc => 'Agrupe por membro da equipe';

  @override
  String get swimlaneTypePriority => 'Prioridade';

  @override
  String get swimlaneTypePriorityDesc => 'Agrupe por nivel de prioridade';

  @override
  String get swimlaneTypeTag => 'Tag';

  @override
  String get swimlaneTypeTagDesc => 'Agrupe por tag da story';

  @override
  String get swimlaneUnassigned => 'Nao Atribuido';

  @override
  String get swimlaneNoTag => 'Sem Tag';

  @override
  String get agileMetricsVelocityTitle => 'Velocity';

  @override
  String get agileMetricsVelocityDesc =>
      'Mede a quantidade de story points concluidos por sprint. Ajuda a prever a capacidade da equipe.';

  @override
  String get agileMetricsLeadTimeDesc =>
      'Tempo total da criacao ate a conclusao. Inclui o tempo de espera no backlog.';

  @override
  String get agileMetricsCycleTimeDesc =>
      'Tempo do inicio do trabalho ate a conclusao. Mede a eficiencia do desenvolvimento.';

  @override
  String get agileMetricsThroughputDesc =>
      'Numero de itens concluidos por unidade de tempo. Indica a produtividade.';

  @override
  String get agileMetricsDistributionDesc =>
      'Visualiza a distribuicao por status. Ajuda a identificar gargalos.';

  @override
  String get agilePredictability => 'Previsibilidade';

  @override
  String agilePredictabilityDesc(int days) {
    return '85% dos itens sao concluidos em <=$days dias';
  }

  @override
  String agileThroughputWeekly(int weeks) {
    return 'Itens concluidos/semana (ultimas $weeks sem.)';
  }

  @override
  String get agileNoDataVelocity => 'Sem dados de velocity';

  @override
  String get agileNoDataLeadTime => 'Sem dados de lead time';

  @override
  String get agileNoDataCycleTime => 'Sem dados de cycle time';

  @override
  String get agileNoDataThroughput => 'Sem dados de throughput';

  @override
  String get agileNoDataAccuracy => 'Sem dados de accuracy';

  @override
  String get agileStartFinishOneItem =>
      'Conclua pelo menos um item para calcular';

  @override
  String get timeDays => 'dias';

  @override
  String get auditLogTitle => 'Audit Log';

  @override
  String auditLogEventCount(int count) {
    return '$count eventos';
  }

  @override
  String get actionRefresh => 'Atualizar';

  @override
  String get auditLogFilterEntityType => 'Tipo';

  @override
  String get auditLogFilterAction => 'Acao';

  @override
  String get auditLogFilterFromDate => 'De';

  @override
  String get actionDetails => 'Detalhes';

  @override
  String get auditLogDetailsTitle => 'Detalhes da Alteracao';

  @override
  String get auditLogPreviousValue => 'Valor anterior:';

  @override
  String get auditLogNewValue => 'Novo valor:';

  @override
  String get auditLogNoEvents => 'Nenhum evento registrado';

  @override
  String get auditLogNoEventsDesc =>
      'As atividades do projeto serao registradas aqui';

  @override
  String get recentActivityTitle => 'Atividade Recente';

  @override
  String get actionViewAll => 'Ver tudo';

  @override
  String get recentActivityNone => 'Nenhuma atividade recente';

  @override
  String get burndownChartTitle => 'Burndown Chart';

  @override
  String get agileIdeal => 'Ideal';

  @override
  String get agileActual => 'Real';

  @override
  String get agileRemaining => 'Restantes';

  @override
  String get agileBurndownNoDataDesc =>
      'Os dados aparecerao quando o sprint estiver ativo';

  @override
  String get agileCompleteActiveFirst =>
      'Conclua o sprint ativo antes de iniciar outro';

  @override
  String get kanbanSwimlanes => 'Swimlanes:';

  @override
  String get kanbanSwimlaneLabel => 'Swimlane';

  @override
  String get agileNoTags => 'Sem tags';

  @override
  String get kanbanWipExceededBanner =>
      'WIP Limit excedido! Conclua alguns itens antes de iniciar novos.';

  @override
  String get kanbanConfigWip => 'Configurar WIP';

  @override
  String get kanbanPoliciesDesc =>
      'As politicas explicitas ajudam a equipe a entender as regras desta coluna.';

  @override
  String get kanbanNewPolicyHint => 'Nova politica...';

  @override
  String kanbanWipLimitOf(int count, int limit) {
    return 'WIP: $count de $limit max';
  }

  @override
  String get kanbanWipExplanationDesc =>
      'WIP (Work In Progress) Limits sao limites no numero de itens que podem estar em uma coluna ao mesmo tempo.';

  @override
  String get kanbanUnderstand => 'Entendi';

  @override
  String get agileHours => 'Horas';

  @override
  String get agileStoriesPerSprint => 'Stories / Sprint';

  @override
  String get agileSprints => 'Sprints';

  @override
  String get agileTeamComposition => 'Composicao da Equipe';

  @override
  String get agileHoursNote =>
      'As horas sao uma referencia interna. Para o planejamento Scrum, use a visualizacao de Story Points.';

  @override
  String agileWorkloadBalanceTooltip(String avg, String min, String max) {
    return 'Media Team: $avg SP\nRange bilanciato: $min - $max SP\nLo status è basato sulla deviazione dalla media.';
  }

  @override
  String get agileHealthTimeTooltip =>
      'Giorni trascorsi / Totale giorni (basato su date Inizio/Fine).';

  @override
  String get agileHealthWorkTooltip =>
      'Story Points completati su totalmente pianificati.';

  @override
  String get agileHealthProgressTooltip =>
      'Numero di storie attualmente in lavorazione.';

  @override
  String get agileHealthDoneTooltip =>
      'Storie completate su totale storie nello sprint.';

  @override
  String get agileHealthCommitmentTooltip =>
      'Confiabilidade (Concluído/Planejado) com base em sprints anteriores.';

  @override
  String get agileHealthVelocityTooltip =>
      'Média diária de Story Points concluídos neste sprint.';

  @override
  String get agileSprintScopeTooltip =>
      'Acompanha as mudanças no escopo do sprint. \'Original\' são os pontos planejados quando o sprint começou, \'Atual\' são os pontos das histórias atualmente no sprint.';

  @override
  String get agileEstimationAccuracyTooltip =>
      'Fórmula: (Pontos Concluídos / Pontos Planejados) x 100. Indica a confiabilidade da equipe em concluir o trabalho prometido no início do sprint.';

  @override
  String get agileCommitmentTrendTooltip =>
      'Exibe a tendência de confiabilidade da equipe comparando Pontos Planejados vs Concluídos para cada sprint fechado.';

  @override
  String get agileNoTeamMembers => 'Sem membros da equipe';

  @override
  String get agileGmailAuthError =>
      'Autorizacao Gmail nao disponivel. Tente fazer logout e login.';

  @override
  String get agileGmailPermissionDenied => 'Permissao Gmail nao concedida.';

  @override
  String get agileResend => 'Reenviar';

  @override
  String get agileRevoke => 'Revogar';

  @override
  String get agileVelocityUnits => 'Story Points / Sprint';

  @override
  String get agileFiltersTitle => 'Filtros';

  @override
  String get agilePlanned => 'Planejado';

  @override
  String get archiveDeleteSuccess => 'Arquivado/excluido com sucesso';

  @override
  String get agileNoItems => 'Nenhum elemento para mostrar';

  @override
  String agileItemsOfTotal(int completed, int total) {
    return '$completed de $total';
  }

  @override
  String get agileItemsCompletedLabel => 'Elementos Concluidos';

  @override
  String get agileDaysRemainingSuffix => 'dias restantes';

  @override
  String get agileItems => 'itens';

  @override
  String get agileItemsMore => 'altri items';

  @override
  String get wipAgeTitle => 'Età Work Items';

  @override
  String get wipAgeEmpty => 'Nessun item in lavorazione';

  @override
  String wipAgeDays(int count) {
    return '$count giorni';
  }

  @override
  String get wipAgeWarning =>
      'Alcuni item sono in lavorazione da troppo tempo. Potrebbero esserci blocchi.';

  @override
  String get agilePerWeekSuffix => '/sem';

  @override
  String get average => 'Media';

  @override
  String get agileAvgVelocitySprint => 'Velocidade (Sprint)';

  @override
  String get agileAvgVelocityWeekly => 'Velocidade (Semanal)';

  @override
  String get agileAvgVelocitySprintTooltip =>
      'Média de pontos de história concluídos por sprint.';

  @override
  String get agileAvgVelocityWeeklyTooltip =>
      'Média de pontos de história concluídos por semana.';

  @override
  String get agileFiltersDoneTooltip =>
      'Histórias concluídas ou de sprints fechados são arquivadas por padrão. Selecione este filtro para visualizá-las.';

  @override
  String agileBacklogDoneBadge(Object count) {
    return '($count) Done';
  }

  @override
  String get agileBacklogDoneBadgeTooltip =>
      'Estas histórias estão ocultas por padrão. Use o filtro de status \'Done\' para visualizá-las.';

  @override
  String get agileFlowEfficiencyTooltip =>
      'Fórmula: (Cycle Time / Lead Time) x 100. Representa a porcentagem de tempo que o trabalho está \'ativo\' em relação ao tempo total no sistema.';

  @override
  String get getAgileFlowCycleTimeTooltip =>
      'Tempo médio para concluir uma história a partir do momento em que é iniciada (In Progress).';

  @override
  String get agileFlowLeadTimeTooltip =>
      'Tempo médio total desde a criação da história até a sua conclusão (Done).';

  @override
  String get agileFlowWipTooltip =>
      'Work In Progress: número di histórias em que se está trabalhando atualmente (excluindo Backlog e Done).';

  @override
  String get agileBlockedItemsTooltip =>
      'Storie che hanno delle dipendenze non soddisfatte (altre storie non ancora completate).';

  @override
  String agileItemsCount(int count) {
    return '$count elementos';
  }

  @override
  String get agileDaysLeft => 'Dias Restantes';

  @override
  String get all => 'Todos';

  @override
  String get kanbanGuidePoliciesTitle => 'Politicas Explicitas';

  @override
  String get agileDaysLabel => 'Dias';

  @override
  String get agileStatRemaining => 'restantes';

  @override
  String get agileStatsCompletedLabel => 'Concluidos';

  @override
  String get agileStatsPlannedLabel => 'Planejados';

  @override
  String get agileProgressLabel => 'Progresso';

  @override
  String get agileDurationLabel => 'Duracao';

  @override
  String get agileVelocityLabel => 'Velocity';

  @override
  String get agileStoriesLabel => 'Stories';

  @override
  String get agileSprintSummary => 'Resumo do Sprint';

  @override
  String get agileStoriesTotal => 'Stories totais';

  @override
  String get agileStoriesCompleted => 'Stories concluidas';

  @override
  String get agilePointsCompletedLabel => 'Story Points concluidos';

  @override
  String get agileStoriesIncomplete => 'Stories incompletas';

  @override
  String get agileIncompleteReturnToBacklog => '(voltarao para o backlog)';

  @override
  String get agilePointsLabel => 'Story Points';

  @override
  String get agileRecordReview => 'Realizar Sprint Review';

  @override
  String get agileCompleteSprintAction => 'Fechar Sprint';

  @override
  String get agileMissingReview => 'Sprint Review ainda nao realizada';

  @override
  String get agileSprintReviewCompleted => 'Sprint Review concluida';

  @override
  String get agileReviewNotesLabel => 'Notas da Review';

  @override
  String get agileReviewFeedbackLabel => 'Feedback dos Stakeholders';

  @override
  String get agileReviewNextFocus => 'Foco do Proximo Sprint';

  @override
  String get agileBacklogUpdatesLabel => 'Alteracoes no Backlog';

  @override
  String get agileSaveReview => 'Salvar Review';

  @override
  String get agileConductedBy => 'Conduzida por';

  @override
  String get agileReviewDate => 'Data da Review';

  @override
  String get agileReviewOutcome => 'Resultado da Review';

  @override
  String get agileStoriesRejected => 'Stories nao aceitas';

  @override
  String get agileRejectedWarning =>
      'As stories nao concluidas ou nao aceitas voltarao automaticamente para o Backlog.';

  @override
  String get agileReviewDemoHint => 'O que foi mostrado durante a demo?';

  @override
  String get agileReviewFeedbackHint => 'Feedback recebido dos stakeholders';

  @override
  String get agileReviewBacklogHint => 'Nova alteracao no backlog...';

  @override
  String get agileReviewNextFocusHint =>
      'No que a equipe deveria se concentrar?';

  @override
  String get agileReviewScrumGuide =>
      'O Scrum Guide 2020 recomenda realizar a Sprint Review antes de fechar o sprint para inspecionar o trabalho realizado com os stakeholders.';

  @override
  String agileSprintCompleteConfirm(String name) {
    return 'Tem certeza de que deseja concluir \"$name\"?';
  }

  @override
  String agileSprintCompleteSuccess(String velocity) {
    return 'Sprint concluido! Velocity: $velocity pts/semana';
  }

  @override
  String get agileSprintReviewSaveSuccess => 'Sprint Review salva';

  @override
  String get agileEstimationAccuracy => 'Confiabilidade do Planejamento';

  @override
  String get agileCompleteOneSprintFirst => 'Conclua pelo menos um sprint';

  @override
  String get agileNoDataAccuracyFix => 'Sem dados de precisao';

  @override
  String get agileScrumGuideRecommends =>
      'O Scrum Guide recomenda o planejamento baseado na Velocity historica, nao nas horas.';

  @override
  String get agileNoSkillsDefined => 'Nenhuma competencia definida';

  @override
  String get agileAddSkillsToMembers =>
      'Adicione competencias aos membros da equipe';

  @override
  String get retroNoSprintWarningTitle => 'Nenhum Sprint Concluido';

  @override
  String get retroNoSprintWarningMessage =>
      'Para criar uma retrospectiva Scrum, voce deve primeiro concluir pelo menos um sprint. As retrospectivas sao vinculadas aos sprints para rastrear melhorias entre iteracoes.';

  @override
  String get agileGoToSprints => 'Ir para Sprints';

  @override
  String get agileSprintReviewHistory => 'Historico de Sprint Reviews';

  @override
  String get agileNoSprintReviews => 'Nenhuma Sprint Review';

  @override
  String get agileNoSprintReviewsHint =>
      'Conclua um sprint e realize uma Sprint Review para ve-la aqui';

  @override
  String get agileAttendees => 'Participantes';

  @override
  String get agileStoryEvaluations => 'Avaliacao de Stories';

  @override
  String get agileDecisions => 'Decisoes';

  @override
  String get agileDemoNotes => 'Notas da Demo';

  @override
  String get agileFeedback => 'Feedback';

  @override
  String get agileStoryApproved => 'Aprovada';

  @override
  String get agileStoryNeedsRefinement => 'Precisa Refinamento';

  @override
  String get agileStoryRejected => 'Rejeitada';

  @override
  String get agileAddAttendee => 'Adicionar Participante';

  @override
  String get agileAddDecision => 'Adicionar Decisão';

  @override
  String get agileNoDecisions => 'Nenhuma decisão adicionada';

  @override
  String get agileTooltipApproved => 'Approvata';

  @override
  String get agileTooltipRefinement => 'Da raffinare';

  @override
  String get agileTooltipRejected => 'Rifiutata';

  @override
  String get agileReviewGuidance =>
      'Seleziona l\'esito. \'Da raffinare\' e \'Rifiutata\' riportano la storia nel Backlog.';

  @override
  String get agileEvaluateStories => 'Avaliar Stories';

  @override
  String get agileSelectRole => 'Selecionar Papel';

  @override
  String get agileStatsNotCompleted => 'Nao Concluidas';

  @override
  String get agileFramework => 'Framework';

  @override
  String get teamMembers => 'Membros da Equipe';

  @override
  String get eisenhowerImportCsv => 'Importar CSV';

  @override
  String get eisenhowerImportPreview => 'Pré-visualização';

  @override
  String get eisenhowerImportSelectFile => 'Selecionar arquivo';

  @override
  String get eisenhowerImportFormatHint =>
      'O arquivo CSV deve conter uma coluna \'titulo\' ou \'title\'';

  @override
  String get eisenhowerImportClickToSelect => 'Clique para selecionar';

  @override
  String get eisenhowerImportSupportedFormats => 'Formatos suportados';

  @override
  String get eisenhowerImportNoActivities => 'Nenhuma atividade encontrada';

  @override
  String get eisenhowerImportMarkRevealed => 'Marcar como reveladas';

  @override
  String get eisenhowerImportMarkRevealedHint =>
      'As atividades importadas serão marcadas como já votadas';

  @override
  String eisenhowerImportSuccess(int count) {
    return 'Importação concluída com sucesso';
  }

  @override
  String get actionSelectAll => 'Selecionar Todos';

  @override
  String get actionDeselectAll => 'Desmarcar Todos';

  @override
  String get actionImport => 'Importar';

  @override
  String get eisenhowerImportShowInstructions => 'Mostrar instruções';

  @override
  String get eisenhowerImportInstructionsTitle => 'Instruções para importação';

  @override
  String get eisenhowerImportInstructionsBody =>
      'Prepare um arquivo CSV com as colunas: título, descrição (opcional), quadrante (opcional, 1-4).';

  @override
  String get eisenhowerImportExampleFormat => 'Formato de exemplo';

  @override
  String get eisenhowerImportChangeFile => 'Alterar arquivo';

  @override
  String eisenhowerImportSkippedRows(int count) {
    return 'Linhas ignoradas';
  }

  @override
  String eisenhowerImportAndMore(int count) {
    return 'e mais';
  }

  @override
  String eisenhowerImportFoundActivities(int valid, int total) {
    return 'Atividades encontradas';
  }

  @override
  String eisenhowerImportErrorEmptyTitle(int row) {
    return 'Título vazio';
  }

  @override
  String eisenhowerImportErrorInvalidRow(int row) {
    return 'Linha inválida';
  }

  @override
  String get eisenhowerImportErrorMissingColumn => 'Coluna ausente';

  @override
  String get eisenhowerImportErrorEmptyFile => 'Arquivo vazio';

  @override
  String get eisenhowerImportErrorNoHeader => 'Cabeçalho ausente';

  @override
  String eisenhowerImportErrorRow(int row) {
    return 'Erro na linha';
  }

  @override
  String get eisenhowerImportErrorReadFile => 'Erro ao ler o arquivo';

  @override
  String get agileSprintHealthTitle => 'Sprint Health';

  @override
  String get agileSprintHealthNoSprint => 'Nenhum sprint ativo';

  @override
  String get agileSprintHealthNoSprintDesc =>
      'Inicie um sprint para ver as métricas de saúde';

  @override
  String get agileSprintHealthGoal => 'Sprint Goal';

  @override
  String get agileSprintHealthOnTrack => 'No Caminho';

  @override
  String get agileSprintHealthAtRisk => 'Em Risco';

  @override
  String get agileSprintHealthOffTrack => 'Atrasado';

  @override
  String get agileSprintHealthTime => 'Tempo';

  @override
  String get agileSprintHealthWork => 'Trabalho';

  @override
  String get agileSprintHealthDaysLeft => 'dias restantes';

  @override
  String get agileSprintHealthSpRemaining => 'SP restantes';

  @override
  String get agileSprintHealthStoriesInProgress => 'In Corso';

  @override
  String get agileSprintHealthStoriesDone => 'Stories Concluídas';

  @override
  String get agileSprintHealthCommitment => 'Confiabilidade';

  @override
  String get agileSprintHealthDailyVelocity => 'Vel. Diária';

  @override
  String get agileSprintHealthPrediction => 'Previsão';

  @override
  String get agileSprintHealthOnTime => 'No prazo';

  @override
  String get agileSprintHealthStoriesBreakdown => 'Distribuição de Stories';

  @override
  String get agileSprintBurndownTitle => 'Sprint Burndown';

  @override
  String get agileSprintBurndownNoData => 'Nenhum dado de burndown';

  @override
  String get agileSprintBurndownNoDataDesc =>
      'Atribua stories ao sprint para ver o burndown';

  @override
  String get agileWorkloadTitle => 'Carga de Trabalho';

  @override
  String get agileWorkloadBalanced => 'Equilibrado';

  @override
  String get agileWorkloadUnbalanced => 'Desequilibrado';

  @override
  String get agileWorkloadTotalStories => 'Stories totais';

  @override
  String get agileWorkloadAssigned => 'Atribuído';

  @override
  String get agileWorkloadAvgSp => 'Média SP';

  @override
  String get agileWorkloadStories => 'Stories';

  @override
  String get agileWorkloadInProgress => 'Em Andamento';

  @override
  String get agileWorkloadUnassigned => 'Não atribuído';

  @override
  String get agileWorkloadUnassignedWarning => 'Stories não atribuídas';

  @override
  String get agileWorkloadNoStories => 'Nenhuma story';

  @override
  String get agileWorkloadNoStoriesDesc =>
      'Atribua stories aos membros do time para ver a distribuição de carga';

  @override
  String get agileWorkloadOverloaded => 'Sobrecarregado';

  @override
  String get agileCommitmentTrendTitle =>
      'Trend de Confiabilidade do Commitment';

  @override
  String get agileCommitmentTrendNoData => 'Nenhum dado disponível';

  @override
  String get agileCommitmentTrendNoDataDesc =>
      'Conclua pelo menos um sprint para visualizar o trend';

  @override
  String get agileCommitmentTrendPlanned => 'Planejados';

  @override
  String get agileCommitmentTrendCompleted => 'Concluídos';

  @override
  String get agileCommitmentTrendAvg => 'Média';

  @override
  String get agileFlowEfficiencyTitle => 'Flow Efficiency & WIP';

  @override
  String get agileFlowEfficiencyNoData => 'Nenhum dado disponível';

  @override
  String get agileFlowEfficiencyNoDataDesc =>
      'Adicione stories para visualizar a análise do fluxo';

  @override
  String get agileFlowEfficiency => 'Flow Efficiency';

  @override
  String get agileFlowCycleTime => 'Cycle Time';

  @override
  String get agileFlowLeadTime => 'Lead Time';

  @override
  String get agileFlowDays => 'dias';

  @override
  String get agileFlowWipByStatus => 'WIP por Status';

  @override
  String get agileFlowAvg => 'média';

  @override
  String get agileBlockedItemsTitle => 'Itens Bloqueados';

  @override
  String get agileBlockedItemsNone => 'Nenhum item bloqueado';

  @override
  String get agileBlockedItemsNoneDesc =>
      'Todas as dependências estão satisfeitas';

  @override
  String agileBlockedItemsCount(Object count) {
    return '$count bloqueados';
  }

  @override
  String get agileBlockedItemsSp => 'SP bloqueados';

  @override
  String get agileBlockedItemsBlockedBy => 'Bloqueado por';

  @override
  String get agileBlockedItemsDependency => 'dependência';

  @override
  String get agileBlockedItemsDependencies => 'dependências';

  @override
  String get agileSprintScopeTitle => 'Scope do Sprint';

  @override
  String get agileSprintScopeNoSprint => 'Nenhum sprint ativo';

  @override
  String get agileSprintScopeNoSprintDesc =>
      'Inicie um sprint para monitorar as variações de scope';

  @override
  String get agileSprintScopeOriginal => 'Original';

  @override
  String get agileSprintScopeCurrent => 'Atual';

  @override
  String get agileSprintScopeDelta => 'Delta';

  @override
  String get agileSprintScopeCreep => 'Scope Creep';

  @override
  String get agileSprintScopeReduction => 'Redução de Scope';

  @override
  String get agileSprintScopeStable => 'Estável';

  @override
  String get agileSprintScopeSp => 'SP';

  @override
  String get landingIntegrationBadge => 'Integração';

  @override
  String get landingIntegrationTitle => 'Integrações';

  @override
  String get landingIntegrationSubtitle =>
      'Conecte suas ferramentas favoritas ao Keisen';

  @override
  String get landingIntegrationFlowTitle => 'Fluxo de Integração';

  @override
  String get landingIntegrationStep1 => 'Crie o projeto';

  @override
  String get landingIntegrationStep1Desc =>
      'Configure o projeto e defina os parâmetros iniciais.';

  @override
  String get landingIntegrationStep2 => 'Adicione o time';

  @override
  String get landingIntegrationStep2Desc =>
      'Convide os membros do time e atribua os papéis.';

  @override
  String get landingIntegrationStep3 => 'Planeje o trabalho';

  @override
  String get landingIntegrationStep3Desc =>
      'Crie stories, estime e priorize o backlog.';

  @override
  String get landingIntegrationStep4 => 'Execute os sprints';

  @override
  String get landingIntegrationStep4Desc =>
      'Gerencie o trabalho com Board e Burndown em tempo real.';

  @override
  String get landingIntegrationStep5 => 'Analise os resultados';

  @override
  String get landingIntegrationStep5Desc =>
      'Revise métricas, velocity e melhore continuamente.';

  @override
  String get landingIntegrationExport0Title => 'Google Sheets';

  @override
  String get landingIntegrationExport0Desc =>
      'Exporte os dados para Google Sheets para análises avançadas.';

  @override
  String get landingIntegrationExport1Title => 'JIRA';

  @override
  String get landingIntegrationExport1Desc =>
      'Sincronize com JIRA para gerenciamento de tickets.';

  @override
  String get landingIntegrationExport2Title => 'Exportação CSV';

  @override
  String get landingIntegrationExport2Desc =>
      'Exporte relatórios em formato CSV para processamento externo.';

  @override
  String get landingIntegrationExport3Title => 'Compartilhamento por Link';

  @override
  String get landingIntegrationExport3Desc =>
      'Compartilhe dados via link direto com os stakeholders.';

  @override
  String get landingIntegrationDashboardTitle => 'Dashboard Integrado';

  @override
  String get landingIntegrationDashboardDesc =>
      'Visualize todos os dados do seu projeto em um único dashboard integrado.';

  @override
  String jiraTransitionTitle(Object transitionName) {
    return 'Transição JIRA';
  }

  @override
  String get jiraTransitionInfo => 'Informações da transição';

  @override
  String get jiraTransitionConfirm => 'Confirmar transição';

  @override
  String get jiraTransitionCancel => 'Cancelar';

  @override
  String get jiraFieldRequired => 'Campo obrigatório';

  @override
  String jiraSyncSuccess(Object transitionName) {
    return 'Sincronização concluída';
  }

  @override
  String jiraSyncedTo(Object statusName) {
    return 'Sincronizado com';
  }

  @override
  String jiraSyncFromSuccess(Object issueKey) {
    return 'Sincronização do JIRA concluída';
  }

  @override
  String jiraSyncFailed(Object error) {
    return 'Falha na sincronização';
  }

  @override
  String jiraSyncWarning(Object warning) {
    return 'Aviso de sincronização';
  }

  @override
  String get actionSyncJira => 'Sincronizar com Jira';

  @override
  String get validationRequired => 'Obbligatorio';

  @override
  String get jiraInvalidDomain => 'Domínio inválido';

  @override
  String get jiraInvalidEmail => 'E-mail inválido';

  @override
  String get jiraCreateTokenLink => 'Criar token da API';

  @override
  String get agileHelpTitle => 'Guia Rápido';

  @override
  String get agileHelpStep1Title => 'Popule o Backlog';

  @override
  String get agileHelpStep1Desc =>
      'Crie User Stories na aba Backlog para definir o trabalho a ser realizado.';

  @override
  String get agileHelpStep2Title => 'Planeje o Sprint';

  @override
  String get agileHelpStep2Desc =>
      'Vá na aba Sprint, crie um novo sprint e selecione as stories do backlog.';

  @override
  String get agileHelpStep3Title => 'Trabalhe na Board';

  @override
  String get agileHelpStep3Desc =>
      'Use a aba Board para visualizar o progresso. Arraste os cards para atualizar';

  @override
  String get agileHelpStep4Title => 'Sincronize e Feche';

  @override
  String get agileHelpStep4Desc =>
      'Se o Jira estiver conectado, os status se atualizam automaticamente. Use \'Concluir Sprint\'';

  @override
  String get actionNext => 'Avançar';

  @override
  String get actionBack => 'Voltar';

  @override
  String get actionFinish => 'Concluir';

  @override
  String get agileStartSprintHint =>
      'Inicie o Sprint para ver as stories ativas';

  @override
  String get workflowTitle => 'Flusso di Lavoro';

  @override
  String get workflowShowButton => 'Mostra Flusso';

  @override
  String get workflowDiagramTitle => 'Diagramma Flusso Stati';

  @override
  String get workflowLegend => 'Legenda';

  @override
  String get workflowScrumDesc =>
      'In Scrum, le storie fluiscono attraverso Sprint Planning, Sviluppo, Review e Done. Il flusso è iterativo con sprint a tempo definito.';

  @override
  String get workflowKanbanDesc =>
      'In Kanban, il lavoro fluisce continuamente. Le storie vengono tirate (pull) nel sistema in base ai limiti WIP e alla capacità.';

  @override
  String get workflowHybridDesc =>
      'Hybrid combina sprint Scrum con flusso Kanban. Le storie possono essere tirate continuamente o pianificate negli sprint.';

  @override
  String get workflowFromAny => 'Da Qualunque';

  @override
  String get workflowFromAnyDesc => 'Può transitare da qualunque stato';

  @override
  String get workflowCycleLabel => 'Rework';

  @override
  String get workflowCycleDesc => 'Transizione bidirezionale (ciclo)';

  @override
  String get workflowOptionalDesc => 'Step opzionale (può saltare)';

  @override
  String get kanbanPoliciesActive => 'Policy Attive (Controlli Automatici)';

  @override
  String get kanbanPoliciesExplicit => 'Policy Esplicite (Note per il team)';
}
