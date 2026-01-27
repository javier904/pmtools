// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get smartTodoListOrigin => 'Lista di appartenenza';

  @override
  String get newRetro => 'Nueva Retro';

  @override
  String get appTitle => 'Keisen';

  @override
  String get goToHome => 'Ir al inicio';

  @override
  String get actionSave => 'Guardar';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionDelete => 'Eliminar';

  @override
  String get actionEdit => 'Editar';

  @override
  String get actionCreate => 'Crear';

  @override
  String get actionAdd => 'Añadir';

  @override
  String get actionClose => 'Cerrar';

  @override
  String get actionRetry => 'Reintentar';

  @override
  String get actionConfirm => 'Confirmar';

  @override
  String get actionSearch => 'Buscar';

  @override
  String get actionFilter => 'Filtrar';

  @override
  String get actionExport => 'Exportar';

  @override
  String get actionCopy => 'Copiar';

  @override
  String get actionShare => 'Compartir';

  @override
  String get actionDone => 'Hecho';

  @override
  String get actionReset => 'Restablecer';

  @override
  String get actionOpen => 'Abrir';

  @override
  String get stateLoading => 'Cargando...';

  @override
  String get stateEmpty => 'Sin elementos';

  @override
  String get stateError => 'Error';

  @override
  String get stateSuccess => 'Éxito';

  @override
  String get subscriptionCurrent => 'ACTUAL';

  @override
  String get subscriptionRecommended => 'RECOMENDADO';

  @override
  String get subscriptionFree => 'Gratis';

  @override
  String get subscriptionPerMonth => '/mes';

  @override
  String get subscriptionPerYear => '/año';

  @override
  String subscriptionSaveYearly(String amount) {
    return 'Ahorra $amount con el plan anual';
  }

  @override
  String subscriptionTrialDays(int days) {
    return '$days días de prueba gratis';
  }

  @override
  String get subscriptionUnlimitedProjects => 'Proyectos ilimitados';

  @override
  String subscriptionProjectsActive(int count) {
    return '$count proyectos activos';
  }

  @override
  String get subscriptionUnlimitedLists => 'Listas ilimitadas';

  @override
  String subscriptionSmartTodoLists(int count) {
    return '$count listas Smart Todo';
  }

  @override
  String get subscriptionActiveProjectsLabel => 'Proyectos Activos';

  @override
  String get subscriptionSmartTodoListsLabel => 'Listas Smart Todo';

  @override
  String get subscriptionUnlimitedTasks => 'Tareas ilimitadas';

  @override
  String subscriptionTasksPerProject(int count) {
    return '$count tareas por proyecto';
  }

  @override
  String get subscriptionUnlimitedInvites => 'Invitaciones ilimitadas';

  @override
  String subscriptionInvitesPerProject(int count) {
    return '$count invitaciones por proyecto';
  }

  @override
  String get subscriptionWithAds => 'Con anuncios';

  @override
  String get subscriptionWithoutAds => 'Sin anuncios';

  @override
  String get authSignInGoogle => 'Iniciar sesión con Google';

  @override
  String get authSignOut => 'Cerrar sesión';

  @override
  String get authLogoutConfirm => '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String get formNameRequired => 'Introduce tu nombre';

  @override
  String get authError => 'Error de autenticación';

  @override
  String get authUserNotFound => 'Usuario no encontrado';

  @override
  String get authWrongPassword => 'Contraseña incorrecta';

  @override
  String get authEmailInUse => 'El correo ya está en uso';

  @override
  String get authWeakPassword => 'Contraseña demasiado débil';

  @override
  String get authInvalidEmail => 'Correo electrónico inválido';

  @override
  String get appSubtitle => 'Herramientas Ágiles para Equipos';

  @override
  String get authOr => 'o';

  @override
  String get authPassword => 'Contraseña';

  @override
  String get authRegister => 'Registrarse';

  @override
  String get authLogin => 'Iniciar sesión';

  @override
  String get authHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get authNoAccount => '¿No tienes una cuenta?';

  @override
  String get navHome => 'Inicio';

  @override
  String get navProfile => 'Perfil';

  @override
  String get navSettings => 'Configuración';

  @override
  String get eisenhowerTitle => 'Matriz Eisenhower';

  @override
  String get eisenhowerYourMatrices => 'Tus matrices';

  @override
  String get eisenhowerNoMatrices => 'No hay matrices creadas';

  @override
  String get eisenhowerNewMatrix => 'Nueva Matriz';

  @override
  String get eisenhowerViewGrid => 'Cuadrícula';

  @override
  String get eisenhowerViewChart => 'Gráfico';

  @override
  String get eisenhowerViewList => 'Lista';

  @override
  String get eisenhowerViewRaci => 'RACI';

  @override
  String get quadrantUrgent => 'URGENTE';

  @override
  String get quadrantNotUrgent => 'NO URGENTE';

  @override
  String get quadrantImportant => 'IMPORTANTE';

  @override
  String get quadrantNotImportant => 'NO IMPORTANTE';

  @override
  String get quadrantQ1Title => 'HACER AHORA';

  @override
  String get quadrantQ2Title => 'PROGRAMAR';

  @override
  String get quadrantQ3Title => 'DELEGAR';

  @override
  String get quadrantQ4Title => 'ELIMINAR';

  @override
  String get quadrantQ1Subtitle => 'Urgente e Importante';

  @override
  String get quadrantQ2Subtitle => 'Importante, No Urgente';

  @override
  String get quadrantQ3Subtitle => 'Urgente, No Importante';

  @override
  String get quadrantQ4Subtitle => 'No Urgente, No Importante';

  @override
  String get eisenhowerNoActivities => 'Sin actividades';

  @override
  String get eisenhowerNewActivity => 'Nueva Actividad';

  @override
  String get eisenhowerExportSheets => 'Exportar a Google Sheets';

  @override
  String get eisenhowerInviteParticipants => 'Invitar Participantes';

  @override
  String get eisenhowerDeleteMatrix => 'Eliminar Matriz';

  @override
  String get eisenhowerDeleteMatrixConfirm =>
      '¿Estás seguro de que quieres eliminar esta matriz?';

  @override
  String get eisenhowerActivityTitle => 'Título de la actividad';

  @override
  String get eisenhowerActivityNotes => 'Notas';

  @override
  String get eisenhowerDueDate => 'Fecha límite';

  @override
  String get eisenhowerPriority => 'Prioridad';

  @override
  String get eisenhowerAssignee => 'Asignado a';

  @override
  String get eisenhowerCompleted => 'Completado';

  @override
  String get eisenhowerMoveToQuadrant => 'Mover al cuadrante';

  @override
  String get eisenhowerMatrixSettings => 'Configuración de la Matriz';

  @override
  String get eisenhowerBackToList => 'Lista';

  @override
  String get eisenhowerPriorityList => 'Lista de Prioridades';

  @override
  String get eisenhowerAllActivities => 'Todas las actividades';

  @override
  String get eisenhowerToVote => 'Por votar';

  @override
  String get eisenhowerVoted => 'Votado';

  @override
  String get eisenhowerTotal => 'Total';

  @override
  String get eisenhowerEditParticipants => 'Editar participantes';

  @override
  String eisenhowerActivityCountLabel(int count) {
    return '$count actividades';
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
  String get eisenhowerQuadrant => 'Cuadrante';

  @override
  String get eisenhowerUrgencyAvg => 'Urgencia promedio';

  @override
  String get eisenhowerImportanceAvg => 'Importancia promedio';

  @override
  String get eisenhowerVotesLabel => 'Votos:';

  @override
  String get eisenhowerNoVotesYet => 'Aún no se han recogido votos';

  @override
  String get eisenhowerEditMatrix => 'Editar Matriz';

  @override
  String get eisenhowerAddActivity => 'Añadir Actividad';

  @override
  String get eisenhowerDeleteActivity => 'Eliminar Actividad';

  @override
  String eisenhowerDeleteActivityConfirm(String title) {
    return '¿Estás seguro de que quieres eliminar \"$title\"?';
  }

  @override
  String get eisenhowerMatrixCreated => 'Matriz creada con éxito';

  @override
  String get eisenhowerMatrixUpdated => 'Matriz actualizada';

  @override
  String get eisenhowerMatrixDeleted => 'Matriz eliminada';

  @override
  String get eisenhowerActivityAdded => 'Actividad añadida';

  @override
  String get eisenhowerActivityDeleted => 'Actividad eliminada';

  @override
  String get eisenhowerVotesSaved => 'Votos guardados';

  @override
  String get eisenhowerExportCompleted => '¡Exportación completada!';

  @override
  String get eisenhowerExportCompletedDialog => 'Exportación Completada';

  @override
  String get eisenhowerExportDialogContent =>
      'Se ha creado el Google Sheets.\n¿Quieres abrirlo en el navegador?';

  @override
  String get eisenhowerOpen => 'Abrir';

  @override
  String get eisenhowerAddParticipantsFirst =>
      'Añade participantes a la matriz primero';

  @override
  String get eisenhowerSearchLabel => 'Buscar:';

  @override
  String get eisenhowerSearchHint => 'Buscar matrices...';

  @override
  String get eisenhowerNoMatrixFound => 'No se encontró ninguna matriz';

  @override
  String get eisenhowerCreateFirstMatrix =>
      'Crea tu primera Matriz Eisenhower\npara organizar tus prioridades';

  @override
  String get eisenhowerCreateMatrix => 'Crear Matriz';

  @override
  String get eisenhowerClickToOpen => 'Matriz Eisenhower\nHaz clic para abrir';

  @override
  String get eisenhowerTotalActivities => 'Total de actividades en la matriz';

  @override
  String get eisenhowerVotedActivities => 'Actividades votadas';

  @override
  String get eisenhowerPendingVoting => 'Actividades por votar';

  @override
  String get eisenhowerStartVoting => 'Iniciar Votación Independiente';

  @override
  String eisenhowerStartVotingDesc(String title) {
    return '¿Quieres iniciar una sesión de votación independiente para \"$title\"?\n\nCada participante votará sin ver los votos de los demás, hasta que todos hayan votado y se revelen los votos.';
  }

  @override
  String get eisenhowerStart => 'Iniciar';

  @override
  String get eisenhowerVotingStarted => 'Votación iniciada';

  @override
  String get eisenhowerResetVoting => '¿Restablecer Votación?';

  @override
  String get eisenhowerResetVotingDesc => 'Todos los votos serán eliminados.';

  @override
  String get eisenhowerVotingReset => 'Votación restablecida';

  @override
  String get eisenhowerMinVotersRequired =>
      'Se requieren al menos 2 votantes para la votación independiente';

  @override
  String eisenhowerDeleteMatrixWithActivities(int count) {
    return 'También se eliminarán las $count actividades.';
  }

  @override
  String eisenhowerYourMatricesCount(int filtered, int total) {
    return 'Tus matrices ($filtered/$total)';
  }

  @override
  String get formTitleRequired => 'Introduce un título';

  @override
  String get formTitleHint => 'Ej.: Prioridades Q1 2025';

  @override
  String get formDescriptionHint => 'Descripción opcional';

  @override
  String get formParticipantHint => 'Nombre del participante';

  @override
  String get formAddParticipantHint =>
      'Añade al menos un participante para votar';

  @override
  String get formActivityTitleHint => 'Ej.: Completar documentación de la API';

  @override
  String get errorCreatingMatrix => 'Error al crear la matriz';

  @override
  String get errorUpdatingMatrix => 'Error al actualizar';

  @override
  String get errorDeletingMatrix => 'Error al eliminar';

  @override
  String get errorAddingActivity => 'Error al añadir actividad';

  @override
  String get errorSavingVotes => 'Error al guardar votos';

  @override
  String get errorExport => 'Error durante la exportación';

  @override
  String get errorStartingVoting => 'Error al iniciar votación';

  @override
  String get errorResetVoting => 'Error al restablecer';

  @override
  String get errorLoadingActivities => 'Error al cargar actividades';

  @override
  String get eisenhowerWaitingForVotes => 'In attesa di voti';

  @override
  String eisenhowerVotedParticipants(int ready, int total) {
    return '$ready/$total voti';
  }

  @override
  String get eisenhowerVoteSubmit => 'VOTA';

  @override
  String get eisenhowerVotedSuccess => 'Hai votato';

  @override
  String get eisenhowerRevealVotes => 'RIVELA VOTI';

  @override
  String get eisenhowerQuickVote => 'Voto Rapido';

  @override
  String get eisenhowerTeamVote => 'Voto Team';

  @override
  String get eisenhowerUrgency => 'URGENCIA';

  @override
  String get eisenhowerImportance => 'IMPORTANCIA';

  @override
  String get eisenhowerUrgencyShort => 'U:';

  @override
  String get eisenhowerImportanceShort => 'I:';

  @override
  String get eisenhowerVotingInProgress => 'VOTAZIONE IN CORSO';

  @override
  String get eisenhowerWaitingForOthers =>
      'In attesa che tutti votino. Il facilitatore rivelerà i voti.';

  @override
  String get eisenhowerReady => 'Pronto';

  @override
  String get eisenhowerWaiting => 'In attesa';

  @override
  String get eisenhowerIndividualVotes => 'VOTI INDIVIDUALI';

  @override
  String get eisenhowerResult => 'RISULTATO';

  @override
  String get eisenhowerAverage => 'MEDIA';

  @override
  String get eisenhowerVotesRevealed => 'Voti Rivelati';

  @override
  String get eisenhowerNextActivity => 'Prossima Attività';

  @override
  String get eisenhowerNoVotesRecorded => 'Nessun voto registrato';

  @override
  String get eisenhowerWaitingForStart => 'In attesa';

  @override
  String get eisenhowerPreVotesTooltip =>
      'Voti anticipati che verranno conteggiati quando il facilitatore avvia la votazione';

  @override
  String get eisenhowerObserverWaiting =>
      'In attesa che il facilitatore avvii la votazione collettiva';

  @override
  String get eisenhowerPreVoteTooltip =>
      'Esprimi il tuo voto in anticipo. Verrà conteggiato quando la votazione sarà avviata.';

  @override
  String get eisenhowerPreVote => 'Pre-vota';

  @override
  String get eisenhowerPreVoted => 'Hai pre-votato';

  @override
  String get eisenhowerStartVotingTooltip =>
      'Avvia la sessione di votazione collettiva. I pre-voti esistenti verranno preservati.';

  @override
  String get eisenhowerResetVotingTooltip =>
      'Resetta la votazione cancellando tutti i voti';

  @override
  String get eisenhowerObserverWaitingVotes =>
      'Osservando la votazione in corso...';

  @override
  String get eisenhowerWaitingForAllVotes =>
      'In attesa che tutti i partecipanti votino';

  @override
  String get eisenhowerRevealTooltipReady =>
      'Tutti hanno votato! Clicca per rivelare i risultati.';

  @override
  String eisenhowerRevealTooltipNotReady(int count) {
    return 'Mancano ancora $count voti';
  }

  @override
  String get eisenhowerVotingLocked => 'Votazione chiusa';

  @override
  String get eisenhowerVotingLockedTooltip =>
      'I voti sono stati rivelati. Non è più possibile votare su questa attività.';

  @override
  String eisenhowerOnlineParticipants(int online, int total) {
    return '$online di $total partecipanti online';
  }

  @override
  String get eisenhowerVoting => 'Votazione';

  @override
  String get eisenhowerAllActivitiesVoted =>
      'Tutte le attività sono state votate!';

  @override
  String get estimationTitle => 'Sala de Estimación';

  @override
  String get estimationYourSessions => 'Tus sesiones';

  @override
  String get estimationNoSessions => 'No hay sesiones creadas';

  @override
  String get estimationNewSession => 'Nueva Sesión';

  @override
  String get estimationEditSession => 'Editar Sesión';

  @override
  String get estimationJoinSession => 'Unirse a la sesión';

  @override
  String get estimationSessionCode => 'Código de sesión';

  @override
  String get estimationEnterCode => 'Introduce el código';

  @override
  String get sessionStatusDraft => 'Borrador';

  @override
  String get sessionStatusActive => 'Activa';

  @override
  String get sessionStatusCompleted => 'Completada';

  @override
  String get sessionName => 'Nombre de la Sesión';

  @override
  String get sessionNameRequired => 'Nombre de la Sesión *';

  @override
  String get sessionNameHint => 'Ej.: Sprint 15 - Estimación de User Stories';

  @override
  String get sessionDescription => 'Descripción';

  @override
  String get sessionCardSet => 'Conjunto de Cartas';

  @override
  String get cardSetFibonacci =>
      'Fibonacci (0, 1, 2, 3, 5, 8, 13, 20, 40, 100, ?, ?)';

  @override
  String get cardSetSimplified => 'Simplificado (1, 2, 3, 5, 8, 13, ?, ?)';

  @override
  String get sessionEstimationMode => 'Modo de Estimación';

  @override
  String get sessionEstimationModeLocked =>
      'No se puede cambiar el modo después de iniciar la votación';

  @override
  String get sessionAutoReveal => 'Revelar automáticamente';

  @override
  String get sessionAutoRevealDesc => 'Revelar cuando todos voten';

  @override
  String get sessionAllowObservers => 'Observadores';

  @override
  String get sessionAllowObserversDesc => 'Permitir participantes que no voten';

  @override
  String get sessionConfiguration => 'Configuración';

  @override
  String get voteConsensus => '¡Consenso alcanzado!';

  @override
  String get voteResults => 'Resultados de la Votación';

  @override
  String get voteRevote => 'Volver a votar';

  @override
  String get voteReveal => 'Revelar';

  @override
  String get voteHide => 'Ocultar';

  @override
  String get voteAverage => 'Promedio';

  @override
  String get voteMedian => 'Mediana';

  @override
  String get voteMode => 'Moda';

  @override
  String get voteVoters => 'Votantes';

  @override
  String get voteDistribution => 'Distribución de votos';

  @override
  String get voteFinalEstimate => 'Estimación final';

  @override
  String get voteSelectFinal => 'Seleccionar estimación final';

  @override
  String get voteAverageTooltip => 'Media aritmética de los votos numéricos';

  @override
  String get voteMedianTooltip =>
      'Valor central cuando los votos están ordenados';

  @override
  String get voteModeTooltip =>
      'Voto más frecuente (el valor elegido más veces)';

  @override
  String get voteVotersTooltip => 'Número total de participantes que votaron';

  @override
  String get voteWaiting => 'Esperando votos...';

  @override
  String get voteSubmitted => 'Voto enviado';

  @override
  String get voteNotSubmitted => 'No votado';

  @override
  String get storyToEstimate => 'Historia a estimar';

  @override
  String get storyTitle => 'Título de la historia';

  @override
  String get storyDescription => 'Descripción de la historia';

  @override
  String get storyAddNew => 'Añadir historia';

  @override
  String get storyNoStories => 'No hay historias para estimar';

  @override
  String get storyComplete => 'Historia completada';

  @override
  String get storySkip => 'Omitir historia';

  @override
  String get estimationModeFibonacci => 'Fibonacci';

  @override
  String get estimationModeTshirt => 'Tallas de Camiseta';

  @override
  String get estimationModeDecimal => 'Decimal';

  @override
  String get estimationModeThreePoint => 'Tres Puntos (PERT)';

  @override
  String get estimationModeDotVoting => 'Votación por Puntos';

  @override
  String get estimationModeBucketSystem => 'Sistema de Cubos';

  @override
  String get estimationModeFiveFingers => 'Cinco Dedos';

  @override
  String get estimationVotesRevealed => 'Votos Revelados';

  @override
  String get estimationVotingInProgress => 'Votación en Curso';

  @override
  String estimationVotesCountFormatted(int count, int total) {
    return '$count/$total votos';
  }

  @override
  String get estimationConsensusReached => '¡Consenso alcanzado!';

  @override
  String get estimationVotingResults => 'Resultados de la Votación';

  @override
  String get estimationRevote => 'Votar de nuevo';

  @override
  String get estimationAverage => 'Promedio';

  @override
  String get estimationAverageTooltip =>
      'Media aritmética de los votos numéricos';

  @override
  String get estimationMedian => 'Mediana';

  @override
  String get estimationMedianTooltip =>
      'Valor central cuando los votos están ordenados';

  @override
  String get estimationMode => 'Moda';

  @override
  String get estimationModeTooltip =>
      'Voto más frecuente (el valor elegido más veces)';

  @override
  String get estimationVoters => 'Votantes';

  @override
  String get estimationVotersTooltip => 'Número total de participantes';

  @override
  String get estimationVoteDistribution => 'Distribución de Votos';

  @override
  String get estimationSelectFinalEstimate => 'Seleccionar Estimación Final';

  @override
  String get estimationFinalEstimate => 'Estimación Final';

  @override
  String get eisenhowerChartTitle => 'Distribución de Actividades';

  @override
  String get quadrantLabelDo => 'Q1 - HACER';

  @override
  String get quadrantLabelPlan => 'Q2 - PLANIFICAR';

  @override
  String get quadrantLabelDelegate => 'Q3 - DELEGAR';

  @override
  String get quadrantLabelEliminate => 'Q4 - ELIMINAR';

  @override
  String get eisenhowerNoRatedActivities => 'Sin actividades votadas';

  @override
  String get eisenhowerVoteToSeeChart =>
      'Vota actividades para verlas en el gráfico';

  @override
  String get eisenhowerChartCardTitle => 'Gráfico de Distribución';

  @override
  String get raciAddColumnTitle => 'Añadir Columna RACI';

  @override
  String get raciColumnType => 'Tipo';

  @override
  String get raciTypePerson => 'Persona (Participante)';

  @override
  String get raciTypeCustom => 'Personalizado (Equipo/Otro)';

  @override
  String get raciSelectParticipant => 'Seleccionar participante';

  @override
  String get raciColumnName => 'Nombre de la columna';

  @override
  String get raciColumnNameHint => 'Ej.: Equipo de desarrollo';

  @override
  String get raciDeleteColumnTitle => 'Eliminar Columna';

  @override
  String raciDeleteColumnConfirm(String name) {
    return '¿Eliminar columna \'$name\'? Se perderán las asignaciones.';
  }

  @override
  String estimationOnlineParticipants(int online, int total) {
    return '$online de $total participantes en línea';
  }

  @override
  String get estimationNewStoryTitle => 'Nueva Historia';

  @override
  String get estimationStoryTitleLabel => 'Título *';

  @override
  String get estimationStoryTitleHint => 'Ej: HU-123: Como usuario quiero...';

  @override
  String get estimationStoryDescriptionLabel => 'Descripción';

  @override
  String get estimationStoryDescriptionHint =>
      'Criterios de aceptación, notas...';

  @override
  String get estimationEnterTitleAlert => 'Introduce un título';

  @override
  String get estimationParticipantsHeader => 'Participantes';

  @override
  String get estimationRoleFacilitator => 'Facilitador';

  @override
  String get estimationRoleVoters => 'Votantes';

  @override
  String get estimationRoleObservers => 'Observadores';

  @override
  String get estimationYouSuffix => '(tú)';

  @override
  String get estimationDecimalTitle => 'Estimación decimal';

  @override
  String get estimationDecimalHint =>
      'Ingresa tu estimación en días (ej: 1.5, 2.25)';

  @override
  String get estimationQuickSelect => 'Selección rápida:';

  @override
  String get estimationDaysSuffix => 'días';

  @override
  String estimationVoteValue(String value) {
    return 'Voto: $value días';
  }

  @override
  String get estimationEnterValueAlert => 'Introduce un valor';

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
  String get retroTitle => 'Mis Retrospectivas';

  @override
  String get retroNoRetros => 'Sin retrospectivas';

  @override
  String get retroCreateNew => 'Crear Nueva';

  @override
  String get retroGuidance => 'Guida alle Retrospettive';

  @override
  String get retroSearchHint => 'Cerca retrospettiva...';

  @override
  String get retroNoResults => 'Nessun risultato per la ricerca';

  @override
  String get retroFilterAll => 'Tutte';

  @override
  String get retroFilterActive => 'Active';

  @override
  String get retroFilterCompleted => 'Completed';

  @override
  String get retroFilterDraft => 'Draft';

  @override
  String get retroDeleteTitle => 'Elimina Retrospettiva';

  @override
  String retroDeleteConfirm(String title) {
    return '¿Estás seguro?';
  }

  @override
  String get retroDeleteSuccess => 'Retrospettiva eliminata con successo';

  @override
  String retroDeleteError(String error) {
    return 'Errore durante l\'eliminazione: $error';
  }

  @override
  String get retroDeleteConfirmAction => 'Elimina definitivamente';

  @override
  String get retroNewRetroTitle => 'Nuova Retrospettiva';

  @override
  String get retroLinkToSprint => 'Collega a Sprint?';

  @override
  String get retroNoProjectFound => 'Nessun progetto trovato.';

  @override
  String get retroSelectProject => 'Seleziona Progetto';

  @override
  String get retroSelectSprint => 'Seleziona Sprint';

  @override
  String retroSprintLabel(int number, String name) {
    return 'Sprint $number: $name';
  }

  @override
  String get retroSessionTitle => 'Titolo Sessione';

  @override
  String get retroSessionTitleHint => 'Es: Weekly Sync, Project Review...';

  @override
  String get retroTemplateLabel => 'Template';

  @override
  String get retroVotesPerUser => 'Voti per utente:';

  @override
  String get retroActionClose => 'Chiudi';

  @override
  String get retroActionCreate => 'Crea';

  @override
  String get retroStatusDraft => 'Borrador';

  @override
  String get retroStatusActive => 'En Progreso';

  @override
  String get retroStatusCompleted => 'Completada';

  @override
  String get retroTemplateStartStopContinue => 'Start, Stop, Continue';

  @override
  String get retroTemplateSailboat => 'Velero';

  @override
  String get retroTemplate4Ls => '4 Ls';

  @override
  String get retroTemplateStarfish => 'Estrella de Mar';

  @override
  String get retroTemplateMadSadGlad => 'Mad Sad Glad';

  @override
  String get retroTemplateDAKI => 'DAKI (Drop Add Keep Improve)';

  @override
  String get retroDescStartStopContinue =>
      'Orientada a la acción: Empezar, Parar, Continuar.';

  @override
  String get retroDescSailboat =>
      'Visual: Viento (empuja), Anclas (frena), Rocas (riesgos), Isla (metas).';

  @override
  String get retroDesc4Ls =>
      'Liked (Gustó), Learned (Aprendió), Lacked (Faltó), Longed For (Deseó).';

  @override
  String get retroDescStarfish => 'Keep, Stop, Start, More, Less.';

  @override
  String get retroDescMadSadGlad => 'Emocional: Enojado, Triste, Feliz.';

  @override
  String get retroDescDAKI =>
      'Pragmática: Eliminar, Añadir, Mantener, Mejorar.';

  @override
  String get retroUsageStartStopContinue =>
      'Mejor para feedback accionable y cambios de comportamiento.';

  @override
  String get retroUsageSailboat =>
      'Mejor para visualizar el viaje del equipo, metas y riesgos. Bueno para pensamiento creativo.';

  @override
  String get retroUsage4Ls =>
      'Reflexiva: Mejor para aprender del pasado y destacar aspectos emocionales.';

  @override
  String get retroUsageStarfish =>
      'Calibración: Mejor para escalar esfuerzos (hacer más/menos), no solo binario.';

  @override
  String get retroUsageMadSadGlad =>
      'Mejor para check-ins emocionales, resolver conflictos o tras un sprint estresante.';

  @override
  String get retroUsageDAKI =>
      'Decisiva: Mejor para limpieza. Foco en decisiones concretas.';

  @override
  String get retroIcebreakerSentiment => 'Voto de Sentimiento';

  @override
  String get retroIcebreakerOneWord => 'Una Palabra';

  @override
  String get retroIcebreakerWeather => 'Reporte Meteorológico';

  @override
  String get retroIcebreakerSentimentDesc =>
      'Vota del 1 al 5 cómo te sentiste durante el sprint.';

  @override
  String get retroIcebreakerOneWordDesc =>
      'Describe el sprint con una sola palabra.';

  @override
  String get retroIcebreakerWeatherDesc =>
      'Elige un icono del clima que represente el sprint.';

  @override
  String get retroPhaseIcebreaker => 'ROMPEHIELOS';

  @override
  String get retroPhaseWriting => 'ESCRITURA';

  @override
  String get retroPhaseVoting => 'VOTACIÓN';

  @override
  String get retroPhaseDiscuss => 'DISCUSIÓN';

  @override
  String get retroActionItemsLabel => 'Action Items';

  @override
  String get retroActionDragToCreate =>
      'Trascina qui una card per creare un Action Item collegato';

  @override
  String get retroNoActionItems => 'Aún no se han creado Action Items.';

  @override
  String get facilitatorGuideNextColumn => 'Siguiente: Recoger acción de';

  @override
  String get collectionRationaleSSC =>
      'Primero Stop para remover bloqueantes, luego Start nuevas prácticas, finalmente Continue lo que funciona.';

  @override
  String get collectionRationaleMSG =>
      'Primero abordar las frustraciones, luego las decepciones, luego celebrar los éxitos.';

  @override
  String get collectionRationale4Ls =>
      'Primero llenar vacíos, luego planificar aspiraciones futuras, mantener lo que funciona, compartir aprendizajes.';

  @override
  String get collectionRationaleSailboat =>
      'Primero mitigar riesgos, remover bloqueantes, luego aprovechar facilitadores y alinearse a objetivos.';

  @override
  String get collectionRationaleStarfish =>
      'Detener malas prácticas, reducir otras, mantener las buenas, aumentar las valiosas, iniciar nuevas.';

  @override
  String get collectionRationaleDAKI =>
      'Drop para liberar capacidad, Add nuevas prácticas, Improve existentes, Keep lo que funciona.';

  @override
  String get missingSuggestionSSCStop =>
      'Considera qué práctica está bloqueando al equipo y debería detenerse.';

  @override
  String get missingSuggestionSSCStart =>
      'Piensa en qué nueva práctica podría ayudar al equipo a mejorar.';

  @override
  String get missingSuggestionMSGMad =>
      'Aborda las frustraciones del equipo - ¿qué está causando enojo?';

  @override
  String get missingSuggestionMSGSad =>
      'Resuelve las decepciones - ¿qué entristeció al equipo?';

  @override
  String get missingSuggestion4LsLacked =>
      '¿Qué faltaba que el equipo necesitaba?';

  @override
  String get missingSuggestion4LsLonged =>
      '¿Qué desea el equipo para el futuro?';

  @override
  String get missingSuggestionSailboatAnchor =>
      '¿Qué está impidiendo al equipo alcanzar sus objetivos?';

  @override
  String get missingSuggestionSailboatRock =>
      '¿Qué riesgos amenazan el progreso del equipo?';

  @override
  String get missingSuggestionStarfishStop =>
      '¿Qué práctica debería el equipo dejar de hacer completamente?';

  @override
  String get missingSuggestionStarfishStart =>
      '¿Qué nueva práctica debería comenzar el equipo?';

  @override
  String get missingSuggestionDAKIDrop =>
      '¿Qué debería el equipo decidir eliminar?';

  @override
  String get missingSuggestionDAKIAdd =>
      '¿Qué nueva decisión debería tomar el equipo?';

  @override
  String get missingSuggestionGeneric =>
      'Considera crear una acción desde esta columna.';

  @override
  String get facilitatorGuideAllCovered =>
      '¡Todas las columnas requeridas cubiertas!';

  @override
  String get facilitatorGuideMissing => 'Mancano azioni per';

  @override
  String get retroPhaseStart => 'Inizia';

  @override
  String get retroPhaseStop => 'Smetti';

  @override
  String get retroPhaseContinue => 'Continua';

  @override
  String get retroColumnMad => 'Enfadado';

  @override
  String get retroColumnSad => 'Triste';

  @override
  String get retroColumnGlad => 'Contento';

  @override
  String get retroColumnLiked => 'Gustado';

  @override
  String get retroColumnLearned => 'Aprendido';

  @override
  String get retroColumnLacked => 'Faltado';

  @override
  String get retroColumnLonged => 'Desiderato';

  @override
  String get retroColumnWind => 'Viento';

  @override
  String get retroColumnAnchor => 'Anclas';

  @override
  String get retroColumnRock => 'Rocas';

  @override
  String get retroColumnGoal => 'Isla';

  @override
  String get retroColumnKeep => 'Mantener';

  @override
  String get retroColumnMore => 'Más';

  @override
  String get retroColumnLess => 'Menos';

  @override
  String get retroColumnDrop => 'Eliminar';

  @override
  String get retroColumnAdd => 'Añadir';

  @override
  String get retroColumnImprove => 'Mejorar';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get formTitle => 'Título';

  @override
  String get formDescription => 'Descripción';

  @override
  String get formName => 'Nombre';

  @override
  String get formRequired => 'Campo obligatorio';

  @override
  String get formHint => 'Introduce un valor';

  @override
  String get formOptional => 'Opcional';

  @override
  String errorGeneric(String error) {
    return 'Error: $error';
  }

  @override
  String get errorLoading => 'Error al cargar datos';

  @override
  String get errorSaving => 'Error al guardar';

  @override
  String get errorNetwork => 'Error de conexión';

  @override
  String get errorPermission => 'Permiso denegado';

  @override
  String get errorNotFound => 'No encontrado';

  @override
  String get successSaved => 'Guardado con éxito';

  @override
  String get successDeleted => 'Eliminado con éxito';

  @override
  String get successCopied => 'Copiado al portapapeles';

  @override
  String get filterAll => 'Todos';

  @override
  String get filterRemove => 'Quitar filtros';

  @override
  String get filterActive => 'Activo';

  @override
  String get filterCompleted => 'Completado';

  @override
  String get participants => 'Participantes';

  @override
  String get addParticipant => 'Añadir participante';

  @override
  String get removeParticipant => 'Eliminar participante';

  @override
  String get noParticipants => 'Sin participantes';

  @override
  String get participantJoined => 'se unió';

  @override
  String get participantLeft => 'salió';

  @override
  String get participantRole => 'Rol';

  @override
  String get participantVoter => 'Votante';

  @override
  String get participantObserver => 'Observador';

  @override
  String get participantModerator => 'Moderador';

  @override
  String get confirmDelete => 'Confirmar eliminación';

  @override
  String get confirmDeleteMessage => 'Esta acción no se puede deshacer.';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get ok => 'OK';

  @override
  String get today => 'Hoy';

  @override
  String get yesterday => 'Ayer';

  @override
  String get tomorrow => 'Mañana';

  @override
  String daysAgo(int count) {
    return 'hace $count días';
  }

  @override
  String hoursAgo(int count) {
    return 'hace $count horas';
  }

  @override
  String minutesAgo(int count) {
    return 'hace $count minutos';
  }

  @override
  String itemCount(int count) {
    return '$count elementos';
  }

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String greeting(String name) {
    return '¡Hola, $name!';
  }

  @override
  String get copyLink => 'Copiar enlace';

  @override
  String get shareSession => 'Compartir sesión';

  @override
  String get inviteByEmail => 'Invitar por correo';

  @override
  String get inviteByLink => 'Invitar por enlace';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileEmail => 'Correo electrónico';

  @override
  String get profileDisplayName => 'Nombre para mostrar';

  @override
  String get profilePhotoUrl => 'Foto de perfil';

  @override
  String get profileEditProfile => 'Editar perfil';

  @override
  String get profileReload => 'Recargar';

  @override
  String get profilePersonalInfo => 'Información Personal';

  @override
  String get profileLastName => 'Apellido';

  @override
  String get profileCompany => 'Empresa';

  @override
  String get profileJobTitle => 'Cargo';

  @override
  String get profileBio => 'Biografía';

  @override
  String get profileSubscription => 'Suscripción';

  @override
  String get profilePlan => 'Plan';

  @override
  String get profileBillingCycle => 'Ciclo de facturación';

  @override
  String get profilePrice => 'Precio';

  @override
  String get profileActivationDate => 'Fecha de activación';

  @override
  String get profileTrialEnd => 'Fin del período de prueba';

  @override
  String get profileNextRenewal => 'Próxima renovación';

  @override
  String get profileDaysRemaining => 'Días restantes';

  @override
  String get profileUpgrade => 'Mejorar';

  @override
  String get profileUpgradePlan => 'Mejorar Plan';

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
  String get cycleMonthly => 'Mensile';

  @override
  String get cycleQuarterly => 'Trimestrale';

  @override
  String get cycleYearly => 'Annuale';

  @override
  String get cycleLifetime => 'Sempre';

  @override
  String get pricePerMonth => 'mese';

  @override
  String get pricePerQuarter => 'trim';

  @override
  String get pricePerYear => 'anno';

  @override
  String get priceForever => 'sempre';

  @override
  String get priceFree => 'Gratuito';

  @override
  String get profileGeneralSettings => 'Configuración General';

  @override
  String get profileAnimations => 'Animaciones';

  @override
  String get profileAnimationsDesc => 'Habilitar animaciones de la interfaz';

  @override
  String get profileFeatures => 'Funcionalidades';

  @override
  String get profileCalendarIntegration => 'Integración con Calendario';

  @override
  String get profileCalendarIntegrationDesc =>
      'Sincronizar sprints y fechas límite';

  @override
  String get profileExportSheets => 'Exportar a Google Sheets';

  @override
  String get profileExportSheetsDesc => 'Exportar datos a hojas de cálculo';

  @override
  String get profileBetaFeatures => 'Funciones Beta';

  @override
  String get profileBetaFeaturesDesc => 'Acceso anticipado a nuevas funciones';

  @override
  String get profileAdvancedMetrics => 'Métricas Avanzadas';

  @override
  String get profileAdvancedMetricsDesc => 'Estadísticas e informes detallados';

  @override
  String get profileNotifications => 'Notificaciones';

  @override
  String get profileEmailNotifications => 'Notificaciones por Correo';

  @override
  String get profileEmailNotificationsDesc =>
      'Recibir actualizaciones por correo';

  @override
  String get profilePushNotifications => 'Notificaciones Push';

  @override
  String get profilePushNotificationsDesc => 'Notificaciones del navegador';

  @override
  String get profileSprintReminders => 'Recordatorios de Sprint';

  @override
  String get profileSprintRemindersDesc =>
      'Alertas para fechas límite de sprint';

  @override
  String get profileSessionInvites => 'Invitaciones a Sesiones';

  @override
  String get profileSessionInvitesDesc => 'Notificaciones para nuevas sesiones';

  @override
  String get profileWeeklySummary => 'Resumen Semanal';

  @override
  String get profileWeeklySummaryDesc => 'Informe de actividad semanal';

  @override
  String get profileDangerZone => 'Zona de Peligro';

  @override
  String get profileDeleteAccount => 'Eliminar Cuenta';

  @override
  String get profileDeleteAccountDesc =>
      'Solicitar la eliminación permanente de tu cuenta y todos los datos asociados';

  @override
  String get profileDeleteAccountRequest => 'Solicitar';

  @override
  String get profileDeleteAccountIrreversible =>
      'Esta acción es irreversible. Todos tus datos serán eliminados permanentemente.';

  @override
  String get profileDeleteAccountReason => 'Motivo (opcional)';

  @override
  String get profileDeleteAccountReasonHint =>
      '¿Por qué quieres eliminar tu cuenta?';

  @override
  String get profileRequestDeletion => 'Solicitar Eliminación';

  @override
  String get profileDeletionInProgress => 'Eliminación en progreso';

  @override
  String profileDeletionRequestedAt(String date) {
    return 'Solicitada el $date';
  }

  @override
  String get profileCancelRequest => 'Cancelar solicitud';

  @override
  String get profileDeletionRequestSent => 'Solicitud de eliminación enviada';

  @override
  String get profileDeletionRequestCancelled => 'Solicitud cancelada';

  @override
  String get profileUpdated => 'Perfil actualizado';

  @override
  String get profileLogout => 'Cerrar sesión';

  @override
  String get profileLogoutDesc => 'Desconectar tu cuenta de este dispositivo';

  @override
  String get profileLogoutConfirm =>
      '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String get profileSubscriptionCancelled => 'Suscripción cancelada';

  @override
  String get profileCancelSubscription => 'Cancelar Suscripción';

  @override
  String get profileCancelSubscriptionConfirm =>
      '¿Estás seguro de que quieres cancelar tu suscripción? Continuarás usando las funciones premium hasta el final del período actual.';

  @override
  String get profileKeepSubscription => 'No, mantenerla';

  @override
  String get profileYesCancel => 'Sí, cancelar';

  @override
  String profileUpgradeComingSoon(String plan) {
    return 'Mejora a $plan próximamente...';
  }

  @override
  String get profileFree => 'Gratis';

  @override
  String get profileMonthly => 'EUR/mes';

  @override
  String get profileUser => 'Usuario';

  @override
  String profileErrorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get stateSaving => 'Guardando...';

  @override
  String get cardCoffee => 'Descanso';

  @override
  String get cardQuestion => 'No sé';

  @override
  String get toolEisenhower => 'Matriz Eisenhower';

  @override
  String get toolEisenhowerDesc =>
      'Organiza actividades por urgencia e importancia. Cuadrantes para decidir qué hacer ahora, programar, delegar o eliminar.';

  @override
  String get toolEisenhowerDescShort => 'Prioriza por urgencia e importancia';

  @override
  String get toolEstimation => 'Sala de Estimación';

  @override
  String get toolEstimationDesc =>
      'Sesiones de estimación colaborativas para el equipo. Planning Poker, tallas de camiseta y otros métodos para estimar historias de usuario.';

  @override
  String get toolEstimationDescShort => 'Sesiones de estimación colaborativas';

  @override
  String get toolSmartTodo => 'Smart Todo';

  @override
  String get toolSmartTodoDesc =>
      'Listas inteligentes y colaborativas. Importa desde CSV/texto, invita participantes y gestiona tareas con filtros avanzados.';

  @override
  String get toolSmartTodoDescShort =>
      'Listas inteligentes y colaborativas. Importa desde CSV, invita y gestiona.';

  @override
  String get toolAgileProcess => 'Gestor de Procesos Ágiles';

  @override
  String get toolAgileProcessDesc =>
      'Gestiona proyectos ágiles completos con backlog, planificación de sprints, tablero kanban, métricas y retrospectivas.';

  @override
  String get toolAgileProcessDescShort =>
      'Gestiona proyectos ágiles con backlog, sprints, kanban y métricas.';

  @override
  String get toolRetro => 'Tablero de Retrospectiva';

  @override
  String get toolRetroDesc =>
      'Recoge feedback del equipo sobre qué salió bien, qué mejorar y acciones a tomar.';

  @override
  String get toolRetroDescShort =>
      'Recoge feedback del equipo sobre qué salió bien y qué mejorar.';

  @override
  String get homeUtilities => 'Utilidades';

  @override
  String get homeSelectTool => 'Selecciona una herramienta para empezar';

  @override
  String get statusOnline => 'En línea';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get featureComingSoon => '¡Esta función estará disponible pronto!';

  @override
  String get featureSmartImport => 'Importación Inteligente';

  @override
  String get featureCollaboration => 'Colaboración';

  @override
  String get featureFilters => 'Filtros';

  @override
  String get feature4Quadrants => '4 Cuadrantes';

  @override
  String get featureDragDrop => 'Arrastrar y Soltar';

  @override
  String get featureCollaborative => 'Colaborativo';

  @override
  String get featurePlanningPoker => 'Planning Poker';

  @override
  String get featureTshirtSize => 'Talla de Camiseta';

  @override
  String get featureRealtime => 'Tiempo Real';

  @override
  String get featureScrum => 'Scrum';

  @override
  String get featureKanban => 'Kanban';

  @override
  String get featureHybrid => 'Híbrido';

  @override
  String get featureWentWell => 'Fue Bien';

  @override
  String get featureToImprove => 'A Mejorar';

  @override
  String get featureActions => 'Acciones';

  @override
  String get themeLightMode => 'Modo Claro';

  @override
  String get themeDarkMode => 'Modo Oscuro';

  @override
  String get estimationBackToSessions => 'Volver a sesiones';

  @override
  String get estimationSessionSettings => 'Configuración de Sesión';

  @override
  String get estimationList => 'Lista';

  @override
  String estimationSessionsCount(int filtered, int total) {
    return 'Tus sesiones ($filtered/$total)';
  }

  @override
  String get estimationNoSessionFound => 'No se encontró ninguna sesión';

  @override
  String get estimationCreateFirstSession =>
      'Crea tu primera sesión de estimación\npara estimar actividades con el equipo';

  @override
  String get estimationStoriesTotal => 'Total de historias';

  @override
  String get estimationStoriesCompleted => 'Historias completadas';

  @override
  String get estimationParticipantsActive => 'Participantes activos';

  @override
  String estimationProgress(int completed, int total, String percent) {
    return 'Progreso: $completed/$total historias ($percent%)';
  }

  @override
  String get estimationStart => 'Iniciar';

  @override
  String get estimationComplete => 'Completar';

  @override
  String get estimationAllStoriesEstimated =>
      '¡Todas las historias han sido estimadas!';

  @override
  String get estimationNoVotingInProgress => 'No hay votación en curso';

  @override
  String estimationCompletedLabel(
    int completed,
    int total,
    String total_estimate,
  ) {
    return 'Completado: $completed/$total | Estimación total: $total_estimate pt';
  }

  @override
  String estimationVoteStory(String title) {
    return 'Votar: $title';
  }

  @override
  String get estimationAddStoriesToStart => 'Añade historias para empezar';

  @override
  String get estimationInVoting => 'EN VOTACIÓN';

  @override
  String get estimationReveal => 'Revelar';

  @override
  String get estimationSkip => 'Omitir';

  @override
  String get estimationStories => 'Historias';

  @override
  String get estimationAddStory => 'Añadir Historia';

  @override
  String get estimationStartVoting => 'Iniciar votación';

  @override
  String get estimationViewVotes => 'Ver votos';

  @override
  String get estimationViewDetail => 'Ver detalle';

  @override
  String get estimationFinalEstimateLabel => 'Estimación final:';

  @override
  String estimationVotesOf(String title) {
    return 'Votos: $title';
  }

  @override
  String get estimationParticipantVotes => 'Votos de participantes:';

  @override
  String get estimationPointsOrDays => 'puntos / días';

  @override
  String get estimationEstimateRationale =>
      'Justificación de la estimación (opcional)';

  @override
  String get estimationExplainRationale =>
      'Explica la justificación de la estimación...\nEj.: Alta complejidad técnica, dependencias externas...';

  @override
  String get estimationRationaleHelp =>
      'La justificación ayuda al equipo a recordar las decisiones tomadas durante la estimación.';

  @override
  String get estimationConfirmFinalEstimate => 'Confirmar Estimación Final';

  @override
  String get estimationEnterValidEstimate => 'Introduce una estimación válida';

  @override
  String get estimationHintEstimate => 'Ej.: 5, 8, 13...';

  @override
  String get estimationStatus => 'Estado';

  @override
  String get estimationOrder => 'Orden';

  @override
  String get estimationVotesReceived => 'Votos recibidos';

  @override
  String get estimationAverageVotes => 'Promedio de votos';

  @override
  String get estimationConsensus => 'Consenso';

  @override
  String get storyStatusPending => 'Pendiente';

  @override
  String get storyStatusVoting => 'Votando';

  @override
  String get storyStatusRevealed => 'Votos revelados';

  @override
  String get participantManagement => 'Gestión de Participantes';

  @override
  String get participantCopySessionLink => 'Copiar enlace de sesión';

  @override
  String get participantInvitesTab => 'Invitaciones';

  @override
  String get participantSessionLink =>
      'Enlace de Sesión (compartir con participantes)';

  @override
  String get participantAddDirect => 'Añadir Participante Directo';

  @override
  String get participantEmailRequired => 'Correo electrónico *';

  @override
  String get participantEmailHint => 'correo@ejemplo.com';

  @override
  String get participantNameHint => 'Nombre para mostrar';

  @override
  String participantVotersAndObservers(int voters, int observers) {
    return '$voters votantes, $observers observadores';
  }

  @override
  String get participantYou => '(tú)';

  @override
  String get participantMakeVoter => 'Hacer Votante';

  @override
  String get participantMakeObserver => 'Hacer Observador';

  @override
  String get participantRemoveTitle => 'Eliminar Participante';

  @override
  String participantRemoveConfirm(String name) {
    return '¿Estás seguro de que quieres eliminar a \"$name\" de la sesión?';
  }

  @override
  String participantAddedToSession(String email) {
    return '$email añadido a la sesión';
  }

  @override
  String participantRemovedFromSession(String name) {
    return '$name eliminado de la sesión';
  }

  @override
  String participantRoleUpdated(String email) {
    return 'Rol actualizado para $email';
  }

  @override
  String get participantFacilitator => 'Facilitador';

  @override
  String get inviteSendNew => 'Enviar Nueva Invitación';

  @override
  String get inviteRecipientEmail => 'Correo del destinatario *';

  @override
  String get inviteCreate => 'Crear Invitación';

  @override
  String get invitesSent => 'Invitaciones Enviadas';

  @override
  String get inviteNoInvites => 'No hay invitaciones enviadas';

  @override
  String inviteCreatedFor(String email) {
    return 'Invitación creada para $email';
  }

  @override
  String inviteSentTo(String email) {
    return 'Invitación enviada por email a $email';
  }

  @override
  String inviteExpiresIn(int days) {
    return 'Expira en ${days}d';
  }

  @override
  String get inviteCopyLink => 'Copiar enlace';

  @override
  String get inviteRevokeAction => 'Revocar invitación';

  @override
  String get inviteDeleteAction => 'Eliminar invitación';

  @override
  String get inviteRevokeTitle => '¿Revocar invitación?';

  @override
  String inviteRevokeConfirm(String email) {
    return '¿Estás seguro de que quieres revocar la invitación para $email?';
  }

  @override
  String get inviteRevoke => 'Revocar';

  @override
  String inviteRevokedFor(String email) {
    return 'Invitación revocada para $email';
  }

  @override
  String get inviteDeleteTitle => 'Eliminar Invitación';

  @override
  String inviteDeleteConfirm(String email) {
    return '¿Estás seguro de que quieres eliminar la invitación para $email?\n\nEsta acción es irreversible.';
  }

  @override
  String inviteDeletedFor(String email) {
    return 'Invitación eliminada para $email';
  }

  @override
  String get inviteLinkCopied => '¡Enlace copiado!';

  @override
  String get linkCopied => 'Enlace copiado al portapapeles';

  @override
  String get enterValidEmail => 'Introduce una dirección de correo válida';

  @override
  String get sessionCreatedSuccess => 'Sesión creada con éxito';

  @override
  String get sessionUpdated => 'Sesión actualizada';

  @override
  String get sessionDeleted => 'Sesión eliminada';

  @override
  String get sessionStarted => 'Sesión iniciada';

  @override
  String get sessionCompletedSuccess => 'Sesión completada';

  @override
  String get sessionNotFound => 'Sesión no encontrada';

  @override
  String get storyAdded => 'Historia añadida';

  @override
  String get storyDeleted => 'Historia eliminada';

  @override
  String estimateSaved(String estimate) {
    return 'Estimación guardada: $estimate';
  }

  @override
  String get deleteSessionTitle => 'Eliminar Sesión';

  @override
  String deleteSessionConfirm(String name, int count) {
    return '¿Estás seguro de que quieres eliminar \"$name\"?\nTambién se eliminarán las $count historias.';
  }

  @override
  String get deleteStoryTitle => 'Eliminar Historia';

  @override
  String deleteStoryConfirm(String title) {
    return '¿Estás seguro de que quieres eliminar \"$title\"?';
  }

  @override
  String get errorLoadingSession => 'Error al cargar sesión';

  @override
  String get errorLoadingStories => 'Error al cargar historias';

  @override
  String get errorCreatingSession => 'Error al crear sesión';

  @override
  String get errorUpdatingSession => 'Error al actualizar';

  @override
  String get errorDeletingSession => 'Error al eliminar';

  @override
  String get errorAddingStory => 'Error al añadir historia';

  @override
  String get errorStartingSession => 'Error al iniciar sesión';

  @override
  String get errorCompletingSession => 'Error al completar sesión';

  @override
  String get errorSubmittingVote => 'Error al enviar voto';

  @override
  String get errorRevealingVotes => 'Error al revelar';

  @override
  String get errorSavingEstimate => 'Error al guardar estimación';

  @override
  String get errorSkipping => 'Error al omitir';

  @override
  String get retroIcebreakerTitle => 'Rompehielos: Moral del Equipo';

  @override
  String get retroIcebreakerQuestion => '¿Cómo te sentiste en este sprint?';

  @override
  String retroParticipantsVoted(int count) {
    return '$count participantes votaron';
  }

  @override
  String get retroEndIcebreakerStartWriting =>
      'Terminar Rompehielos e Iniciar Escritura';

  @override
  String get retroMoodTerrible => 'Terrible';

  @override
  String get retroMoodBad => 'Mal';

  @override
  String get retroMoodNeutral => 'Neutral';

  @override
  String get retroMoodGood => 'Bien';

  @override
  String get retroMoodExcellent => 'Excelente';

  @override
  String get actionSubmit => 'Invia';

  @override
  String get retroIcebreakerOneWordTitle => 'Icebreaker: Una Parola';

  @override
  String get retroIcebreakerOneWordQuestion =>
      'Descrivi questo sprint con UNA sola parola';

  @override
  String get retroIcebreakerOneWordHint => 'La tua parola...';

  @override
  String get retroIcebreakerSubmitted => 'Inviato!';

  @override
  String retroIcebreakerWordsSubmitted(int count) {
    return '$count parole inviate';
  }

  @override
  String get retroIcebreakerWeatherTitle => 'Icebreaker: Meteo';

  @override
  String get retroIcebreakerWeatherQuestion =>
      'Quale meteo rappresenta meglio come ti senti riguardo a questo sprint?';

  @override
  String get retroWeatherSunny => 'Soleggiato';

  @override
  String get retroWeatherPartlyCloudy => 'Parz. nuvoloso';

  @override
  String get retroWeatherCloudy => 'Nuvoloso';

  @override
  String get retroWeatherRainy => 'Piovoso';

  @override
  String get retroWeatherStormy => 'Tempestoso';

  @override
  String get retroAgileCoach => 'Coach Ágil';

  @override
  String get retroCoachSetup =>
      'Elige una plantilla. \"Start/Stop/Continue\" es genial para equipos nuevos. Asegúrate de que todos estén presentes.';

  @override
  String get retroCoachIcebreaker =>
      '¡Rompe el hielo! Haz una ronda rápida preguntando \"¿Cómo estás?\" o usa una pregunta divertida.';

  @override
  String get retroCoachWriting =>
      'Estamos en modo INCÓGNITO. Escribe tarjetas libremente, nadie verá lo que escribes hasta el final. ¡Evita sesgos!';

  @override
  String get retroCoachVoting =>
      '¡Hora de Revisión! Todas las tarjetas son visibles. Léelas y usa tus 3 votos para decidir qué discutir.';

  @override
  String get retroCoachDiscuss =>
      'Enfócate en las tarjetas más votadas. Define Action Items claros: ¿Quién hace qué y cuándo?';

  @override
  String get retroCoachCompleted =>
      '¡Buen trabajo! La retrospectiva está completa. Los Action Items han sido enviados al Backlog.';

  @override
  String retroStep(int step, String title) {
    return 'Paso $step: $title';
  }

  @override
  String retroCurrentFocus(String title) {
    return 'Enfoque actual: $title';
  }

  @override
  String get retroCanvasMinColumns =>
      'La plantilla requiere al menos 4 columnas (estilo Velero)';

  @override
  String retroAddTo(String title) {
    return 'Añadir a $title';
  }

  @override
  String get retroNoColumnsConfigured => 'No hay columnas configuradas.';

  @override
  String get retroNewActionItem => 'Nuevo Action Item';

  @override
  String get retroEditActionItem => 'Editar Action Item';

  @override
  String get retroActionWhatToDo => '¿Qué hay que hacer?';

  @override
  String get retroActionDescriptionHint => 'Describe la acción concreta...';

  @override
  String get retroActionRequired => 'Obligatorio';

  @override
  String get retroActionLinkedCard => 'Vinculada a Tarjeta Retro (Opcional)';

  @override
  String get retroActionNone => 'Ninguna';

  @override
  String get retroActionType => 'Tipo de acción';

  @override
  String get retroActionNoType => 'Sin tipo específico';

  @override
  String get retroActionAssignee => 'Responsable';

  @override
  String get retroActionNoAssignee => 'Ninguno';

  @override
  String get retroActionPriority => 'Prioridad';

  @override
  String get retroActionDueDate => 'Fecha Límite';

  @override
  String get retroActionSelectDate => 'Seleccionar fecha...';

  @override
  String get retroActionSupportResources => 'Recursos de Apoyo';

  @override
  String get retroActionResourcesHint =>
      'Herramientas, presupuesto, personal adicional necesario...';

  @override
  String get retroActionMonitoring => 'Método de Seguimiento';

  @override
  String get retroActionMonitoringHint =>
      '¿Cómo verificaremos el progreso? (ej. Daily, Review...)';

  @override
  String get retroActionResourcesShort => 'Rec';

  @override
  String get retroTableRef => 'Ref.';

  @override
  String get retroTableSourceColumn => 'Columna';

  @override
  String get retroTableDescription => 'Descripción';

  @override
  String get retroTableOwner => 'Responsable';

  @override
  String get retroIcebreakerTwoTruths => 'Due Verità e una Bugia';

  @override
  String get retroDescTwoTruths => 'Semplice e classico.';

  @override
  String get retroIcebreakerCheckin => 'Check-in Emotivo';

  @override
  String get retroDescCheckin => 'Come si sentono tutti?';

  @override
  String get retroTableActions => 'Acciones';

  @override
  String get retroSupportResources => 'Recursos de Soporte';

  @override
  String get retroMonitoringMethod => 'Método de Monitoreo';

  @override
  String get retroUnassigned => 'Sin asignar';

  @override
  String get retroDeleteActionItem => 'Eliminar Action Item';

  @override
  String get retroChooseMethodology => 'Elegir Metodología';

  @override
  String get retroHidingWhileTyping => 'Ocultando mientras escribes...';

  @override
  String retroVoteLimitReached(int max) {
    return '¡Has alcanzado el límite de $max votos!';
  }

  @override
  String get retroAddCardHint => '¿Cuáles son tus pensamientos?';

  @override
  String get retroAddCard => 'Añadir Tarjeta';

  @override
  String get retroTimeUp => '¡Se Acabó el Tiempo!';

  @override
  String get retroTimeUpMessage =>
      'El tiempo para esta fase ha terminado. Termina la discusión o extiende el tiempo.';

  @override
  String get retroTimeUpOk => 'Ok, entendido';

  @override
  String get retroStopTimer => 'Detener Temporizador';

  @override
  String get retroStartTimer => 'Iniciar Temporizador';

  @override
  String retroTimerMinutes(int minutes) {
    return '$minutes Min';
  }

  @override
  String get retroAddCardButton => 'Aggiungi Card';

  @override
  String get retroNoRetrosFound => 'No se encontraron retrospectivas';

  @override
  String get retroDeleteRetro => 'Eliminar Retrospectiva';

  @override
  String get retroParticipantsLabel => 'Participantes';

  @override
  String get retroNotesCreated => 'Notas creadas';

  @override
  String retroStatusLabel(String status) {
    return 'Estado: $status';
  }

  @override
  String retroDateLabel(String date) {
    return 'Fecha: $date';
  }

  @override
  String retroSprintDefault(int number) {
    return 'Sprint $number';
  }

  @override
  String get smartTodoNoTasks => 'No hay tareas en esta lista';

  @override
  String get smartTodoNoTasksInColumn => 'Sin tareas';

  @override
  String smartTodoCompletionStats(int completed, int total) {
    return '$completed/$total completadas';
  }

  @override
  String get smartTodoCreatedDate => 'Fecha de creación';

  @override
  String get smartTodoParticipantRole => 'Participante';

  @override
  String get smartTodoUnassigned => 'Sin asignar';

  @override
  String get smartTodoNewTask => 'Nueva Tarea';

  @override
  String get smartTodoEditTask => 'Editar';

  @override
  String get smartTodoTaskTitle => 'Título de la tarea';

  @override
  String get smartTodoDescription => 'DESCRIPCIÓN';

  @override
  String get smartTodoDescriptionHint => 'Añadir una descripción detallada...';

  @override
  String get smartTodoChecklist => 'CHECKLIST';

  @override
  String get smartTodoAddChecklistItem => 'Añadir elemento';

  @override
  String get smartTodoAttachments => 'ADJUNTOS';

  @override
  String get smartTodoAddLink => 'Añadir Enlace';

  @override
  String get smartTodoComments => 'COMENTARIOS';

  @override
  String get smartTodoWriteComment => 'Escribe un comentario...';

  @override
  String get smartTodoAddImageTooltip => 'Añadir Imagen (URL)';

  @override
  String get smartTodoStatus => 'ESTADO';

  @override
  String get smartTodoPriority => 'PRIORIDAD';

  @override
  String get smartTodoAssignees => 'ASIGNADOS';

  @override
  String get smartTodoNoAssignee => 'Nadie';

  @override
  String get smartTodoTags => 'ETIQUETAS';

  @override
  String get smartTodoNoTags => 'Sin etiquetas';

  @override
  String get smartTodoDueDate => 'FECHA LÍMITE';

  @override
  String get smartTodoSetDate => 'Establecer fecha';

  @override
  String get smartTodoEffort => 'ESFUERZO';

  @override
  String get smartTodoEffortHint => 'Puntos (ej. 5)';

  @override
  String get smartTodoAssignTo => 'Asignar a';

  @override
  String get smartTodoSelectTags => 'Seleccionar Etiquetas';

  @override
  String get smartTodoNoTagsAvailable =>
      'No hay etiquetas disponibles. Crea una en configuración.';

  @override
  String get smartTodoNewSubtask => 'Nuevo estado';

  @override
  String get smartTodoAddLinkTitle => 'Añadir Enlace';

  @override
  String get smartTodoLinkName => 'Nombre';

  @override
  String get smartTodoLinkUrl => 'URL (https://...)';

  @override
  String get smartTodoCannotOpenLink => 'No se puede abrir el enlace';

  @override
  String get smartTodoPasteImage => 'Pegar Imagen';

  @override
  String get smartTodoPasteImageFound => 'Imagen del portapapeles encontrada.';

  @override
  String get smartTodoPasteImageConfirm =>
      '¿Quieres añadir esta imagen desde tu portapapeles?';

  @override
  String get smartTodoYesAdd => 'Sí, añadir';

  @override
  String get smartTodoAddImage => 'Añadir Imagen';

  @override
  String get smartTodoImageUrlHint =>
      'Pega la URL de la imagen (ej. capturada con CleanShot/Gyazo)';

  @override
  String get smartTodoImageUrl => 'URL de Imagen';

  @override
  String get smartTodoPasteFromClipboard => 'Pegar del Portapapeles';

  @override
  String get smartTodoEditComment => 'Editar comentario';

  @override
  String get smartTodoSortBy => 'Ordenar por';

  @override
  String get smartTodoSortDate => 'Recientes';

  @override
  String get smartTodoSortManual => 'Manual';

  @override
  String get smartTodoColumnSortTitle => 'Ordenar Columna';

  @override
  String get smartTodoPendingTasks => 'Tareas por completar';

  @override
  String get smartTodoCompletedTasks => 'Tareas completadas';

  @override
  String get smartTodoEnterTitle => 'Introduce un título';

  @override
  String get smartTodoUser => 'Usuario';

  @override
  String get smartTodoImportTasks => 'Importar Tareas';

  @override
  String get smartTodoImportStep1 => 'Paso 1: Elegir Fuente';

  @override
  String get smartTodoImportStep2 => 'Paso 2: Mapear Columnas';

  @override
  String get smartTodoImportStep3 => 'Paso 3: Revisar y Confirmar';

  @override
  String get smartTodoImportRetry => 'Reintentar';

  @override
  String get smartTodoImportPasteText => 'Pegar Texto (CSV/Txt)';

  @override
  String get smartTodoImportUploadFile => 'Subir Archivo (CSV)';

  @override
  String get smartTodoImportPasteHint =>
      'Pega tus tareas aquí. Usa coma como separador.';

  @override
  String get smartTodoImportPasteExample =>
      'ej. Comprar leche\nLlamar a María\nTerminar el informe';

  @override
  String get smartTodoImportSelectFile => 'Seleccionar Archivo CSV';

  @override
  String smartTodoImportFileSelected(String fileName) {
    return 'Archivo seleccionado: $fileName';
  }

  @override
  String smartTodoImportFileError(String error) {
    return 'Error al leer archivo: $error';
  }

  @override
  String get smartTodoImportNoData => 'No se encontraron datos';

  @override
  String get smartTodoImportColumnMapping =>
      'Detectamos estas columnas. Mapea cada columna al campo correcto.';

  @override
  String smartTodoImportColumnLabel(int index, String value) {
    return 'Columna $index: \"$value\"';
  }

  @override
  String smartTodoImportSampleValue(String value) {
    return 'Valor de ejemplo: \"$value\"';
  }

  @override
  String smartTodoImportFoundTasks(int count) {
    return 'Se encontraron $count tareas válidas. Revisa antes de importar.';
  }

  @override
  String get smartTodoImportDestinationColumn => 'Destino:';

  @override
  String get smartTodoImportBack => 'Atrás';

  @override
  String get smartTodoImportNext => 'Siguiente';

  @override
  String smartTodoImportButton(int count) {
    return 'Importar $count Tareas';
  }

  @override
  String get smartTodoImportEnterText =>
      'Introduce algún texto o sube un archivo.';

  @override
  String get smartTodoImportNoValidRows => 'No se encontraron filas válidas.';

  @override
  String get smartTodoImportMapTitle => 'Debes mapear al menos el \"Título\".';

  @override
  String smartTodoImportParsingError(String error) {
    return 'Error de Parseo: $error';
  }

  @override
  String smartTodoImportSuccess(int count) {
    return '¡$count tareas importadas!';
  }

  @override
  String smartTodoImportError(String error) {
    return 'Error de Importación: $error';
  }

  @override
  String get smartTodoImportHelpTitle => '¿Cómo importar tareas?';

  @override
  String get smartTodoImportHelpSimpleTitle =>
      'Lista simple (una tarea por línea)';

  @override
  String get smartTodoImportHelpSimpleDesc =>
      'Pega una lista simple con un título por línea. Cada línea se convierte en una tarea.';

  @override
  String get smartTodoImportHelpSimpleExample =>
      'Comprar leche\nLlamar a Mario\nTerminar el informe';

  @override
  String get smartTodoImportHelpCsvTitle => 'Formato CSV (con columnas)';

  @override
  String get smartTodoImportHelpCsvDesc =>
      'Usa valores separados por comas con una fila de encabezado. La primera fila define las columnas.';

  @override
  String get smartTodoImportHelpCsvExample =>
      'title,priority,assignee\nComprar leche,high,mario@email.com\nLlamar a Mario,medium,';

  @override
  String get smartTodoImportHelpFieldsTitle => 'Campos disponibles:';

  @override
  String get smartTodoImportHelpFieldTitle =>
      'Título de la tarea (obligatorio)';

  @override
  String get smartTodoImportHelpFieldDesc => 'Descripción de la tarea';

  @override
  String get smartTodoImportHelpFieldPriority =>
      'high, medium, low (o alta, media, baja)';

  @override
  String get smartTodoImportHelpFieldStatus =>
      'Nombre de la columna (ej: Por hacer, En curso)';

  @override
  String get smartTodoImportHelpFieldAssignee => 'Email del usuario';

  @override
  String get smartTodoImportHelpFieldEffort => 'Horas (número)';

  @override
  String get smartTodoImportHelpFieldTags =>
      'Etiquetas (#tag o separadas por coma)';

  @override
  String smartTodoImportStatusHint(String columns) {
    return 'Columnas disponibles para STATUS: $columns';
  }

  @override
  String get smartTodoImportEmptyColumn => '(columna vacía)';

  @override
  String get smartTodoImportFieldIgnore => '-- Ignorar --';

  @override
  String get smartTodoImportFieldTitle => 'Título';

  @override
  String get smartTodoImportFieldDescription => 'Descripción';

  @override
  String get smartTodoImportFieldPriority => 'Prioridad';

  @override
  String get smartTodoImportFieldStatus => 'Estado (Columna)';

  @override
  String get smartTodoImportFieldAssignee => 'Asignado';

  @override
  String get smartTodoImportFieldEffort => 'Esfuerzo';

  @override
  String get smartTodoImportFieldTags => 'Etiquetas';

  @override
  String get smartTodoDeleteTaskTitle => 'Eliminar tarea';

  @override
  String get smartTodoDeleteTaskContent =>
      '¿Estás seguro de que quieres eliminar esta tarea? Esta acción no se puede deshacer.';

  @override
  String get smartTodoDeleteNoPermission =>
      'No tienes permiso para eliminar esta tarea';

  @override
  String get smartTodoSheetsExportTitle => 'Exportar a Google Sheets';

  @override
  String get smartTodoSheetsExportExists =>
      'Ya existe un documento de Google Sheets para esta lista.';

  @override
  String get smartTodoSheetsOpen => 'Abrir';

  @override
  String get smartTodoSheetsUpdate => 'Actualizar';

  @override
  String get smartTodoSheetsUpdating => 'Actualizando Google Sheets...';

  @override
  String get smartTodoSheetsCreating => 'Creando Google Sheets...';

  @override
  String get smartTodoSheetsUpdated => '¡Google Sheets actualizado!';

  @override
  String get smartTodoSheetsCreated => '¡Google Sheets creado!';

  @override
  String get smartTodoSheetsError => 'Error durante la exportación (ver log)';

  @override
  String get error => 'Error';

  @override
  String smartTodoAuditLogTitle(String title) {
    return 'Registro de auditoría - $title';
  }

  @override
  String get smartTodoAuditFilterUser => 'Usuario';

  @override
  String get smartTodoAuditFilterType => 'Tipo';

  @override
  String get smartTodoAuditFilterAction => 'Acción';

  @override
  String get smartTodoAuditFilterTag => 'Etiqueta';

  @override
  String get smartTodoAuditFilterSearch => 'Buscar';

  @override
  String get smartTodoAuditFilterAll => 'Todos';

  @override
  String get smartTodoAuditFilterAllFemale => 'Todas';

  @override
  String get smartTodoAuditPremiumRequired =>
      'Premium requerido para historial extendido';

  @override
  String smartTodoAuditLastDays(int days) {
    return 'Últimos $days días';
  }

  @override
  String get smartTodoAuditClearFilters => 'Limpiar filtros';

  @override
  String get smartTodoAuditViewTimeline => 'Vista cronológica';

  @override
  String get smartTodoAuditViewColumns => 'Vista columnas';

  @override
  String get smartTodoAuditNoActivity => 'Sin actividad registrada';

  @override
  String get smartTodoAuditNoResults =>
      'Sin resultados para los filtros seleccionados';

  @override
  String smartTodoAuditActivities(int count) {
    return '$count actividades';
  }

  @override
  String get smartTodoAuditNoUserActivity => 'Sin actividad';

  @override
  String get smartTodoAuditLoadMore => 'Cargar 50 más...';

  @override
  String get smartTodoAuditEmptyValue => '(vacío)';

  @override
  String get smartTodoAuditEntityList => 'Lista';

  @override
  String get smartTodoAuditEntityTask => 'Tarea';

  @override
  String get smartTodoAuditEntityInvite => 'Invitación';

  @override
  String get smartTodoAuditEntityParticipant => 'Participante';

  @override
  String get smartTodoAuditEntityColumn => 'Columna';

  @override
  String get smartTodoAuditEntityTag => 'Etiqueta';

  @override
  String get smartTodoAuditActionCreate => 'Creado';

  @override
  String get smartTodoAuditActionUpdate => 'Modificado';

  @override
  String get smartTodoAuditActionDelete => 'Eliminado';

  @override
  String get smartTodoAuditActionArchive => 'Archivado';

  @override
  String get smartTodoAuditActionRestore => 'Restaurado';

  @override
  String get smartTodoAuditActionMove => 'Movido';

  @override
  String get smartTodoAuditActionAssign => 'Asignado';

  @override
  String get smartTodoAuditActionInvite => 'Invitado';

  @override
  String get smartTodoAuditActionJoin => 'Unido';

  @override
  String get smartTodoAuditActionRevoke => 'Revocado';

  @override
  String get smartTodoAuditActionReorder => 'Reordenado';

  @override
  String get smartTodoAuditActionBatchCreate => 'Importar';

  @override
  String get smartTodoAuditTimeNow => 'Ahora';

  @override
  String smartTodoAuditTimeMinutesAgo(int count) {
    return 'Hace $count min';
  }

  @override
  String smartTodoAuditTimeHoursAgo(int count) {
    return 'Hace $count horas';
  }

  @override
  String smartTodoAuditTimeDaysAgo(int count) {
    return 'Hace $count días';
  }

  @override
  String get smartTodoCfdTitle => 'CFD Analytics';

  @override
  String get smartTodoCfdTooltip => 'CFD Analytics';

  @override
  String get smartTodoCfdDateRange => 'Periodo:';

  @override
  String get smartTodoCfd7Days => '7 dias';

  @override
  String get smartTodoCfd14Days => '14 dias';

  @override
  String get smartTodoCfd30Days => '30 dias';

  @override
  String get smartTodoCfd90Days => '90 dias';

  @override
  String get smartTodoCfdError => 'Error al cargar';

  @override
  String get smartTodoCfdRetry => 'Actualizar';

  @override
  String get smartTodoCfdNoData => 'No hay datos disponibles';

  @override
  String get smartTodoCfdNoDataHint =>
      'Los movimientos de tareas se rastrearan aqui';

  @override
  String get smartTodoCfdKeyMetrics => 'Metricas Clave';

  @override
  String get smartTodoCfdLeadTime => 'Lead Time';

  @override
  String get smartTodoCfdLeadTimeTooltip =>
      'Tiempo desde creacion hasta completar';

  @override
  String get smartTodoCfdCycleTime => 'Cycle Time';

  @override
  String get smartTodoCfdCycleTimeTooltip =>
      'Tiempo desde inicio del trabajo hasta completar';

  @override
  String get smartTodoCfdThroughput => 'Rendimiento';

  @override
  String get smartTodoCfdThroughputTooltip => 'Tareas completadas por semana';

  @override
  String get smartTodoCfdWip => 'TEP';

  @override
  String get smartTodoCfdWipTooltip => 'Trabajo en progreso';

  @override
  String get smartTodoCfdLimit => 'Limite';

  @override
  String get smartTodoCfdCompleted => 'completadas';

  @override
  String get smartTodoCfdFlowAnalysis => 'Analisis de Flujo';

  @override
  String get smartTodoCfdArrived => 'Llegados';

  @override
  String get smartTodoCfdBacklogShrinking => 'Backlog disminuyendo';

  @override
  String get smartTodoCfdBacklogGrowing => 'Backlog creciendo';

  @override
  String get smartTodoCfdBottlenecks => 'Deteccion de Cuellos de Botella';

  @override
  String get smartTodoCfdNoBottlenecks => 'Sin cuellos de botella';

  @override
  String get smartTodoCfdTasks => 'tareas';

  @override
  String get smartTodoCfdAvgAge => 'Edad prom';

  @override
  String get smartTodoCfdAgingWip => 'Trabajos en Progreso Envejecidos';

  @override
  String get smartTodoCfdTask => 'Tarea';

  @override
  String get smartTodoCfdColumn => 'Columna';

  @override
  String get smartTodoCfdAge => 'Edad';

  @override
  String get smartTodoCfdDays => 'dias';

  @override
  String get smartTodoCfdHowCalculated => 'Como se calcula?';

  @override
  String get smartTodoCfdMedian => 'Mediana';

  @override
  String get smartTodoCfdP85 => 'P85';

  @override
  String get smartTodoCfdP95 => 'P95';

  @override
  String get smartTodoCfdMin => 'Min';

  @override
  String get smartTodoCfdMax => 'Max';

  @override
  String get smartTodoCfdSample => 'Muestra';

  @override
  String get smartTodoCfdVsPrevious => 'vs periodo anterior';

  @override
  String get smartTodoCfdArrivalRate => 'Tasa de Llegada';

  @override
  String get smartTodoCfdCompletionRate => 'Tasa de Finalizacion';

  @override
  String get smartTodoCfdNetFlow => 'Flujo Neto';

  @override
  String get smartTodoCfdPerDay => '/dia';

  @override
  String get smartTodoCfdPerWeek => '/semana';

  @override
  String get smartTodoCfdSeverity => 'Severidad';

  @override
  String get smartTodoCfdAssignee => 'Asignado';

  @override
  String get smartTodoCfdUnassigned => 'Sin asignar';

  @override
  String get smartTodoCfdLeadTimeExplanation =>
      'El Lead Time mide el tiempo total desde que se crea una tarea hasta que se completa.\n\n**Formula:**\nLead Time = Fecha de Completado - Fecha de Creacion\n\n**Metricas:**\n- **Promedio**: Media de todos los lead times\n- **Mediana**: Valor central (menos sensible a valores atipicos)\n- **P85**: El 85% de las tareas se completan en este tiempo\n- **P95**: El 95% de las tareas se completan en este tiempo\n\n**Por que es importante:**\nEl Lead Time representa la experiencia del cliente - el tiempo total de espera. Usa P85 para dar estimaciones de entrega a los clientes.';

  @override
  String get smartTodoCfdCycleTimeExplanation =>
      'El Cycle Time mide el tiempo desde que el trabajo comienza realmente (la tarea sale de \'Por Hacer\') hasta su finalizacion.\n\n**Formula:**\nCycle Time = Fecha de Completado - Fecha de Inicio del Trabajo\n\n**Diferencia con Lead Time:**\n- **Lead Time** = Perspectiva del cliente (incluye espera)\n- **Cycle Time** = Perspectiva del equipo (solo trabajo activo)\n\n**Como se detecta \'Inicio del Trabajo\':**\nLa primera vez que una tarea sale de la columna \'Por Hacer\' se registra como fecha de inicio del trabajo.';

  @override
  String get smartTodoCfdThroughputExplanation =>
      'El Throughput mide cuantas tareas se completan por unidad de tiempo.\n\n**Formulas:**\n- Promedio Diario = Tareas Completadas / Dias en el Periodo\n- Promedio Semanal = Promedio Diario x 7\n\n**Como usarlo:**\nPronosticar fechas de entrega:\nTareas Restantes / Throughput Semanal = Semanas para Completar\n\n**Ejemplo:**\n30 tareas restantes, throughput de 10/semana = ~3 semanas';

  @override
  String get smartTodoCfdWipExplanation =>
      'El WIP (Work In Progress) cuenta las tareas actualmente en progreso - no en \'Por Hacer\' y no en \'Hecho\'.\n\n**Formula:**\nWIP = Total Tareas - Tareas Por Hacer - Tareas Hechas\n\n**Ley de Little:**\nLead Time = WIP / Throughput\n\nReducir el WIP reduce directamente el Lead Time!\n\n**Limite WIP Sugerido:**\nTamano del Equipo x 2 (mejores practicas Kanban)\n\n**Estado:**\n- Saludable: WIP <= Limite\n- Atencion: WIP > Limite x 1.25\n- Critico: WIP > Limite x 1.5';

  @override
  String get smartTodoCfdFlowExplanation =>
      'El Analisis de Flujo compara la tasa de llegada de nuevas tareas vs tareas completadas.\n\n**Formulas:**\n- Tasa de Llegada = Nuevas Tareas Creadas / Dias\n- Tasa de Finalizacion = Tareas Completadas / Dias\n- Flujo Neto = Completadas - Llegadas\n\n**Interpretacion del estado:**\n- **Vaciando** (Finalizacion > Llegada): WIP disminuyendo - bien!\n- **Equilibrado** (dentro de +/-10%): Flujo estable\n- **Llenando** (Llegada > Finalizacion): WIP aumentando - accion necesaria';

  @override
  String get smartTodoCfdBottleneckExplanation =>
      'La Deteccion de Cuellos de Botella identifica columnas donde las tareas se acumulan o permanecen demasiado tiempo.\n\n**Algoritmo:**\nSeveridad = (Score Conteo + Score Edad) / 2\n\nDonde:\n- Score Conteo = Tareas en Columna / 10\n- Score Edad = Edad Promedio / 7 dias\n\n**Senalado cuando:**\n- 2+ tareas en la columna, O\n- Edad promedio > 2 dias\n\n**Niveles de severidad:**\n- Bajo (< 0.3): Monitorear\n- Medio (0.3-0.6): Investigar\n- Alto (> 0.6): Actuar';

  @override
  String get smartTodoCfdAgingExplanation =>
      'Aging WIP muestra las tareas actualmente en progreso, ordenadas por cuanto tiempo han estado en trabajo.\n\n**Formula:**\nEdad = Hora Actual - Fecha de Inicio del Trabajo (en dias)\n\n**Estado por edad:**\n- Fresco (< 3 dias): Normal\n- Atencion (3-7 dias): Puede necesitar atencion\n- Critico (> 7 dias): Probablemente bloqueado - investigar!\n\nLas tareas antiguas a menudo indican bloqueos, requisitos poco claros o crecimiento del alcance.';

  @override
  String get smartTodoCfdTeamBalance => 'Equilibrio del Equipo';

  @override
  String get smartTodoCfdTeamBalanceExplanation =>
      'El Equilibrio del Equipo muestra la distribucion de tareas entre los miembros.\n\n**Puntuacion de Equilibrio:**\nCalculado usando el coeficiente de variacion (CV).\nPuntuacion = 1 / (1 + CV)\n\n**Estado:**\n- Equilibrado (≥80%): Trabajo distribuido equitativamente\n- Desigual (50-80%): Algun desequilibrio\n- Desequilibrado (<50%): Disparidad significativa\n\n**Columnas:**\n- Por Hacer: Tareas en espera\n- WIP: Tareas en progreso\n- Hecho: Tareas completadas';

  @override
  String get smartTodoCfdBalanced => 'Equilibrado';

  @override
  String get smartTodoCfdUneven => 'Desigual';

  @override
  String get smartTodoCfdImbalanced => 'Desequilibrado';

  @override
  String get smartTodoCfdMember => 'Miembro';

  @override
  String get smartTodoCfdTotal => 'Total';

  @override
  String get smartTodoCfdToDo => 'Por Hacer';

  @override
  String get smartTodoCfdInProgress => 'En Progreso';

  @override
  String get smartTodoCfdDone => 'Hecho';

  @override
  String get smartTodoNewTaskDefault => 'Nueva Tarea';

  @override
  String get smartTodoRename => 'Renombrar';

  @override
  String get smartTodoAddActivity => 'Añadir una actividad';

  @override
  String get smartTodoAddColumn => 'Añadir Columna';

  @override
  String get smartTodoParticipantManagement => 'Gestión de Participantes';

  @override
  String get smartTodoParticipantsTab => 'Participantes';

  @override
  String get smartTodoInvitesTab => 'Invitaciones';

  @override
  String get smartTodoAddParticipant => 'Añadir Participante';

  @override
  String smartTodoMembers(int count) {
    return 'Miembros ($count)';
  }

  @override
  String get smartTodoNoInvitesPending => 'No hay invitaciones pendientes';

  @override
  String smartTodoRoleLabel(String role) {
    return 'Rol: $role';
  }

  @override
  String get smartTodoExpired => 'EXPIRADA';

  @override
  String smartTodoSentBy(String name) {
    return 'Enviado por $name';
  }

  @override
  String get smartTodoResendEmail => 'Reenviar Correo';

  @override
  String get smartTodoRevoke => 'Revocar';

  @override
  String get smartTodoSendingEmail => 'Enviando correo...';

  @override
  String get smartTodoEmailResent => '¡Correo reenviado!';

  @override
  String get smartTodoEmailSendError => 'Error al enviar correo.';

  @override
  String get smartTodoInvalidSession => 'Sesión inválida para enviar correo.';

  @override
  String get smartTodoEmail => 'Correo electrónico';

  @override
  String get smartTodoRole => 'Rol';

  @override
  String get smartTodoInviteCreated =>
      '¡Invitación creada y enviada con éxito!';

  @override
  String get smartTodoInviteCreatedNoEmail =>
      'Invitación creada, pero el correo no se envió (verifica el inicio de sesión/permisos de Google).';

  @override
  String get smartTodoUserAlreadyInvited => 'Usuario ya invitado.';

  @override
  String get smartTodoInviteCollaborator => 'Invitar Colaborador';

  @override
  String get smartTodoEditorRole => 'Editor (Puede editar)';

  @override
  String get smartTodoViewerRole => 'Visor (Solo lectura)';

  @override
  String get smartTodoSendEmailNotification => 'Enviar notificación por correo';

  @override
  String get smartTodoSend => 'Enviar';

  @override
  String get smartTodoInvalidEmail => 'Correo inválido';

  @override
  String get smartTodoUserNotAuthenticated =>
      'Usuario no autenticado o correo faltante';

  @override
  String get smartTodoGoogleLoginRequired =>
      'Se requiere inicio de sesión con Google para enviar correos';

  @override
  String smartTodoInviteSent(String email) {
    return 'Invitación enviada a $email';
  }

  @override
  String get smartTodoUserAlreadyInvitedOrPending =>
      'Usuario ya invitado o invitación pendiente.';

  @override
  String get smartTodoFilterToday => 'Hoy';

  @override
  String get smartTodoFilterMyTasks => 'Mis Tareas';

  @override
  String get smartTodoFilterOwner => 'Propietario';

  @override
  String get smartTodoViewGlobalTasks => 'Ver Tareas Globales';

  @override
  String get smartTodoViewLists => 'Ver Listas';

  @override
  String get smartTodoNewListDialogTitle => 'Nueva Lista';

  @override
  String get smartTodoTitleLabel => 'Título *';

  @override
  String get smartTodoDescriptionLabel => 'Descripción';

  @override
  String get smartTodoCancel => 'Cancelar';

  @override
  String get smartTodoCreate => 'Crear';

  @override
  String get smartTodoSave => 'Guardar';

  @override
  String get smartTodoNoListsPresent => 'No hay listas disponibles';

  @override
  String get smartTodoCreateFirstList => 'Crea tu primera lista para comenzar';

  @override
  String smartTodoMembersCount(int count) {
    return '$count miembros';
  }

  @override
  String get smartTodoRenameListTitle => 'Renombrar Lista';

  @override
  String get smartTodoNewNameLabel => 'Nuevo nombre';

  @override
  String get smartTodoDeleteListTitle => 'Eliminar Lista';

  @override
  String get smartTodoDeleteListConfirm =>
      '¿Seguro que quieres eliminar esta lista y todas sus tareas? Esta acción es irreversible.';

  @override
  String get smartTodoDelete => 'Eliminar';

  @override
  String get smartTodoEdit => 'Editar';

  @override
  String get smartTodoSearchHint => 'Buscar listas...';

  @override
  String get smartTodoSearchTasksHint => 'Buscar...';

  @override
  String smartTodoNoSearchResults(String query) {
    return 'Sin resultados para \"$query\"';
  }

  @override
  String get smartTodoColumnTodo => 'Por Hacer';

  @override
  String get smartTodoColumnInProgress => 'En Progreso';

  @override
  String get smartTodoColumnDone => 'Hecho';

  @override
  String get smartTodoAllPeople => 'Todas las personas';

  @override
  String smartTodoPeopleCount(int count) {
    return '$count personas';
  }

  @override
  String get smartTodoFilterByPerson => 'Filtrar por persona';

  @override
  String get smartTodoApplyFilters => 'Aplicar Filtros';

  @override
  String get smartTodoAllTags => 'Todas las etiquetas';

  @override
  String smartTodoTagsCount(int count) {
    return '$count etiquetas';
  }

  @override
  String get smartTodoFilterByTag => 'Filtrar por etiqueta';

  @override
  String get smartTodoTagAlreadyExists => 'Etiqueta ya existente';

  @override
  String smartTodoError(String error) {
    return 'Error: $error';
  }

  @override
  String get profileMenuTitle => 'Perfil';

  @override
  String get profileMenuLogout => 'Cerrar Sesión';

  @override
  String get profileLogoutDialogTitle => 'Cerrar Sesión';

  @override
  String get profileLogoutDialogConfirm =>
      '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String get agileAddToSprint => 'Añadir al Sprint';

  @override
  String get agileEstimate => 'ESTIMAR';

  @override
  String get agileEstimated => 'Estimado';

  @override
  String get agileEstimateRequired =>
      'Estimación requerida (haz clic para estimar)';

  @override
  String get agilePoints => 'pts';

  @override
  String agilePointsValue(int points) {
    return '$points pts';
  }

  @override
  String get agileMethodologyGuideTitle => 'Guía de Metodología Ágil';

  @override
  String get agileMethodologyGuideSubtitle =>
      'Elige la metodología que mejor se adapte a tu proyecto';

  @override
  String get agileScrumShortDesc =>
      'Sprints de tiempo fijo, Velocidad, Burndown. Ideal para productos con requisitos en evolución.';

  @override
  String get agileKanbanShortDesc =>
      'Flujo continuo, Límites WIP, Lead Time. Ideal para soporte y solicitudes continuas.';

  @override
  String get agileScrumbanShortDesc =>
      'Mezcla de Sprints y flujo continuo. Ideal para equipos que quieren flexibilidad.';

  @override
  String get agileGuide => 'Guía';

  @override
  String get backlogProductBacklog => 'Product Backlog';

  @override
  String get backlogArchiveCompleted => 'Archivo Completado';

  @override
  String get backlogStories => 'historias';

  @override
  String get backlogEstimated => 'estimadas';

  @override
  String get backlogShowActive => 'Mostrar Backlog activo';

  @override
  String backlogShowArchive(int count) {
    return 'Mostrar Archivo ($count completadas)';
  }

  @override
  String get backlogTab => 'Backlog';

  @override
  String backlogArchiveTab(int count) {
    return 'Archivo ($count)';
  }

  @override
  String get backlogFilters => 'Filtros';

  @override
  String get backlogNewStory => 'Nueva Historia';

  @override
  String get backlogSearchHint => 'Buscar por título, descripción o ID...';

  @override
  String get backlogStatusFilter => 'Estado: ';

  @override
  String get backlogPriorityFilter => 'Prioridad: ';

  @override
  String get backlogTagFilter => 'Etiqueta: ';

  @override
  String get backlogAllStatuses => 'Todos';

  @override
  String get backlogAllPriorities => 'Todas';

  @override
  String get backlogRemoveFilters => 'Quitar filtros';

  @override
  String get backlogNoStoryFound => 'No se encontró ninguna historia';

  @override
  String get backlogEmpty => 'Backlog vacío';

  @override
  String get backlogAddFirstStory => 'Añade la primera User Story';

  @override
  String get kanbanWipExceeded =>
      '¡Límite WIP excedido! Completa algunos elementos antes de empezar nuevos.';

  @override
  String get kanbanInfo => 'Info';

  @override
  String get kanbanConfigureWip => 'Configurar WIP';

  @override
  String kanbanWipTooltip(int current, int max) {
    return 'WIP: $current de $max máx';
  }

  @override
  String get kanbanNoWipLimit => 'Sin límite WIP';

  @override
  String kanbanItems(int count) {
    return '$count elementos';
  }

  @override
  String get kanbanEmpty => 'Vacío';

  @override
  String kanbanWipLimitTitle(String column) {
    return 'Límite WIP: $column';
  }

  @override
  String get kanbanWipLimitDesc =>
      'Establece el número máximo de elementos que pueden estar en esta columna al mismo tiempo.';

  @override
  String get kanbanWipLimitLabel => 'Límite WIP';

  @override
  String get kanbanWipLimitHint => 'Dejar vacío para sin límite';

  @override
  String kanbanWipLimitSuggestion(int count) {
    return 'Sugerencia: empieza con $count y ajusta según el equipo.';
  }

  @override
  String get kanbanRemoveLimit => 'Quitar Límite';

  @override
  String get kanbanWipExceededTitle => 'Límite WIP Excedido';

  @override
  String get kanbanWipExceededMessage => 'Mover ';

  @override
  String get kanbanWipExceededIn => ' a ';

  @override
  String get kanbanWipExceededWillExceed => ' excederá el límite WIP.';

  @override
  String kanbanColumnLabel(String name) {
    return 'Columna: $name';
  }

  @override
  String kanbanCurrentCount(int current, int limit) {
    return 'Actual: $current | Límite: $limit';
  }

  @override
  String kanbanAfterMove(int count) {
    return 'Después de mover: $count';
  }

  @override
  String get kanbanSuggestion =>
      'Sugerencia: completa o mueve otros elementos antes de empezar nuevos para mantener un flujo de trabajo óptimo.';

  @override
  String get kanbanMoveAnyway => 'Mover de Todos Modos';

  @override
  String get kanbanWipExplanationTitle => 'Límites WIP';

  @override
  String get kanbanWipWhat => '¿Qué son los Límites WIP?';

  @override
  String get kanbanWipWhatDesc =>
      'Los Límites WIP (Work In Progress) son límites en el número de elementos que pueden estar en una columna al mismo tiempo.';

  @override
  String get kanbanWipWhy => '¿Por qué usarlos?';

  @override
  String get kanbanWipBenefit1 =>
      '- Reducen la multitarea y aumentan el enfoque';

  @override
  String get kanbanWipBenefit2 => '- Destacan los cuellos de botella';

  @override
  String get kanbanWipBenefit3 => '- Mejoran el flujo de trabajo';

  @override
  String get kanbanWipBenefit4 => '- Aceleran la finalización de elementos';

  @override
  String get kanbanWipWhatToDo => '¿Qué hacer si se excede un límite?';

  @override
  String get kanbanWipWhatToDoDesc =>
      '1. Completar o mover elementos existentes antes de empezar nuevos\n2. Ayudar a compañeros a desbloquear elementos en revisión\n3. Analizar por qué se excedió el límite';

  @override
  String get kanbanUnderstood => 'Entendido';

  @override
  String get kanbanBoardTitle => 'Tablero Kanban';

  @override
  String sprintTitle(int count) {
    return 'Sprint ($count)';
  }

  @override
  String get sprintNew => 'Nuevo Sprint';

  @override
  String get sprintNoSprints => 'Sin sprints';

  @override
  String get sprintCreateFirst => 'Crea el primer sprint para empezar';

  @override
  String sprintNumber(int number) {
    return 'Sprint $number';
  }

  @override
  String get sprintStart => 'Iniciar Sprint';

  @override
  String get sprintComplete => 'Completar Sprint';

  @override
  String sprintDays(int days) {
    return '${days}d';
  }

  @override
  String sprintStoriesCount(int count) {
    return '$count';
  }

  @override
  String get sprintStoriesLabel => 'historias';

  @override
  String get sprintPointsPlanned => 'pts';

  @override
  String get sprintPointsCompleted => 'completados';

  @override
  String get sprintVelocity => 'velocidad';

  @override
  String sprintDaysRemaining(int days) {
    return '${days}d restantes';
  }

  @override
  String get sprintStartButton => 'Iniciar';

  @override
  String get sprintCompleteActiveFirst =>
      'Completa el sprint activo antes de iniciar otro';

  @override
  String get sprintEditTitle => 'Editar Sprint';

  @override
  String get sprintNewTitle => 'Nuevo Sprint';

  @override
  String get sprintNameLabel => 'Nombre del Sprint';

  @override
  String get sprintNameHint => 'ej. Sprint 1 - MVP';

  @override
  String get sprintNameRequired => 'Introduce un nombre';

  @override
  String get sprintGoalLabel => 'Objetivo del Sprint';

  @override
  String get sprintGoalHint => 'Objetivo del sprint';

  @override
  String get sprintStartDateLabel => 'Fecha de Inicio';

  @override
  String get sprintEndDateLabel => 'Fecha de Fin';

  @override
  String sprintDuration(int days) {
    return 'Duración: $days días';
  }

  @override
  String sprintAverageVelocity(String velocity) {
    return 'Velocidad promedio: $velocity pts/sprint';
  }

  @override
  String sprintTeamMembers(int count) {
    return 'Equipo: $count miembros';
  }

  @override
  String get sprintPlanningTitle => 'Planificación de Sprint';

  @override
  String get sprintPlanningSubtitle =>
      'Selecciona las historias a completar en este sprint';

  @override
  String get sprintPlanningSelected => 'Seleccionadas';

  @override
  String get sprintPlanningSuggested => 'Sugeridas';

  @override
  String get sprintPlanningCapacity => 'Capacidad';

  @override
  String get sprintPlanningBasedOnVelocity => 'basado en velocidad promedio';

  @override
  String sprintPlanningDays(int days) {
    return '$days días';
  }

  @override
  String get sprintPlanningExceeded =>
      'Advertencia: velocidad sugerida excedida';

  @override
  String get sprintPlanningNoStories =>
      'No hay historias disponibles en el backlog';

  @override
  String get sprintPlanningNotEstimated => 'Sin estimar';

  @override
  String sprintPlanningConfirm(int count) {
    return 'Confirmar ($count historias)';
  }

  @override
  String get storyFormEditTitle => 'Editar Historia';

  @override
  String get storyFormNewTitle => 'Nueva User Story';

  @override
  String get storyFormDetailsTab => 'Detalles';

  @override
  String get storyFormAcceptanceTab => 'Criterios de Aceptación';

  @override
  String get storyFormOtherTab => 'Otros';

  @override
  String get storyFormTitleLabel => 'Título *';

  @override
  String get storyFormTitleHint => 'Ej: US-123: Como usuario quiero...';

  @override
  String get storyFormTitleRequired => 'Introduce un título';

  @override
  String get storyFormUseTemplate => 'Usar plantilla User Story';

  @override
  String get storyFormTemplateSubtitle => 'Como... Quiero... Para que...';

  @override
  String get storyFormAsA => 'Como...';

  @override
  String get storyFormAsAHint => 'usuario, admin, cliente...';

  @override
  String get storyFormIWant => 'Quiero...';

  @override
  String get storyFormIWantHint => 'poder hacer algo...';

  @override
  String get storyFormIWantRequired => 'Introduce lo que el usuario quiere';

  @override
  String get storyFormSoThat => 'Para que...';

  @override
  String get storyFormSoThatHint => 'obtener un beneficio...';

  @override
  String get storyFormDescriptionLabel => 'Descripción';

  @override
  String get storyFormDescriptionHint => 'Criterios de aceptación, notas...';

  @override
  String get storyFormDescriptionRequired => 'Introduce una descripción';

  @override
  String get storyFormPreview => 'Vista previa:';

  @override
  String get storyFormEmptyDescription => '(descripción vacía)';

  @override
  String get storyFormAcceptanceCriteriaTitle => 'Criterios de Aceptación';

  @override
  String get storyFormAcceptanceCriteriaSubtitle =>
      'Define cuándo la historia puede considerarse completa';

  @override
  String get storyFormAddCriterionHint => 'Añadir criterio de aceptación...';

  @override
  String get storyFormNoCriteria => 'Sin criterios definidos';

  @override
  String get storyFormSuggestions => 'Sugerencias:';

  @override
  String get storyFormSuggestion1 => 'Los datos se guardan correctamente';

  @override
  String get storyFormSuggestion2 => 'El usuario recibe confirmación';

  @override
  String get storyFormSuggestion3 =>
      'El formulario muestra errores de validación';

  @override
  String get storyFormSuggestion4 =>
      'La funcionalidad es accesible desde móvil';

  @override
  String get storyFormPriorityLabel => 'Prioridad (MoSCoW)';

  @override
  String get storyFormBusinessValueLabel => 'Valor de Negocio';

  @override
  String get storyFormBusinessValueHigh => 'Alto valor de negocio';

  @override
  String get storyFormBusinessValueMedium => 'Valor medio';

  @override
  String get storyFormBusinessValueLow => 'Bajo valor de negocio';

  @override
  String get storyFormStoryPointsLabel => 'Estimado en Story Points';

  @override
  String get storyFormStoryPointsTooltip =>
      'Los Story Points representan la complejidad relativa del trabajo.\nUsa la secuencia Fibonacci: 1 (simple) -> 21 (muy complejo).';

  @override
  String get storyFormNoPoints => 'Ninguno';

  @override
  String get storyFormPointsSimple => 'Tarea rápida y simple';

  @override
  String get storyFormPointsMedium => 'Tarea de complejidad media';

  @override
  String get storyFormPointsComplex => 'Tarea compleja, requiere análisis';

  @override
  String get storyFormPointsVeryComplex =>
      'Muy compleja, considera dividir la historia';

  @override
  String get storyFormTagsLabel => 'Etiquetas';

  @override
  String get storyFormAddTagHint => 'Añadir etiqueta...';

  @override
  String get storyFormExistingTags => 'Etiquetas existentes:';

  @override
  String get storyFormAssigneeLabel => 'Asignar a';

  @override
  String get storyFormAssigneeHint => 'Selecciona un miembro del equipo';

  @override
  String get storyFormNotAssigned => 'Sin asignar';

  @override
  String storyDetailPointsLabel(int points) {
    return '$points puntos';
  }

  @override
  String get storyDetailDescriptionTitle => 'Descripción';

  @override
  String get storyDetailNoDescription => 'Sin descripción';

  @override
  String storyDetailAcceptanceCriteria(int completed, int total) {
    return 'Criterios de Aceptación ($completed/$total)';
  }

  @override
  String get storyDetailNoCriteria => 'Sin criterios definidos';

  @override
  String get storyDetailEstimationTitle => 'Estimación';

  @override
  String get storyDetailFinalEstimate => 'Estimación final: ';

  @override
  String storyDetailEstimatesReceived(int count) {
    return '$count estimaciones recibidas';
  }

  @override
  String get storyDetailInfoTitle => 'Información';

  @override
  String get storyDetailBusinessValue => 'Valor de Negocio';

  @override
  String get storyDetailAssignedTo => 'Asignado a';

  @override
  String get storyDetailSprint => 'Sprint';

  @override
  String get storyDetailCreatedAt => 'Creado el';

  @override
  String get storyDetailStartedAt => 'Iniciado el';

  @override
  String get storyDetailCompletedAt => 'Completado el';

  @override
  String get landingBadge => 'Herramientas para Equipos Ágiles';

  @override
  String get landingHeroTitle => 'Construye mejores productos\ncon Keisen';

  @override
  String get landingHeroSubtitle =>
      'Prioriza, estima y gestiona tus proyectos con herramientas colaborativas. Todo en un solo lugar, gratis.';

  @override
  String get landingStartFree => 'Empezar Gratis';

  @override
  String get landingEverythingNeed => 'Todo lo que necesitas';

  @override
  String get landingModernTools =>
      'Herramientas diseñadas para equipos modernos';

  @override
  String get landingSmartTodoBadge => 'Productividad';

  @override
  String get landingSmartTodoTitle => 'Lista Smart Todo';

  @override
  String get landingSmartTodoSubtitle =>
      'Gestión inteligente y colaborativa de tareas para equipos modernos';

  @override
  String get landingSmartTodoCollaborativeTitle =>
      'Listas de Tareas Colaborativas';

  @override
  String get landingSmartTodoCollaborativeDesc =>
      'Smart Todo transforma la gestión de actividades diarias en un proceso fluido y colaborativo. Crea listas, asigna tareas a miembros del equipo y monitorea el progreso en tiempo real.\n\nIdeal para equipos distribuidos que necesitan sincronización continua sobre las actividades a completar.';

  @override
  String get landingSmartTodoImportTitle => 'Importación Flexible';

  @override
  String get landingSmartTodoImportDesc =>
      'Importa tus actividades desde fuentes externas con solo unos clics. Soporte para archivos CSV, copiar/pegar desde Excel o texto libre. El sistema reconoce automáticamente la estructura de datos.\n\nMigra fácilmente desde otras herramientas sin perder información ni reingresar cada tarea manualmente.';

  @override
  String get landingSmartTodoShareTitle => 'Compartir e Invitaciones';

  @override
  String get landingSmartTodoShareDesc =>
      'Invita a colegas y colaboradores a tus listas por correo electrónico. Cada participante puede ver, comentar y actualizar el estado de las tareas asignadas.\n\nPerfecto para gestionar proyectos transversales con stakeholders externos o equipos multifuncionales.';

  @override
  String get landingSmartTodoFeaturesTitle => 'Funciones de Smart Todo';

  @override
  String get landingEisenhowerBadge => 'Priorización';

  @override
  String get landingEisenhowerSubtitle =>
      'El método de toma de decisiones usado por líderes para gestionar el tiempo';

  @override
  String get landingEisenhowerUrgentImportantTitle => 'Urgente vs Importante';

  @override
  String get landingEisenhowerUrgentImportantDesc =>
      'La Matriz Eisenhower, ideada por el 34º Presidente de EE.UU. Dwight D. Eisenhower, divide las actividades en cuatro cuadrantes basados en dos criterios: urgencia e importancia.\n\nEste marco de decisiones ayuda a distinguir lo que requiere atención inmediata de lo que contribuye a objetivos a largo plazo.';

  @override
  String get landingEisenhowerDecisionsTitle => 'Mejores Decisiones';

  @override
  String get landingEisenhowerDecisionsDesc =>
      'Aplicando constantemente la matriz, desarrollas una mentalidad orientada a resultados. Aprendes a decir \"no\" a las distracciones y a enfocarte en lo que genera valor real.\n\nNuestra herramienta digital hace este proceso inmediato: arrastra las actividades al cuadrante correcto y obtén una vista clara de tus prioridades.';

  @override
  String get landingEisenhowerBenefitsTitle =>
      '¿Por qué usar la Matriz Eisenhower?';

  @override
  String get landingEisenhowerBenefitsDesc =>
      'Los estudios muestran que el 80% de las actividades diarias caen en los cuadrantes 3 y 4 (no importantes). La matriz te ayuda a identificarlas y liberar tiempo para lo que realmente importa.';

  @override
  String get landingEisenhowerQuadrants =>
      'Cuadrante 1: Urgente + Importante → Hacer Ahora\nCuadrante 2: No Urgente + Importante → Programar\nCuadrante 3: Urgente + No Importante → Delegar\nCuadrante 4: No Urgente + No Importante → Eliminar';

  @override
  String get landingAgileBadge => 'Metodologías';

  @override
  String get landingAgileTitle => 'Framework Agile y Scrum';

  @override
  String get landingAgileSubtitle =>
      'Implementa las mejores prácticas para el desarrollo iterativo de software';

  @override
  String get landingAgileIterativeTitle => 'Desarrollo Iterativo e Incremental';

  @override
  String get landingAgileIterativeDesc =>
      'El enfoque Ágil divide el trabajo en ciclos cortos llamados Sprints, típicamente de 1-4 semanas. Cada iteración produce un incremento de producto funcional.\n\nCon Keisen, puedes gestionar tu backlog, planificar sprints y monitorear la velocidad del equipo en tiempo real.';

  @override
  String get landingAgileScrumTitle => 'Framework Scrum';

  @override
  String get landingAgileScrumDesc =>
      'Scrum es el framework Ágil más extendido. Define roles (Product Owner, Scrum Master, Equipo), eventos (Sprint Planning, Daily, Review, Retrospective) y artefactos (Product Backlog, Sprint Backlog).\n\nKeisen soporta todos los eventos Scrum con herramientas dedicadas para cada ceremonia.';

  @override
  String get landingAgileKanbanTitle => 'Tablero Kanban';

  @override
  String get landingAgileKanbanDesc =>
      'El método Kanban visualiza el flujo de trabajo a través de columnas que representan estados del proceso. Limita el Trabajo en Progreso (WIP) para maximizar el rendimiento.\n\nNuestro tablero Kanban soporta personalización de columnas, límites WIP y métricas de flujo.';

  @override
  String get landingEstimationBadge => 'Estimación';

  @override
  String get landingEstimationTitle => 'Técnicas de Estimación Colaborativas';

  @override
  String get landingEstimationSubtitle =>
      'Elige el mejor método para tu equipo para estimaciones precisas';

  @override
  String get landingEstimationFeaturesTitle =>
      'Funciones de la Sala de Estimación';

  @override
  String get landingRetroBadge => 'Retrospectiva';

  @override
  String get landingRetroTitle => 'Retrospectivas Interactivas';

  @override
  String get landingRetroSubtitle =>
      'Herramientas colaborativas en tiempo real: temporizadores, votación anónima, action items e informes de IA.';

  @override
  String get landingRetroActionTitle => 'Seguimiento de Action Items';

  @override
  String get landingRetroActionDesc =>
      'Cada retrospectiva genera action items rastreables con responsables, fechas límite y estado. Monitorea el seguimiento a lo largo del tiempo.';

  @override
  String get landingWorkflowBadge => 'Flujo de Trabajo';

  @override
  String get landingWorkflowTitle => 'Cómo funciona';

  @override
  String get landingWorkflowSubtitle => 'Empieza en 3 simples pasos';

  @override
  String get landingStep1Title => 'Crea un proyecto';

  @override
  String get landingStep1Desc =>
      'Crea tu proyecto Ágil e invita al equipo. Configura sprints, backlogs y tableros.';

  @override
  String get landingStep2Title => 'Colabora';

  @override
  String get landingStep2Desc =>
      'Estima historias de usuario juntos, organiza sprints y sigue el progreso en tiempo real.';

  @override
  String get landingStep3Title => 'Mejora';

  @override
  String get landingStep3Desc =>
      'Analiza métricas, realiza retrospectivas y mejora continuamente el proceso.';

  @override
  String get landingCtaTitle => '¿Listo para empezar?';

  @override
  String get landingCtaDesc =>
      'Regístrate gratis y empieza a colaborar con tu equipo.';

  @override
  String get landingFooterBrandDesc =>
      'Herramientas colaborativas para equipos ágiles.\nPlanifica, estima y mejora juntos.';

  @override
  String get landingFooterProduct => 'Producto';

  @override
  String get landingFooterResources => 'Recursos';

  @override
  String get landingFooterCompany => 'Empresa';

  @override
  String get landingFooterLegal => 'Legal';

  @override
  String get landingCopyright =>
      '© 2026 Keisen. Todos los derechos reservados.';

  @override
  String get featureSmartImportDesc =>
      'Creación rápida de tareas con descripción\nAsignación a miembros del equipo\nPrioridad y fechas límite configurables\nNotificaciones de finalización';

  @override
  String get featureImportDesc =>
      'Importar desde archivo CSV\nCopiar/pegar desde Excel\nParseo inteligente de texto\nMapeo automático de campos';

  @override
  String get featureShareDesc =>
      'Invitaciones por correo\nPermisos configurables\nComentarios en tareas\nHistorial de modificaciones';

  @override
  String get featureSmartTaskCreation => 'Creación rápida de tareas';

  @override
  String get featureTeamAssignment => 'Asignación a equipos';

  @override
  String get featurePriorityDeadline => 'Prioridad y Fechas Límite';

  @override
  String get featureCompletionNotifications => 'Notificaciones de Finalización';

  @override
  String get featureCsvImport => 'Importación CSV';

  @override
  String get featureExcelPaste => 'Copiar/Pegar Excel';

  @override
  String get featureSmartParsing => 'Parseo Inteligente de Texto';

  @override
  String get featureAutoMapping => 'Mapeo Automático de Campos';

  @override
  String get featureEmailInvites => 'Invitaciones por Correo';

  @override
  String get featurePermissions => 'Permisos Configurables';

  @override
  String get featureTaskComments => 'Comentarios en Tareas';

  @override
  String get featureHistory => 'Historial de Cambios';

  @override
  String get featureAdvancedFilters => 'Filtros Avanzados';

  @override
  String get featureFullTextSearch => 'Búsqueda de Texto Completo';

  @override
  String get featureSorting => 'Ordenación';

  @override
  String get featureTagsCategories => 'Etiquetas y Categorías';

  @override
  String get featureArchiving => 'Archivado';

  @override
  String get featureSort => 'Ordenación';

  @override
  String get featureDataExport => 'Exportación de Datos';

  @override
  String get landingIntroFeatures =>
      'Planificación de Sprint con capacidad del equipo\nBacklog priorizado con arrastrar y soltar\nSeguimiento de velocidad y gráfico burndown\nDaily standup facilitado';

  @override
  String get landingAgileScrumFeatures =>
      'Product Backlog con story points\nSprint Backlog con desglose de tareas\nTablero de retrospectiva integrado\nMétricas Scrum automáticas';

  @override
  String get landingAgileKanbanFeatures =>
      'Columnas personalizables\nLímites WIP por columna\nArrastrar y soltar intuitivo\nLead time y cycle time';

  @override
  String get landingEstimationPokerDesc =>
      'El método clásico: cada miembro elige una carta (1, 2, 3, 5, 8...). Las estimaciones se revelan simultáneamente para evitar sesgos.';

  @override
  String get landingEstimationTShirtTitle => 'Talla de Camiseta';

  @override
  String get landingEstimationTShirtSubtitle => 'Dimensionamiento Relativo';

  @override
  String get landingEstimationTShirtDesc =>
      'Estimación rápida usando tallas: XS, S, M, L, XL, XXL. Ideal para grooming inicial del backlog o cuando se necesitan estimaciones aproximadas.';

  @override
  String get landingEstimationPertTitle => 'Tres Puntos (PERT)';

  @override
  String get landingEstimationPertSubtitle =>
      'Optimista / Probable / Pesimista';

  @override
  String get landingEstimationPertDesc =>
      'Técnica estadística: cada miembro proporciona 3 estimaciones (O, M, P). La fórmula PERT calcula el promedio ponderado: (O + 4M + P) / 6.';

  @override
  String get landingEstimationBucketTitle => 'Sistema de Cubos';

  @override
  String get landingEstimationBucketSubtitle => 'Categorización Rápida';

  @override
  String get landingEstimationBucketDesc =>
      'Las historias de usuario se asignan a \"cubos\" predefinidos. Excelente para estimar grandes cantidades de elementos rápidamente en sesiones de refinamiento.';

  @override
  String get landingEstimationChipHiddenVote => 'Votación Oculta';

  @override
  String get landingEstimationChipTimer => 'Temporizador Configurable';

  @override
  String get landingEstimationChipStats => 'Estadísticas en Tiempo Real';

  @override
  String get landingEstimationChipParticipants => 'Hasta 20 Participantes';

  @override
  String get landingEstimationChipHistory => 'Historial de Estimaciones';

  @override
  String get landingEstimationChipExport => 'Exportar Resultados';

  @override
  String get landingRetroTemplateStartStopTitle => 'Start / Stop / Continue';

  @override
  String get landingRetroTemplateStartStopDesc =>
      'El formato clásico: qué empezar a hacer, qué dejar de hacer, qué seguir haciendo.';

  @override
  String get landingRetroTemplateMadSadTitle => 'Mad / Sad / Glad';

  @override
  String get landingRetroTemplateMadSadDesc =>
      'Retrospectiva emocional: qué nos hizo enfadar, entristecer o alegrar.';

  @override
  String get landingRetroTemplate4LsTitle => '4L\'s';

  @override
  String get landingRetroTemplate4LsDesc =>
      'Liked, Learned, Lacked, Longed For - análisis completo del sprint.';

  @override
  String get landingRetroTemplateSailboatTitle => 'Velero';

  @override
  String get landingRetroTemplateSailboatDesc =>
      'Metáfora visual: viento (ayudas), ancla (obstáculos), rocas (riesgos), isla (objetivos).';

  @override
  String get landingRetroTemplateWentWellTitle => 'Fue Bien / A Mejorar';

  @override
  String get landingRetroTemplateWentWellDesc =>
      'Formato simple y directo: qué salió bien y qué mejorar.';

  @override
  String get landingRetroTemplateDakiTitle => 'DAKI';

  @override
  String get landingRetroTemplateDakiDesc =>
      'Drop, Add, Keep, Improve - decisiones concretas para el próximo sprint.';

  @override
  String get landingRetroFeatureTrackingTitle => 'Seguimiento de Action Items';

  @override
  String get landingRetroFeatureTrackingDesc =>
      'Cada retrospectiva genera action items rastreables con responsable, fecha límite y estado. Monitorea el seguimiento a lo largo del tiempo.';

  @override
  String get landingAgileSectionBadge => 'Metodologías';

  @override
  String get landingAgileSectionTitle => 'Framework Agile y Scrum';

  @override
  String get landingAgileSectionSubtitle =>
      'Implementa las mejores prácticas del desarrollo iterativo de software';

  @override
  String get landingSmartTodoCollabTitle => 'Listas de Tareas Colaborativas';

  @override
  String get landingSmartTodoCollabDesc =>
      'Smart Todo transforma la gestión diaria de tareas en un proceso fluido y colaborativo. Crea listas, asigna tareas a miembros del equipo y monitorea el progreso en tiempo real.\n\nIdeal para equipos distribuidos que necesitan sincronización continua sobre las tareas a completar.';

  @override
  String get landingSmartTodoCollabFeatures =>
      'Creación rápida de tareas con descripción\nAsignación a miembros del equipo\nPrioridades y fechas límite configurables\nNotificaciones de finalización';

  @override
  String get landingSmartTodoImportFeatures =>
      'Importar desde archivo CSV\nCopiar/pegar desde Excel\nParseo inteligente de texto\nMapeo automático de campos';

  @override
  String get landingSmartTodoSharingTitle => 'Compartir e Invitaciones';

  @override
  String get landingSmartTodoSharingDesc =>
      'Invita a colegas y colaboradores a tus listas por correo electrónico. Cada participante puede ver, comentar y actualizar el estado de las tareas asignadas.\n\nPerfecto para gestionar proyectos transversales con stakeholders externos o equipos.';

  @override
  String get landingSmartTodoSharingFeatures =>
      'Invitaciones por correo\nPermisos configurables\nComentarios en tareas\nHistorial de cambios';

  @override
  String get landingSmartTodoChipFilters => 'Filtros avanzados';

  @override
  String get landingSmartTodoChipSearch => 'Búsqueda de texto completo';

  @override
  String get landingSmartTodoChipSort => 'Ordenación';

  @override
  String get landingSmartTodoChipTags => 'Etiquetas y categorías';

  @override
  String get landingSmartTodoChipArchive => 'Archivado';

  @override
  String get landingSmartTodoChipExport => 'Exportación de datos';

  @override
  String get landingEisenhowerTitle => 'Matriz Eisenhower';

  @override
  String get landingEisenhowerUrgentTitle => 'Urgente vs Importante';

  @override
  String get landingEisenhowerUrgentDesc =>
      'La Matriz Eisenhower, ideada por el 34º Presidente de los Estados Unidos Dwight D. Eisenhower, divide las actividades en cuatro cuadrantes basados en dos criterios: urgencia e importancia.\n\nEste marco de toma de decisiones ayuda a distinguir lo que requiere atención inmediata de lo que contribuye a objetivos a largo plazo.';

  @override
  String get landingEisenhowerUrgentFeatures =>
      'Cuadrante 1: Urgente + Importante → Hacer primero\nCuadrante 2: No urgente + Importante → Programar\nCuadrante 3: Urgente + No importante → Delegar\nCuadrante 4: No urgente + No importante → No hacer';

  @override
  String get landingEisenhowerDecisionsFeatures =>
      'Arrastrar y soltar intuitivo\nColaboración de equipo en tiempo real\nEstadísticas de distribución\nExportación para informes';

  @override
  String get landingEisenhowerUrgentLabel => 'URGENTE';

  @override
  String get landingEisenhowerNotUrgentLabel => 'NO URGENTE';

  @override
  String get landingEisenhowerImportantLabel => 'IMPORTANTE';

  @override
  String get landingEisenhowerNotImportantLabel => 'NO IMPORTANTE';

  @override
  String get landingEisenhowerDoLabel => 'HACER';

  @override
  String get landingEisenhowerDoDesc => 'Crisis, plazos, emergencias';

  @override
  String get landingEisenhowerPlanLabel => 'PLANIFICAR';

  @override
  String get landingEisenhowerPlanDesc => 'Estrategia, crecimiento, relaciones';

  @override
  String get landingEisenhowerDelegateLabel => 'DELEGAR';

  @override
  String get landingEisenhowerDelegateDesc =>
      'Interrupciones, reuniones, correos';

  @override
  String get landingEisenhowerEliminateLabel => 'ELIMINAR';

  @override
  String get landingEisenhowerEliminateDesc =>
      'Distracciones, redes sociales, pérdidas de tiempo';

  @override
  String get landingFooterFeatures => 'Funcionalidades';

  @override
  String get landingFooterPricing => 'Precios';

  @override
  String get landingFooterChangelog => 'Registro de cambios';

  @override
  String get landingFooterRoadmap => 'Hoja de ruta';

  @override
  String get landingFooterDocs => 'Documentación';

  @override
  String get landingFooterAgileGuides => 'Guías Ágiles';

  @override
  String get landingFooterBlog => 'Blog';

  @override
  String get landingFooterCommunity => 'Comunidad';

  @override
  String get landingFooterAbout => 'Sobre Nosotros';

  @override
  String get landingFooterContact => 'Contacto';

  @override
  String get landingFooterJobs => 'Empleo';

  @override
  String get landingFooterPress => 'Kit de Prensa';

  @override
  String get landingFooterPrivacy => 'Política de Privacidad';

  @override
  String get landingFooterTerms => 'Términos de Servicio';

  @override
  String get landingFooterCookies => 'Política de Cookies';

  @override
  String get landingFooterGdpr => 'GDPR';

  @override
  String get legalCookieTitle => 'Usamos cookies';

  @override
  String get legalCookieMessage =>
      'Usamos cookies para mejorar tu experiencia y con fines analíticos. Al continuar, aceptas el uso de cookies.';

  @override
  String get legalCookieAccept => 'Aceptar todas';

  @override
  String get legalCookieRefuse => 'Solo necesarias';

  @override
  String get legalCookiePolicy => 'Política de Cookies';

  @override
  String get legalPrivacyPolicy => 'Política de Privacidad';

  @override
  String get legalTermsOfService => 'Términos de Servicio';

  @override
  String get legalGDPR => 'RGPD';

  @override
  String get legalLastUpdatedLabel => 'Última actualización';

  @override
  String get legalLastUpdatedDate => '18 de enero de 2026';

  @override
  String get legalAcceptTerms =>
      'Acepto los Términos de servicio y la Política de privacidad';

  @override
  String get legalMustAcceptTerms =>
      'Debes aceptar los términos para continuar';

  @override
  String get legalPrivacyContent =>
      '## 1. Introducción\nBienvenido a **Keisen** (\"nosotros\", \"nuestro\", \"la Plataforma\"). Su privacidad es importante para nosotros. Esta Política de privacidad explica cómo recopilamos, utilizamos, divulgamos y protegemos su información cuando utiliza nuestra aplicación web.\n\n## 2. Información que recopilamos\nRecopilamos dos tipos de datos e información:\n\n### 2.1 Información proporcionada por el usuario\n- **Datos de la cuenta:** Cuando inicia sesión a través de Google Sign-In o crea una cuenta, recopilamos su nombre, dirección de correo electrónico e imagen de perfil.\n- **Contenido del usuario:** Recopilamos los datos que ingresa voluntariamente en la plataforma, incluidos tareas, estimaciones, retrospectivas, comentarios y configuraciones del equipo.\n\n### 2.2 Información recopilada automáticamente\n- **Registros del sistema:** Direcciones IP, tipo de navegador, páginas visitadas y marcas de tiempo.\n- **Cookies:** Utilizamos cookies técnicas esenciales para mantener su sesión activa.\n\n## 3. Cómo utilizamos su información\nUtilizamos la información recopilada para:\n- Proporcionar, operar y mantener nuestros Servicios.\n- Mejorar, personalizar y ampliar nuestra Plataforma.\n- Analizar cómo utiliza el sitio web para mejorar el experiencia del usuario.\n- Enviarle correos electrónicos de servicio (por ejemplo, invitaciones de equipo, actualizaciones importantes).\n\n## 4. Intercambio de información\nNo vendemos sus datos personales. Compartimos información solo con:\n- **Proveedores de servicios:** Utilizamos **Google Firebase** (Google LLC) para servicios de alojamiento, autenticación y base de datos. Los datos se procesan de acuerdo con la [Política de privacidad de Google](https://policies.google.com/privacy).\n- **Obligaciones legales:** Si lo requiere la ley o para proteger nuestros derechos.\n\n## 5. Seguridad de los datos\nImplementamos medidas de seguridad técnicas y organizativas estándar de la industria (como el cifrado en tránsito) para proteger sus datos. Sin embargo, ningún método de transmisión por Internet es 100% seguro.\n\n## 6. Sus derechos\nTiene derecho a:\n- Acceder a sus datos personales.\n- Solicitar la corrección de datos inexactos.\n- Solicitar la eliminación de sus datos (\"Derecho al olvido\").\n- Oponerse al procesamiento de sus datos.\n\nPara ejercer estos derechos, contáctenos en: suppkesien@gmail.com.\n\n## 7. Cambios en esta Política\nEs posible que actualicemos esta Política de privacidad de vez en cuando. Le notificaremos cualquier cambio publicando la nueva Política en esta página.';

  @override
  String get legalTermsContent =>
      '## 1. Aceptación de los términos\nAl acceder o utilizar **Keisen**, usted acepta estar sujeto a estos Términos de servicio (\"Términos\"). Si no está de acuerdo con estos Términos, no debe utilizar nuestros Servicios.\n\n## 2. Descripción del servicio\nKeisen es una plataforma de colaboración para equipos ágiles que ofrece herramientas como Smart Todo, Matriz de Eisenhower, Sala de estimación y Gestión de procesos ágiles. Nos reservamos el derecho de modificar o interrumpir el servicio en cualquier momento.\n\n## 3. Cuentas de usuario\nUsted es responsable de mantener la confidencialidad de las credenciales de su cuenta y de todas las actividades que ocurran bajo su cuenta. Nos reservamos el derecho de suspender o eliminar cuentas que violen estos Términos.\n\n## 4. Conducta del usuario\nUsted acepta no utilizar el Servicio para:\n- Violar leyes locales, nacionales o internacionales.\n- Cargar contenido ofensivo, difamatorio o ilegal.\n- Intentar el acceso no autorizado a los sistemas de la Plataforma.\n\n## 5. Propiedad intelectual\nTodos los derechos de propiedad intelectual relacionados con la Plataforma y su contenido original (excluyendo el contenido proporcionado por el usuario) son propiedad exclusiva de Leonardo Torella.\n\n## 6. Limitación de responsabilidad\nEn la medida máxima permitida por la ley, Keisen se proporciona \"tal cual\" y \"según disponibilidad\". No garantizamos que el servicio sea ininterrumpido o libre de errores. No seremos responsables de los daños indirectos, incidentales o consecuentes derivados del uso del servicio.\n\n## 7. Ley aplicable\nEstos Términos se rigen por las leyes del Estado italiano.\n\n## 8. Contactos\nPara preguntas sobre estos Términos, contáctenos en: suppkesien@gmail.com.';

  @override
  String get legalCookiesContent =>
      '## 1. ¿Qué son las cookies?\nLas cookies son pequeños archivos de texto que se guardan en su dispositivo cuando visita un sitio web. Se utilizan ampliamente para que los sitios web funcionen de manera más eficiente y para proporcionar información a los propietarios del sitio.\n\n## 2. Cómo utilizamos las cookies\nUtilizamos cookies para varios propósitos:\n\n### 2.1 Cookies técnicas (esenciales)\nEstas cookies son necesarias para que el sitio web funcione y no se pueden desactivar en nuestros sistemas. Por lo general, solo se configuran en respuesta a las acciones que usted realiza y que constituyen una solicitud de servicios, como configurar sus preferencias de privacidad, iniciar sesión o completar formularios.\n*Ejemplo:* Cookies de sesión de Firebase Auth para mantener al usuario conectado.\n\n### 2.2 Cookies analíticas\nEstas cookies nos permiten contar las visitas y las fuentes de tráfico para que podamos medir y mejorar el rendimiento de nuestro sitio. Toda la información recopilada por estas cookies es agregada y, por lo tanto, anónima.\n\n## 3. Gestión de cookies\nLa mayoría de los navegadores web le permiten controlar la mayoría de las cookies a través de la configuración del navegador. Sin embargo, si desactiva las cookies esenciales, es posible que algunas partes de nuestro Servicio no funcionen correctamente (por ejemplo, no podrá iniciar sesión).\n\n## 4. Cookies de terceros\nUtilizamos servicios de terceros como **Google Firebase** que pueden configurar sus propias cookies. Le recomendamos que consulte sus respectivas políticas de privacidad para obtener más detalles.';

  @override
  String get legalGdprContent =>
      '## Compromiso con la protección de datos (RGPD)\nDe acuerdo con el Reglamento General de Protección de Datos (RGPD) de la Unión Europea, Keisen se compromete a proteger los datos personales de los usuarios y a garantizar la transparencia en su tratamiento.\n\n## Responsable del tratamiento\nEl Responsable del tratamiento es:\n**Keisen Team**\nCorreo electrónico: suppkesien@gmail.com\n\n## Base legal para el tratamiento\nTratamos sus datos personales solo cuando tenemos una base legal para hacerlo. Esto incluye:\n- **Consentimiento:** Nos ha dado permiso para tratar sus datos para un propósito específico.\n- **Ejecución de un contrato:** El tratamiento es necesario para proporcionar los Servicios que ha solicitado (por ejemplo, el uso de la plataforma).\n- **Interés legítimo:** El tratamiento es necesario para nuestros intereses legítimos (por ejemplo, seguridad, mejora del servicio), a menos que sus derechos y libertades fundamentales prevalezcan sobre esos intereses.\n\n## Transferencia de datos\nSus datos se almacenan en servidores seguros proporcionados por Google Cloud Platform (Google Firebase). Google se adhiere a los estándares internacionales de seguridad y cumple con el RGPD a través de Cláusulas Contractuales Estándar (SCC).\n\n## Sus derechos RGPD\nComo usuario en la UE, tiene los siguientes derechos:\n1.  **Derecho de acceso:** Tiene derecho a solicitar copias de sus datos personales.\n2.  **Derecho de rectificación:** Tiene derecho a solicitar la corrección de la información que considere inexacta.\n3.  **Derecho a la eliminación (\"Derecho al olvido\"):** Tiene derecho a solicitar la eliminación de sus datos personales, bajo ciertas condiciones.\n4.  **Derecho a restringir el tratamiento:** Tiene derecho a solicitar la restricción del procesamiento de sus datos.\n5.  **Derecho a la portabilidad de los datos:** Tiene derecho a solicitar la transferencia de los datos que hemos recopilado a otra organización o directamente a usted.\n\n## Ejercicio de derechos\nSi desea ejercer alguno de estos derechos, comuníquese con nosotros en: suppkesien@gmail.com. Responderemos a su solicitud en el plazo de un mes.';

  @override
  String get profilePrivacy => 'Privacidad';

  @override
  String get profileExportData => 'Exportar mis datos';

  @override
  String get profileDeleteAccountConfirm =>
      'Sei sicuro di voler eliminare definitivamente il tuo account? Questa azione è irreversibile.';

  @override
  String get subscriptionTitle => 'Suscripción';

  @override
  String get subscriptionTabPlans => 'Planes';

  @override
  String get subscriptionTabUsage => 'Uso';

  @override
  String get subscriptionTabBilling => 'Facturación';

  @override
  String subscriptionActiveProjects(int count) {
    return '$count proyectos activos';
  }

  @override
  String subscriptionActiveLists(int count) {
    return '$count listas Smart Todo';
  }

  @override
  String get subscriptionCurrentPlan => 'Plan actual';

  @override
  String subscriptionUpgradeTo(String plan) {
    return 'Mejorar a $plan';
  }

  @override
  String subscriptionDowngradeTo(String plan) {
    return 'Cambiar a $plan';
  }

  @override
  String subscriptionChoose(String plan) {
    return 'Elegir $plan';
  }

  @override
  String get subscriptionMonthly => 'Mensual';

  @override
  String get subscriptionYearly => 'Anual (-17%)';

  @override
  String get subscriptionLimitReached => 'Límite alcanzado';

  @override
  String get subscriptionLimitProjects =>
      'Has alcanzado el número máximo de proyectos para tu plan. Mejora a Premium para crear más proyectos.';

  @override
  String get subscriptionLimitLists =>
      'Has alcanzado el número máximo de listas para tu plan. Mejora a Premium para crear más listas.';

  @override
  String get subscriptionLimitTasks =>
      'Has alcanzado el número máximo de tareas para este proyecto. Mejora a Premium para añadir más tareas.';

  @override
  String get subscriptionLimitInvites =>
      'Has alcanzado el número máximo de invitaciones para este proyecto. Mejora a Premium para invitar a más personas.';

  @override
  String get subscriptionLimitEstimations =>
      'Has alcanzado el número máximo de sesiones de estimación. Mejora a Premium para crear más.';

  @override
  String get subscriptionLimitRetrospectives =>
      'Has alcanzado el número máximo de retrospectivas. Mejora a Premium para crear más.';

  @override
  String get subscriptionLimitAgileProjects =>
      'Has alcanzado el número máximo de proyectos Agile. Mejora a Premium para crear más.';

  @override
  String get subscriptionLimitDefault =>
      'Has alcanzado el límite de tu plan actual.';

  @override
  String get subscriptionCurrentUsage => 'Uso actual';

  @override
  String get subscriptionUpgradeToPremium => 'Mejorar a Premium';

  @override
  String get subscriptionBenefitProjects => '30 proyectos activos';

  @override
  String get subscriptionBenefitLists => '30 listas Smart Todo';

  @override
  String get subscriptionBenefitTasks => '100 tareas por proyecto';

  @override
  String get subscriptionBenefitNoAds => 'Sin anuncios';

  @override
  String get subscriptionStartingFrom => 'Desde 4,99€/mes';

  @override
  String get subscriptionLater => 'Más tarde';

  @override
  String get subscriptionViewPlans => 'Ver planes';

  @override
  String subscriptionCanCreateOne(String entity) {
    return 'Puedes crear 1 $entity más';
  }

  @override
  String subscriptionCanCreateMany(int count, String entity) {
    return 'Puedes crear $count $entity más';
  }

  @override
  String get subscriptionUpgrade => 'MEJORAR';

  @override
  String subscriptionUsed(int count) {
    return 'Usado: $count';
  }

  @override
  String get subscriptionUnlimited => 'Ilimitado';

  @override
  String subscriptionLimit(int count) {
    return 'Límite: $count';
  }

  @override
  String get subscriptionPlanUsage => 'Uso del plan';

  @override
  String get subscriptionRefresh => 'Actualizar';

  @override
  String get subscriptionAdsActive => 'Anuncios activos';

  @override
  String get subscriptionRemoveAds => 'Mejora a Premium para quitar anuncios';

  @override
  String get subscriptionNoAds => 'Sin anuncios';

  @override
  String get subscriptionLoadError => 'No se pudieron cargar los datos de uso';

  @override
  String get subscriptionAdLabel => 'ANUNCIO';

  @override
  String get subscriptionAdPlaceholder => 'Espacio Publicitario';

  @override
  String get subscriptionDevEnvironment => '(Entorno de desarrollo)';

  @override
  String get subscriptionRemoveAdsUnlock =>
      'Quita anuncios y desbloquea funciones avanzadas';

  @override
  String get subscriptionUpgradeButton => 'Mejorar';

  @override
  String subscriptionLoadingError(String error) {
    return 'Error de carga: $error';
  }

  @override
  String get subscriptionCompletePayment =>
      'Completa el pago en la ventana abierta';

  @override
  String subscriptionError(String error) {
    return 'Error: $error';
  }

  @override
  String get subscriptionConfirmDowngrade => 'Confirmar cambio';

  @override
  String get subscriptionDowngradeMessage =>
      '¿Estás seguro de que quieres cambiar al plan Gratis?\n\nTu suscripción permanecerá activa hasta el final del período actual, después del cual cambiarás automáticamente al plan Gratis.\n\nNo perderás tus datos, pero algunas funciones pueden estar limitadas.';

  @override
  String get subscriptionCancel => 'Cancelar';

  @override
  String get subscriptionConfirmDowngradeButton => 'Confirmar cambio';

  @override
  String get subscriptionCancelled =>
      'Suscripción cancelada. Permanecerá activa hasta el final del período.';

  @override
  String subscriptionPortalError(String error) {
    return 'Error al abrir el portal: $error';
  }

  @override
  String get subscriptionRetry => 'Reintentar';

  @override
  String get subscriptionChooseRightPlan => 'Elige el plan adecuado para ti';

  @override
  String get subscriptionStartFree => 'Empieza gratis, mejora cuando quieras';

  @override
  String subscriptionPlan(String plan) {
    return 'Plan $plan';
  }

  @override
  String subscriptionPlanName(String plan) {
    return 'Plan actual: $plan';
  }

  @override
  String subscriptionTrialUntil(String date) {
    return 'Prueba hasta $date';
  }

  @override
  String subscriptionRenewal(String date) {
    return 'Renovación: $date';
  }

  @override
  String get subscriptionManage => 'Gestionar';

  @override
  String get subscriptionLoginRequired =>
      'Por favor inicia sesión para ver el uso';

  @override
  String get subscriptionSuggestion => 'Sugerencia';

  @override
  String get subscriptionSuggestionText =>
      'Mejora a Premium para desbloquear más proyectos, quitar anuncios y aumentar límites. ¡Prueba gratis durante 7 días!';

  @override
  String get subscriptionPaymentManagement => 'Gestión de pagos';

  @override
  String get subscriptionNoActiveSubscription => 'Sin suscripción activa';

  @override
  String get subscriptionUsingFreePlan => 'Estás usando el plan Gratis';

  @override
  String get subscriptionViewPaidPlans => 'Ver planes de pago';

  @override
  String get subscriptionPaymentMethod => 'Método de pago';

  @override
  String get subscriptionEditPaymentMethod => 'Editar tarjeta o método de pago';

  @override
  String get subscriptionInvoices => 'Facturas';

  @override
  String get subscriptionViewInvoices => 'Ver y descargar facturas';

  @override
  String get subscriptionCancelSubscription => 'Cancelar suscripción';

  @override
  String get subscriptionAccessUntilEnd =>
      'El acceso permanecerá activo hasta el final del período';

  @override
  String get subscriptionPaymentHistory => 'Historial de pagos';

  @override
  String get subscriptionNoPayments => 'Sin pagos registrados';

  @override
  String get subscriptionCompleted => 'Completado';

  @override
  String get subscriptionDateNotAvailable => 'Fecha no disponible';

  @override
  String get subscriptionFaq => 'Preguntas frecuentes';

  @override
  String get subscriptionFaqCancel => '¿Puedo cancelar en cualquier momento?';

  @override
  String get subscriptionFaqCancelAnswer =>
      'Sí, puedes cancelar tu suscripción en cualquier momento. El acceso permanecerá activo hasta el final del período pagado.';

  @override
  String get subscriptionFaqTrial => '¿Cómo funciona la prueba gratuita?';

  @override
  String get subscriptionFaqTrialAnswer =>
      'Con la prueba gratuita tienes acceso completo a todas las funciones del plan elegido. Al final del período de prueba, la suscripción de pago comenzará automáticamente.';

  @override
  String get subscriptionFaqChange => '¿Puedo cambiar de plan?';

  @override
  String get subscriptionFaqChangeAnswer =>
      'Puedes mejorar o reducir tu plan en cualquier momento. El importe se calculará proporcionalmente.';

  @override
  String get subscriptionFaqData => '¿Mis datos están seguros?';

  @override
  String get subscriptionFaqDataAnswer =>
      'Absolutamente sí. Nunca perderás tus datos, incluso si cambias a un plan inferior. Algunas funciones pueden estar limitadas, pero los datos siempre permanecen accesibles.';

  @override
  String get subscriptionStatusActive => 'Activa';

  @override
  String get subscriptionStatusTrialing => 'En prueba';

  @override
  String get subscriptionStatusPastDue => 'Vencida';

  @override
  String get subscriptionStatusCancelled => 'Cancelada';

  @override
  String get subscriptionStatusExpired => 'Expirada';

  @override
  String get subscriptionStatusPaused => 'Pausada';

  @override
  String get subscriptionStatus => 'Estado';

  @override
  String get subscriptionStarted => 'Iniciada';

  @override
  String get subscriptionNextRenewal => 'Próxima renovación';

  @override
  String get subscriptionTrialEnd => 'Fin de prueba';

  @override
  String get toolSectionTitle => 'Herramientas';

  @override
  String get deadlineTitle => 'Fechas Límite';

  @override
  String get deadlineNoUpcoming => 'Sin fechas límite próximas';

  @override
  String get deadlineAll => 'Todos';

  @override
  String get deadlineToday => 'Hoy';

  @override
  String get deadlineTomorrow => 'Mañana';

  @override
  String get deadlineSprint => 'Sprint';

  @override
  String get deadlineTask => 'Tarea';

  @override
  String get favTitle => 'Favoritos';

  @override
  String get favFilterAll => 'Todos';

  @override
  String get favFilterTodo => 'Listas Todo';

  @override
  String get favFilterMatrix => 'Matrices';

  @override
  String get favFilterProject => 'Proyectos';

  @override
  String get favFilterPoker => 'Estimación';

  @override
  String get actionRemoveFromFavorites => 'Quitar de favoritos';

  @override
  String get favFilterRetro => 'Retro';

  @override
  String get favNoFavorites => 'No se encontraron favoritos';

  @override
  String get favTypeTodo => 'Lista Todo';

  @override
  String get favTypeMatrix => 'Matriz Eisenhower';

  @override
  String get favTypeProject => 'Proyecto Ágil';

  @override
  String get favTypeRetro => 'Retrospectiva';

  @override
  String get favTypePoker => 'Planning Poker';

  @override
  String get favTypeTool => 'Herramienta';

  @override
  String get deadline2Days => '2 Días';

  @override
  String get deadline3Days => '3 Días';

  @override
  String get deadline5Days => '5 Días';

  @override
  String get deadlineConfigTitle => 'Configurar Accesos Rápidos';

  @override
  String get deadlineConfigDesc =>
      'Elige los períodos de tiempo a mostrar en el encabezado.';

  @override
  String get smartTodoClose => 'Cerrar';

  @override
  String get smartTodoDone => 'Hecho';

  @override
  String get smartTodoAdd => 'Añadir';

  @override
  String get smartTodoEmailLabel => 'Email';

  @override
  String get exceptionLoginGoogleRequired =>
      'Inicio de sesión de Google requerido para enviar correos';

  @override
  String get exceptionUserNotAuthenticated => 'Usuario no autenticado';

  @override
  String errorLoginFailed(String error) {
    return 'Error de inicio de sesión: $error';
  }

  @override
  String retroParticipantsTitle(int count) {
    return 'Participantes ($count)';
  }

  @override
  String get actionReopen => 'Reabrir';

  @override
  String get retroWaitingForFacilitator =>
      'Esperando al facilitador para iniciar la sesión...';

  @override
  String get retroGeneratingSheet => 'Generando hoja de cálculo de Google...';

  @override
  String get retroExportSuccess => '¡Exportación completada!';

  @override
  String get retroExportSuccessMessage =>
      'Tu retrospectiva ha sido exportada a Google Sheets.';

  @override
  String get retroExportError => 'Error al exportar a Sheets.';

  @override
  String get retroReportCopied =>
      '¡Informe copiado al portapapeles! Pégalo en Excel o Notas.';

  @override
  String get retroReopenTitle => 'Reabrir Retrospectiva';

  @override
  String get retroReopenConfirm =>
      '¿Estás seguro de que quieres reabrir la retrospectiva? Volverá a la fase de Discusión.';

  @override
  String get errorAuthRequired => 'Autenticación requerida';

  @override
  String get errorRetroIdMissing => 'Falta ID de retrospectiva';

  @override
  String get pokerInviteAccepted =>
      '¡Invitación aceptada! Redirigiendo a la sesión.';

  @override
  String get pokerInviteRefused => 'Invitación rechazada';

  @override
  String get pokerConfirmRefuseTitle => 'Rechazar Invitación';

  @override
  String get pokerConfirmRefuseContent =>
      '¿Estás seguro de que quieres rechazar esta invitación?';

  @override
  String get pokerVerifyingInvite => 'Verificando invitación...';

  @override
  String get actionBackHome => 'Volver al Inicio';

  @override
  String get actionSignin => 'Iniciar Sesión';

  @override
  String get exceptionStoryNotFound => 'Historia no encontrada';

  @override
  String get exceptionNoTasksInProject =>
      'No se encontraron tareas en el proyecto';

  @override
  String get exceptionInvitePending =>
      'Ya existe una invitación pendiente para este correo';

  @override
  String get exceptionAlreadyParticipant => 'El usuario ya es un participante';

  @override
  String get exceptionInviteInvalid => 'Invitación no válida o caducada';

  @override
  String get exceptionInviteCalculated => 'Invitación caducada';

  @override
  String get exceptionInviteWrongUser => 'Invitación destinada a otro usuario';

  @override
  String get todoImportTasks => 'Importar Tareas';

  @override
  String get todoExportSheets => 'Exportar a Sheets';

  @override
  String get todoDeleteColumnTitle => 'Eliminar Columna';

  @override
  String get todoDeleteColumnConfirm =>
      '¿Estás seguro? Las tareas de esta columna se perderán.';

  @override
  String get exceptionListNotFound => 'Lista no encontrada';

  @override
  String get langItalian => 'Italiano';

  @override
  String get langEnglish => 'English';

  @override
  String get langFrench => 'Français';

  @override
  String get langSpanish => 'Español';

  @override
  String get jsonExportLabel => 'Descargar copia JSON de tus datos';

  @override
  String errorExporting(String error) {
    return 'Error al exportar: $error';
  }

  @override
  String get smartTodoViewKanban => 'Kanban';

  @override
  String get smartTodoViewList => 'Lista';

  @override
  String get smartTodoViewResource => 'Por Recurso';

  @override
  String get smartTodoInviteTooltip => 'Invitar';

  @override
  String get smartTodoOptionsTooltip => 'Más opciones';

  @override
  String get smartTodoActionImport => 'Importar tareas';

  @override
  String get smartTodoActionExportSheets => 'Exportar a Sheets';

  @override
  String get smartTodoDeleteColumnTitle => 'Eliminar columna';

  @override
  String get smartTodoDeleteColumnContent =>
      '¿Estás seguro? Las tareas de esta columna dejarán de ser visibles.';

  @override
  String get smartTodoNewColumn => 'Nueva columna';

  @override
  String get smartTodoColumnNameHint => 'Nombre de la columna';

  @override
  String get smartTodoColorLabel => 'COLOR';

  @override
  String get smartTodoMarkAsDone => 'Marcar como hecho';

  @override
  String get smartTodoColumnDoneDescription =>
      'Las tareas en esta columna se considerarán \'Hechas\' (tachadas).';

  @override
  String get smartTodoListSettingsTitle => 'Configuración de la lista';

  @override
  String get smartTodoRenameList => 'Renombrar lista';

  @override
  String get smartTodoManageTags => 'Gestionar etiquetas';

  @override
  String get smartTodoDeleteList => 'Eliminar lista';

  @override
  String get smartTodoEditPermissionError =>
      'Solo puedes editar las tareas asignadas a ti';

  @override
  String errorDeletingAccount(String error) {
    return 'Error al eliminar la cuenta: $error';
  }

  @override
  String get errorRecentLoginRequired =>
      'Se requiere inicio de sesión reciente. Por favor, cierra sesión e inicia sesión de nuevo antes de eliminar tu cuenta.';

  @override
  String actionGuide(String framework) {
    return 'Guía $framework';
  }

  @override
  String get actionExportSheets => 'Exportar a Google Sheets';

  @override
  String get actionAuditLog => 'Registro de Auditoría';

  @override
  String get actionInviteMember => 'Invitar Miembro';

  @override
  String get actionSettings => 'Configuración';

  @override
  String get retroSelectIcebreakerTooltip =>
      'Selecciona la actividad para romper el hielo';

  @override
  String get retroIcebreakerLabel => 'Actividad inicial';

  @override
  String get retroTimePhasesOptional => 'Temporizador de Fases (Opcional)';

  @override
  String get retroTimePhasesDesc =>
      'Establece la duración en minutos para cada fase:';

  @override
  String get retroIcebreakerSectionTitle => 'Rompehielos';

  @override
  String get retroBoardTitle => 'Tablero de Retrospectivas';

  @override
  String get searchPlaceholder => 'Buscar todo...';

  @override
  String get searchResultsTitle => 'Resultados de Búsqueda';

  @override
  String searchNoResults(Object query) {
    return 'Sin resultados para \'$query\'';
  }

  @override
  String get searchResultTypeProject => 'Proyecto';

  @override
  String get searchResultTypeTodo => 'Lista ToDo';

  @override
  String get searchResultTypeRetro => 'Retrospectiva';

  @override
  String get searchResultTypeEisenhower => 'Matriz Eisenhower';

  @override
  String get searchResultTypeEstimation => 'Estimation Room';

  @override
  String get searchBackToDashboard => 'Volver al Tablero';

  @override
  String get smartTodoAddItem => 'Aggiungi voce';

  @override
  String get smartTodoAddImageUrl => 'Aggiungi Immagine (URL)';

  @override
  String get smartTodoNone => 'Nessuno';

  @override
  String get smartTodoPointsHint => 'Punti (es. 5)';

  @override
  String get smartTodoNewItem => 'Nuova voce';

  @override
  String get smartTodoDeleteComment => 'Elimina';

  @override
  String get priorityHigh => 'ALTA';

  @override
  String get priorityMedium => 'MEDIA';

  @override
  String get priorityLow => 'BASSA';

  @override
  String get exportToEstimation => 'Exportar a estimación';

  @override
  String get exportToEstimationDesc =>
      'Crear una sesión de estimación con estas tareas';

  @override
  String get exportToEisenhower => 'Enviar a Eisenhower';

  @override
  String get exportToEisenhowerDesc =>
      'Crear una matriz Eisenhower con estas tareas';

  @override
  String get selectTasksToExport => 'Seleccionar Tareas';

  @override
  String get selectTasksToExportDesc => 'Elige qué tareas incluir';

  @override
  String get noTasksSelected => 'Ninguna tarea seleccionada';

  @override
  String get selectAtLeastOne => 'Selecciona al menos una tarea';

  @override
  String get createEstimationSession => 'Crear Sesión de Estimación';

  @override
  String tasksSelectedCount(int count) {
    return '$count tarea(s) seleccionada(s)';
  }

  @override
  String get exportSuccess => 'Exportado con éxito';

  @override
  String get exportFromEstimation => 'Exportar a Lista';

  @override
  String get exportFromEstimationDesc =>
      'Exportar historias estimadas a una lista Smart Todo';

  @override
  String get selectDestinationList => 'Seleccionar lista de destino';

  @override
  String get createNewList => 'Crear nueva lista';

  @override
  String get existingList => 'Lista existente';

  @override
  String get listName => 'Nombre de la lista';

  @override
  String get listNameHint => 'Ingresa un nombre para la nueva lista';

  @override
  String get selectList => 'Seleccionar lista';

  @override
  String get selectListHint => 'Elige una lista';

  @override
  String get noListsAvailable =>
      'No hay listas disponibles. Se creará una nueva.';

  @override
  String storiesSelectedCount(int count) {
    return '$count historia(s) seleccionada(s)';
  }

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get deselectAll => 'Deseleccionar todo';

  @override
  String get importStories => 'Importar Historias';

  @override
  String storiesImportedCount(int count) {
    return '$count historia(s) importada(s)';
  }

  @override
  String get noEstimatedStories =>
      'Sin historias con estimaciones para importar';

  @override
  String get selectDestinationMatrix => 'Seleccionar Matriz Destino';

  @override
  String get existingMatrix => 'Matriz Existente';

  @override
  String get createNewMatrix => 'Crear Nueva Matriz';

  @override
  String get matrixName => 'Nombre de Matriz';

  @override
  String get matrixNameHint => 'Introduce un nombre para la nueva matriz';

  @override
  String get selectMatrix => 'Seleccionar Matriz';

  @override
  String get selectMatrixHint => 'Elige una matriz de destino';

  @override
  String get noMatricesAvailable =>
      'No hay matrices disponibles. Crea una nueva.';

  @override
  String activitiesCreated(int count) {
    return '$count actividades creadas';
  }

  @override
  String get importFromEisenhower => 'Importar desde Eisenhower';

  @override
  String get importFromEisenhowerDesc =>
      'Agregar tareas priorizadas a esta lista';

  @override
  String get quadrantQ1 => 'Urgente e Importante';

  @override
  String get quadrantQ2 => 'No Urgente e Importante';

  @override
  String get quadrantQ3 => 'Urgente y No Importante';

  @override
  String get quadrantQ4 => 'No Urgente y No Importante';

  @override
  String get warningQ4Tasks =>
      'Las tareas Q4 generalmente no valen la pena. ¿Estás seguro?';

  @override
  String get priorityMappingInfo =>
      'Mapeo de prioridad: Q1=Alta, Q2=Media, Q3/Q4=Baja';

  @override
  String get selectColumns => 'Seleccionar Columnas';

  @override
  String get allTasks => 'Todas las Tareas';

  @override
  String get filterByColumn => 'Filtrar por columna';

  @override
  String get exportFromEisenhower => 'Exportar desde Eisenhower';

  @override
  String get exportFromEisenhowerDesc =>
      'Selecciona las actividades para exportar a Smart Todo';

  @override
  String get filterByQuadrant => 'Filtrar por cuadrante:';

  @override
  String get allActivities => 'Todas';

  @override
  String activitiesSelectedCount(int count) {
    return '$count actividades seleccionadas';
  }

  @override
  String get noActivitiesSelected => 'No hay actividades en este filtro';

  @override
  String get unvoted => 'SIN VOTAR';

  @override
  String tasksCreated(int count) {
    return '$count tareas creadas';
  }

  @override
  String get exportToUserStories => 'Exportar a User Stories';

  @override
  String get exportToUserStoriesDesc =>
      'Crear user stories en un proyecto Agile';

  @override
  String get selectDestinationProject => 'Seleccionar Proyecto Destino';

  @override
  String get existingProject => 'Proyecto existente';

  @override
  String get createNewProject => 'Crear nuevo proyecto';

  @override
  String get projectName => 'Nombre del Proyecto';

  @override
  String get projectNameHint => 'Ingresa un nombre para el nuevo proyecto';

  @override
  String get selectProject => 'Seleccionar proyecto';

  @override
  String get selectProjectHint => 'Elige un proyecto de destino';

  @override
  String get noProjectsAvailable =>
      'No hay proyectos disponibles. Crea uno nuevo.';

  @override
  String get userStoryFieldMappingInfo =>
      'Mapeo: Título → Título story, Descripción → Descripción story, Esfuerzo → Story points, Prioridad → Business value';

  @override
  String storiesCreated(int count) {
    return '$count stories creadas';
  }

  @override
  String get configureNewProject => 'Configurar nuevo proyecto';

  @override
  String get exportToAgileSprint => 'Exportar a Sprint';

  @override
  String get exportToAgileSprintDesc =>
      'Agregar stories estimadas a un sprint Agile';

  @override
  String get selectSprint => 'Seleccionar sprint';

  @override
  String get selectSprintHint => 'Elige un sprint de destino';

  @override
  String get noSprintsAvailable =>
      'No hay sprints disponibles. Crea primero un sprint en planificación.';

  @override
  String get sprintExportFieldMappingInfo =>
      'Mapeo: Título → Título story, Descripción → Descripción, Estimación → Story points';

  @override
  String get exportToSprint => 'Exportar a sprint';

  @override
  String totalStoryPoints(int count) {
    return '$count story points en total';
  }

  @override
  String storiesAddedToSprint(int count, String sprintName) {
    return '$count stories agregadas a $sprintName';
  }

  @override
  String storiesAddedToProject(int count, String projectName) {
    return '$count stories agregadas al proyecto $projectName';
  }

  @override
  String get exportEisenhowerToSprintDesc =>
      'Transforma las actividades Eisenhower en User Stories';

  @override
  String get exportEisenhowerToEstimationDesc =>
      'Crear una sesión de estimación a partir de las actividades';

  @override
  String get selectedActivities => 'actividades seleccionadas';

  @override
  String get noActivitiesToExport => 'No hay actividades para exportar';

  @override
  String get hiddenQ4Activities => 'Ocultas';

  @override
  String get q4Activities => 'actividades Q4 (Eliminar)';

  @override
  String get showQ4 => 'Mostrar Q4';

  @override
  String get hideQ4 => 'Ocultar Q4';

  @override
  String get showingAllActivities => 'Mostrando todas las actividades';

  @override
  String get eisenhowerMappingInfo =>
      'Q1→Must, Q2→Should, Q3→Could, Q4→Won\'t. Importancia→Business Value.';

  @override
  String get estimationExportInfo =>
      'Las actividades se agregarán como stories a estimar. La prioridad Q no se transferirá.';

  @override
  String get createSession => 'Crear Sesión';

  @override
  String get estimationType => 'Tipo de estimación';

  @override
  String activitiesAddedToSprint(int count, String sprintName) {
    return '$count attività aggiunte a $sprintName';
  }

  @override
  String activitiesAddedToProject(int count, String projectName) {
    return '$count attività aggiunte al progetto $projectName';
  }

  @override
  String estimationSessionCreated(int count) {
    return 'Sessione di stima creata con $count attività';
  }

  @override
  String activitiesExportedToSprint(int count, String sprintName) {
    return '$count actividades exportadas al sprint $sprintName';
  }

  @override
  String activitiesExportedToEstimation(int count, String sessionName) {
    return '$count actividades exportadas a la sesión de estimación $sessionName';
  }

  @override
  String get archiveAction => 'Archivar';

  @override
  String get archiveRestoreAction => 'Restaurar';

  @override
  String get archiveShowArchived => 'Mostrar archivados';

  @override
  String get archiveHideArchived => 'Ocultar archivados';

  @override
  String archiveConfirmTitle(String itemType) {
    return 'Archivar $itemType';
  }

  @override
  String get archiveConfirmMessage =>
      '¿Estás seguro de que quieres archivar este elemento? Podrá ser restaurado más tarde.';

  @override
  String archiveRestoreConfirmTitle(String itemType) {
    return 'Restaurar $itemType';
  }

  @override
  String get archiveRestoreConfirmMessage =>
      '¿Quieres restaurar este elemento del archivo?';

  @override
  String get archiveSuccessMessage => 'Elemento archivado con éxito';

  @override
  String get archiveRestoreSuccessMessage => 'Elemento restaurado con éxito';

  @override
  String get archiveErrorMessage => 'Error al archivar';

  @override
  String get archiveRestoreErrorMessage => 'Error al restaurar';

  @override
  String get archiveFilterLabel => 'Archivo';

  @override
  String get archiveFilterActive => 'Activos';

  @override
  String get archiveFilterArchived => 'Archivados';

  @override
  String get archiveFilterAll => 'Todos';

  @override
  String get archiveBadge => 'Archivado';

  @override
  String get archiveEmptyMessage => 'No hay elementos archivados';

  @override
  String get completeAction => 'Completar';

  @override
  String get reopenAction => 'Reabrir';

  @override
  String completeConfirmTitle(String itemType) {
    return 'Completar $itemType';
  }

  @override
  String get completeConfirmMessage =>
      '¿Estás seguro de que quieres completar este elemento?';

  @override
  String get completeSuccessMessage => 'Elemento completado con éxito';

  @override
  String get reopenSuccessMessage => 'Elemento reabierto con éxito';

  @override
  String get completedBadge => 'Completado';

  @override
  String get inviteNewInvite => 'NUEVA INVITACIÓN';

  @override
  String get inviteRole => 'Rol:';

  @override
  String get inviteSendEmailNotification => 'Enviar notificación por email';

  @override
  String get inviteSendInvite => 'Enviar Invitación';

  @override
  String get inviteLink => 'Enlace de invitación:';

  @override
  String get inviteList => 'INVITACIONES';

  @override
  String get inviteResend => 'Reenviar';

  @override
  String get inviteRevokeMessage => 'La invitación ya no será válida.';

  @override
  String get inviteResent => 'Invitación reenviada';

  @override
  String inviteSentByEmail(String email) {
    return 'Invitación enviada por email a $email';
  }

  @override
  String get inviteStatusPending => 'Pendiente';

  @override
  String get inviteStatusAccepted => 'Aceptada';

  @override
  String get inviteStatusDeclined => 'Rechazada';

  @override
  String get inviteStatusExpired => 'Expirada';

  @override
  String get inviteStatusRevoked => 'Revocada';

  @override
  String get inviteGmailAuthTitle => 'Autorización de Gmail';

  @override
  String get inviteGmailAuthMessage =>
      'Para enviar emails de invitación, necesitas volver a autenticarte con Google.\n\n¿Quieres continuar?';

  @override
  String get inviteGmailAuthNo => 'No, solo enlace';

  @override
  String get inviteGmailAuthYes => 'Autorizar';

  @override
  String get inviteGmailNotAvailable =>
      'Autorización de Gmail no disponible. Intenta cerrar sesión e iniciar de nuevo.';

  @override
  String get inviteGmailNoPermission => 'Permiso de Gmail no concedido.';

  @override
  String get inviteEnterEmail => 'Ingresa un email';

  @override
  String get inviteInvalidEmail => 'Email inválido';

  @override
  String get pendingInvites => 'Invitaciones Pendientes';

  @override
  String get noPendingInvites => 'No hay invitaciones pendientes';

  @override
  String invitedBy(String name) {
    return 'Invitado por $name';
  }

  @override
  String get inviteOpenInstance => 'Abrir';

  @override
  String get inviteAcceptFirst => 'Acepta la invitación para abrir';

  @override
  String get inviteAccept => 'Aceptar';

  @override
  String get inviteDecline => 'Rechazar';

  @override
  String get inviteAcceptedSuccess => '¡Invitación aceptada con éxito!';

  @override
  String get inviteAcceptedError => 'Error al aceptar la invitación';

  @override
  String get inviteDeclinedSuccess => 'Invitación rechazada';

  @override
  String get inviteDeclinedError => 'Error al rechazar la invitación';

  @override
  String get inviteDeclineTitle => '¿Rechazar invitación?';

  @override
  String get inviteDeclineMessage =>
      '¿Estás seguro de que quieres rechazar esta invitación?';

  @override
  String expiresInHours(int hours) {
    return 'Expira en ${hours}h';
  }

  @override
  String expiresInDays(int days) {
    return 'Expira en ${days}d';
  }

  @override
  String get close => 'Cerrar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get raciTitle => 'Matriz RACI';

  @override
  String get raciNoActivities => 'No hay actividades disponibles';

  @override
  String get raciAddActivity => 'Agregar actividad';

  @override
  String get raciAddColumn => 'Agregar columna';

  @override
  String get raciActivities => 'ACTIVIDADES';

  @override
  String get raciAssignRole => 'Asignar rol';

  @override
  String get raciNone => 'Ninguno';

  @override
  String get raciSaving => 'Guardando...';

  @override
  String get raciSaveChanges => 'Guardar cambios';

  @override
  String get raciSavedSuccessfully => 'Cambios guardados correctamente';

  @override
  String get raciErrorSaving => 'Error al guardar';

  @override
  String get raciMissingAccountable => 'Falta Accountable (A)';

  @override
  String get raciOnlyOneAccountable => 'Solo un Accountable por actividad';

  @override
  String get raciDuplicateRoles => 'Roles duplicados';

  @override
  String get raciNoResponsible => 'No hay Responsible (R) asignado';

  @override
  String get raciTooManyInformed =>
      'Demasiados Informed (I): considera reducir';

  @override
  String get raciNewColumn => 'Nueva columna';

  @override
  String get raciRemoveColumn => 'Eliminar columna';

  @override
  String raciRemoveColumnConfirm(String name) {
    return '¿Eliminar la columna \"$name\"? Se eliminarán todas las asignaciones de roles para esta columna.';
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
  String get votingDialogNotUrgent => 'No urgente';

  @override
  String get votingDialogVeryUrgent => 'Muy urgente';

  @override
  String get votingDialogNotImportant => 'No importante';

  @override
  String get votingDialogVeryImportant => 'Muy importante';

  @override
  String get votingDialogConfirmVote => 'Confirmar voto';

  @override
  String get votingDialogQuadrant => 'Cuadrante:';

  @override
  String get voteCollectionTitle => 'Recoger votos';

  @override
  String get voteCollectionParticipants => 'participantes';

  @override
  String get voteCollectionResult => 'Resultado:';

  @override
  String get voteCollectionAverage => 'Promedio:';

  @override
  String get voteCollectionSaveVotes => 'Guardar votos';

  @override
  String get scatterChartTitle => 'Distribución de actividades';

  @override
  String get scatterChartNoActivities => 'No hay actividades votadas';

  @override
  String get scatterChartVoteToShow =>
      'Vota las actividades para verlas en el gráfico';

  @override
  String get scatterChartUrgencyLabel => 'Urgencia:';

  @override
  String get scatterChartImportanceLabel => 'Importancia:';

  @override
  String get scatterChartAxisUrgency => 'URGENCIA';

  @override
  String get scatterChartAxisImportance => 'IMPORTANCIA';

  @override
  String get scatterChartQ1Label => 'Q1 - HACER';

  @override
  String get scatterChartQ2Label => 'Q2 - PLANIFICAR';

  @override
  String get scatterChartQ3Label => 'Q3 - DELEGAR';

  @override
  String get scatterChartQ4Label => 'Q4 - ELIMINAR';

  @override
  String get scatterChartCardTitle => 'Gráfico de distribución';

  @override
  String get votingStatusYou => 'Tú';

  @override
  String get votingStatusReset => 'Reiniciar';

  @override
  String get estimationDecimalHintPlaceholder => 'Ej: 2.5';

  @override
  String get estimationDecimalSuffixDays => 'días';

  @override
  String get estimationDecimalVote => 'Votar';

  @override
  String estimationDecimalVoteValue(String value) {
    return 'Voto: $value días';
  }

  @override
  String get estimationDecimalQuickSelect => 'Selección rápida:';

  @override
  String get estimationDecimalEnterValue => 'Ingresa un valor';

  @override
  String get estimationDecimalInvalidValue => 'Valor no válido';

  @override
  String estimationDecimalMinValue(String value) {
    return 'Mín: $value';
  }

  @override
  String estimationDecimalMaxValue(String value) {
    return 'Máx: $value';
  }

  @override
  String get estimationThreePointTitle => 'Estimación de tres puntos (PERT)';

  @override
  String get estimationThreePointOptimistic => 'Optimista (O)';

  @override
  String get estimationThreePointRealistic => 'Realista (M)';

  @override
  String get estimationThreePointPessimistic => 'Pesimista (P)';

  @override
  String get estimationThreePointBestCase => 'Mejor caso';

  @override
  String get estimationThreePointMostLikely => 'Más probable';

  @override
  String get estimationThreePointWorstCase => 'Peor caso';

  @override
  String get estimationThreePointAllFieldsRequired =>
      'Todos los campos son obligatorios';

  @override
  String get estimationThreePointInvalidValues => 'Valores no válidos';

  @override
  String get estimationThreePointOptMustBeLteReal =>
      'Optimista debe ser <= Realista';

  @override
  String get estimationThreePointRealMustBeLtePess =>
      'Realista debe ser <= Pesimista';

  @override
  String get estimationThreePointOptMustBeLtePess =>
      'Optimista debe ser <= Pesimista';

  @override
  String get estimationThreePointGuide => 'Guía:';

  @override
  String get estimationThreePointGuideO =>
      'O: Estimación del mejor caso (todo va bien)';

  @override
  String get estimationThreePointGuideM =>
      'M: Estimación más probable (condiciones normales)';

  @override
  String get estimationThreePointGuideP =>
      'P: Estimación del peor caso (imprevistos)';

  @override
  String get estimationThreePointStdDev => 'Desv. Est.';

  @override
  String get estimationThreePointDaysSuffix => 'd';

  @override
  String get storyFormNewStory => 'Nueva Story';

  @override
  String get storyFormEnterTitle => 'Ingresa un título';

  @override
  String get sessionSearchHint => 'Buscar sesiones...';

  @override
  String get sessionSearchFilters => 'Filtros';

  @override
  String get sessionSearchFiltersTooltip => 'Filtros';

  @override
  String get sessionSearchStatusLabel => 'Estado: ';

  @override
  String get sessionSearchStatusAll => 'Todos';

  @override
  String get sessionSearchStatusDraft => 'Borrador';

  @override
  String get sessionSearchStatusActive => 'Activa';

  @override
  String get sessionSearchStatusCompleted => 'Completada';

  @override
  String get sessionSearchModeLabel => 'Modo: ';

  @override
  String get sessionSearchModeAll => 'Todos';

  @override
  String get sessionSearchRemoveFilters => 'Quitar filtros';

  @override
  String get sessionSearchActiveFilters => 'Filtros activos:';

  @override
  String get sessionSearchRemoveAllFilters => 'Quitar todos';

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
  String get votingBoardVotesRevealed => 'Votos revelados';

  @override
  String get votingBoardVotingInProgress => 'Votación en curso';

  @override
  String votingBoardVotesCount(int voted, int total) {
    return '$voted/$total votos';
  }

  @override
  String get estimationSelectYourEstimate => 'Selecciona tu estimación';

  @override
  String estimationVoteSelected(String value) {
    return 'Voto seleccionado: $value';
  }

  @override
  String get estimationDotVotingTitle => 'Dot Voting';

  @override
  String get estimationDotVotingDesc =>
      'Modo de votación con asignación de puntos.\nPróximamente...';

  @override
  String get estimationBucketSystemTitle => 'Bucket System';

  @override
  String get estimationBucketSystemDesc =>
      'Estimación por afinidad con agrupación.\nPróximamente...';

  @override
  String get estimationModeTitle => 'Modo de estimación';

  @override
  String get statisticsTitle => 'Estadísticas de votación';

  @override
  String get statisticsAverage => 'Promedio';

  @override
  String get statisticsMedian => 'Mediana';

  @override
  String get statisticsMode => 'Moda';

  @override
  String get statisticsVoters => 'Votantes';

  @override
  String get statisticsPertStats => 'Estadísticas PERT';

  @override
  String get statisticsPertAvg => 'Prom. PERT';

  @override
  String get statisticsStdDev => 'Desv. Est.';

  @override
  String get statisticsVariance => 'Varianza';

  @override
  String get statisticsRange => 'Rango:';

  @override
  String get statisticsConsensusReached => '¡Consenso alcanzado!';

  @override
  String get retroGuideTooltip => 'Guida alle Retrospettive';

  @override
  String get retroSearchPlaceholder => 'Cerca retrospettiva...';

  @override
  String get retroNoSearchResults => 'Nessun risultato per la ricerca';

  @override
  String get retroNewRetro => 'Nuova Retrospettiva';

  @override
  String get retroNoProjectsFound => 'Nessun progetto trovato.';

  @override
  String retroDeleteMessage(String retroName) {
    return 'Sei sicuro di voler eliminare definitivamente la retrospettiva \"$retroName\"?\n\nQuesta azione è irreversibile e cancellerà tutti i dati associati (card, voti, action items).';
  }

  @override
  String get retroDeletePermanently => 'Elimina definitivamente';

  @override
  String get retroDeletedSuccess => 'Retrospettiva eliminata con successo';

  @override
  String errorPrefix(String error) {
    return 'Errore: $error';
  }

  @override
  String get loaderProjectIdMissing => 'ID progetto mancante';

  @override
  String get loaderProjectNotFound => 'Progetto non trovato';

  @override
  String get loaderLoadError => 'Errore caricamento';

  @override
  String get loaderError => 'Errore';

  @override
  String get loaderUnknownError => 'Errore sconosciuto';

  @override
  String get actionGoBack => 'Torna indietro';

  @override
  String get authRequired => 'Autenticazione richiesta';

  @override
  String get retroIdMissing => 'ID retrospettiva mancante';

  @override
  String get pokerInviteStatusAccepted => 'è già stato accettato';

  @override
  String get pokerInviteStatusDeclined => 'è stato rifiutato';

  @override
  String get pokerInviteStatusExpired => 'è scaduto';

  @override
  String get pokerInviteStatusRevoked => 'è stato revocato';

  @override
  String get pokerInviteStatusPending => 'è in attesa';

  @override
  String get pokerInviteYouAreInvited => 'Sei Stato Invitato!';

  @override
  String pokerInviteInvitedBy(String name) {
    return '$name ti ha invitato a partecipare';
  }

  @override
  String get pokerInviteSessionLabel => 'Sessione';

  @override
  String get pokerInviteProjectLabel => 'Progetto';

  @override
  String get pokerInviteRoleLabel => 'Ruolo Assegnato';

  @override
  String get pokerInviteExpiryLabel => 'Scadenza Invito';

  @override
  String pokerInviteExpiryDays(int days) {
    return 'Tra $days giorni';
  }

  @override
  String get pokerInviteDecline => 'Rifiuta';

  @override
  String get pokerInviteAccept => 'Accetta Invito';

  @override
  String loadingMatrixError(String error) {
    return 'Errore caricamento matrice: $error';
  }

  @override
  String loadingDataError(String error) {
    return 'Errore caricamento dati: $error';
  }

  @override
  String loadingActivitiesError(String error) {
    return 'Errore caricamento attività: $error';
  }

  @override
  String smartTodoSprintDays(int days) {
    return '$days días/sprint';
  }

  @override
  String smartTodoHoursPerDay(int hours) {
    return '${hours}h/día';
  }

  @override
  String get smartTodoImageFromClipboardFound =>
      'Imagen encontrada en el portapapeles';

  @override
  String get smartTodoAddImageFromClipboard =>
      'Añadir imagen desde el portapapeles';

  @override
  String get smartTodoInviteCreatedAndSent => 'Invitación creada y enviada';

  @override
  String get retroColumnDropDesc =>
      '¿Qué no aporta valor y debería eliminarse?';

  @override
  String get retroColumnAddDesc =>
      '¿Qué nuevas prácticas deberíamos introducir?';

  @override
  String get retroColumnKeepDesc => '¿Qué funciona bien y debería continuar?';

  @override
  String get retroColumnImproveDesc => '¿Qué podemos hacer mejor?';

  @override
  String get retroColumnStart => 'Comenzar';

  @override
  String get retroColumnStartDesc =>
      '¿Qué nuevas actividades deberíamos comenzar?';

  @override
  String get retroColumnStop => 'Detener';

  @override
  String get retroColumnStopDesc => '¿Qué deberíamos dejar de hacer?';

  @override
  String get retroColumnContinue => 'Continuar';

  @override
  String get retroColumnContinueDesc => '¿Qué deberíamos seguir haciendo?';

  @override
  String get retroColumnLongedFor => 'Deseado';

  @override
  String get retroColumnLikedDesc => '¿Qué te gustó de este sprint?';

  @override
  String get retroColumnLearnedDesc => '¿Qué aprendiste de nuevo?';

  @override
  String get retroColumnLackedDesc => '¿Qué faltó en este sprint?';

  @override
  String get retroColumnLongedForDesc => '¿Qué desearías tener en el futuro?';

  @override
  String get retroColumnMadDesc => '¿Qué te hizo enojar o frustrar?';

  @override
  String get retroColumnSadDesc => '¿Qué te decepcionó o entristeció?';

  @override
  String get retroColumnGladDesc => '¿Qué te hizo feliz o satisfecho?';

  @override
  String get retroColumnWindDesc => '¿Qué nos impulsó? Fortalezas y apoyo.';

  @override
  String get retroColumnAnchorDesc =>
      '¿Qué nos ralentizó? Obstáculos y bloqueos.';

  @override
  String get retroColumnRockDesc =>
      '¿Qué riesgos futuros vemos en el horizonte?';

  @override
  String get retroColumnGoalDesc => '¿Cuál es nuestro destino ideal?';

  @override
  String get retroColumnMoreDesc => '¿Qué deberíamos hacer más?';

  @override
  String get retroColumnLessDesc => '¿Qué deberíamos hacer menos?';

  @override
  String get actionTypeMaintain => 'Mantener';

  @override
  String get actionTypeStop => 'Detener';

  @override
  String get actionTypeBegin => 'Comenzar';

  @override
  String get actionTypeIncrease => 'Aumentar';

  @override
  String get actionTypeDecrease => 'Disminuir';

  @override
  String get actionTypePrevent => 'Prevenir';

  @override
  String get actionTypeCelebrate => 'Celebrar';

  @override
  String get actionTypeReplicate => 'Replicar';

  @override
  String get actionTypeShare => 'Compartir';

  @override
  String get actionTypeProvide => 'Proveer';

  @override
  String get actionTypePlan => 'Planificar';

  @override
  String get actionTypeLeverage => 'Aprovechar';

  @override
  String get actionTypeRemove => 'Eliminar';

  @override
  String get actionTypeMitigate => 'Mitigar';

  @override
  String get actionTypeAlign => 'Alinear';

  @override
  String get actionTypeEliminate => 'Eliminar';

  @override
  String get actionTypeImplement => 'Implementar';

  @override
  String get actionTypeEnhance => 'Mejorar';

  @override
  String get coachTipSSCWriting =>
      'Enfócate en comportamientos concretos y observables. Cada elemento debe ser algo sobre lo que el equipo pueda actuar directamente. Evita declaraciones vagas.';

  @override
  String get coachTipSSCVoting =>
      'Vota basándote en el impacto y la viabilidad. Los elementos más votados se convertirán en compromisos del sprint.';

  @override
  String get coachTipSSCDiscuss =>
      'Para cada elemento más votado, define QUIÉN hará QUÉ para CUÁNDO. Transforma las ideas en acciones específicas.';

  @override
  String get coachTipMSGWriting =>
      'Crea un espacio seguro para las emociones. Todos los sentimientos son válidos. Enfócate en la situación, no en la persona. Usa declaraciones \'Me siento...\'.';

  @override
  String get coachTipMSGVoting =>
      'Vota para identificar experiencias compartidas. Los patrones emocionales revelan dinámicas del equipo que necesitan atención.';

  @override
  String get coachTipMSGDiscuss =>
      'Reconoce las emociones antes de resolver problemas. Pregunta \'¿Qué ayudaría?\' en lugar de saltar a soluciones. Escucha activamente.';

  @override
  String get coachTip4LsWriting =>
      'Reflexiona sobre aprendizajes, no solo eventos. Piensa en qué insights llevarás contigo. Cada L representa una perspectiva diferente.';

  @override
  String get coachTip4LsVoting =>
      'Prioriza los aprendizajes que podrían mejorar futuros sprints. Enfócate en conocimiento transferible.';

  @override
  String get coachTip4LsDiscuss =>
      'Transforma los aprendizajes en documentación o cambios de proceso. Pregunta \'¿Cómo podemos compartir este conocimiento con otros?\'';

  @override
  String get coachTipSailboatWriting =>
      'Usa la metáfora: el Viento nos empuja (facilitadores), las Anclas nos frenan (bloqueantes), las Rocas son riesgos futuros, la Isla es nuestra meta.';

  @override
  String get coachTipSailboatVoting =>
      'Prioriza según el impacto del riesgo y el potencial de los facilitadores. Equilibra entre abordar bloqueantes y aprovechar fortalezas.';

  @override
  String get coachTipSailboatDiscuss =>
      'Crea un registro de riesgos para las rocas. Define estrategias de mitigación. Aprovecha los vientos para superar las anclas.';

  @override
  String get coachTipDAKIWriting =>
      'Sé decisivo: Elimina lo que desperdicia tiempo, Agrega lo que falta, Mantén lo que funciona, Mejora lo que podría ser mejor.';

  @override
  String get coachTipDAKIVoting =>
      'Vota pragmáticamente. Enfócate en cambios que tendrán impacto inmediato y medible.';

  @override
  String get coachTipDAKIDiscuss =>
      'Toma decisiones claras como equipo. Para cada elemento, comprométete con una acción específica o decide explícitamente no actuar.';

  @override
  String get coachTipStarfishWriting =>
      'Usa gradaciones: Mantener (como está), Más (aumentar), Menos (disminuir), Stop (eliminar), Start (comenzar). Esto permite feedback matizado.';

  @override
  String get coachTipStarfishVoting =>
      'Considera el esfuerzo vs el impacto. Los elementos \'Más\' y \'Menos\' pueden ser más fáciles de implementar que \'Start\' y \'Stop\'.';

  @override
  String get coachTipStarfishDiscuss =>
      'Define métricas específicas para \'más\' y \'menos\'. ¿Cuánto más? ¿Cómo mediremos? Establece objetivos de calibración claros.';

  @override
  String get discussPromptSSCStart =>
      '¿Qué nueva práctica deberíamos comenzar? Piensa en brechas en nuestro proceso que un nuevo hábito podría llenar.';

  @override
  String get discussPromptSSCStop =>
      '¿Qué desperdicia nuestro tiempo o energía? Considera actividades que no entregan valor proporcional a su costo.';

  @override
  String get discussPromptSSCContinue =>
      '¿Qué está funcionando bien? Reconoce y refuerza las prácticas efectivas.';

  @override
  String get discussPromptMSGMad =>
      '¿Qué te frustró? Recuerda, estamos discutiendo situaciones, no culpando individuos.';

  @override
  String get discussPromptMSGSad =>
      '¿Qué te decepcionó? ¿Qué expectativas no se cumplieron?';

  @override
  String get discussPromptMSGGlad =>
      '¿Qué te hizo feliz? ¿Qué momentos te dieron satisfacción este sprint?';

  @override
  String get discussPrompt4LsLiked =>
      '¿Qué disfrutaste? ¿Qué hizo el trabajo agradable?';

  @override
  String get discussPrompt4LsLearned =>
      '¿Qué nueva habilidad, insight o conocimiento adquiriste?';

  @override
  String get discussPrompt4LsLacked =>
      '¿Qué faltó? ¿Qué recursos, apoyo o claridad hubieran ayudado?';

  @override
  String get discussPrompt4LsLonged =>
      '¿Qué deseas? ¿Qué haría mejores los futuros sprints?';

  @override
  String get discussPromptSailboatWind =>
      '¿Qué nos impulsó hacia adelante? ¿Cuáles son nuestras fortalezas y apoyo externo?';

  @override
  String get discussPromptSailboatAnchor =>
      '¿Qué nos frenó? ¿Qué obstáculos internos o externos nos retrasaron?';

  @override
  String get discussPromptSailboatRock =>
      '¿Qué riesgos vemos adelante? ¿Qué podría descarrilarnos si no se aborda?';

  @override
  String get discussPromptSailboatGoal =>
      '¿Cuál es nuestro destino? ¿Estamos alineados sobre hacia dónde vamos?';

  @override
  String get discussPromptDAKIDrop =>
      '¿Qué deberíamos eliminar? ¿Qué no aporta valor?';

  @override
  String get discussPromptDAKIAdd =>
      '¿Qué deberíamos introducir? ¿Qué falta en nuestro toolkit?';

  @override
  String get discussPromptDAKIKeep =>
      '¿Qué debemos preservar? ¿Qué es esencial para nuestro éxito?';

  @override
  String get discussPromptDAKIImprove =>
      '¿Qué podría ser mejor? ¿Dónde podemos mejorar?';

  @override
  String get discussPromptStarfishKeep =>
      '¿Qué deberíamos mantener exactamente como está?';

  @override
  String get discussPromptStarfishMore =>
      '¿Qué deberíamos aumentar? ¿Hacer más?';

  @override
  String get discussPromptStarfishLess =>
      '¿Qué deberíamos reducir? ¿Hacer menos?';

  @override
  String get discussPromptStarfishStop =>
      '¿Qué deberíamos eliminar completamente?';

  @override
  String get discussPromptStarfishStart =>
      '¿Qué nueva cosa deberíamos comenzar?';

  @override
  String get discussPromptGeneric =>
      '¿Qué insights emergieron de esta columna? ¿Qué patrones ves?';

  @override
  String get smartPromptSSCStartQuestion =>
      '¿Qué nueva práctica específica comenzarás, y cómo medirás su adopción?';

  @override
  String get smartPromptSSCStartExample =>
      'ej., \'Comenzar standup diario de 15 min a las 9:30, rastrear asistencia por 2 semanas\'';

  @override
  String get smartPromptSSCStartPlaceholder =>
      'Comenzaremos [práctica específica] para [fecha], medida por [métrica]';

  @override
  String get smartPromptSSCStopQuestion =>
      '¿Qué dejarás de hacer, y qué harás en su lugar?';

  @override
  String get smartPromptSSCStopExample =>
      'ej., \'Dejar de enviar actualizaciones por email, usar el canal Slack #updates en su lugar\'';

  @override
  String get smartPromptSSCStopPlaceholder =>
      'Dejaremos de hacer [práctica] y en su lugar [alternativa]';

  @override
  String get smartPromptSSCContinueQuestion =>
      '¿Qué práctica continuarás, y cómo te asegurarás de que no desaparezca?';

  @override
  String get smartPromptSSCContinueExample =>
      'ej., \'Continuar code reviews en menos de 4 horas, agregar a Definition of Done\'';

  @override
  String get smartPromptSSCContinuePlaceholder =>
      'Continuaremos [práctica], reforzada por [mecanismo]';

  @override
  String get smartPromptMSGMadQuestion =>
      '¿Qué acción abordaría esta frustración y quién la liderará?';

  @override
  String get smartPromptMSGMadExample =>
      'ej., \'Programar reunión con PM para clarificar proceso de requisitos - María para el viernes\'';

  @override
  String get smartPromptMSGMadPlaceholder =>
      '[Acción para abordar frustración], responsable: [nombre], para: [fecha]';

  @override
  String get smartPromptMSGSadQuestion =>
      '¿Qué cambio evitaría que esta decepción se repita?';

  @override
  String get smartPromptMSGSadExample =>
      'ej., \'Crear checklist de comunicación para actualizaciones a stakeholders - revisión semanal\'';

  @override
  String get smartPromptMSGSadPlaceholder =>
      '[Acción preventiva], rastreada vía [método]';

  @override
  String get smartPromptMSGGladQuestion =>
      '¿Cómo podemos replicar o amplificar lo que nos hizo felices?';

  @override
  String get smartPromptMSGGladExample =>
      'ej., \'Documentar formato de sesión de pairing y compartir con otros equipos para fin de semana\'';

  @override
  String get smartPromptMSGGladPlaceholder =>
      '[Acción para replicar/amplificar], compartir con [audiencia]';

  @override
  String get smartPrompt4LsLikedQuestion =>
      '¿Cómo podemos asegurar que esta experiencia positiva continúe?';

  @override
  String get smartPrompt4LsLikedExample =>
      'ej., \'Hacer de la sesión de mob programming un evento semanal recurrente\'';

  @override
  String get smartPrompt4LsLikedPlaceholder =>
      '[Acción para preservar experiencia positiva]';

  @override
  String get smartPrompt4LsLearnedQuestion =>
      '¿Cómo documentarás y compartirás este aprendizaje?';

  @override
  String get smartPrompt4LsLearnedExample =>
      'ej., \'Escribir artículo wiki sobre nuevo enfoque de testing, presentar en tech talk el próximo mes\'';

  @override
  String get smartPrompt4LsLearnedPlaceholder =>
      'Documentar en [ubicación], compartir vía [método] para [fecha]';

  @override
  String get smartPrompt4LsLackedQuestion =>
      '¿Qué recursos o apoyo específicos solicitarás y a quién?';

  @override
  String get smartPrompt4LsLackedExample =>
      'ej., \'Solicitar presupuesto de capacitación CI/CD al manager - enviar antes del próximo planning\'';

  @override
  String get smartPrompt4LsLackedPlaceholder =>
      'Solicitar [recurso] a [persona/equipo], deadline: [fecha]';

  @override
  String get smartPrompt4LsLongedQuestion =>
      '¿Qué primer paso concreto te acercará a este deseo?';

  @override
  String get smartPrompt4LsLongedExample =>
      'ej., \'Redactar propuesta para 20% de tiempo para proyectos personales - compartir con team lead el lunes\'';

  @override
  String get smartPrompt4LsLongedPlaceholder =>
      'Primer paso hacia [deseo]: [acción] para [fecha]';

  @override
  String get smartPromptSailboatWindQuestion =>
      '¿Cómo aprovecharás este facilitador para acelerar el progreso?';

  @override
  String get smartPromptSailboatWindExample =>
      'ej., \'Usar fuerte expertise en QA para mentorear juniors - programar primera sesión esta semana\'';

  @override
  String get smartPromptSailboatWindPlaceholder =>
      'Aprovechar [facilitador] con [acción específica]';

  @override
  String get smartPromptSailboatAnchorQuestion =>
      '¿Qué acción específica eliminará o reducirá este bloqueante?';

  @override
  String get smartPromptSailboatAnchorExample =>
      'ej., \'Escalar problema de infraestructura al CTO - preparar brief para el miércoles\'';

  @override
  String get smartPromptSailboatAnchorPlaceholder =>
      'Eliminar [bloqueante] con [acción], escalar a [persona] si es necesario';

  @override
  String get smartPromptSailboatRockQuestion =>
      '¿Qué estrategia de mitigación implementarás para este riesgo?';

  @override
  String get smartPromptSailboatRockExample =>
      'ej., \'Agregar plan de respaldo para dependencia de proveedor - documentar alternativas para fin de sprint\'';

  @override
  String get smartPromptSailboatRockPlaceholder =>
      'Mitigar [riesgo] con [estrategia], trigger: [condición]';

  @override
  String get smartPromptSailboatGoalQuestion =>
      '¿Qué hito confirmará el progreso hacia este objetivo?';

  @override
  String get smartPromptSailboatGoalExample =>
      'ej., \'Demo MVP a stakeholders para el 15 feb, recolectar feedback vía encuesta\'';

  @override
  String get smartPromptSailboatGoalPlaceholder =>
      'Hito hacia [objetivo]: [entregable] para [fecha]';

  @override
  String get smartPromptDAKIDropQuestion =>
      '¿Qué eliminarás y cómo te asegurarás de que no regrese?';

  @override
  String get smartPromptDAKIDropExample =>
      'ej., \'Eliminar pasos de deployment manuales - automatizar para fin de sprint\'';

  @override
  String get smartPromptDAKIDropPlaceholder =>
      'Eliminar [práctica], prevenir regreso con [mecanismo]';

  @override
  String get smartPromptDAKIAddQuestion =>
      '¿Qué nueva práctica introducirás y cómo validarás que funciona?';

  @override
  String get smartPromptDAKIAddExample =>
      'ej., \'Agregar sistema de feature flags - probar en 2 features, revisar resultados en 2 semanas\'';

  @override
  String get smartPromptDAKIAddPlaceholder =>
      'Agregar [práctica], validar éxito vía [métrica]';

  @override
  String get smartPromptDAKIKeepQuestion =>
      '¿Cómo protegerás esta práctica de ser despriorizada?';

  @override
  String get smartPromptDAKIKeepExample =>
      'ej., \'Mantener estándares de code review - agregar al team charter, auditoría mensual\'';

  @override
  String get smartPromptDAKIKeepPlaceholder =>
      'Proteger [práctica] con [mecanismo]';

  @override
  String get smartPromptDAKIImproveQuestion =>
      '¿Qué mejora específica harás y cómo medirás la mejora?';

  @override
  String get smartPromptDAKIImproveExample =>
      'ej., \'Mejorar cobertura de tests del 60% al 80% - focus en módulo de pagos primero\'';

  @override
  String get smartPromptDAKIImprovePlaceholder =>
      'Mejorar [práctica] de [actual] a [objetivo] para [fecha]';

  @override
  String get smartPromptStarfishKeepQuestion =>
      '¿Qué práctica mantendrás y quién es responsable de asegurar consistencia?';

  @override
  String get smartPromptStarfishKeepExample =>
      'ej., \'Mantener demos del viernes - Tom se asegura de reservar sala, agenda compartida para el jueves\'';

  @override
  String get smartPromptStarfishKeepPlaceholder =>
      'Mantener [práctica], responsable: [nombre]';

  @override
  String get smartPromptStarfishMoreQuestion => '¿Qué aumentarás y cuánto?';

  @override
  String get smartPromptStarfishMoreExample =>
      'ej., \'Aumentar pair programming de 2h a 6h por semana por desarrollador\'';

  @override
  String get smartPromptStarfishMorePlaceholder =>
      'Aumentar [práctica] de [nivel actual] a [nivel objetivo]';

  @override
  String get smartPromptStarfishLessQuestion => '¿Qué reducirás y cuánto?';

  @override
  String get smartPromptStarfishLessExample =>
      'ej., \'Reducir reuniones de 10h a 6h por semana - cancelar review recurrente\'';

  @override
  String get smartPromptStarfishLessPlaceholder =>
      'Reducir [práctica] de [nivel actual] a [nivel objetivo]';

  @override
  String get smartPromptStarfishStopQuestion =>
      '¿Qué dejarás de hacer completamente y qué lo reemplaza (si algo)?';

  @override
  String get smartPromptStarfishStopExample =>
      'ej., \'Dejar tracking de tiempo detallado en tareas - estimaciones basadas en confianza en su lugar\'';

  @override
  String get smartPromptStarfishStopPlaceholder =>
      'Dejar [práctica], reemplazar con [alternativa] o nada';

  @override
  String get smartPromptStarfishStartQuestion =>
      '¿Qué nueva práctica comenzarás y cuándo será la primera ocurrencia?';

  @override
  String get smartPromptStarfishStartExample =>
      'ej., \'Comenzar tech debt Tuesday - primera sesión la próxima semana, 2h de tiempo protegido\'';

  @override
  String get smartPromptStarfishStartPlaceholder =>
      'Comenzar [práctica], primera ocurrencia: [fecha/hora]';

  @override
  String get smartPromptGenericQuestion =>
      '¿Qué acción específica abordará este elemento?';

  @override
  String get smartPromptGenericExample =>
      'ej., \'Definir acción específica con responsable, deadline, y criterios de éxito\'';

  @override
  String get smartPromptGenericPlaceholder =>
      '[Acción], responsable: [nombre], para: [fecha]';

  @override
  String get methodologyFocusAction =>
      'Orientado a la acción: se enfoca en cambios de comportamiento concretos';

  @override
  String get methodologyFocusEmotion =>
      'Enfocado en emociones: explora los sentimientos del equipo para construir seguridad psicológica';

  @override
  String get methodologyFocusLearning =>
      'Reflexivo sobre aprendizaje: enfatiza la captura y compartición del conocimiento';

  @override
  String get methodologyFocusRisk =>
      'Riesgo y Objetivo: equilibra facilitadores, bloqueantes, riesgos y objetivos';

  @override
  String get methodologyFocusCalibration =>
      'Calibración: usa gradaciones (más/menos) para ajustes matizados';

  @override
  String get methodologyFocusDecision =>
      'Decisional: impulsa decisiones claras del equipo sobre prácticas';

  @override
  String get exportSheetOverview => 'Resumen';

  @override
  String get exportSheetActionItems => 'Acciones';

  @override
  String get exportSheetBoardItems => 'Elementos del Board';

  @override
  String get exportSheetTeamHealth => 'Salud del Equipo';

  @override
  String get exportSheetLessonsLearned => 'Lecciones Aprendidas';

  @override
  String get exportSheetRiskRegister => 'Registro de Riesgos';

  @override
  String get exportSheetCalibrationMatrix => 'Matriz de Calibración';

  @override
  String get exportSheetDecisionLog => 'Registro de Decisiones';

  @override
  String get exportHeaderRetrospectiveReport => 'INFORME RETROSPECTIVA';

  @override
  String get exportHeaderTitle => 'Título:';

  @override
  String get exportHeaderDate => 'Fecha:';

  @override
  String get exportHeaderTemplate => 'Plantilla:';

  @override
  String get exportHeaderMethodology => 'Enfoque Metodológico:';

  @override
  String get exportHeaderSentiments => 'Sentimientos (Prom.):';

  @override
  String get exportHeaderParticipants => 'PARTICIPANTES';

  @override
  String get exportHeaderSummary => 'RESUMEN';

  @override
  String get exportHeaderTotalItems => 'Total Elementos:';

  @override
  String get exportHeaderActionItems => 'Acciones:';

  @override
  String get exportHeaderSuggestedFollowUp => 'Seguimiento Sugerido:';

  @override
  String get exportTeamHealthTitle => 'ANÁLISIS SALUD DEL EQUIPO';

  @override
  String get exportTeamHealthEmotionalDistribution => 'Distribución Emocional';

  @override
  String get exportTeamHealthMadCount => 'Elementos Mad:';

  @override
  String get exportTeamHealthSadCount => 'Elementos Sad:';

  @override
  String get exportTeamHealthGladCount => 'Elementos Glad:';

  @override
  String get exportTeamHealthMadItems => 'FRUSTRACIONES (Mad)';

  @override
  String get exportTeamHealthSadItems => 'DECEPCIONES (Sad)';

  @override
  String get exportTeamHealthGladItems => 'CELEBRACIONES (Glad)';

  @override
  String get exportTeamHealthRecommendation => 'Recomendación Salud Equipo:';

  @override
  String get exportTeamHealthHighFrustration =>
      'Alto nivel de frustración detectado. Considera facilitar una sesión enfocada en resolución de problemas.';

  @override
  String get exportTeamHealthBalanced =>
      'Estado emocional equilibrado. El equipo muestra capacidades de reflexión saludables.';

  @override
  String get exportTeamHealthPositive =>
      'Moral del equipo positivo. Aprovecha esta energía para mejoras desafiantes.';

  @override
  String get exportLessonsLearnedTitle => 'REGISTRO DE LECCIONES APRENDIDAS';

  @override
  String get exportLessonsLearnedWhatWorked => 'LO QUE FUNCIONÓ (Liked)';

  @override
  String get exportLessonsLearnedNewSkills =>
      'NUEVAS HABILIDADES E INSIGHTS (Learned)';

  @override
  String get exportLessonsLearnedGaps =>
      'BRECHAS Y ELEMENTOS FALTANTES (Lacked)';

  @override
  String get exportLessonsLearnedWishes => 'ASPIRACIONES FUTURAS (Longed For)';

  @override
  String get exportLessonsLearnedKnowledgeActions =>
      'Acciones de Compartir Conocimiento';

  @override
  String get exportLessonsLearnedDocumentationNeeded =>
      'Documentación Necesaria:';

  @override
  String get exportLessonsLearnedTrainingNeeded =>
      'Capacitación/Compartir Necesario:';

  @override
  String get exportRiskRegisterTitle => 'REGISTRO DE RIESGOS Y FACILITADORES';

  @override
  String get exportRiskRegisterEnablers => 'FACILITADORES (Viento)';

  @override
  String get exportRiskRegisterBlockers => 'BLOQUEANTES (Ancla)';

  @override
  String get exportRiskRegisterRisks => 'RIESGOS (Rocas)';

  @override
  String get exportRiskRegisterGoals => 'OBJETIVOS (Isla)';

  @override
  String get exportRiskRegisterRiskItem => 'Riesgo';

  @override
  String get exportRiskRegisterImpact => 'Impacto Potencial';

  @override
  String get exportRiskRegisterMitigation => 'Acción de Mitigación';

  @override
  String get exportRiskRegisterStatus => 'Estado';

  @override
  String get exportRiskRegisterGoalAlignment =>
      'Verificación Alineación Objetivos:';

  @override
  String get exportRiskRegisterGoalAlignmentNote =>
      'Verificar si las acciones actuales están alineadas con los objetivos declarados.';

  @override
  String get exportCalibrationTitle => 'MATRIZ DE CALIBRACIÓN';

  @override
  String get exportCalibrationKeepDoing => 'SEGUIR HACIENDO';

  @override
  String get exportCalibrationDoMore => 'HACER MÁS';

  @override
  String get exportCalibrationDoLess => 'HACER MENOS';

  @override
  String get exportCalibrationStopDoing => 'DEJAR DE HACER';

  @override
  String get exportCalibrationStartDoing => 'EMPEZAR A HACER';

  @override
  String get exportCalibrationPractice => 'Práctica';

  @override
  String get exportCalibrationCurrentState => 'Estado Actual';

  @override
  String get exportCalibrationTargetState => 'Estado Objetivo';

  @override
  String get exportCalibrationAdjustment => 'Ajuste';

  @override
  String get exportCalibrationNote =>
      'La calibración se enfoca en afinar las prácticas existentes en lugar de cambios radicales.';

  @override
  String get exportDecisionLogTitle => 'REGISTRO DE DECISIONES';

  @override
  String get exportDecisionLogDrop => 'DECISIONES A ABANDONAR';

  @override
  String get exportDecisionLogAdd => 'DECISIONES A AGREGAR';

  @override
  String get exportDecisionLogKeep => 'DECISIONES A MANTENER';

  @override
  String get exportDecisionLogImprove => 'DECISIONES A MEJORAR';

  @override
  String get exportDecisionLogDecision => 'Decisión';

  @override
  String get exportDecisionLogRationale => 'Justificación';

  @override
  String get exportDecisionLogOwner => 'Responsable';

  @override
  String get exportDecisionLogDeadline => 'Fecha Límite';

  @override
  String get exportDecisionLogPrioritizationNote => 'Recomendación Prioridad:';

  @override
  String get exportDecisionLogPrioritizationHint =>
      'Enfocarse primero en decisiones DROP para liberar capacidad, luego agregar nuevas prácticas.';

  @override
  String get exportNoItems => 'Sin elementos registrados';

  @override
  String get exportNoActionItems => 'Sin acciones';

  @override
  String get exportNotApplicable => 'N/A';

  @override
  String get facilitatorGuideTitle => 'Guía de Recolección de Acciones';

  @override
  String get facilitatorGuideCoverage => 'Cobertura';

  @override
  String get facilitatorGuideComplete => 'Completa';

  @override
  String get facilitatorGuideIncomplete => 'Incompleta';

  @override
  String get facilitatorGuideSuggestedOrder => 'Orden Sugerido:';

  @override
  String get facilitatorGuideMissingRequired => 'Faltan acciones requeridas';

  @override
  String get facilitatorGuideColumnHasAction => 'Tiene acción';

  @override
  String get facilitatorGuideColumnNoAction => 'Sin acción';

  @override
  String get facilitatorGuideRequired => 'Requerido';

  @override
  String get facilitatorGuideOptional => 'Opcional';
}
