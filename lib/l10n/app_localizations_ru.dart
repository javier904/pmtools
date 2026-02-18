// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get smartTodoListOrigin => 'List origin';

  @override
  String get smartTodoSortTooltip => 'Sort Options';

  @override
  String get smartTodoSortManual => 'Manual';

  @override
  String get smartTodoSortDate => 'Recent';

  @override
  String get smartTodoActionSortPriority => 'Reorder by Priority';

  @override
  String get smartTodoActionSortDeadline => 'Reorder by Deadline';

  @override
  String get smartTodoOrderUpdated => 'Order updated manually';

  @override
  String get newRetro => 'Новая ретроспектива';

  @override
  String get appTitle => 'Agile Tools';

  @override
  String get goToHome => 'На главную';

  @override
  String get actionSave => 'Сохранить';

  @override
  String get actionCancel => 'Отмена';

  @override
  String get actionDelete => 'Удалить';

  @override
  String get actionEdit => 'Редактировать';

  @override
  String get actionCreate => 'Создать';

  @override
  String get actionAdd => 'Добавить';

  @override
  String get actionClose => 'Закрыть';

  @override
  String get agileSprint => 'Спринт';

  @override
  String get agileStatus => 'Статус';

  @override
  String get agilePermissionErrorBacklog =>
      'Доступ запрещен: только PO или Scrum Master могут перемещать в бэклог';

  @override
  String get actionHide => 'Скрыть карточки';

  @override
  String get actionRetry => 'Повторить';

  @override
  String get exportAllData => 'Экспортировать все данные (полный отчет)';

  @override
  String get actionConfirm => 'Подтвердить';

  @override
  String get actionSearch => 'Поиск';

  @override
  String get actionFilter => 'Фильтр';

  @override
  String get actionExport => 'Экспорт';

  @override
  String get actionExportCsv => 'Экспорт в CSV';

  @override
  String get retroBoard => 'Элементы доски';

  @override
  String get actionCopy => 'Копировать';

  @override
  String get actionShare => 'Поделиться';

  @override
  String get actionDone => 'Готово';

  @override
  String get actionReset => 'Сбросить';

  @override
  String get actionOpen => 'Открыть';

  @override
  String get stateLoading => 'Загрузка...';

  @override
  String get stateEmpty => 'Нет элементов';

  @override
  String get stateError => 'Ошибка';

  @override
  String get stateSuccess => 'Успешно';

  @override
  String get subscriptionCurrent => 'ТЕКУЩИЙ';

  @override
  String get subscriptionRecommended => 'RECOMMENDED';

  @override
  String get subscriptionFree => 'Бесплатно';

  @override
  String get subscriptionPerMonth => '/мес';

  @override
  String get subscriptionPerYear => '/год';

  @override
  String subscriptionSaveYearly(String amount) {
    return 'Экономия: €$amount/год';
  }

  @override
  String subscriptionTrialDays(int days) {
    return '$days дн. бесплатно';
  }

  @override
  String get subscriptionUnlimitedProjects => 'Безлимитные проекты';

  @override
  String subscriptionProjectsActive(int count) {
    return '$count активных проектов';
  }

  @override
  String get subscriptionUnlimitedLists => 'Безлимитные списки';

  @override
  String subscriptionSmartTodoLists(int count) {
    return 'Списки Smart Todo';
  }

  @override
  String get subscriptionActiveProjectsLabel => 'Активные проекты';

  @override
  String get subscriptionSmartTodoListsLabel => 'Списки Smart Todo';

  @override
  String get subscriptionUnlimitedTasks => 'Безлимитные задачи';

  @override
  String subscriptionTasksPerProject(int count) {
    return '$count задач на проект';
  }

  @override
  String get subscriptionUnlimitedInvites => 'Безлимитные приглашения';

  @override
  String subscriptionInvitesPerProject(int count) {
    return 'Приглашений на проект: $count';
  }

  @override
  String get subscriptionWithAds => 'С рекламой';

  @override
  String get subscriptionWithoutAds => 'Без рекламы';

  @override
  String get authSignInGoogle => 'Войти через Google';

  @override
  String get authSignOut => 'Выйти';

  @override
  String get authLogoutConfirm => 'Вы уверены, что хотите выйти из аккаунта?';

  @override
  String get formNameRequired => 'Введите ваше имя';

  @override
  String get authError => 'Ошибка аутентификации';

  @override
  String get authUserNotFound => 'Пользователь не найден';

  @override
  String get authWrongPassword => 'Неверный пароль';

  @override
  String get authEmailInUse => 'Email уже используется';

  @override
  String get authWeakPassword => 'Слишком слабый пароль';

  @override
  String get authInvalidEmail => 'Некорректный email';

  @override
  String get appSubtitle => 'Keisen for Teams';

  @override
  String get authOr => 'или';

  @override
  String get authPassword => 'Пароль';

  @override
  String get authRegister => 'Регистрация';

  @override
  String get authLogin => 'Войти';

  @override
  String get authHaveAccount => 'Уже есть аккаунт?';

  @override
  String get authNoAccount => 'Нет аккаунта?';

  @override
  String get authForgotPassword => 'Забыли пароль?';

  @override
  String get authResetPasswordSent =>
      'Инструкции по сбросу пароля отправлены на почту. Проверьте ваш почтовый ящик.';

  @override
  String get authVerifyEmail => 'Подтвердите Email';

  @override
  String authVerifyEmailDesc(String email) {
    return 'Мы отправили письмо с подтверждением на адрес $email. Перейдите по ссылке для активации аккаунта.';
  }

  @override
  String get authResendVerification => 'Переотправить письмо с подтверждением';

  @override
  String get authVerificationSent => 'Письмо с подтверждением отправлено!';

  @override
  String get authEmailVerified => 'Email подтвержден!';

  @override
  String get authIVerified => 'Я подтвердил свой email';

  @override
  String get authWaitingVerification => 'Ожидание подтверждения...';

  @override
  String get authChangePassword => 'Сменить пароль';

  @override
  String get authCurrentPassword => 'Текущий пароль';

  @override
  String get authNewPassword => 'Новый пароль';

  @override
  String get authConfirmNewPassword => 'Подтвердите новый пароль';

  @override
  String get authPasswordChanged => 'Пароль успешно изменен';

  @override
  String get authPasswordMismatch => 'Пароли не совпадают';

  @override
  String get authPasswordTooShort => 'Минимум 6 символов';

  @override
  String get authReauthRequired => 'Подтвердите вашу личность';

  @override
  String get authReauthDesc =>
      'В целях безопасности подтвердите свою личность, чтобы продолжить.';

  @override
  String get authSignInWithEmail => 'Войти через Email';

  @override
  String get authWrongCurrentPassword => 'Текущий пароль неверен';

  @override
  String get profileSecurity => 'Безопасность';

  @override
  String authCooldownWait(int seconds) {
    return 'Подождите $seconds сек. перед повторной отправкой';
  }

  @override
  String get navHome => 'Главная';

  @override
  String get navProfile => 'Профиль';

  @override
  String get navSettings => 'Настройки';

  @override
  String get eisenhowerTitle => 'Eisenhower Matrix';

  @override
  String get eisenhowerYourMatrices => 'Ваши матрицы';

  @override
  String get eisenhowerNoMatrices => 'Матрицы не созданы';

  @override
  String get eisenhowerNewMatrix => 'Новая матрица';

  @override
  String get eisenhowerViewGrid => 'Сетка';

  @override
  String get eisenhowerViewChart => 'График';

  @override
  String get eisenhowerViewList => 'Список';

  @override
  String get eisenhowerViewRaci => 'RACI';

  @override
  String get quadrantUrgent => 'СРОЧНО';

  @override
  String get quadrantNotUrgent => 'НЕ СРОЧНО';

  @override
  String get quadrantImportant => 'ВАЖНО';

  @override
  String get quadrantNotImportant => 'НЕ ВАЖНО';

  @override
  String get quadrantQ1Title => 'СДЕЛАТЬ СЕЙЧАС';

  @override
  String get quadrantQ2Title => 'ЗАПЛАНИРОВАТЬ';

  @override
  String get quadrantQ3Title => 'ДЕЛЕГИРОВАТЬ';

  @override
  String get quadrantQ4Title => 'ИСКЛЮЧИТЬ';

  @override
  String get quadrantQ1Subtitle => 'Срочно и Важно';

  @override
  String get quadrantQ2Subtitle => 'Важно, Не Срочно';

  @override
  String get quadrantQ3Subtitle => 'Срочно, Не Важно';

  @override
  String get quadrantQ4Subtitle => 'Не Срочно, Не Важно';

  @override
  String get eisenhowerNoActivities => 'Нет задач';

  @override
  String get eisenhowerNewActivity => 'Новая задача';

  @override
  String get eisenhowerExportSheets => 'Экспорт в Google Таблицы';

  @override
  String get eisenhowerInviteParticipants => 'Пригласить участников';

  @override
  String get eisenhowerDeleteMatrix => 'Удалить матрицу';

  @override
  String get eisenhowerDeleteMatrixConfirm =>
      'Вы уверены, что хотите удалить эту матрицу?';

  @override
  String get eisenhowerActivityTitle => 'Название задачи';

  @override
  String get eisenhowerActivityNotes => 'Заметки';

  @override
  String get eisenhowerDueDate => 'Срок исполнения';

  @override
  String get eisenhowerPriority => 'Приоритет';

  @override
  String get eisenhowerAssignee => 'Исполнитель';

  @override
  String get eisenhowerCompleted => 'Завершено';

  @override
  String get eisenhowerMoveToQuadrant => 'Переместить в квадрант';

  @override
  String get eisenhowerMatrixSettings => 'Настройки матрицы';

  @override
  String get eisenhowerBackToList => 'К списку';

  @override
  String get eisenhowerPriorityList => 'Список приоритетов';

  @override
  String get eisenhowerAllActivities => 'Все задачи';

  @override
  String get eisenhowerToVote => 'Голосовать';

  @override
  String get eisenhowerVoted => 'Проголосовано';

  @override
  String get eisenhowerTotal => 'Всего';

  @override
  String get eisenhowerEditParticipants => 'Редактировать участников';

  @override
  String eisenhowerActivityCountLabel(int count) {
    return '$count задач';
  }

  @override
  String eisenhowerVoteCountLabel(int count) {
    return '$count голосов';
  }

  @override
  String get eisenhowerModifyVotes => 'Изменить голоса';

  @override
  String get eisenhowerVote => 'Голосовать';

  @override
  String get eisenhowerQuadrant => 'Квадрант';

  @override
  String get eisenhowerUrgencyAvg => 'Средняя срочность';

  @override
  String get eisenhowerImportanceAvg => 'Средняя важность';

  @override
  String get eisenhowerVotesLabel => 'Голоса:';

  @override
  String get eisenhowerNoVotesYet => 'Голоса еще не собраны';

  @override
  String get eisenhowerEditMatrix => 'Редактировать матрицу';

  @override
  String get eisenhowerAddActivity => 'Добавить задачу';

  @override
  String get eisenhowerDeleteActivity => 'Удалить задачу';

  @override
  String eisenhowerDeleteActivityConfirm(String title) {
    return 'Вы уверены, что хотите удалить \"$title\"?';
  }

  @override
  String get eisenhowerMatrixCreated => 'Матрица успешно создана';

  @override
  String get eisenhowerMatrixUpdated => 'Матрица обновлена';

  @override
  String get eisenhowerMatrixDeleted => 'Матрица удалена';

  @override
  String get eisenhowerActivityAdded => 'Задача добавлена';

  @override
  String get eisenhowerActivityDeleted => 'Задача удалена';

  @override
  String get eisenhowerVotesSaved => 'Голоса сохранены';

  @override
  String get eisenhowerExportCompleted => 'Export completed!';

  @override
  String get eisenhowerExportAll => 'Экспортировать все данные';

  @override
  String get eisenhowerExportCompletedDialog => 'Экспорт завершен';

  @override
  String get eisenhowerExportDialogContent =>
      'Google Таблица создана. Хотите открыть ее в браузере?';

  @override
  String get eisenhowerOpen => 'Открыть';

  @override
  String get eisenhowerAddParticipantsFirst =>
      'Сначала добавьте участников в матрицу';

  @override
  String get eisenhowerSearchLabel => 'Поиск:';

  @override
  String get eisenhowerSearchHint => 'Поиск матриц...';

  @override
  String get eisenhowerNoMatrixFound => 'Матрица не найдена';

  @override
  String get eisenhowerCreateFirstMatrix =>
      'Создайте свою первую матрицу Эйзенхауэра,\nчтобы организовать свои приоритеты';

  @override
  String get eisenhowerCreateMatrix => 'Создать матрицу';

  @override
  String get eisenhowerClickToOpen =>
      'Матрица Эйзенхауэра\nНажмите, чтобы открыть';

  @override
  String get eisenhowerTotalActivities => 'Всего задач в матрице';

  @override
  String get eisenhowerVotedActivities => 'Оцененные задачи';

  @override
  String get eisenhowerPendingVoting => 'Задачи для голосования';

  @override
  String get eisenhowerStartVoting => 'Начать независимое голосование';

  @override
  String eisenhowerStartVotingDesc(String title) {
    return 'Do you want to start an independent voting session for \"$title\"?\n\nEach participant will vote without seeing others\' votes, until everyone has voted and votes are revealed.';
  }

  @override
  String get eisenhowerStart => 'Start';

  @override
  String get eisenhowerVotingStarted => 'Voting started';

  @override
  String get eisenhowerResetVoting => 'Reset Voting?';

  @override
  String get eisenhowerResetVotingDesc => 'All votes will be deleted.';

  @override
  String get eisenhowerVotingReset => 'Voting reset';

  @override
  String get eisenhowerMinVotersRequired =>
      'At least 2 voters required for independent voting';

  @override
  String eisenhowerDeleteMatrixWithActivities(int count) {
    return 'Also all $count activities will be deleted.';
  }

  @override
  String eisenhowerYourMatricesCount(int filtered, int total) {
    return 'Ваши матрицы ($filtered/$total)';
  }

  @override
  String get formTitleRequired => 'Enter a title';

  @override
  String get formTitleHint => 'E.g.: Q1 2025 Priorities';

  @override
  String get formDescriptionHint => 'Optional description';

  @override
  String get formParticipantHint => 'Participant name';

  @override
  String get formAddParticipantHint => 'Add at least one participant to vote';

  @override
  String get formActivityTitleHint => 'E.g.: Complete API documentation';

  @override
  String get errorCreatingMatrix => 'Error creating matrix';

  @override
  String get errorUpdatingMatrix => 'Error updating';

  @override
  String get errorDeletingMatrix => 'Error deleting';

  @override
  String get errorAddingActivity => 'Ошибка при добавлении задачи';

  @override
  String get errorSavingVotes => 'Error saving votes';

  @override
  String get errorExport => 'Error during export';

  @override
  String get errorStartingVoting => 'Error starting voting';

  @override
  String get errorResetVoting => 'Error resetting';

  @override
  String get errorLoadingActivities => 'Error loading activities';

  @override
  String get eisenhowerWaitingForVotes => 'Ожидание голосов';

  @override
  String eisenhowerVotedParticipants(int ready, int total) {
    return '$ready/$total голосов';
  }

  @override
  String get eisenhowerVoteSubmit => 'Голосовать';

  @override
  String get eisenhowerVotedSuccess => 'Голос успешно отправлен!';

  @override
  String get eisenhowerRevealVotes => 'РАСКРЫТЬ ГОЛОСА';

  @override
  String get eisenhowerQuickVote => 'Быстрое голосование';

  @override
  String get eisenhowerTeamVote => 'Командное голосование';

  @override
  String get eisenhowerUrgency => 'СРОЧНОСТЬ';

  @override
  String get eisenhowerImportance => 'ВАЖНОСТЬ';

  @override
  String get eisenhowerUrgencyShort => 'С:';

  @override
  String get eisenhowerImportanceShort => 'В:';

  @override
  String get eisenhowerVoting => 'Голосование';

  @override
  String get eisenhowerVotingInProgress => 'ИДЕТ ГОЛОСОВАНИЕ';

  @override
  String get eisenhowerWaitingForOthers =>
      'Ожидание завершения голосования всеми участниками. Фасилитатор раскроет голоса.';

  @override
  String get eisenhowerReady => 'Готов';

  @override
  String get eisenhowerWaiting => 'Ожидание';

  @override
  String get eisenhowerIndividualVotes => 'ИНДИВИДУАЛЬНЫЕ ГОЛОСА';

  @override
  String get eisenhowerResult => 'РЕЗУЛЬТАТ';

  @override
  String get eisenhowerAverage => 'СРЕДНЕЕ';

  @override
  String get eisenhowerVotesRevealed => 'Голоса открыты';

  @override
  String get eisenhowerNextActivity => 'Следующая задача';

  @override
  String get eisenhowerNoVotesRecorded => 'Голоса не зафиксированы';

  @override
  String get eisenhowerWaitingForStart => 'Ожидание';

  @override
  String get eisenhowerPreVotesTooltip =>
      'Предварительные голоса, которые будут учтены, когда фасилитатор начнет голосование';

  @override
  String get eisenhowerObserverWaiting =>
      'Ожидание начала коллективного голосования фасилитатором';

  @override
  String get eisenhowerPreVoteTooltip =>
      'Проголосуйте заранее. Ваш голос будет учтен при начале голосования.';

  @override
  String get eisenhowerPreVote => 'Предварительный голос';

  @override
  String get eisenhowerPreVoted => 'Проголосовал заранее';

  @override
  String get eisenhowerStartVotingTooltip =>
      'Начать сессию коллективного голосования. Существующие предварительные голоса будут сохранены.';

  @override
  String get eisenhowerResetVotingTooltip =>
      'Сбросить голосование, удалив все голоса';

  @override
  String get eisenhowerObserverWaitingVotes =>
      'Наблюдение за сессией голосования...';

  @override
  String get eisenhowerWaitingForAllVotes =>
      'Ожидание голосования всех участников';

  @override
  String get eisenhowerRevealTooltipReady =>
      'Все проголосовали! Нажмите, чтобы раскрыть результаты.';

  @override
  String eisenhowerRevealTooltipNotReady(int count) {
    return 'Не хватает $count голосов';
  }

  @override
  String get eisenhowerVotingLocked => 'Голосование закрыто';

  @override
  String get eisenhowerVotingLockedTooltip =>
      'Голоса были раскрыты. Голосование для этой задачи больше невозможно.';

  @override
  String eisenhowerOnlineParticipants(int online, int total) {
    return '$online из $total участников онлайн';
  }

  @override
  String get eisenhowerAllActivitiesVoted => 'Все задачи были оценены!';

  @override
  String get eisenhowerAlreadyVotedError =>
      'Эта задача уже оценена. Фасилитатор должен переоткрыть голосование, чтобы изменить его.';

  @override
  String eisenhowerYourVote(Object urgency, Object importance) {
    return 'Ваш голос: С=$urgency, В=$importance';
  }

  @override
  String eisenhowerVoterName(Object name) {
    return 'Голос: $name';
  }

  @override
  String get eisenhowerUrgencyLow => 'Не срочно';

  @override
  String get eisenhowerUrgencyHigh => 'Очень срочно';

  @override
  String get eisenhowerImportanceLow => 'Не важно';

  @override
  String get eisenhowerImportanceHigh => 'Очень важно';

  @override
  String eisenhowerQuadrantLabel(Object name) {
    return 'Квадрант: $name';
  }

  @override
  String get eisenhowerQ1Name => 'Q1 — СДЕЛАТЬ СЕЙЧАС';

  @override
  String get eisenhowerQ1Desc => 'Срочно + Важно';

  @override
  String get eisenhowerQ2Name => 'Q2 — ЗАПЛАНИРОВАТЬ';

  @override
  String get eisenhowerQ2Desc => 'Не срочно + Важно';

  @override
  String get eisenhowerQ3Name => 'Q3 — ДЕЛЕГИРОВАТЬ';

  @override
  String get eisenhowerQ3Desc => 'Срочно + Не важно';

  @override
  String get eisenhowerQ4Name => 'Q4 — ИСКЛЮЧИТЬ';

  @override
  String get eisenhowerQ4Desc => 'Не срочно + Не важно';

  @override
  String eisenhowerPreVotes(Object count) {
    return '$count предв. голосов';
  }

  @override
  String get eisenhowerVotesVisibleAfterReveal =>
      'Голоса будут видны, когда фасилитатор нажмет «Раскрыть голоса»';

  @override
  String eisenhowerNextActivityError(Object error) {
    return 'Ошибка при начале следующего голосования: $error';
  }

  @override
  String get eisenhowerReopenVotes => 'Переоткрыть голосование';

  @override
  String get eisenhowerReopenVotesTooltip =>
      'Перезапустить официальное голосование, начиная с текущих оценок';

  @override
  String get eisenhowerReopenVotesConfirm => 'Переоткрыть все голоса?';

  @override
  String get eisenhowerReopenVotesDesc =>
      'Это перезапустит сессию официального голосования для всех задач, сохраняя текущие оценки в качестве отправных точек. Вы хотите продолжить?';

  @override
  String get estimationTitle => 'Оценка задач';

  @override
  String get estimationYourSessions => 'Ваши сессии';

  @override
  String get estimationNoSessions => 'Сессии не созданы';

  @override
  String get estimationNewSession => 'Новая сессия';

  @override
  String get estimationEditSession => 'Редактировать сессию';

  @override
  String get estimationJoinSession => 'Присоединиться к сессии';

  @override
  String get estimationSessionCode => 'Код сессии';

  @override
  String get estimationEnterCode => 'Введите код';

  @override
  String get sessionStatusDraft => 'Черновик';

  @override
  String get sessionStatusActive => 'Активна';

  @override
  String get sessionStatusCompleted => 'Завершена';

  @override
  String get sessionName => 'Название сессии';

  @override
  String get sessionNameRequired => 'Название сессии *';

  @override
  String get sessionNameHint =>
      'Пример: Спринт 15 — Оценка пользовательских историй';

  @override
  String get sessionDescription => 'Описание';

  @override
  String get sessionCardSet => 'Набор карт';

  @override
  String get cardSetFibonacci =>
      'Фибоначчи (0, 1, 2, 3, 5, 8, 13, 20, 40, 100, ?, ?)';

  @override
  String get cardSetSimplified => 'Упрощенный (1, 2, 3, 5, 8, 13, ?, ?)';

  @override
  String get sessionEstimationMode => 'Режим оценки';

  @override
  String get sessionEstimationModeLocked =>
      'Невозможно изменить режим после начала голосования';

  @override
  String get sessionAutoReveal => 'Авто-раскрытие';

  @override
  String get sessionAutoRevealDesc => 'Раскрыть, когда все проголосуют';

  @override
  String get sessionAllowObservers => 'Наблюдатели';

  @override
  String get sessionAllowObserversDesc => 'Разрешить участие без голосования';

  @override
  String get sessionConfiguration => 'Конфигурация';

  @override
  String get voteConsensus => 'Консенсус достигнут!';

  @override
  String get voteResults => 'Результаты голосования';

  @override
  String get voteRevote => 'Переголосовать';

  @override
  String get voteReveal => 'Раскрыть';

  @override
  String get voteHide => 'Скрыть';

  @override
  String get voteAverage => 'Среднее';

  @override
  String get voteMedian => 'Медиана';

  @override
  String get voteMode => 'Мода';

  @override
  String get voteVoters => 'Участники';

  @override
  String get voteDistribution => 'Распределение голосов';

  @override
  String get voteFinalEstimate => 'Итоговая оценка';

  @override
  String get voteSelectFinal => 'Выберите итоговую оценку';

  @override
  String get voteAverageTooltip => 'Арифметическое среднее числовых голосов';

  @override
  String get voteMedianTooltip => 'Среднее значение при сортировке голосов';

  @override
  String get voteModeTooltip =>
      'Наиболее часто встречающийся голос (значение, выбранное чаще всего)';

  @override
  String get voteVotersTooltip =>
      'Общее количество участников, принявших участие в голосовании';

  @override
  String get voteWaiting => 'Ожидание голосов...';

  @override
  String get voteSubmitted => 'Голос отправлен';

  @override
  String get voteNotSubmitted => 'Не голосовал';

  @override
  String get storyToEstimate => 'Задача для оценки';

  @override
  String get storyTitle => 'Заголовок задачи';

  @override
  String get storyDescription => 'Описание задачи';

  @override
  String get storyAddNew => 'Добавить задачу';

  @override
  String get storyNoStories => 'Нет задач для оценки';

  @override
  String get retrospectivesVoted => 'Проголосовали';

  @override
  String get storyComplete => 'Задача выполнена';

  @override
  String get storySkip => 'Пропустить задачу';

  @override
  String get estimationModeFibonacci => 'Фибоначчи';

  @override
  String get estimationModeTshirt => 'Размеры футболок (S, M, L...)';

  @override
  String get estimationModeDecimal => 'Десятичные (в днях)';

  @override
  String get estimationModeThreePoint => 'Тройная оценка (PERT)';

  @override
  String get estimationModeDotVoting => 'Точечное голосование';

  @override
  String get estimationModeBucketSystem => 'Система «корзин»';

  @override
  String get estimationModeFiveFingers => 'Пять пальцев';

  @override
  String get estimationVotesRevealed => 'Голоса раскрыты';

  @override
  String get estimationVotingInProgress => 'Идет голосование';

  @override
  String estimationVotesCountFormatted(int count, int total) {
    return '$count/$total голосов';
  }

  @override
  String get estimationConsensusReached => 'Консенсус достигнут!';

  @override
  String get estimationVotingResults => 'Результаты голосования';

  @override
  String get estimationRevote => 'Переголосовать';

  @override
  String get estimationAverage => 'Среднее';

  @override
  String get estimationAverageTooltip =>
      'Среднее арифметическое числовых голосов';

  @override
  String get estimationMedian => 'Медиана';

  @override
  String get estimationMedianTooltip =>
      'Среднее значение при сортировке голосов';

  @override
  String get estimationMode => 'Мода';

  @override
  String get estimationModeTooltip => 'Наиболее часто встречающийся голос';

  @override
  String get estimationVoters => 'Участники';

  @override
  String get estimationVotersTooltip => 'Общее количество участников';

  @override
  String get estimationVoteDistribution => 'Распределение голосов';

  @override
  String get estimationSelectFinalEstimate => 'Выберите итоговую оценку';

  @override
  String get estimationFinalEstimate => 'Итоговая оценка';

  @override
  String get eisenhowerChartTitle => 'Распределение задач';

  @override
  String get quadrantLabelDo => 'Q1 — СДЕЛАТЬ';

  @override
  String get quadrantLabelPlan => 'Q2 — ПЛАН';

  @override
  String get quadrantLabelDelegate => 'Q3 — ДЕЛЕГИРОВАТЬ';

  @override
  String get quadrantLabelEliminate => 'Q4 — ИСКЛЮЧИТЬ';

  @override
  String get eisenhowerNoRatedActivities => 'Нет оцененных задач';

  @override
  String get eisenhowerVoteToSeeChart =>
      'Проголосуйте за задачи, чтобы увидеть их на графике';

  @override
  String get eisenhowerChartCardTitle => 'Диаграмма распределения';

  @override
  String get raciAddColumnTitle => 'Добавить колонку RACI';

  @override
  String get raciColumnType => 'Тип';

  @override
  String get raciTypePerson => 'Человек (Участник)';

  @override
  String get raciTypeCustom => 'Пользовательский (Команда/Другое)';

  @override
  String get raciSelectParticipant => 'Выберите участника';

  @override
  String get raciColumnName => 'Название колонки';

  @override
  String get raciColumnNameHint => 'Пример: Команда разработки';

  @override
  String get raciDeleteColumnTitle => 'Удалить колонку';

  @override
  String raciDeleteColumnConfirm(String name) {
    return 'Удалить колонку «$name»? Назначения будут потеряны.';
  }

  @override
  String estimationOnlineParticipants(int online, int total) {
    return '$online из $total участников онлайн';
  }

  @override
  String get estimationNewStoryTitle => 'Новая история';

  @override
  String get estimationStoryTitleLabel => 'Заголовок *';

  @override
  String get estimationStoryTitleHint =>
      'Пример: US-123: Как пользователь, я хочу...';

  @override
  String get estimationStoryDescriptionLabel => 'Описание';

  @override
  String get estimationStoryDescriptionHint => 'Критерии приемки, заметки...';

  @override
  String get estimationEnterTitleAlert => 'Пожалуйста, введите заголовок';

  @override
  String get estimationParticipantsHeader => 'Участники';

  @override
  String get estimationRoleFacilitator => 'Фасилитатор';

  @override
  String get estimationRoleVoters => 'Голосующие';

  @override
  String get estimationRoleObservers => 'Наблюдатели';

  @override
  String get estimationYouSuffix => '(вы)';

  @override
  String get estimationDecimalTitle => 'Десятичная оценка';

  @override
  String get estimationDecimalHint =>
      'Введите вашу оценку в днях (например, 1.5, 2.25)';

  @override
  String get estimationQuickSelect => 'Быстрый выбор:';

  @override
  String get estimationDaysSuffix => 'дней';

  @override
  String estimationVoteValue(String value) {
    return 'Голос: $value дн.';
  }

  @override
  String get estimationEnterValueAlert => 'Введите значение';

  @override
  String get estimationInvalidValueAlert => 'Некорректное значение';

  @override
  String estimationMinAlert(double value) {
    return 'Мин: $value';
  }

  @override
  String estimationMaxAlert(double value) {
    return 'Макс: $value';
  }

  @override
  String get retroTitle => 'Мои ретроспективы';

  @override
  String get retroNoRetros => 'Нет ретроспектив';

  @override
  String get retroNoRetrosFound => 'Ретроспектива не найдена';

  @override
  String get retroCreateNew => 'Создать новую';

  @override
  String get retroContinueAction => 'Продолжить';

  @override
  String get retroCurrentPhase => 'Фаза';

  @override
  String get retroNoCompletedRetros => 'Нет завершенных ретроспектив';

  @override
  String get retroStandalone => 'Автономная';

  @override
  String get retroCompletedOn => 'Завершена';

  @override
  String get retroSummaryDetails => 'Детали';

  @override
  String get retroSummaryCompleted => 'Завершена';

  @override
  String get retroSummaryFacilitator => 'Фасилитатор';

  @override
  String get retroSummaryNotAvailable => 'Н/Д';

  @override
  String get retroSummarySprint => 'Спринт';

  @override
  String get retroSummaryFeedback => 'Обратная связь';

  @override
  String get retroSummaryNoCards => 'Нет карточек';

  @override
  String get retroChooseMode => 'Выберите режим ретроспективы';

  @override
  String get retroQuickForm => 'Быстрая форма';

  @override
  String get retroInteractiveBoard => 'Интерактивная доска';

  @override
  String get retroQuickModeDesc =>
      'Заполните быструю форму, чтобы зафиксировать основные моменты спринта.';

  @override
  String get retroInteractiveModeDesc =>
      'Запустите доску в реальном времени для совместной работы со всей командой.';

  @override
  String get retroNoOperationsReview => 'Нет обзора операций';

  @override
  String get retroOperationsReview => 'Обзор операций';

  @override
  String get retroOperationsReviewDesc =>
      'Создайте обзор операций для улучшения рабочего процесса';

  @override
  String get retroWentWell => 'Что прошло хорошо?';

  @override
  String get retroToImprove => 'Что нужно улучшить?';

  @override
  String get retroWentWellHint => 'Добавьте положительный момент...';

  @override
  String get retroToImproveHint => 'Добавьте то, что стоит улучшить...';

  @override
  String get retroActionItemHint => 'Добавьте пункт плана действий...';

  @override
  String get retroSave => 'Сохранить ретроспективу';

  @override
  String get agileEstimate => 'ОЦЕНКА';

  @override
  String get agileAssign => 'Назначить';

  @override
  String get agileCardMenuTooltip => 'Опции (приоритет, оценка и т. д.)';

  @override
  String get kanbanPolicyHelpTitle => 'Column Policies (Rules)';

  @override
  String get kanbanPolicyHelpIntro =>
      'Правила колонок — это явные установки, определяющие, когда карточка может войти в колонку или покинуть ее. Они обеспечивают качество и плавность потока.';

  @override
  String get kanbanPolicyRule1Title => '1. Requires Acceptance Criteria';

  @override
  String get kanbanPolicyRule1Desc =>
      'Карточка должна иметь хотя бы один определенный критерий приемки. Полезно для обеспечения ясности требований до начала разработки.';

  @override
  String get kanbanPolicyRule2Title => '2. Оценка завершена';

  @override
  String get kanbanPolicyRule2Desc =>
      'Карточка должна иметь оценку > 0. Важно для планирования и отслеживания скорости.';

  @override
  String get kanbanPolicyRule3Title => '3. Макс. 2 дня в колонке';

  @override
  String get kanbanPolicyRule3Desc =>
      'Помечает карточки, застрявшие в одном статусе более 48 часов. Помогает выявить узкие места или заблокированные задачи.';

  @override
  String get kanbanPolicyRule4Title => '4. Все критерии соблюдены';

  @override
  String get kanbanPolicyRule4Desc =>
      'Блокирует перемещение в «Готово», пока не отмечены все критерии приемки. Обеспечивает выполнение Definition of Done.';

  @override
  String get retroOpenInteractiveBoard => 'Открыть интерактивную доску';

  @override
  String get retroSentimentTeam => 'Настрой команды';

  @override
  String get retroExcellent => 'Отлично';

  @override
  String get retroGood => 'Хорошо';

  @override
  String get retroNormal => 'Нормально';

  @override
  String get retroNeedsImprovement => 'Оставляет желать лучшего';

  @override
  String get retroCritical => 'Критично';

  @override
  String get retroNoElements => 'Нет элементов';

  @override
  String get retroNoActionItemsFound => 'Пункты плана действий не найдены';

  @override
  String retroAssignedTo(String email) {
    return 'Назначено: $email';
  }

  @override
  String retroVotesCount(int count) {
    return '+$count голосов';
  }

  @override
  String get retroGuidance => 'Руководство по ретроспективе';

  @override
  String retroResultLabel(String score, String label) {
    return 'Средний настрой: $score ($label)';
  }

  @override
  String get retroSearchHint => 'Поиск ретроспективы...';

  @override
  String get agileProgressManual => 'Вручную';

  @override
  String get agileProgress => 'Прогресс';

  @override
  String get agileProgressAuto => 'Авто';

  @override
  String agileProgressTooltipManual(int percent) {
    return 'Установлено вручную: $percent%';
  }

  @override
  String agileProgressTooltipCriteria(int completed, int total) {
    return 'Выполнено критериев: $completed/$total';
  }

  @override
  String agileProgressTooltipStatus(String status) {
    return 'Оценено на основе статуса: $status';
  }

  @override
  String get agileProcessTitle => 'Менеджер процессов Agile';

  @override
  String get agileSearchProjects => 'Поиск проектов...';

  @override
  String get agileMethodologyGuide => 'Руководство по методологии';

  @override
  String get agileMethodologyGuideTitle => 'Руководство по Agile-методологиям';

  @override
  String get agileMethodologyGuideSubtitle =>
      'Выберите методологию, которая лучше всего подходит вашему проекту';

  @override
  String get agileNewProject => 'Новый проект';

  @override
  String get agileRoles => 'РОЛИ';

  @override
  String get agileProcessFlow => 'ПОТОК ПРОЦЕССА';

  @override
  String get agileArtifacts => 'АРТЕФАКТЫ';

  @override
  String get agileBestPractices => 'Лучшие практики';

  @override
  String get agileAntiPatterns => 'Антипаттерны (чего избегать)';

  @override
  String get agileFAQ => 'Часто задаваемые вопросы';

  @override
  String get agileScrumShortDesc =>
      'Спринты фиксированной длительности, Velocity, Burndown. Идеально для продуктов с меняющимися требованиями.';

  @override
  String get agileKanbanShortDesc =>
      'Непрерывный поток, лимиты WIP, Lead Time. Идеально для техподдержки и непрерывных запросов.';

  @override
  String get agileScrumbanShortDesc =>
      'Смесь спринтов и непрерывного потока. Идеально для команд, которым нужна гибкость.';

  @override
  String get agileRolePODesc => 'Управляет бэклогом и приоритетами';

  @override
  String get agileRoleSMDesc => 'Фасилитирует процесс и устраняет препятствия';

  @override
  String get agileRoleDevTeamDesc => 'Участники, разрабатывающие продукт';

  @override
  String get agileRoleStakeholdersDesc =>
      'Предоставляют обратную связь и требования';

  @override
  String get agileRoleSRMDesc =>
      'Управляет входящими запросами и фасилитирует приоритизацию (заменяет PO)';

  @override
  String get agileRoleSDMDesc =>
      'Управляет потоком работ и фасилитирует поставку (заменяет SM)';

  @override
  String get agileRoleTeamDesc => 'Выполняет работу, соблюдая лимиты WIP';

  @override
  String get agileRoleFlowMasterDesc => 'Оптимизирует поток и фасилитирует';

  @override
  String get agileRoleTeamHybridDesc =>
      'Кросс-функциональная, самоорганизованная';

  @override
  String get scrumOverview =>
      'Scrum — это итеративный и инкрементальный Agile-фреймворк для управления разработкой продуктов.\nОн основан на рабочих циклах фиксированной длительности, называемых спринтами, обычно от 2 до 4 недель.';

  @override
  String get scrumRolesTitle => 'Роли в Scrum';

  @override
  String get scrumRolesContent =>
      'Scrum определяет три ключевые роли, которые взаимодействуют для успеха проекта.';

  @override
  String get scrumRolesPO =>
      'Product Owner: представляет стейкхолдеров, управляет бэклогом продукта и максимизирует его ценность';

  @override
  String get scrumRolesSM =>
      'Scrum Master: фасилитирует процесс Scrum, устраняет препятствия и помогает команде совершенствоваться';

  @override
  String get scrumRolesDev =>
      'Development Team: кросс-функциональная и самоорганизованная команда, поставляющая инкремент продукта';

  @override
  String get scrumEventsTitle => 'События Scrum';

  @override
  String get scrumEventsContent =>
      'Scrum предусматривает регулярные события для создания регулярности и минимизации случайных встреч.';

  @override
  String get scrumEventsPlanning =>
      'Планирование спринта (Sprint Planning): планирование работ (макс. 8ч для 4-х недельного спринта)';

  @override
  String get scrumEventsDaily =>
      'Daily Scrum: ежедневная синхронизация команды (15 минут)';

  @override
  String get scrumEventsRetro =>
      'Ретроспектива спринта (Sprint Retrospective): самоанализ команды для улучшения (макс. 3ч)';

  @override
  String get scrumEventsRetroContent =>
      'Создайте ретроспективу, чтобы проанализировать прошлый спринт и выявить области для улучшения.';

  @override
  String get scrumEventsReview =>
      'Обзор спринта (Sprint Review): демо выполненной работы стейкхолдерам (макс. 4ч)';

  @override
  String get scrumArtifactsTitle => 'Артефакты Scrum';

  @override
  String get scrumArtifactsContent =>
      'Артефакты представляют собой работу или ценность и предназначены для обеспечения прозрачности.';

  @override
  String get scrumArtifactsPB =>
      'Бэклог продукта (Product Backlog): упорядоченный список всего, что может потребоваться в продукте';

  @override
  String get scrumArtifactsSB =>
      'Бэклог спринта (Sprint Backlog): элементы, выбранные для спринта + план по доставке инкремента';

  @override
  String get scrumArtifactsIncrement =>
      'Инкремент: сумма всех элементов, завершенных в течение спринта, потенциально готовая к выпуску';

  @override
  String get scrumStoryPointsTitle => 'Story Points и скорость (Velocity)';

  @override
  String get scrumStoryPointsContent =>
      'Story Points — это относительная мера сложности пользовательской истории. Они измеряют не время, а усилия, сложность и неопределенность.\n\nПоследовательность Фибоначчи (1, 2, 3, 5, 8, 13, 21) обычно используется потому что:\n• Она отражает возрастающую неопределенность для крупных задач\n• Она затрудняет ложную точность\n• Она облегчает обсуждение при оценке\n\nVelocity (скорость) — это среднее количество Story Points, выполненных за последние спринты, и служит для:\n• Прогнозирования объема работ в будущих спринтах\n• Выявления тенденций продуктивности команды\n• Важно: не сравнивать разные команды (у каждой своя шкала)';

  @override
  String get scrumBP1 =>
      'Соблюдайте фиксированную длительность спринтов и таймбокс';

  @override
  String get scrumBP2 =>
      'Бэклог продукта должен быть всегда приоритизирован и уточнен';

  @override
  String get scrumBP3 => 'User Story должны соответствовать критериям INVEST';

  @override
  String get scrumBP4 =>
      'Definition of Done (Определение готовности) должно быть четким и общим';

  @override
  String get scrumBP5 => 'Не меняйте цель спринта в ходе спринта';

  @override
  String get scrumBP6 => 'Празднуйте успехи на обзоре спринта';

  @override
  String get scrumBP7 =>
      'Ретроспектива должна приводить к конкретным действиям по улучшению';

  @override
  String get scrumBP8 =>
      'Команда должна быть многофункциональной и самоорганизованной';

  @override
  String get scrumBP9 =>
      'Используйте управляемую фазу закрытия для обзора спринта перед финализацией';

  @override
  String get scrumBP10 =>
      'Не создавайте несколько спринтов на стадии планирования одновременно: завершите или удалите существующий перед созданием нового';

  @override
  String get scrumAP1 => 'Спринт без четкой цели';

  @override
  String get scrumAP2 => 'Daily Scrum превратился в отчетное собрание';

  @override
  String get scrumAP3 => 'Пропуск ретроспективы из-за «занятости»';

  @override
  String get scrumAP4 => 'Product Owner отсутствует или недоступен';

  @override
  String get scrumAP5 => 'Добавление работы в спринт без удаления другой';

  @override
  String get scrumAP6 => 'Story Points переводятся в часы (теряется смысл)';

  @override
  String get scrumAP7 => 'Команда слишком велика (идеал — 5-9 человек)';

  @override
  String get scrumAP8 => 'Scrum Master, который «назначает» задачи команде';

  @override
  String get scrumAP9 =>
      'Закрытие спринта без обзора и решения по незавершенным задачам';

  @override
  String get scrumSprintClosingTitle => 'Управляемое закрытие спринта';

  @override
  String get scrumSprintClosingContent =>
      'Процесс закрытия спринта следует логике из 2 шагов согласно Scrum Guide 2020:\n\n1. **Обзор спринта (Sprint Review)**: качественная фаза. Стейкхолдеры инспектируют инкремент. Каждая история оценивается как «Утверждена» (Done) или «Требует уточнения» (возвращается в бэклог для будущей доработки).\n\n2. **Финализация спринта**: административная фаза. Команда решает судьбу незавершенной работы: вернуть в бэклог, переместить в статус «Готово к работе» или «На уточнение».';

  @override
  String get scrumFAQ1Q => 'Какова оптимальная длина спринта?';

  @override
  String get scrumFAQ1A =>
      'Типичная продолжительность — 2 недели, но может варьироваться от 1 до 4. Короткие спринты позволяют чаще получать обратную связь и быстрее корректировать курс. Длинные спринты дают больше времени на сложные задачи. Важно сохранять постоянную длительность.';

  @override
  String get scrumFAQ2Q =>
      'Что делать с незавершенной работой в конце спринта?';

  @override
  String get scrumFAQ2A =>
      'Незавершенные задачи возвращаются в бэклог продукта и приоритизируются заново. Никогда не продлевайте спринт и не упрощайте критерии готовности. Используйте ретроспективу, чтобы понять причины.';

  @override
  String get scrumFAQ3Q => 'Можно ли менять бэклог спринта в процессе?';

  @override
  String get scrumFAQ3A =>
      'Цель спринта меняться не должна, но бэклог спринта может эволюционировать. Команда может договориться с PO о замене элементов равной ценности. Если цель спринта становится неактуальной, PO может отменить спринт.';

  @override
  String get scrumFAQ4Q => 'Как рассчитать начальную скорость?';

  @override
  String get scrumFAQ4A =>
      'Для первых 3-х спринтов делайте консервативные оценки. После у вас появится надежная средняя скорость (Velocity). Не используйте скорость других команд как ориентир.';

  @override
  String get kanbanOverview =>
      'Канбан — это метод управления работой, в котором упор делается на визуализацию потока, ограничение незавершенной работы (WIP) и непрерывное улучшение процесса.\n\nКанбан идеален для:\n• Команд поддержки и сопровождения с непрерывным потоком запросов\n• Условий, где приоритеты часто меняются\n• Ситуаций, когда невозможно планировать фиксированные итерации\n• Постепенного перехода на Agile';

  @override
  String get kanbanPrinciplesTitle => 'Принципы Канбана';

  @override
  String get kanbanPrinciplesContent =>
      'Канбан основан на принципах инкрементальных изменений и уважения к существующим ролям.';

  @override
  String get kanbanPrinciple1 =>
      'Визуализируйте рабочий процесс: сделайте всю работу видимой';

  @override
  String get agileItems => 'задач';

  @override
  String get agileItemsShort => 'зад.';

  @override
  String get agileWorkloadAvgItems => 'Ср. задач на человека';

  @override
  String get agileKanbanCapacityNote =>
      'Производительность рассчитывается на еженедельной основе (5 рабочих дней).';

  @override
  String get agilePriority => 'Приоритет';

  @override
  String get agileRoleSRM => 'Менеджер сервисных запросов (SRM)';

  @override
  String get agileRoleSDM => 'Менеджер сервисной поставки (SDM)';

  @override
  String get agileRoleTeamMember => 'Участник команды';

  @override
  String get agileFrameworkLocked =>
      'Невозможно изменить фреймворк для проектов с существующими задачами';

  @override
  String get agileComingSoon => 'Скоро будет доступно';

  @override
  String get kanbanPrinciple2 =>
      'Ограничивайте WIP: завершайте работу перед началом новой';

  @override
  String get kanbanPrinciple3 =>
      'Управляйте потоком: оптимизируйте для максимизации пропускной способности';

  @override
  String get kanbanPrinciple4 =>
      'Сделайте правила явными: определите четкие принципы';

  @override
  String get kanbanPrinciple5 =>
      'Внедряйте петли обратной связи: постоянно совершенствуйтесь';

  @override
  String get kanbanPrinciple6 =>
      'Улучшайте совместно: развивайтесь через эксперименты';

  @override
  String get kanbanBoardTitle => 'Канбан-доска';

  @override
  String get kanbanBoardContent =>
      'Доска визуализирует рабочий процесс через его фазы. Каждая колонка представляет состояние работы (например, К выполнению, В работе, Готово).\n\nКлючевые элементы доски:\n• Колонки: состояния потока работ\n• Карточка: единицы работы\n• Лимиты WIP: ограничения для каждой колонки\n• Дорожки (Swimlanes): горизонтальные группы (опционально)';

  @override
  String get kanbanWIPTitle => 'Лимиты WIP (незавершенной работы)';

  @override
  String get kanbanWIPContent =>
      'Лимиты WIP — это сердце Канбана. Ограничение незавершенной работы:\n\n• Уменьшает количество переключений между контекстами\n• Подсвечивает узкие места\n• Ускоряет пропускную способность\n• Улучшает качество (меньше ошибок из-за многозадачности)\n• Повышает предсказуемость\n\nКак устанавливать лимиты WIP:\n• Начните с удвоенного числа участников на колонку\n• Наблюдайте за потоком и корректируйте\n• «Правильный» лимит создает небольшое напряжение в потоке';

  @override
  String get kanbanMetricsTitle => 'Метрики Канбана';

  @override
  String get kanbanMetricsContent =>
      'Канбан использует метрики потока для измерения и улучшения процесса.';

  @override
  String get kanbanMetric1 =>
      'Lead Time: время от запроса до завершения (включая ожидание)';

  @override
  String get kanbanMetric2 =>
      'Cycle Time: время от начала работы до завершения';

  @override
  String get kanbanMetric3 =>
      'Throughput: задачи, выполненные за единицу времени';

  @override
  String get kanbanMetric4 =>
      'WIP: количество работы в процессе в любой момент времени';

  @override
  String get kanbanMetric5 =>
      'Накопительная диаграмма потока (CFD): визуализирует накопление работы во времени';

  @override
  String get kanbanCadencesTitle => 'Каденции Канбана';

  @override
  String get kanbanCadencesContent =>
      'В отличие от Scrum, Канбан не предписывает фиксированные события. Однако регулярные каденции помогают непрерывному улучшению:\n\n• Standup Meeting: ежедневная синхронизация перед доской\n• Replenishment Meeting: приоритизация бэклога\n• Delivery Planning: планирование релизов\n• Service Delivery Review: анализ метрик\n• Risk Review: анализ рисков и препятствий\n• Operations Review: улучшение процесса';

  @override
  String get kanbanSwimlanesTitle => 'Дорожки (Swimlanes)';

  @override
  String get kanbanSwimlanesContent =>
      'Дорожки — это горизонтальные ряды, которые группируют карточки на доске по общему признаку.\n\nТипы дорожек:\n• Тип обслуживания (Class of Service): группа по приоритету/срочности\n• Исполнитель: группа по участникам команды\n• Приоритет: группа по уровню MoSCoW\n• Тег: группа по тегам историй\n\nДорожки помогают:\n• Визуализировать нагрузку на человека\n• Управлять разными классами обслуживания (срочно, стандарт)\n• Выявлять узкие места по типам работ';

  @override
  String kanbanPoliciesTitle(String columnName) {
    return 'Правила: $columnName';
  }

  @override
  String get kanbanPoliciesContent =>
      'Практика Канбана №4: «Сделайте правила явными» требует определения четких правил для каждой колонки.\n\nПримеры правил:\n• «Макс. 24ч в этой колонке» — ограничение по времени\n• «Требуется одобренное код-ревью» — критерий выхода\n• «Макс. 1 задача на человека» — индивидуальный лимит\n• «Требуется ежедневное обновление» — коммуникация\n\nПравила:\n• Делают ожидания прозрачными для всех\n• Снижают количество двусмысленностей и конфликтов\n• Облегчают включение новых участников\n• Позволяют выявлять нарушения установленных норм';

  @override
  String get kanbanBP1 => 'Визуализируйте ВСЮ работу, включая скрытые задачи';

  @override
  String get kanbanBP2 => 'Строго соблюдайте лимиты WIP';

  @override
  String get kanbanBP3 =>
      'Сосредоточьтесь на завершении, а не на начале нового';

  @override
  String get kanbanBP4 =>
      'Используйте метрики для принятия решений, а не для оценки людей';

  @override
  String get kanbanBP5 => 'Улучшайте постепенно, шаг за шагом';

  @override
  String get kanbanBP6 => 'Блокируйте новую работу, если лимит WIP достигнут';

  @override
  String velocityTooltipAverage(int count) {
    return 'На основе всех $count завершенных спринтов';
  }

  @override
  String get kanbanBP7 => 'Анализируйте блокировщики и быстро устраняйте их';

  @override
  String get kanbanBP8 =>
      'Используйте дорожки (swimlanes) для приоритетов или типов работ';

  @override
  String get kanbanAP1 => 'Лимиты WIP слишком высоки (или отсутствуют)';

  @override
  String get kanbanAP2 => 'Игнорирование блокировок на доске';

  @override
  String get kanbanAP3 => 'Несоблюдение лимитов, когда «это срочно»';

  @override
  String get kanbanAP4 => 'Слишком общие колонки (например, только To Do/Done)';

  @override
  String get kanbanAP5 => 'Отсутствие отслеживания входа/выхода задач';

  @override
  String get kanbanAP6 =>
      'Использование Канбана только как доски задач без применения принципов';

  @override
  String get kanbanAP7 =>
      'Отсутствие анализа накопительной диаграммы потока (CFD)';

  @override
  String get kanbanAP8 => 'Слишком много дорожек, усложняющих визуализацию';

  @override
  String get kanbanFAQ1Q => 'Как обрабатывать срочные задачи в Канбане?';

  @override
  String get kanbanFAQ1A =>
      'Создайте дорожку (swimlane) «Expedite» с лимитом WIP 1. Такие задачи обходят очередь, но должны быть редкими. Если всё срочно — значит, ничего не срочно.';

  @override
  String get kanbanFAQ2Q => 'Подходит ли Канбан для разработки ПО?';

  @override
  String get kanbanFAQ2A =>
      'История считается «Готовой», когда она соответствует критериям готовности (Definition of Done), включая тестирование, документацию и приемку пользователем. Карточки переносятся в последний столбец только тогда, когда они действительно могут быть поставлены.';

  @override
  String get kanbanFAQ3Q => 'Как установить начальные лимиты WIP?';

  @override
  String get kanbanFAQ3A =>
      'Начальная формула: (количество участников + 1) на столбец. Понаблюдайте 2 недели и постепенно уменьшайте лимит до легкого «напряжения». Оптимальный лимит индивидуален для каждой команды и контекста.';

  @override
  String get kanbanFAQ4Q =>
      'Как скоро появятся результаты при использовании Канбана?';

  @override
  String get kanbanFAQ4A =>
      'Первые улучшения (визуализация) заметны сразу. Сокращение Lead Time наблюдается через 2–4 недели. Значительные улучшения процесса требуют 2–3 месяцев.';

  @override
  String get hybridOverview =>
      'Scrumban сочетает в себе элементы Scrum и Kanban, создавая гибкий подход,\nадаптирующийся к контексту команды. Он сохраняет структуру спринтов с\nгибкостью непрерывного потока и лимитов WIP.\n\nScrumban идеален для:\n• Команд, переходящих от Scrum к Kanban (или наоборот)\n• Проектов с сочетанием разработки фич и поддержки\n• Команд, которые хотят спринты, но с большей гибкостью\n• Случаев, когда «чистый» Scrum слишком жесткий для контекста';

  @override
  String get hybridFromScrumTitle => 'Из Scrum: Структура';

  @override
  String get hybridFromScrumContent =>
      'Scrumban сохраняет некоторые структурные элементы Scrum для предсказуемости.';

  @override
  String get hybridFromScrum1 =>
      'Спринт (опционально): фиксированные итерации для ритмичности';

  @override
  String get hybridFromScrum2 => 'Планирование спринта: выбор работы на период';

  @override
  String get hybridFromScrum3 => 'Ретроспектива: рефлексия и улучшение';

  @override
  String get hybridFromScrum4 => 'Демо/Обзор: демонстрация созданной ценности';

  @override
  String get hybridFromScrum5 =>
      'Story Points: For estimates and predictions (optional)';

  @override
  String get hybridFromKanbanTitle => 'Из Kanban: Поток';

  @override
  String get hybridFromKanbanContent =>
      'Scrumban заимствует принципы потока из Kanban для эффективности.';

  @override
  String get hybridFromKanban1 =>
      'Лимиты WIP: ограничение незавершенной работы';

  @override
  String get hybridFromKanban2 =>
      'Pull-система: команда «вытягивает» работу при наличии ресурсов';

  @override
  String get hybridFromKanban3 => 'Визуализация: общая и прозрачная доска';

  @override
  String get hybridFromKanban4 =>
      'Метрики потока: Lead Time, Cycle Time, Throughput';

  @override
  String get hybridFromKanban5 =>
      'Непрерывное улучшение: явные правила и эксперименты';

  @override
  String get hybridOnDemandTitle => 'Планирование по требованию';

  @override
  String get hybridOnDemandContent =>
      'В Scrumban планирование может быть «по требованию», а не через фиксированные интервалы.\n\nПланирование запускается, когда:\n• Бэклог «Ready» опускается ниже порога\n• Новые срочные запросы требуют приоритизации\n• Приближается важная веха\n\nЭто сокращает планирование, когда оно не нужно, и позволяет быстрее реагировать на изменения.';

  @override
  String get hybridWhenTitle => 'Когда и что использовать';

  @override
  String get hybridWhenContent =>
      'Scrumban — это не «делать всё подряд». Это выбор правильных элементов для контекста.\n\nЭлементы Scrum, когда:\n• Нужна предсказуемость в поставках\n• Стейкхолдеры хотят регулярных демо\n• Команде полезен фиксированный ритм\n\nЭлементы Kanban, когда:\n• Работа непредсказуема (поддержка, багфиксинг)\n• Нужна реакция на срочные задачи\n• Внимание сосредоточено на непрерывной пропускной способности';

  @override
  String get hybridBP1 =>
      'Начните с того, что вам знакомо, и добавляйте элементы постепенно';

  @override
  String get hybridBP2 => 'Лимиты WIP не обсуждаются, даже при наличии спринта';

  @override
  String get hybridBP3 =>
      'Используйте спринт для ритма, а не как жесткое обязательство';

  @override
  String get hybridBP4 => 'Сохраняйте ретроспективу — это двигатель улучшений';

  @override
  String get hybridBP5 => 'Метрики потока помогают больше, чем просто Velocity';

  @override
  String get hybridBP6 => 'Экспериментируйте с чем-то одним за раз';

  @override
  String get hybridBP7 =>
      'Документируйте командные правила и регулярно их пересматривайте';

  @override
  String get hybridBP8 =>
      'Используйте дорожки для разделения новых фич и поддержки';

  @override
  String get hybridAP1 =>
      'Худшее из обоих миров (жесткость Scrum + хаос Kanban)';

  @override
  String get hybridAP2 => 'Отказ от ретроспектив, потому что «мы гибкие»';

  @override
  String get hybridAP3 =>
      'Игнорирование лимитов WIP, потому что «у нас спринты»';

  @override
  String get hybridAP4 => 'Смена фреймворка каждый спринт';

  @override
  String get hybridAP5 => 'Отсутствие каденции (ни спринта, ни других ритмов)';

  @override
  String get hybridAP6 => 'Путаница между гибкостью и отсутствием правил';

  @override
  String get hybridAP7 => 'Ничего не измеряется';

  @override
  String get hybridAP8 => 'Излишняя сложность для данного контекста';

  @override
  String get hybridFAQ1Q => 'Есть ли в Scrumban спринты?';

  @override
  String get hybridFAQ1A =>
      'It depends on the team. You can have Sprint for cadence (review, planning) but allow continuous flow of work within the Sprint. Or you can eliminate Sprints and have only Kanban cadences.';

  @override
  String get hybridFAQ2Q => 'Как измерять эффективность в Scrumban?';

  @override
  String get hybridFAQ2A =>
      'Use both Scrum metrics (Velocity if using Sprint and Story Points) and Kanban metrics (Lead Time, Cycle Time, Throughput). Flow metrics are often more useful for improvement.';

  @override
  String get hybridFAQ3Q => 'С чего начать внедрение Scrumban?';

  @override
  String get hybridFAQ3A =>
      'If coming from Scrum: add WIP limits and visualize the flow. If coming from Kanban: add regular cadences for review and planning. Start from what the team knows and add incrementally.';

  @override
  String get hybridFAQ4Q =>
      'Является ли Scrumban «менее гибким», чем чистый Scrum?';

  @override
  String get hybridFAQ4A =>
      'No. Agile doesn\'t mean following a specific framework. Scrumban can be more Agile because it adapts to context. The important thing is to continuously inspect and adapt.';

  @override
  String get retroNoResults => 'Ничего не найдено';

  @override
  String get agileNoAssignee => 'Unassigned';

  @override
  String get retroFilterAll => 'Все';

  @override
  String get retroFilterActive => 'Активные';

  @override
  String get retroFilterCompleted => 'Завершенные';

  @override
  String get retroFilterDraft => 'Черновики';

  @override
  String get retroDeleteTitle => 'Удалить ретроспективу';

  @override
  String retroDeleteConfirm(String title) {
    return 'Вы уверены?';
  }

  @override
  String get retroDeleteSuccess => 'Ретроспектива успешно удалена';

  @override
  String retroDeleteError(String error) {
    return 'Ошибка при удалении: $error';
  }

  @override
  String get retroDeleteConfirmAction => 'Удалить навсегда';

  @override
  String get retroNewRetroTitle => 'Новая ретроспектива';

  @override
  String get retroLinkToSprint => 'Привязать к спринту?';

  @override
  String get retroNoProjectFound => 'Проект не найден.';

  @override
  String get retroSelectProject => 'Выберите проект';

  @override
  String get retroSelectSprint => 'Выберите спринт';

  @override
  String retroSprintLabel(int number, String name) {
    return 'Sprint $number: $name';
  }

  @override
  String retroSprintOnlyLabel(int number) {
    return 'Sprint $number';
  }

  @override
  String get retroOwner => 'Владелец';

  @override
  String get retroGuest => 'Гость';

  @override
  String get retroSessionTitle => 'Заголовок сессии';

  @override
  String get retroSessionTitleHint =>
      'Например: Еженедельная синхронизация, Обзор проекта...';

  @override
  String get retroTemplateLabel => 'Шаблон';

  @override
  String get retroVotesPerUser => 'Голосов на пользователя:';

  @override
  String get retroActionClose => 'Закрыть';

  @override
  String get retroActionCreate => 'Создать';

  @override
  String get retroStatusDraft => 'Черновик';

  @override
  String get retroStatusActive => 'В процессе';

  @override
  String get agileBurndownInfoTitle => 'Как читать диаграмму Burndown';

  @override
  String get agileBurndownInfoIdeal =>
      '**Идеальная** линия (пунктирная) показывает целевой прогресс при равномерном выполнении работ.';

  @override
  String get agileBurndownInfoActual =>
      '**Фактическая** линия (сплошная) показывает оставшуюся работу. Выполненные задачи снижают эту линию.';

  @override
  String get agileBurndownInfoGoal =>
      'Ваша цель — держать фактическую линию ниже идеальной, чтобы закончить вовремя.';

  @override
  String get guideToolsTitle => 'Инструменты и интеграции';

  @override
  String get guideJiraContent =>
      'Приложение интегрируется с Jira для синхронизации работы.\n\nКлючевые возможности:\n• **Импорт**: истории из Jira появляются здесь.\n• **Ссылка**: нажатие на ID истории (напр., PROJ-123) открывает Jira.\n• **Синхронизация**: статусы обновляются в обе стороны (если настроено).';

  @override
  String get guideWorkflowTitle => 'Процесс и качество';

  @override
  String get guideAcceptanceCriteriaContent =>
      'Чтобы гарантировать качество, каждая история должна иметь четкие критерии приемки.\n\n• **Быстрое добавление**: критерии можно добавить прямо в деталях истории.\n• **Проверка**: отмечайте критерии по мере выполнения.\n• **Definition of Done**: история считается завершенной (Done) только при выполнении всех критериев.';

  @override
  String get scrumWorkflowStatusContent =>
      'В Scrum жизненный цикл истории состоит из следующих этапов:\n\n**Бэклог продукта** (виден только во вкладке Бэклог):\n1. **Backlog**: Рождение идеи. История еще не проанализирована.\n2. **Refinement**: Анализ и детализация. Командная работа (путь к Definition of Ready).\n3. **Ready**: Соответствует DoR и может быть выбрана в планирование. Только Product Owner может помечать историю как Ready.\n\n**Доска спринта** (видна на доске во время спринта):\n4. **To Do**: Истории «Ready», добавленные в спринт.\n5. **In Progress**: Активная работа команды.\n6. **In Review**: Этап обзора / Code Review.\n7. **Done**: История завершена и проверена.';

  @override
  String get kanbanWorkflowStatusContent =>
      'В Kanban поток непрерывен:\n\n1. **Refinement**: Выделенная колонка для анализа входящих запросов.\n2. **Ready**: Очередь готовых к работе задач (pull-система).\n3. **Active Board**: Прохождение историй через рабочие колонки.\n4. **WIP Limits**: Лимиты для каждой колонки для предотвращения пробок.';

  @override
  String get hybridWorkflowStatusContent =>
      'Scrumban использует гибридный подход:\n\n• Можно использовать спринты для планирования, но управлять ежедневным потоком как в Kanban.\n• Истории «Ready» можно брать в работу при наличии свободных ресурсов, независимо от планирования спринта, если команда так решит.';

  @override
  String get contextualHelpButton => 'Помощь';

  @override
  String get contextualHelpTips => 'Советы';

  @override
  String get contextualHelpBacklogTitle => 'Бэклог продукта';

  @override
  String get contextualHelpBacklogDesc =>
      'Бэклог — это приоритизированный список всей работы. Истории вверху являются самыми важными.';

  @override
  String get contextualHelpBacklogTip1 =>
      'Поддерживайте порядок в бэклоге по приоритету';

  @override
  String get contextualHelpBacklogTip2 =>
      'Сотрудничайте с командой во время уточнения (Refinement) для детализации историй';

  @override
  String get contextualHelpBacklogTip3 =>
      'История готова (Ready), когда она соответствует Definition of Ready';

  @override
  String get contextualHelpSprintTitle => 'Спринт';

  @override
  String get contextualHelpSprintDesc =>
      'Спринт — это фиксированный период времени (1-4 недели), в течение которого команда работает над выбранными историями.';

  @override
  String get contextualHelpSprintTip1 =>
      'Не меняйте состав работ во время спринта';

  @override
  String get contextualHelpSprintTip2 =>
      'Следите за графиком сгорания (burndown) для проверки прогресса';

  @override
  String get contextualHelpSprintTip3 =>
      'Проводите ежедневные летучки (standups) для синхронизации команды';

  @override
  String get contextualHelpSprintTip4 =>
      'В конце спринта используйте «Завершить спринт» для пошагового закрытия с обзором (Sprint Review) и распределением задач';

  @override
  String get contextualHelpKanbanTitle => 'Kanban-доска';

  @override
  String get contextualHelpKanbanDescFlow =>
      'Kanban-доска визуализирует рабочий процесс. Элементы движутся слева направо через колонки.';

  @override
  String get contextualHelpKanbanDescScrum =>
      'В Scrum доска отображает статус историй в текущем спринте.';

  @override
  String get contextualHelpKanbanTip1 =>
      'Соблюдайте лимиты WIP, чтобы избежать заторов';

  @override
  String get contextualHelpKanbanTip2 =>
      'Берите новую работу только при наличии свободной мощности';

  @override
  String get contextualHelpKanbanTip3 =>
      'Следите за возрастом элементов для выявления блокировок';

  @override
  String get contextualHelpKanbanTipScrum1 =>
      'Перемещайте карточки слева направо по мере выполнения';

  @override
  String get contextualHelpKanbanTipScrum2 =>
      'Завершайте одну историю перед началом следующей';

  @override
  String get contextualHelpTeamTitle => 'Команда';

  @override
  String get contextualHelpTeamDesc =>
      'Здесь вы можете управлять участниками команды, их ролями и навыками.';

  @override
  String get contextualHelpTeamTip1 =>
      'Назначьте четкие роли каждому участнику';

  @override
  String get contextualHelpTeamTip2 =>
      'Балансируйте нагрузку между участниками';

  @override
  String get contextualHelpMetricsTitle => 'Метрики';

  @override
  String get contextualHelpMetricsDescScrum =>
      'Следите за скоростью (velocity), сгоранием и точностью оценки для улучшения предсказуемости.';

  @override
  String get contextualHelpMetricsDescKanban =>
      'Следите за Lead Time, Cycle Time и пропускной способностью для оптимизации потока.';

  @override
  String get contextualHelpMetricsDescHybrid =>
      'Комбинируйте метрики Scrum и Kanban для полной картины.';

  @override
  String get contextualHelpMetricsTipScrum1 =>
      'Используйте среднюю скорость для планирования будущих спринтов';

  @override
  String get contextualHelpMetricsTipScrum2 =>
      'Анализируйте оценки для повышения точности';

  @override
  String get contextualHelpMetricsTipKanban1 =>
      'Сокращайте Lead Time для более быстрой поставки ценности';

  @override
  String get contextualHelpMetricsTipKanban2 =>
      'Следите за еженедельной пропускной способностью для предсказуемости';

  @override
  String get contextualHelpMetricsTipKanban3 =>
      'Используйте возраст элементов для выявления блокировок';

  @override
  String get contextualHelpMetricsTipHybrid1 =>
      'Балансируйте метрики скорости и потока';

  @override
  String get contextualHelpMetricsTipHybrid2 =>
      'Адаптируйте метрики под ваш способ работы';

  @override
  String get contextualHelpRetroTitle => 'Ретроспектива';

  @override
  String get contextualHelpRetroDescScrum =>
      'Ретроспектива — это двигатель непрерывного улучшения, предназначенный для превращения фидбека команды в измеримый рост в 4 областях.';

  @override
  String get contextualHelpRetroDescKanban =>
      'В Kanban ретроспектива (Operations Review) фокусируется на анализе потока поставки, выявлении заторов и оптимизации времени производства.';

  @override
  String get contextualHelpRetroTabActiveTitle =>
      'Активная вкладка: Основная сессия';

  @override
  String get contextualHelpRetroTabActive =>
      'Управление текущим мозговым штурмом. Во время фазы написания карточки скрыты для исключения эффекта привязки. Используйте функцию «Перенос», чтобы выбрать нерешенные вопросы из прошлых циклов.';

  @override
  String get contextualHelpRetroTabHistoryTitle =>
      'Вкладка История: Тренды и инсайты';

  @override
  String get contextualHelpRetroTabHistory =>
      'Просматривайте завершенные сессии на графике трендов. Анализируйте эмоциональный фон команды vs процент выполнения задач. Если фон хороший, а выполнение низкое — сделайте задачи более достижимыми.';

  @override
  String get contextualHelpRetroTabActionItemsTitle =>
      'Трекер действий (Action Items)';

  @override
  String get contextualHelpRetroTabActionItems =>
      'Панель стратегического исполнения. Каждое действие должно следовать критериям SMART. Используйте фильтры для проверки просроченных пунктов во время летучек.';

  @override
  String get contextualHelpRetroTabLessonsLearnedTitle =>
      'Реестр извлеченных уроков';

  @override
  String get contextualHelpRetroTabLessonsLearned =>
      'Репозиторий корпоративных знаний (в стиле PMBOK). Действия тактичны («исправить сейчас»), а извлеченные уроки стратегичны («не повторять это никогда»).';

  @override
  String get contextualHelpRetroIntegrationTitle => 'Цикл улучшения';

  @override
  String get contextualHelpRetroIntegration =>
      'Карточки фидбека с доски превращаются в пункты действий. Они отслеживаются на панели, а их выполнение влияет на тренды в Истории. Повторяющиеся паттерны фиксируются как уроки.';

  @override
  String get contextualHelpRetroModeQuickTitle =>
      'Быстрая форма vs Интерактивная доска';

  @override
  String get contextualHelpRetroModeQuick =>
      'Быстрая форма позволяет одному пользователю сразу записать основные моменты и действия. Используйте это, если штурм прошел офлайн. Эффект: данные сразу попадают в Историю без реального времени.';

  @override
  String get contextualHelpRetroModeInteractiveTitle => 'Интерактивная сессия';

  @override
  String get contextualHelpRetroModeInteractive =>
      'Проводит команду через разминку, мозговой штурм, группировку и голосование. Эффект: голос каждого услышан, нет предвзятости, консенсус достигнут.';

  @override
  String get contextualHelpRetroTip1 =>
      'Назначайте четкого владельца и срок каждому пункту действий';

  @override
  String get contextualHelpRetroTip2 =>
      'Отмечайте «Сильные стороны» в уроках, чтобы опираться на то, что работает';

  @override
  String get contextualHelpRetroTip3 =>
      'Используйте быструю форму для цифровизации результатов физических воркшопов';

  @override
  String get retroStatusCompleted => 'Завершена';

  @override
  String get profileIntegrations => 'Интеграции';

  @override
  String get profileJiraIntegration => 'Интеграция с Jira';

  @override
  String get profileJiraIntegrationDesc => 'Подключитесь для импорта историй';

  @override
  String get jiraDomain => 'Домен Jira';

  @override
  String get jiraEmail => 'Email Atlassian';

  @override
  String get jiraApiToken => 'API-токен';

  @override
  String get jiraConnect => 'Подключить';

  @override
  String get jiraDisconnect => 'Отключить';

  @override
  String get jiraSettingsSaved => 'Настройки сохранены';

  @override
  String get jiraSettingsCleared => 'Настройки очищены';

  @override
  String get retroTemplateStartStopContinue => 'Начать, Прекратить, Продолжить';

  @override
  String get retroTemplateSailboat => 'Парусник';

  @override
  String get retroTemplate4Ls => '4 Ls (Liked, Learned, Lacked, Longed For)';

  @override
  String get retroTemplateStarfish => 'Морская звезда';

  @override
  String get retroTemplateMadSadGlad => 'Бесит, Грустно, Радует';

  @override
  String get retroTemplateDAKI => 'DAKI (Drop, Add, Keep, Improve)';

  @override
  String get retroDescStartStopContinue =>
      'Ориентирован на действие: начать делать, прекратить делать, продолжать делать.';

  @override
  String get retroDescSailboat =>
      'Визуальный: Ветер (движет), Якоря (тормозят), Камни (риски), Остров (цели).';

  @override
  String get retroDesc4Ls => 'Нравится, Усвоено, Не хватало, Пожелания.';

  @override
  String get retroDescStarfish =>
      'Сохранить, Прекратить, Начать, Больше, Меньше.';

  @override
  String get retroDescMadSadGlad => 'Эмоциональный: Злой, Грустный, Радостный.';

  @override
  String get retroDescDAKI =>
      'Прагматичный: Убрать, Добавить, Оставить, Улучшить.';

  @override
  String get retroUsageStartStopContinue =>
      'Лучше всего подходит для действенной обратной связи и фокуса на поведенческих изменениях.';

  @override
  String get retroUsageSailboat =>
      'Лучше всего для визуализации пути команды, целей и рисков. Подходит для креативного мышления.';

  @override
  String get retroUsage4Ls =>
      'Рефлексивный: лучше всего для извлечения уроков из прошлого и выделения эмоциональных/обучающих аспектов.';

  @override
  String get retroUsageStarfish =>
      'Калибровка: лучше всего для масштабирования усилий (делать чего-то больше/меньше), а не только двоичного «стоп/старт».';

  @override
  String get retroUsageMadSadGlad =>
      'Лучше всего для эмоциональной проверки, разрешения конфликтов или после напряженного спринта.';

  @override
  String get retroUsageDAKI =>
      'Решительный: лучше всего для «чистки» процессов. Фокусируется на конкретных решениях: Убрать (удалить) или Добавить (инновации).';

  @override
  String get retroIcebreakerSentiment => 'Голосование по настроению';

  @override
  String get retroIcebreakerOneWord => 'Одно слово';

  @override
  String get retroIcebreakerWeather => 'Прогноз погоды';

  @override
  String get retroIcebreakerSentimentDesc =>
      'Оцените от 1 до 5 свое самочувствие в течение спринта.';

  @override
  String get retroIcebreakerOneWordDesc => 'Опишите спринт всего одним словом.';

  @override
  String get retroIcebreakerWeatherDesc =>
      'Выберите иконку погоды, которая олицетворяет этот спринт.';

  @override
  String get retroPhaseIcebreaker => 'ЛЕДОКОЛ';

  @override
  String get retroPhaseWriting => 'WRITING';

  @override
  String get retroPhaseVoting => 'VOTING';

  @override
  String get retroPhaseDiscuss => 'ОБСУЖДЕНИЕ';

  @override
  String get retroActionItemsLabel => 'План действий';

  @override
  String get retroActionDragToCreate =>
      'Перетащите карточку сюда, чтобы создать связанный пункт плана действий';

  @override
  String get retroNoActionItems => 'Пункты плана действий еще не созданы.';

  @override
  String get facilitatorGuideNextColumn => 'Далее: соберите пункты плана из';

  @override
  String get collectionRationaleSSC =>
      'Сначала «Прекратить», чтобы убрать блокировщики, затем «Начать» новые практики, и наконец «Продолжить» то, что работает.';

  @override
  String get collectionRationaleMSG =>
      'Сначала разберитесь с тем, что бесит, затем с разочарованиями, а затем отпразднуйте успехи.';

  @override
  String get collectionRationale4Ls =>
      'Сначала восполните пробелы, затем спланируйте будущие пожелания, сохраните то, что работает, и поделитесь знаниями.';

  @override
  String get collectionRationaleSailboat =>
      'Сначала минимизируйте риски, уберите блокировщики, затем используйте факторы роста и сверьтесь с целями.';

  @override
  String get collectionRationaleStarfish =>
      'Прекратите плохие практики, уменьшите другие, сохраните хорошие, увеличьте ценные и начните новые.';

  @override
  String get collectionRationaleDAKI =>
      '«Убрать», чтобы освободить ресурсы, «Добавить» новые практики, «Улучшить» существующие и «Оставить» то, что работает.';

  @override
  String get missingSuggestionSSCStop =>
      'Подумайте, какая практика мешает команде и должна быть прекращена.';

  @override
  String get missingSuggestionSSCStart =>
      'Подумайте, какая новая практика поможет команде стать лучше.';

  @override
  String get missingSuggestionMSGMad =>
      'Разберитесь с недовольством команды — что вызывает злость?';

  @override
  String get missingSuggestionMSGSad =>
      'Разберитесь с разочарованиями — что заставило команду грустить?';

  @override
  String get missingSuggestion4LsLacked =>
      'Чего не хватало из того, в чем нуждалась команда?';

  @override
  String get missingSuggestion4LsLonged =>
      'Что бы команда хотела иметь в будущем?';

  @override
  String get missingSuggestionSailboatAnchor =>
      'Что удерживает команду от достижения целей?';

  @override
  String get missingSuggestionSailboatRock =>
      'Какие риски угрожают прогрессу команды?';

  @override
  String get missingSuggestionStarfishStop =>
      'Какую практику команде следует полностью прекратить?';

  @override
  String get missingSuggestionStarfishStart =>
      'Какую новую практику команде следует начать?';

  @override
  String get missingSuggestionDAKIDrop => 'Что команде стоит исключить?';

  @override
  String get missingSuggestionDAKIAdd =>
      'Какое новое решение должна принять команда?';

  @override
  String get missingSuggestionGeneric =>
      'Подумайте о создании пункта плана действий из этой колонки.';

  @override
  String get facilitatorGuideAllCovered =>
      'Все необходимые колонки проработаны!';

  @override
  String get facilitatorGuideMissing => 'Отсутствуют пункты плана действий для';

  @override
  String get retroPhaseStart => 'Начать';

  @override
  String get retroPhaseStop => 'Прекратить';

  @override
  String get retroPhaseContinue => 'Продолжить';

  @override
  String get retroColumnMad => 'Бесит';

  @override
  String get retroColumnSad => 'Грустно';

  @override
  String get retroColumnGlad => 'Радует';

  @override
  String get retroColumnLiked => 'Нравится';

  @override
  String get retroColumnLearned => 'Усвоено';

  @override
  String get retroColumnLacked => 'Не хватало';

  @override
  String get retroColumnLonged => 'Пожелания';

  @override
  String get retroColumnWind => 'Ветер';

  @override
  String get retroColumnAnchor => 'Якоря';

  @override
  String get retroColumnRock => 'Камни';

  @override
  String get retroColumnGoal => 'Остров';

  @override
  String get retroColumnKeep => 'Оставить';

  @override
  String get retroColumnMore => 'Больше';

  @override
  String get retroColumnLess => 'Меньше';

  @override
  String get retroColumnDrop => 'Убрать';

  @override
  String get retroColumnAdd => 'Добавить';

  @override
  String get retroColumnImprove => 'Улучшить';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsThemeLight => 'Светлая';

  @override
  String get settingsThemeDark => 'Темная';

  @override
  String get settingsThemeSystem => 'Системная';

  @override
  String get formTitle => 'Заголовок';

  @override
  String get formDescription => 'Описание';

  @override
  String get formName => 'Имя';

  @override
  String get formRequired => 'Обязательное поле';

  @override
  String get formHint => 'Введите значение';

  @override
  String get formOptional => 'Необязательно';

  @override
  String errorGeneric(String error) {
    return 'Произошла ошибка';
  }

  @override
  String get errorLoading => 'Ошибка при загрузке данных';

  @override
  String get errorSaving => 'Ошибка при сохранении';

  @override
  String get errorNetwork => 'Ошибка соединения';

  @override
  String get errorPermission => 'Доступ запрещен';

  @override
  String get errorNotFound => 'Не найдено';

  @override
  String get successSaved => 'Успешно сохранено';

  @override
  String get successDeleted => 'Успешно удалено';

  @override
  String get successCopied => 'Скопировано в буфер обмена';

  @override
  String get filterAll => 'Все';

  @override
  String get filterRemove => 'Сбросить фильтры';

  @override
  String get filterActive => 'Активные';

  @override
  String get filterCompleted => 'Завершенные';

  @override
  String get participants => 'Участники';

  @override
  String get agileAcceptanceCriteria => 'Критерии приемки';

  @override
  String agileAcceptanceCriteriaCount(int completed, int total) {
    return '$completed из $total пунктов';
  }

  @override
  String get agileEstimateRequired =>
      'Требуется оценка (нажмите, чтобы оценить)';

  @override
  String get agileNoActiveSprint => 'Нет активного спринта';

  @override
  String get agileKanbanBoardHint =>
      'На доске Kanban отображаются задачи из активного спринта.\nЧтобы увидеть задачи:';

  @override
  String get agileStartSprintFromTab =>
      'Запустите спринт из вкладки \"Спринт\"';

  @override
  String get agileDisableFilterHint =>
      'Или отключите фильтр, чтобы увидеть все задачи';

  @override
  String get agileShowAllStories => 'Показать все задачи';

  @override
  String get agileFilterActiveSprint => 'Фильтр активного спринта: ';

  @override
  String get agileFilterActive => 'Активные';

  @override
  String get agileFilterAll => 'Все';

  @override
  String get agileActionInvite => 'Пригласить';

  @override
  String agileTeamTitle(int count) {
    return 'Команда ($count)';
  }

  @override
  String get agileNoMembers => 'В команде нет участников';

  @override
  String get agileYouBadge => 'Вы';

  @override
  String agileStatsPlannedCount(int count) {
    return '$count запланировано';
  }

  @override
  String agileStatsTotalCount(int count) {
    return 'Всего: $count';
  }

  @override
  String get agileStatsPtsPerSprint => 'очков/спринт';

  @override
  String get agileStatsWorkInProgress => 'в работе';

  @override
  String get agileStatsItemsPerWeek => 'задач/неделя';

  @override
  String get agileStatsCompletedTooltip =>
      'Количество спринтов со статусом \"Завершен\". Нажмите \"Завершить спринт\", чтобы финализировать активный спринт.';

  @override
  String get agileAverageVelocityTooltip =>
      'Среднее количество Story Points, выполненных за спринт. Рассчитывается на основе завершенных спринтов. Чем выше, тем продуктивнее команда.';

  @override
  String get agileStatsStoriesCompletedTooltip =>
      'Количество задач со статусом \"Готово\". Чтобы увеличить это значение, переместите задачи в колонку \"Готово\" на доске Kanban.';

  @override
  String get agileStatsPointsTooltip =>
      'Сумма очков сложности (SP) выполненных задач. \"Запланировано\" включает все оцененные задачи в бэклоге.';

  @override
  String get agileItemsCompletedTooltip =>
      'Количество рабочих задач со статусом «Готово». Чтобы завершить задачи, переместите их в колонку «Готово».';

  @override
  String get agileInProgressTooltip =>
      'Задачи, находящиеся в работе (WIP). Держите это число низким, чтобы улучшить поток.';

  @override
  String get agileCycleTimeTooltip =>
      'Среднее время, проведенное в активных состояниях (например, «В работе», «Ревью»). Исключает время ожидания в бэклоге или «Готово к работе».';

  @override
  String get agileThroughputTooltip =>
      'Среднее количество задач, выполненных за неделю (последние 4 недели). Указывает на продуктивность команды во времени.';

  @override
  String get agileHybridSprintTooltip => 'Завершенные спринты / Всего.';

  @override
  String get agileHybridCompletedTooltip =>
      'Задачи со статусом «Готово» / Всего. Переместите задачи в колонку «Готово», чтобы завершить их.';

  @override
  String get agileAddSkillsHint => 'Добавьте навыки участникам команды';

  @override
  String get agileSkillMatrixTitle => 'Матрица навыков';

  @override
  String get agileCriticalSkills => 'Критические навыки';

  @override
  String agileCriticalSkillsWarning(String skills) {
    return 'Только 1 человек владеет: $skills';
  }

  @override
  String get agileSkills => 'Навыки';

  @override
  String get agileNoSkills => 'Навыки не указаны';

  @override
  String get agileAddSkill => 'Добавить навык';

  @override
  String get agileNewSkill => 'Новый навык...';

  @override
  String get agileNewSkillDialogTitle => 'Новый навык';

  @override
  String get agileNewSkillName => 'Название навыка';

  @override
  String get agileNewSkillHint => 'Напр.: Flutter, Python, AWS...';

  @override
  String get agileSkillCoverage => 'Покрытие навыками';

  @override
  String get agileNoSkillsAvailable => 'Нет доступных навыков';

  @override
  String agileBasedOnCompletedItems(int count) {
    return 'На основе $count выполненных задач';
  }

  @override
  String get agileNoAcceptanceCriteria => 'Критерии приемки не определены';

  @override
  String get agileDescription => 'Описание';

  @override
  String get agileNoDescription => 'Нет описания';

  @override
  String get agileTags => 'Теги';

  @override
  String get agileEstimates => 'Оценки';

  @override
  String get agileFinalEstimate => 'Итоговая оценка';

  @override
  String agileEstimatesReceived(int count) {
    return 'Получено оценок: $count';
  }

  @override
  String get agileInformation => 'Информация';

  @override
  String get agileBusinessValue => 'Бизнес-ценность';

  @override
  String get agileAssignee => 'Исполнитель';

  @override
  String get agileCreatedBy => 'Кем создано';

  @override
  String get agileCreatedAt => 'Дата создания';

  @override
  String get agileStartedAt => 'Начат в';

  @override
  String get agileCompletedAt => 'Завершено в';

  @override
  String get agileSprintTitle => 'Спринт';

  @override
  String get agileNewSprint => 'Новый спринт';

  @override
  String get agileNoSprints => 'Спринтов пока нет';

  @override
  String get agileCreateFirstSprint =>
      'Создайте первый спринт для начала работы';

  @override
  String get agileSprintStatusPlanning => 'Планирование';

  @override
  String get agileSprintStatusActive => 'Активен';

  @override
  String get agileSprintStatusReview => 'Обзор';

  @override
  String get agileSprintStatusCompleted => 'Завершен';

  @override
  String get agileStartSprint => 'Запустить спринт';

  @override
  String get agileCompleteSprint => 'Завершить спринт';

  @override
  String get agileStartClosing => 'Закрыть спринт';

  @override
  String get agileFinalizeSprint => 'Финализировать спринт';

  @override
  String get agileSprintClosingPhase => 'Фаза завершения';

  @override
  String get agileSprintClosingDesc =>
      'Спринт находится в фазе завершения. Завершите обзор спринта и финализируйте его.';

  @override
  String get agileSprintClosingBanner =>
      'Спринт в фазе завершения — завершите обзор и финализируйте';

  @override
  String get agileSprintClosingStarted => 'Начата фаза завершения спринта';

  @override
  String get agileSprintClosingBoardVisible =>
      'Доска продолжает показывать задачи спринта';

  @override
  String get agileSprintClosingNoNewStories =>
      'Новые задачи не могут быть добавлены в спринт';

  @override
  String get agileSprintClosingReviewFirst =>
      'Проведите обзор спринта перед финализацией';

  @override
  String agileSprintOverdue(int days) {
    return 'Просрочено на $days дн.';
  }

  @override
  String agileSprintDaysWarning(int days) {
    return 'Осталось дней: $days';
  }

  @override
  String get agileStoryDisposition => 'Распоряжение по задаче';

  @override
  String get agileStoryDispositionDesc =>
      'Выберите, что делать с незавершенными задачами';

  @override
  String get agileDispositionBacklog => 'Бэклог (в конец)';

  @override
  String get agileDispositionReady => 'Готово (Ready)';

  @override
  String get agileDispositionRefinement => 'На уточнение';

  @override
  String get agileDispositionBacklogDesc =>
      'Вернуть в бэклог для повторной приоритизации';

  @override
  String get agileDispositionReadyDesc =>
      'Готово к планированию следующего спринта';

  @override
  String get agileDispositionRefinementDesc =>
      'Требуется дополнительный анализ/детализация перед следующим спринтом';

  @override
  String get agileRetroSuggestion =>
      'Хотите создать ретроспективу для этого спринта?';

  @override
  String get agileCreateRetro => 'Создать ретроспективу';

  @override
  String get agileNotNow => 'Не сейчас';

  @override
  String get agileSprintReviewSection => 'Обзор спринта';

  @override
  String get agileSprintSummarySection => 'Раздел итогов спринта';

  @override
  String get agileReviewRecapTitle => 'Итоги обзора спринта';

  @override
  String get agileReviewApproved => 'Одобрено';

  @override
  String get agileReviewRefinement => 'Требуется доработка';

  @override
  String get agileReviewRejected => 'Отклонено';

  @override
  String get agileDeleteSprint => 'Удалить';

  @override
  String get agileSprintName => 'Название спринта';

  @override
  String get agileSprintGoal => 'Цель спринта';

  @override
  String get agileSprintGoalHint => 'Цель спринта';

  @override
  String get agileStartDate => 'Дата начала';

  @override
  String get agileEndDate => 'Дата окончания';

  @override
  String get agileStatsStories => 'задач';

  @override
  String get agileStatsPoints => 'очков';

  @override
  String get agileStatsCompleted => 'завершено';

  @override
  String get agileStatsVelocity => 'скорость';

  @override
  String agileDaysRemainingCount(String count) {
    return 'Осталось дней: $count';
  }

  @override
  String get agileAverageVelocity => 'Ср. скорость';

  @override
  String agileTeamMembersCount(String count) {
    return 'Команда: $count участников';
  }

  @override
  String get agileActionCancel => 'Отмена';

  @override
  String get agileActionSave => 'Сохранить';

  @override
  String get agileActionCreate => 'Создать';

  @override
  String get agileSprintPlanningTitle => 'Планирование спринта';

  @override
  String get agileSprintPlanningSubtitle =>
      'Выберите задачи для выполнения в этом спринте';

  @override
  String get agileBurndownChart => 'Диаграмма сгорания задач (Burndown)';

  @override
  String get agileBurndownIdeal => 'Идеал';

  @override
  String get agileBurndownActual => 'Факт';

  @override
  String get agileBurndownPlanned => 'План';

  @override
  String get agileBurndownRemaining => 'Остаток';

  @override
  String get agileBurndownNoData => 'Нет данных для диаграммы';

  @override
  String get agileBurndownNoDataHint =>
      'Данные появятся, когда спринт будет активирован';

  @override
  String get agileVelocityTrend => 'Тренд скорости';

  @override
  String get agileVelocityNoData => 'Нет данных о скорости';

  @override
  String get agileVelocityNoDataHint =>
      'Завершите хотя бы один спринт, чтобы увидеть тренд';

  @override
  String get agileTeamCapacity => 'Емкость команды';

  @override
  String get agileTeamCapacityScrum => 'Емкость команды (Scrum)';

  @override
  String get agileTeamCapacityHours => 'Емкость команды (часов)';

  @override
  String get agileThroughput => 'Пропускная способность';

  @override
  String get agileSuggestedCapacity => 'Предлагаемая емкость для планирования';

  @override
  String get agileSuggestedCapacityHint =>
      'На основе средней скорости ± стандартное отклонение (±10%)';

  @override
  String get agileSuggestedCapacityNoData =>
      'Завершите хотя бы 1 спринт, чтобы получить рекомендации по емкости';

  @override
  String get agileScrumGuideNote =>
      'Scrum Guide рекомендует планирование на основе исторической скорости (Velocity), а не часов.';

  @override
  String get agileHoursAvailable => 'Доступно';

  @override
  String get agileHoursAssigned => 'Назначено';

  @override
  String get agileHoursOverloaded => 'Перегружено';

  @override
  String get agileHoursTotal => 'Общая емкость';

  @override
  String get agileHoursUtilization => 'Загрузка';

  @override
  String agileMetricsTitle(String framework) {
    return 'Метрики $framework';
  }

  @override
  String get agileItemsCompleted => 'Задач выполнено';

  @override
  String get agileInProgress => 'В работе';

  @override
  String get agileCycleTime => 'Cycle Time';

  @override
  String get agileLeadTime => 'Lead Time';

  @override
  String get agileDistribution => 'Распределение задач';

  @override
  String get agileCompletionRate => 'Процент выполнения';

  @override
  String get agileAccuracy => 'Точность оценки';

  @override
  String get agileEfficiency => 'Эффективность потока';

  @override
  String get removeParticipant => 'Удалить участника';

  @override
  String get noParticipants => 'Нет участников';

  @override
  String get participantJoined => 'присоединился';

  @override
  String get participantLeft => 'покинул';

  @override
  String get participantRole => 'Роль';

  @override
  String get participantVoter => 'Голосующий';

  @override
  String get participantObserver => 'Наблюдатель';

  @override
  String get participantModerator => 'Модератор';

  @override
  String get confirmDelete => 'Подтвердить удаление';

  @override
  String get confirmDeleteMessage => 'Это действие невозможно отменить.';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get ok => 'OK';

  @override
  String get today => 'Сегодня';

  @override
  String get yesterday => 'Вчера';

  @override
  String get tomorrow => 'Завтра';

  @override
  String daysAgo(int count) {
    return '$count дн. назад';
  }

  @override
  String hoursAgo(int count) {
    return '$count ч. назад';
  }

  @override
  String minutesAgo(int count) {
    return '$count мин. назад';
  }

  @override
  String itemCount(int count) {
    return '$count элементов';
  }

  @override
  String get welcomeBack => 'С возвращением!';

  @override
  String greeting(String name) {
    return 'Привет, $name!';
  }

  @override
  String get copyLink => 'Копировать ссылку';

  @override
  String get shareSession => 'Поделиться сессией';

  @override
  String get inviteByEmail => 'Пригласить по почте';

  @override
  String get inviteByLink => 'Пригласить по ссылке';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get profileEmail => 'Эл. почта';

  @override
  String get profileDisplayName => 'Отображаемое имя';

  @override
  String get profilePhotoUrl => 'Фото профиля';

  @override
  String get profileEditProfile => 'Редактировать профиль';

  @override
  String get profileReload => 'Перезагрузить';

  @override
  String get profilePersonalInfo => 'Личная информация';

  @override
  String get profileLastName => 'Фамилия';

  @override
  String get profileCompany => 'Компания';

  @override
  String get profileJobTitle => 'Должность';

  @override
  String get profileBio => 'О себе';

  @override
  String get profileSubscription => 'Подписка';

  @override
  String get profilePlan => 'Тарифный план';

  @override
  String get profileBillingCycle => 'Цикл оплаты';

  @override
  String get profilePrice => 'Цена';

  @override
  String get profileActivationDate => 'Дата активации';

  @override
  String get profileTrialEnd => 'Конец пробного периода';

  @override
  String get profileNextRenewal => 'Следующее продление';

  @override
  String get profileDaysRemaining => 'Осталось дней';

  @override
  String get profileUpgrade => 'Улучшить';

  @override
  String get profileUpgradePlan => 'Повысить тариф';

  @override
  String get planFree => 'Бесплатный';

  @override
  String get planPremium => 'Премиум';

  @override
  String get planElite => 'Элитный';

  @override
  String get statusActive => 'Активен';

  @override
  String get statusTrialing => 'Пробный период';

  @override
  String get statusPastDue => 'Просрочено';

  @override
  String get statusPaused => 'Приостановлено';

  @override
  String get statusCancelled => 'Отменен';

  @override
  String get statusExpired => 'Истек';

  @override
  String get cycleMonthly => 'Ежемесячно';

  @override
  String get cycleQuarterly => 'Ежеквартально';

  @override
  String get cycleYearly => 'Ежегодно';

  @override
  String get cycleLifetime => 'Бессрочно';

  @override
  String get pricePerMonth => 'мес.';

  @override
  String get pricePerQuarter => 'кварт.';

  @override
  String get pricePerYear => 'год';

  @override
  String get priceForever => 'навсегда';

  @override
  String get priceFree => 'Бесплатно';

  @override
  String get profileGeneralSettings => 'Общие настройки';

  @override
  String get profileAnimations => 'Анимации';

  @override
  String get profileAnimationsDesc => 'Включить анимации интерфейса';

  @override
  String get profileFeatures => 'Функции';

  @override
  String get profileCalendarIntegration => 'Интеграция с календарем';

  @override
  String get profileCalendarIntegrationDesc =>
      'Синхронизация спринтов и дедлайнов';

  @override
  String get profileExportSheets => 'Экспорт в Google Таблицы';

  @override
  String get profileExportSheetsDesc => 'Экспорт данных в таблицы';

  @override
  String get profileBetaFeatures => 'Бета-функции';

  @override
  String get profileBetaFeaturesDesc => 'Ранний доступ к новым функциям';

  @override
  String get profileAdvancedMetrics => 'Продвинутые метрики';

  @override
  String get profileAdvancedMetricsDesc => 'Подробная статистика и отчеты';

  @override
  String get profileNotifications => 'Уведомления';

  @override
  String get profileEmailNotifications => 'Уведомления по почте';

  @override
  String get profileEmailNotificationsDesc => 'Получать новости по почте';

  @override
  String get profilePushNotifications => 'Push-уведомления';

  @override
  String get profilePushNotificationsDesc => 'Браузерные уведомления';

  @override
  String get profileSprintReminders => 'Напоминания о спринтах';

  @override
  String get profileSprintRemindersDesc => 'Оповещения о сроках спринтов';

  @override
  String get profileSessionInvites => 'Приглашения в сессии';

  @override
  String get profileSessionInvitesDesc => 'Уведомления о новых сессиях';

  @override
  String get profileWeeklySummary => 'Еженедельный отчет';

  @override
  String get profileWeeklySummaryDesc => 'Отчет об активности за неделю';

  @override
  String get profileDangerZone => 'Опасная зона';

  @override
  String get profileDeleteAccount => 'Удалить аккаунт';

  @override
  String get profileDeleteAccountDesc =>
      'Запрос на безвозвратное удаление вашего аккаунта и всех связанных данных';

  @override
  String get profileDeleteAccountRequest => 'Запрос';

  @override
  String get profileDeleteAccountIrreversible =>
      'Это действие необратимо. Все ваши данные будут безвозвратно удалены.';

  @override
  String get profileDeleteAccountReason => 'Причина (необязательно)';

  @override
  String get profileDeleteAccountReasonHint =>
      'Почему вы хотите удалить свой аккаунт?';

  @override
  String get profileRequestDeletion => 'Запросить удаление';

  @override
  String get profileDeletionInProgress => 'Выполняется удаление';

  @override
  String profileDeletionRequestedAt(String date) {
    return 'Запрошено: $date';
  }

  @override
  String get profileCancelRequest => 'Отменить запрос';

  @override
  String get profileDeletionRequestSent => 'Запрос на удаление отправлен';

  @override
  String get profileDeletionRequestCancelled => 'Запрос отменен';

  @override
  String get profileUpdated => 'Профиль обновлен';

  @override
  String get profileLogout => 'Выйти';

  @override
  String get profileLogoutDesc => 'Отключить ваш аккаунт на этом устройстве';

  @override
  String get profileLogoutConfirm => 'Вы уверены, что хотите выйти?';

  @override
  String get profileSubscriptionCancelled => 'Подписка отменена';

  @override
  String get profileCancelSubscription => 'Отменить подписку';

  @override
  String get profileCancelSubscriptionConfirm =>
      'Вы уверены, что хотите отменить подписку? Вы продолжите пользоваться премиум-функциями до конца текущего периода.';

  @override
  String get profileKeepSubscription => 'Нет, оставить';

  @override
  String get profileYesCancel => 'Да, отменить';

  @override
  String profileUpgradeComingSoon(String plan) {
    return 'Обновление до тарифа $plan скоро будет доступно...';
  }

  @override
  String get profileFree => 'Free';

  @override
  String get profileMonthly => 'евро/мес.';

  @override
  String get profileUser => 'Пользователь';

  @override
  String profileErrorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get stateSaving => 'Сохранение...';

  @override
  String get cardCoffee => 'Перерыв';

  @override
  String get cardQuestion => 'Не знаю';

  @override
  String get toolEisenhower => 'Матрица Эйзенхауэра';

  @override
  String get toolEisenhowerDesc =>
      'Организуйте дела по срочности и важности. Квадранты помогут решить, что делать сейчас, запланировать, делегировать или исключить.';

  @override
  String get toolEisenhowerDescShort => 'Приоритизация по срочности и важности';

  @override
  String get toolEstimation => 'Комната оценки';

  @override
  String get toolEstimationDesc =>
      'Коллективные сессии оценки для команды. Planning Poker, оценка в футболках (T-shirt sizing) и другие методы для оценки пользовательских историй.';

  @override
  String get toolEstimationDescShort => 'Коллективные сессии оценки';

  @override
  String get toolSmartTodo => 'Умные задачи (Smart Todo)';

  @override
  String get toolSmartTodoDesc =>
      'Умные и совместные списки. Импорт из CSV/текста, приглашение участников и управление задачами с помощью продвинутых фильтров.';

  @override
  String get toolSmartTodoDescShort =>
      'Умные совместные списки. Импорт из CSV, приглашение и управление.';

  @override
  String get toolAgileProcess => 'Менеджер процессов Agile';

  @override
  String get toolAgileProcessDesc =>
      'Управление полными agile-проектами: бэклог, планирование спринтов, канбан-доска, метрики и ретроспективы.';

  @override
  String get toolAgileProcessDescShort =>
      'Управление проектами: бэклог, спринты, канбан и метрики.';

  @override
  String get toolRetro => 'Доска ретроспектив';

  @override
  String get toolRetroDesc =>
      'Сбор отзывов команды: что прошло хорошо, что нужно улучшить и какие действия предпринять.';

  @override
  String get toolRetroDescShort =>
      'Сбор отзывов команды о том, что прошло хорошо и что нужно улучшить.';

  @override
  String get homeUtilities => 'Инструменты';

  @override
  String get homeSelectTool => 'Выберите инструмент, чтобы начать';

  @override
  String get statusOnline => 'В сети';

  @override
  String get comingSoon => 'Скоро будет';

  @override
  String get featureComingSoon => 'Эта функция скоро появится!';

  @override
  String get featureSmartImport => 'Умный импорт';

  @override
  String get featureCollaboration => 'Сотрудничество';

  @override
  String get featureFilters => 'Фильтры';

  @override
  String get feature4Quadrants => '4 квадранта';

  @override
  String get featureDragDrop => 'Drag & Drop';

  @override
  String get featureCollaborative => 'Совместная работа';

  @override
  String get featurePlanningPoker => 'Planning Poker';

  @override
  String get featureTshirtSize => 'Размеры футболок';

  @override
  String get featureRealtime => 'Режим реального времени';

  @override
  String get featureScrum => 'Scrum';

  @override
  String get featureKanban => 'Kanban';

  @override
  String get featureHybrid => 'Гибридный';

  @override
  String get featureWentWell => 'Что прошло хорошо';

  @override
  String get featureToImprove => 'Что улучшить';

  @override
  String get featureActions => 'План действий';

  @override
  String get themeLightMode => 'Светлая тема';

  @override
  String get themeDarkMode => 'Темная тема';

  @override
  String get estimationBackToSessions => 'Назад к сессиям';

  @override
  String get estimationSessionSettings => 'Настройки сессии';

  @override
  String get estimationList => 'Список';

  @override
  String estimationSessionsCount(int filtered, int total) {
    return 'Ваши сессии ($filtered/$total)';
  }

  @override
  String get estimationNoSessionFound => 'Сессия не найдена';

  @override
  String get estimationCreateFirstSession =>
      'Создайте свою первую сессию оценки,\nчтобы оценивать задачи вместе с командой';

  @override
  String get estimationStoriesTotal => 'Всего историй';

  @override
  String get estimationStoriesCompleted => 'Выполнено историй';

  @override
  String get estimationParticipantsActive => 'Активные участники';

  @override
  String estimationProgress(int completed, int total, String percent) {
    return 'Прогресс: $completed из $total историй';
  }

  @override
  String get estimationStart => 'Начать';

  @override
  String get estimationComplete => 'Завершить';

  @override
  String get estimationAllStoriesEstimated => 'Все истории оценены!';

  @override
  String get estimationNoVotingInProgress => 'Голосование не проводится';

  @override
  String estimationCompletedLabel(
    int completed,
    int total,
    String total_estimate,
  ) {
    return 'Оценено: $completed из $total | Итоговая оценка: $total_estimate pt';
  }

  @override
  String estimationVoteStory(String title) {
    return 'Голосование: $title';
  }

  @override
  String get estimationAddStoriesToStart => 'Добавьте истории, чтобы начать';

  @override
  String get estimationInVoting => 'ИДЕТ ГОЛОСОВАНИЕ';

  @override
  String get estimationReveal => 'Раскрыть';

  @override
  String get estimationSkip => 'Пропустить';

  @override
  String get estimationStories => 'Истории';

  @override
  String get estimationAddStory => 'Добавить историю';

  @override
  String get estimationStartVoting => 'Начать голосование';

  @override
  String get estimationViewVotes => 'Посмотреть голоса';

  @override
  String get estimationViewDetail => 'Подробнее';

  @override
  String get estimationFinalEstimateLabel => 'Итоговая оценка:';

  @override
  String estimationVotesOf(String title) {
    return 'Голоса: $title';
  }

  @override
  String get estimationParticipantVotes => 'Голоса участников:';

  @override
  String get estimationPointsOrDays => 'очки / дни';

  @override
  String get estimationEstimateRationale =>
      'Обоснование оценки (необязательно)';

  @override
  String get estimationExplainRationale =>
      'Обоснуйте оценку...\nНапр.: высокая техническая сложность, внешние зависимости...';

  @override
  String get estimationRationaleHelp =>
      'Обоснование помогает команде помнить решения, принятые в процессе оценки.';

  @override
  String get estimationConfirmFinalEstimate => 'Подтвердить итоговую оценку';

  @override
  String get estimationEnterValidEstimate => 'Введите корректную оценку';

  @override
  String get estimationHintEstimate => 'Напр.: 5, 8, 13...';

  @override
  String get estimationStatus => 'Статус';

  @override
  String get estimationOrder => 'Порядок';

  @override
  String get estimationVotesReceived => 'Голосов получено';

  @override
  String get estimationAverageVotes => 'Средний балл';

  @override
  String get estimationConsensus => 'Консенсус';

  @override
  String get storyStatusPending => 'Ожидание';

  @override
  String get storyStatusVoting => 'Голосование';

  @override
  String get storyStatusRevealed => 'Голоса раскрыты';

  @override
  String get participantManagement => 'Управление участниками';

  @override
  String get participantCopySessionLink => 'Копировать ссылку на сессию';

  @override
  String get participantInvitesTab => 'Приглашения';

  @override
  String get participantSessionLink =>
      'Ссылка на сессию (поделитесь с участниками)';

  @override
  String get participantAddDirect =>
      'Добавить участника напрямую (напр. открытое голосование)';

  @override
  String get participantEmailRequired => 'Email *';

  @override
  String get participantEmailHint => 'email@example.com';

  @override
  String get participantNameHint => 'Отображаемое имя';

  @override
  String participantVotersAndObservers(int voters, int observers) {
    return 'Голосующих: $voters, наблюдателей: $observers';
  }

  @override
  String get participantYou => '(вы)';

  @override
  String get participantMakeVoter => 'Сделать голосующим';

  @override
  String get participantMakeObserver => 'Сделать наблюдателем';

  @override
  String get participantRemoveTitle => 'Удалить участника';

  @override
  String participantRemoveConfirm(String name) {
    return 'Вы уверены, что хотите удалить «$name» из этой сессии?';
  }

  @override
  String participantAddedToSession(String email) {
    return '$email добавлен(а) в сессию';
  }

  @override
  String participantRemovedFromSession(String name) {
    return '$name удален(а) из сессии';
  }

  @override
  String participantRoleUpdated(String email) {
    return 'Роль обновлена для $email';
  }

  @override
  String get participantFacilitator => 'Фасилитатор';

  @override
  String get inviteSendNew => 'Отправить новое приглашение';

  @override
  String get inviteRecipientEmail => 'Email получателя *';

  @override
  String get inviteCreate => 'Создать приглашение';

  @override
  String get invitesSent => 'Приглашения отправлены';

  @override
  String get inviteNoInvites => 'Приглашения не отправлены';

  @override
  String inviteCreatedFor(String email) {
    return 'Приглашение создано для $email';
  }

  @override
  String inviteSentTo(String email) {
    return 'Приглашение отправлено на почту $email';
  }

  @override
  String inviteExpiresIn(int days) {
    return 'Истекает через $days дн.';
  }

  @override
  String get inviteCopyLink => 'Копировать ссылку';

  @override
  String get inviteRevokeAction => 'Отозвать приглашение';

  @override
  String get inviteDeleteAction => 'Удалить приглашение';

  @override
  String get inviteRevokeTitle => 'Отозвать приглашение?';

  @override
  String inviteRevokeConfirm(String email) {
    return 'Вы уверены, что хотите отозвать приглашение для $email?';
  }

  @override
  String get inviteRevoke => 'Отозвать';

  @override
  String inviteRevokedFor(String email) {
    return 'Приглашение отозвано для $email';
  }

  @override
  String get inviteDeleteTitle => 'Удалить приглашение';

  @override
  String inviteDeleteConfirm(String email) {
    return 'Вы уверены, что хотите удалить приглашение для $email?\n\nЭто действие необратимо.';
  }

  @override
  String inviteDeletedFor(String email) {
    return 'Приглашение удалено для $email';
  }

  @override
  String get inviteLinkCopied => 'Ссылка скопирована!';

  @override
  String get linkCopied => 'Ссылка скопирована в буфер обмена';

  @override
  String get enterValidEmail => 'Введите корректный адрес электронной почты';

  @override
  String get sessionCreatedSuccess => 'Сессия успешно создана';

  @override
  String get sessionUpdated => 'Сессия обновлена';

  @override
  String get sessionDeleted => 'Сессия удалена';

  @override
  String get sessionStarted => 'Сессия начата';

  @override
  String get sessionCompletedSuccess => 'Сессия завершена';

  @override
  String get sessionNotFound => 'Сессия не найдена';

  @override
  String get storyAdded => 'Задача добавлена';

  @override
  String get storyDeleted => 'Задача удалена';

  @override
  String estimateSaved(String estimate) {
    return 'Оценка сохранена: $estimate';
  }

  @override
  String get deleteSessionTitle => 'Удалить сессию';

  @override
  String deleteSessionConfirm(String name, int count) {
    return 'Вы уверены, что хотите удалить «$name»?\nТакже будут удалены все истории ($count).';
  }

  @override
  String get deleteStoryTitle => 'Удалить задачу';

  @override
  String deleteStoryConfirm(String title) {
    return 'Вы уверены, что хотите удалить «$title»?';
  }

  @override
  String get errorLoadingSession => 'Ошибка при загрузке сессии';

  @override
  String get errorLoadingStories => 'Ошибка при загрузке задач';

  @override
  String get errorCreatingSession => 'Ошибка при создании сессии';

  @override
  String get errorUpdatingSession => 'Ошибка при обновлении';

  @override
  String get errorDeletingSession => 'Ошибка при удалении';

  @override
  String get errorAddingStory => 'Ошибка при добавлении задачи';

  @override
  String get errorStartingSession => 'Ошибка при запуске сессии';

  @override
  String get errorCompletingSession => 'Ошибка при завершении сессии';

  @override
  String get errorSubmittingVote => 'Ошибка при отправке голоса';

  @override
  String get errorRevealingVotes => 'Ошибка при раскрытии голосов';

  @override
  String get errorSavingEstimate => 'Ошибка при сохранении оценки';

  @override
  String get errorSkipping => 'Ошибка при пропуске';

  @override
  String get retroIcebreakerTitle => 'Ледокол: настроение команды';

  @override
  String get retroIcebreakerQuestion =>
      'Как вы себя чувствовали в этом спринте?';

  @override
  String retroParticipantsVoted(int count) {
    return 'Проголосовало участников: $count';
  }

  @override
  String get retroEndIcebreakerStartWriting =>
      'Завершить ледокол и начать писать';

  @override
  String get retroMoodTerrible => 'Ужасно';

  @override
  String get retroMoodBad => 'Плохо';

  @override
  String get retroMoodNeutral => 'Нейтрально';

  @override
  String get retroMoodGood => 'Хорошо';

  @override
  String get retroMoodExcellent => 'Отлично';

  @override
  String get actionSubmit => 'Отправить';

  @override
  String get retroIcebreakerOneWordTitle => 'Ледокол: одно слово';

  @override
  String get retroIcebreakerOneWordQuestion =>
      'Опишите этот спринт только ОДНИМ словом';

  @override
  String get retroIcebreakerOneWordHint => 'Ваше слово...';

  @override
  String get retroIcebreakerSubmitted => 'Отправлено!';

  @override
  String retroIcebreakerWordsSubmitted(int count) {
    return 'Отправлено слов: $count';
  }

  @override
  String get retroIcebreakerWeatherTitle => 'Ледокол: прогноз погоды';

  @override
  String get retroIcebreakerWeatherQuestion =>
      'Какая погода лучше всего описывает ваши чувства от этого спринта?';

  @override
  String get retroWeatherSunny => 'Солнечно';

  @override
  String get retroWeatherPartlyCloudy => 'Переменная облачность';

  @override
  String get retroWeatherCloudy => 'Облачно';

  @override
  String get retroWeatherRainy => 'Дождливо';

  @override
  String get retroWeatherStormy => 'Гроза';

  @override
  String get retroAgileCoach => 'Agile-коуч';

  @override
  String get retroCoachSetup =>
      'Выберите шаблон. «Начать/Прекратить/Продолжить» отлично подходит для новых команд. Убедитесь, что все присутствуют.';

  @override
  String get retroCoachIcebreaker =>
      'Растопите лед! Проведите быстрый круг, спрашивая «Как дела?», или используйте забавный вопрос.';

  @override
  String get retroCoachWriting =>
      'Мы находимся в режиме ИНКОГНИТО. Пишите карточки свободно, никто не увидит их до самого конца. Избегайте предвзятости!';

  @override
  String get retroCoachVoting =>
      'Время обзора! Все карточки видны. Прочитайте их и используйте свои 3 голоса, чтобы решить, что обсуждать.';

  @override
  String get retroCoachDiscuss =>
      'Сосредоточьтесь на карточках с наибольшим количеством голосов. Определите четкие пункты плана действий: Кто, что и к какому сроку делает?';

  @override
  String get retroCoachCompleted =>
      'Отличная работа! Ретроспектива завершена. Пункты плана действий отправлены в бэклог.';

  @override
  String retroStep(int step, String title) {
    return 'Шаг $step: $title';
  }

  @override
  String retroCurrentFocus(String title) {
    return 'Текущий фокус: $title';
  }

  @override
  String get retroCanvasMinColumns =>
      'Шаблон требует как минимум 4 колонки (стиль «Парусник»)';

  @override
  String retroAddTo(String title) {
    return 'Добавить в: $title';
  }

  @override
  String get retroNoColumnsConfigured => 'Колонки не настроены.';

  @override
  String get retroNewActionItem => 'Новый пункт плана действий';

  @override
  String get retroEditActionItem => 'Редактировать пункт плана';

  @override
  String get retroActionWhatToDo => 'Что именно нужно сделать?';

  @override
  String get retroActionDescriptionHint => 'Опишите конкретное действие...';

  @override
  String get retroActionRequired => 'Обязательно';

  @override
  String get retroActionLinkedCard => 'Связано с карточкой ретро (опционально)';

  @override
  String get retroActionNone => 'Нет';

  @override
  String get retroActionType => 'Тип действия';

  @override
  String get retroActionNoType => 'Без типа';

  @override
  String get retroActionAssignee => 'Исполнитель';

  @override
  String get retroActionNoAssignee => 'Нет';

  @override
  String get retroActionPriority => 'Приоритет';

  @override
  String get retroActionDueDate => 'Срок выполнения (дедлайн)';

  @override
  String get retroActionSelectDate => 'Выберите дату...';

  @override
  String get retroActionSupportResources => 'Необходимые ресурсы';

  @override
  String get retroActionResourcesHint =>
      'Инструменты, бюджет, дополнительные люди...';

  @override
  String get retroActionMonitoring => 'Способ контроля';

  @override
  String get retroActionMonitoringHint =>
      'Как мы проверим прогресс? (напр. Daily, Review...)';

  @override
  String get retroActionResourcesShort => 'Рес.';

  @override
  String get retroTableRef => 'Ссылка';

  @override
  String get retroTableSourceColumn => 'Колон.';

  @override
  String get retroTableDescription => 'Описание';

  @override
  String get retroTableOwner => 'Ответственный';

  @override
  String get retroTablePriority => 'Приоритет';

  @override
  String get retroTableDueDate => 'Срок';

  @override
  String get retroIcebreakerTwoTruths => 'Две правды, одна ложь';

  @override
  String get retroDescTwoTruths => 'Просто и классически.';

  @override
  String get retroIcebreakerCheckin => 'Эмоциональная проверка (Check-in)';

  @override
  String get retroDescCheckin => 'Как все себя чувствуют?';

  @override
  String get retroTableActions => 'Действия';

  @override
  String get retroSupportResources => 'Ресурсы поддержки';

  @override
  String get retroMonitoringMethod => 'Способ мониторинга';

  @override
  String get retroUnassigned => 'Не назначено';

  @override
  String get retroDeleteActionItem => 'Удалить пункт плана';

  @override
  String get retroChooseMethodology => 'Выберите методологию';

  @override
  String get retroHidingWhileTyping => 'Скрыто во время набора...';

  @override
  String retroVoteLimitReached(int max) {
    return 'Вы достигли лимита в $max голосов!';
  }

  @override
  String get retroAddCardHint => 'Поделитесь своими мыслями...';

  @override
  String get retroAddCard => 'Добавить карточку';

  @override
  String get retroTimeUp => 'Время вышло!';

  @override
  String get retroTimeUpMessage =>
      'Время этой фазы истекло. Завершите обсуждение или добавьте время.';

  @override
  String get retroTimeUpOk => 'ОК, понятно';

  @override
  String get retroStopTimer => 'Остановить таймер';

  @override
  String get retroStartTimer => 'Запустить таймер';

  @override
  String retroTimerMinutes(int minutes) {
    return '$minutes мин';
  }

  @override
  String get retroAddCardButton => 'Добавить карточку';

  @override
  String get retroDeleteRetro => 'Удалить ретроспективу';

  @override
  String get retroParticipantsLabel => 'Участники';

  @override
  String get retroNotesCreated => 'Заметки созданы';

  @override
  String retroStatusLabel(String status) {
    return 'Статус: $status';
  }

  @override
  String retroDateLabel(String date) {
    return 'Дата: $date';
  }

  @override
  String retroSprintDefault(int number) {
    return 'Спринт $number';
  }

  @override
  String get smartTodoNoTasks => 'В этом списке нет задач';

  @override
  String get smartTodoNoTasksInColumn => 'Нет задач';

  @override
  String smartTodoCompletionStats(int completed, int total) {
    return 'Выполнено $completed из $total';
  }

  @override
  String get smartTodoCreatedDate => 'Дата создания';

  @override
  String get smartTodoParticipantRole => 'Участник';

  @override
  String get smartTodoUnassigned => 'Не назначено';

  @override
  String get smartTodoNewTask => 'Новая задача';

  @override
  String get smartTodoEditTask => 'Редактировать задачу';

  @override
  String get smartTodoTaskTitle => 'Название задачи';

  @override
  String get smartTodoDescription => 'ОПИСАНИЕ';

  @override
  String get smartTodoDescriptionHint => 'Добавьте подробное описание...';

  @override
  String get smartTodoChecklist => 'СПИСОК';

  @override
  String get smartTodoAddChecklistItem => 'Добавить пункт';

  @override
  String get smartTodoEditItem => 'Редактировать пункт';

  @override
  String get smartTodoItemTitle => 'Название задачи';

  @override
  String get smartTodoAttachments => 'ВЛОЖЕНИЯ';

  @override
  String get smartTodoAddLink => 'Добавить ссылку';

  @override
  String get smartTodoComments => 'КОММЕНТАРИИ';

  @override
  String get smartTodoWriteComment => 'Напишите комментарий...';

  @override
  String get smartTodoAddImageTooltip => 'Добавить изображение (URL)';

  @override
  String get smartTodoStatus => 'СТАТУС';

  @override
  String get smartTodoPriority => 'ПРИОРИТЕТ';

  @override
  String get smartTodoAssignees => 'ИСПОЛНИТЕЛИ';

  @override
  String get smartTodoNoAssignee => 'Никто';

  @override
  String get smartTodoTags => 'ТЕГИ';

  @override
  String get smartTodoNoTags => 'Без тегов';

  @override
  String get smartTodoDueDate => 'СРОК';

  @override
  String get smartTodoSetDate => 'Установить дату';

  @override
  String get smartTodoEffort => 'ЗАТРАТЫ';

  @override
  String get smartTodoEffortHint => 'Очки (напр. 5)';

  @override
  String get smartTodoAssignTo => 'Назначить на';

  @override
  String get smartTodoSelectTags => 'Выбрать теги';

  @override
  String get smartTodoNoTagsAvailable => 'Нет доступных тегов';

  @override
  String get smartTodoNewSubtask => 'Новый статус';

  @override
  String get smartTodoAddLinkTitle => 'Добавить ссылку';

  @override
  String get smartTodoLinkName => 'Название';

  @override
  String get smartTodoLinkUrl => 'URL';

  @override
  String get smartTodoCannotOpenLink => 'Не удалось открыть ссылку';

  @override
  String get smartTodoPasteImage => 'Вставить изображение';

  @override
  String get smartTodoPasteImageFound => 'Найдено изображение в буфере обмена.';

  @override
  String get smartTodoPasteImageConfirm =>
      'Вы хотите добавить это изображение из буфера обмена?';

  @override
  String get smartTodoYesAdd => 'Да, добавить';

  @override
  String get smartTodoAddImage => 'Добавить изображение';

  @override
  String get smartTodoImageUrlHint =>
      'Вставьте URL изображения (напр. ссылку из CleanShot/Gyazo)';

  @override
  String get smartTodoImageUrl => 'URL изображения';

  @override
  String get smartTodoPasteFromClipboard => 'Вставить из буфера обмена';

  @override
  String get smartTodoEditComment => 'Редактировать';

  @override
  String get smartTodoSortBy => 'Сортировать по';

  @override
  String get smartTodoColumnSortTitle => 'Сортировать колонку';

  @override
  String get smartTodoPendingTasks => 'Задачи к выполнению';

  @override
  String get smartTodoCompletedTasks => 'Завершенные задачи';

  @override
  String get smartTodoEnterTitle => 'Введите название';

  @override
  String get smartTodoUser => 'Пользователь';

  @override
  String get smartTodoImportTasks => 'Импорт задач';

  @override
  String get smartTodoImportStep1 => 'Шаг 1: Выберите источник';

  @override
  String get smartTodoImportStep2 => 'Шаг 2: Сопоставьте колонки';

  @override
  String get smartTodoImportStep3 => 'Шаг 3: Проверка и подтверждение';

  @override
  String get smartTodoImportRetry => 'Повторить';

  @override
  String get smartTodoImportPasteText => 'Вставить текст (CSV/Txt)';

  @override
  String get smartTodoImportUploadFile => 'Загрузить файл (CSV)';

  @override
  String get smartTodoImportPasteHint =>
      'Вставьте задачи здесь. Используйте запятую как разделитель.';

  @override
  String get smartTodoImportPasteExample =>
      'напр. Купить молоко\nПозвонить Марио\nЗавершить отчет';

  @override
  String get smartTodoImportSelectFile => 'Выбрать CSV-файл';

  @override
  String smartTodoImportFileSelected(String fileName) {
    return 'Выбран файл: $fileName';
  }

  @override
  String smartTodoImportFileError(String error) {
    return 'Ошибка чтения файла: $error';
  }

  @override
  String get smartTodoImportNoData => 'Данные не найдены';

  @override
  String get smartTodoImportColumnMapping =>
      'Мы обнаружили следующие колонки. Сопоставьте каждую колонку с нужным полем.';

  @override
  String smartTodoImportColumnLabel(int index, String value) {
    return 'Колонка $index: «$value»';
  }

  @override
  String smartTodoImportSampleValue(String value) {
    return 'Пример значения: «$value»';
  }

  @override
  String smartTodoImportFoundTasks(int count) {
    return 'Найдено $count корректных задач. Проверьте их перед импортом.';
  }

  @override
  String get smartTodoImportDestinationColumn => 'Назначение:';

  @override
  String get smartTodoImportBack => 'Назад';

  @override
  String get smartTodoImportNext => 'Далее';

  @override
  String smartTodoImportButton(int count) {
    return 'Импортировать $count зад.';
  }

  @override
  String get smartTodoImportEnterText => 'Введите текст или загрузите файл.';

  @override
  String get smartTodoImportNoValidRows => 'Корректные строки не найдены.';

  @override
  String get smartTodoImportMapTitle =>
      'Нужно сопоставить как минимум поле «Название».';

  @override
  String smartTodoImportParsingError(String error) {
    return 'Ошибка разбора: $error';
  }

  @override
  String smartTodoImportSuccess(int count) {
    return 'Импортировано $count задач!';
  }

  @override
  String smartTodoImportError(String error) {
    return 'Ошибка импорта: $error';
  }

  @override
  String get smartTodoImportHelpTitle => 'Как импортировать задачи?';

  @override
  String get smartTodoImportHelpSimpleTitle =>
      'Простой список (одна задача на строку)';

  @override
  String get smartTodoImportHelpSimpleDesc =>
      'Вставьте простой список, где каждая строка — это название задачи.';

  @override
  String get smartTodoImportHelpSimpleExample =>
      'Купить молоко\nПозвонить Марио\nЗавершить отчет';

  @override
  String get smartTodoImportHelpCsvTitle => 'Формат CSV (с колонками)';

  @override
  String get smartTodoImportHelpCsvDesc =>
      'Используйте значения, разделенные запятыми, с заголовком. Первая строка определяет колонки.';

  @override
  String get smartTodoImportHelpCsvExample =>
      'заголовок,приоритет,исполнитель\nКупить молоко,высокий,mario@email.com\nПозвонить Марио,средний,';

  @override
  String get smartTodoImportHelpFieldsTitle => 'Доступные поля:';

  @override
  String get smartTodoImportHelpFieldTitle => 'Название задачи (обязательно)';

  @override
  String get smartTodoImportHelpFieldDesc => 'Описание задачи';

  @override
  String get smartTodoImportHelpFieldPriority => 'высокий, средний, низкий';

  @override
  String get smartTodoImportHelpFieldStatus =>
      'Название колонки (напр. К выполнению, В работе)';

  @override
  String get smartTodoImportHelpFieldAssignee => 'Email пользователя';

  @override
  String get smartTodoImportHelpFieldEffort => 'Часы (число)';

  @override
  String get smartTodoImportHelpFieldTags => 'Теги (#тег или через запятую)';

  @override
  String smartTodoImportStatusHint(String columns) {
    return 'Доступные колонки для СТАТУСА: $columns';
  }

  @override
  String get smartTodoImportEmptyColumn => '(пустая колонка)';

  @override
  String get smartTodoImportFieldIgnore => '-- Игнорировать --';

  @override
  String get smartTodoImportFieldTitle => 'Название';

  @override
  String get smartTodoImportFieldDescription => 'Описание';

  @override
  String get smartTodoImportFieldPriority => 'Приоритет';

  @override
  String get smartTodoImportFieldStatus => 'Статус (колон.)';

  @override
  String get smartTodoImportFieldAssignee => 'Исполнитель';

  @override
  String get smartTodoImportFieldEffort => 'Затраты';

  @override
  String get smartTodoImportFieldTags => 'Теги';

  @override
  String get smartTodoDeleteTaskTitle => 'Удалить задачу';

  @override
  String get smartTodoDeleteTaskContent =>
      'Вы уверены, что хотите удалить эту задачу? Это действие необратимо.';

  @override
  String get smartTodoDeleteNoPermission =>
      'У вас нет прав для удаления этой задачи';

  @override
  String get smartTodoSheetsExportTitle => 'Экспорт в Google Таблицы';

  @override
  String get smartTodoSheetsExportExists =>
      'Документ Google Таблиц уже существует для этого списка.';

  @override
  String get smartTodoSheetsOpen => 'Открыть';

  @override
  String get smartTodoSheetsUpdate => 'Обновить';

  @override
  String get smartTodoSheetsUpdating => 'Обновление Google Таблиц...';

  @override
  String get smartTodoSheetsCreating => 'Создание Google Таблиц...';

  @override
  String get smartTodoSheetsUpdated => 'Google Таблицы обновлены!';

  @override
  String get smartTodoSheetsCreated => 'Google Таблицы созданы!';

  @override
  String get smartTodoSheetsError => 'Ошибка при экспорте (см. лог)';

  @override
  String get error => 'Error';

  @override
  String smartTodoAuditLogTitle(String title) {
    return 'Журнал аудита — $title';
  }

  @override
  String get smartTodoAuditFilterUser => 'Пользователь';

  @override
  String get smartTodoAuditFilterType => 'Тип';

  @override
  String get smartTodoAuditFilterAction => 'Действие';

  @override
  String get smartTodoAuditFilterTag => 'Тег';

  @override
  String get smartTodoAuditFilterSearch => 'Поиск';

  @override
  String get smartTodoAuditFilterAll => 'Все';

  @override
  String get smartTodoAuditFilterAllFemale => 'Все';

  @override
  String get smartTodoAuditPremiumRequired =>
      'Требуется Premium для расширенной истории';

  @override
  String smartTodoAuditLastDays(int days) {
    return 'За последние $days дн.';
  }

  @override
  String get smartTodoAuditClearFilters => 'Сбросить фильтры';

  @override
  String get smartTodoAuditViewTimeline => 'Временная шкала';

  @override
  String get smartTodoAuditViewColumns => 'Вид колонок';

  @override
  String get smartTodoAuditNoActivity => 'Активность не записана';

  @override
  String get smartTodoAuditNoResults =>
      'Нет результатов для выбранных фильтров';

  @override
  String smartTodoAuditActivities(int count) {
    return 'Активностей: $count';
  }

  @override
  String get smartTodoAuditNoUserActivity => 'Нет активности';

  @override
  String get smartTodoAuditLoadMore => 'Загрузить еще 50...';

  @override
  String get smartTodoAuditEmptyValue => '(пусто)';

  @override
  String get smartTodoAuditEntityList => 'Список';

  @override
  String get smartTodoAuditEntityTask => 'Задача';

  @override
  String get smartTodoAuditEntityInvite => 'Приглашение';

  @override
  String get smartTodoAuditEntityParticipant => 'Участник';

  @override
  String get smartTodoAuditEntityColumn => 'Колонка';

  @override
  String get smartTodoAuditEntityTag => 'Тег';

  @override
  String get smartTodoAuditActionCreate => 'Создано';

  @override
  String get smartTodoAuditActionUpdate => 'Обновлено';

  @override
  String get smartTodoAuditActionDelete => 'Удалено';

  @override
  String get smartTodoAuditActionArchive => 'Архивировано';

  @override
  String get smartTodoAuditActionRestore => 'Восстановлено';

  @override
  String get smartTodoAuditActionMove => 'Перемещено';

  @override
  String get smartTodoAuditActionAssign => 'Назначено';

  @override
  String get smartTodoAuditActionInvite => 'Приглашен';

  @override
  String get smartTodoAuditActionJoin => 'Присоединился';

  @override
  String get smartTodoAuditActionRevoke => 'Отозвано';

  @override
  String get smartTodoAuditActionReorder => 'Изменен порядок';

  @override
  String get smartTodoAuditActionBatchCreate => 'Импорт';

  @override
  String get smartTodoAuditTimeNow => 'Сейчас';

  @override
  String smartTodoAuditTimeMinutesAgo(int count) {
    return '$count мин. назад';
  }

  @override
  String smartTodoAuditTimeHoursAgo(int count) {
    return '$count ч. назад';
  }

  @override
  String smartTodoAuditTimeDaysAgo(int count) {
    return '$count дн. назад';
  }

  @override
  String get smartTodoCfdTitle => 'Аналитика CFD';

  @override
  String get smartTodoCfdTooltip => 'Аналитика CFD';

  @override
  String get smartTodoCfdDateRange => 'Диапазон дат:';

  @override
  String get smartTodoCfd7Days => '7 дней';

  @override
  String get smartTodoCfd14Days => '14 дней';

  @override
  String get smartTodoCfd30Days => '30 дней';

  @override
  String get smartTodoCfd90Days => '90 дней';

  @override
  String get smartTodoCfdError => 'Ошибка загрузки аналитики';

  @override
  String get smartTodoCfdRetry => 'Обновить';

  @override
  String get smartTodoCfdNoData => 'Нет данных';

  @override
  String get smartTodoCfdNoDataHint =>
      'Здесь будут отслеживаться перемещения задач';

  @override
  String get smartTodoCfdKeyMetrics => 'Ключевые показатели';

  @override
  String get smartTodoCfdLeadTime => 'Lead Time (время выполнения)';

  @override
  String get smartTodoCfdLeadTimeTooltip =>
      'Время от создания задачи до завершения';

  @override
  String get smartTodoCfdCycleTime => 'Cycle Time (время цикла)';

  @override
  String get smartTodoCfdCycleTimeTooltip =>
      'Время от начала работы до завершения';

  @override
  String get smartTodoCfdThroughput => 'Throughput (пропускная способность)';

  @override
  String get smartTodoCfdThroughputTooltip => 'Задач выполнено за неделю';

  @override
  String get smartTodoCfdWip => 'WIP';

  @override
  String get smartTodoCfdWipTooltip => 'Задачи в работе';

  @override
  String get smartTodoCfdLimit => 'Лимит';

  @override
  String get smartTodoCfdCompleted => 'завершено';

  @override
  String get smartTodoCfdFlowAnalysis => 'Анализ потока';

  @override
  String get smartTodoCfdArrived => 'Поступило';

  @override
  String get smartTodoCfdBacklogShrinking => 'Бэклог уменьшается';

  @override
  String get smartTodoCfdBacklogGrowing => 'Бэклог растет';

  @override
  String get smartTodoCfdBottlenecks => 'Обнаружение узких мест';

  @override
  String get smartTodoCfdNoBottlenecks => 'Узких мест не обнаружено';

  @override
  String get smartTodoCfdTasks => 'задач';

  @override
  String get smartTodoCfdAvgAge => 'Средний возраст';

  @override
  String get smartTodoCfdAgingWip => 'Стареющие задачи в работе';

  @override
  String get smartTodoCfdTask => 'Задача';

  @override
  String get smartTodoCfdColumn => 'Колонка';

  @override
  String get smartTodoCfdAge => 'Возраст';

  @override
  String get smartTodoCfdDays => 'дн.';

  @override
  String get smartTodoCfdHowCalculated => 'Как это рассчитывается?';

  @override
  String get smartTodoCfdMedian => 'Медиана';

  @override
  String get smartTodoCfdP85 => 'P85';

  @override
  String get smartTodoCfdP95 => 'P95 (95-й процентиль)';

  @override
  String get smartTodoCfdMin => 'Мин.';

  @override
  String get smartTodoCfdMax => 'Макс.';

  @override
  String get smartTodoCfdSample => 'Выборка';

  @override
  String get smartTodoCfdVsPrevious => 'отн. прошл. периода';

  @override
  String get smartTodoCfdArrivalRate => 'Скорость поступления';

  @override
  String get smartTodoCfdCompletionRate => 'Скорость завершения';

  @override
  String get smartTodoCfdNetFlow => 'Чистый поток';

  @override
  String get smartTodoCfdPerDay => '/день';

  @override
  String get smartTodoCfdPerWeek => '/нед.';

  @override
  String get smartTodoCfdSeverity => 'Критичность';

  @override
  String get smartTodoCfdAssignee => 'Исполнитель';

  @override
  String get smartTodoCfdUnassigned => 'Не назначено';

  @override
  String get smartTodoCfdLeadTimeExplanation =>
      'Lead Time измеряет общее время с момента создания задачи до ее завершения.\n\n**Формула:**\nLead Time = Дата завершения - Дата создания\n\n**Показатели:**\n- **Среднее**: Среднее арифметическое всех значений Lead Time\n- **Медиана**: Среднее значение (менее чувствительно к выбросам)\n- **P85**: 85% задач завершаются в течение этого времени\n- **P95**: 95% задач завершаются в течение этого времени\n\n**Почему это важно:**\nLead Time представляет то, что видит клиент — общее время ожидания. Используйте P85 при оценке сроков доставки для клиентов.';

  @override
  String get smartTodoCfdCycleTimeExplanation =>
      'Cycle Time измеряет время с момента фактического начала работы (когда задача покидает колонку «К выполнению») до завершения.\n\n**Формула:**\nCycle Time = Дата завершения - Дата начала первой работы\n\n**Отличие от Lead Time:**\n- **Lead Time** = Взгляд клиента (включает ожидание)\n- **Cycle Time** = Взгляд команды (только активная работа)\n\n**Как определяется «Начало работы»:**\nМомент первого перемещения задачи из колонки «К выполнению» фиксируется как дата начала работы.';

  @override
  String get smartTodoCfdThroughputExplanation =>
      'Throughput измеряет, сколько задач завершается за единицу времени.\n\n**Формулы:**\n- Среднее за день = Завершенные задачи / Дни в периоде\n- Среднее за неделю = Среднее за день × 7\n\n**Как это использовать:**\nПрогнозирование дат поставки:\nОставшиеся задачи / Еженедельный Throughput = Недель до завершения\n\n**Пример:**\nОсталось 30 задач, Throughput 10 задач в неделю = потребуется ~3 недели';

  @override
  String get smartTodoCfdWipExplanation =>
      'WIP (Work In Progress) учитывает задачи, над которыми сейчас ведется работа — они не в колонке «К выполнению» и не в «Готово».\n\n**Формула:**\nWIP = Всего задач - Задачи в «К выполнению» - Задачи в «Готово»\n\n**Закон Литтла:**\nLead Time = WIP / Throughput\n\nСнижение WIP напрямую сокращает Lead Time!\n\n**Рекомендуемый лимит WIP:**\nРазмер команды × 2 (лучшая практика Канбан)\n\n**Статус:**\n- В норме: WIP ≤ Лимит\n- Внимание: WIP > Лимит × 1.25\n- Критично: WIP > Лимит × 1.5';

  @override
  String get smartTodoCfdFlowExplanation =>
      'Анализ потока сравнивает скорость поступления новых задач и скорость их завершения.\n\n**Формулы:**\n- Скорость поступления = Новые задачи / Дни\n- Скорость завершения = Завершенные задачи / Дни\n- Чистый поток (Net Flow) = Завершено - Поступило\n\n**Интерпретация статуса:**\n- **Осушение** (Завершено > Поступило): WIP уменьшается — отлично!\n- **Сбалансировано** (в пределах ±10%): Стабильный поток\n- **Наполнение** (Поступило > Завершено): WIP растет — требуется действие';

  @override
  String get smartTodoCfdBottleneckExplanation =>
      'Обнаружение узких мест выявляет колонки, где задачи накапливаются или задерживаются слишком долго.\n\n**Алгоритм:**\nКритичность = (Балл кол-ва + Балл возраста) / 2\n\nГде:\n- Балл кол-ва = Задач в колонке / 10\n- Балл возраста = Средний возраст / 7 дней\n\n**Помечается при:**\n- 2+ задачи в колонке ИЛИ\n- Средний возраст > 2 дней\n\n**Уровни критичности:**\n- Низкий (< 0.3): Наблюдать\n- Средний (0.3-0.6): Исследовать\n- Высокий (> 0.6): Принять меры';

  @override
  String get smartTodoCfdAgingExplanation =>
      'Aging WIP показывает задачи, которые сейчас находятся в работе, отсортированные по времени их выполнения.\n\n**Формула:**\nВозраст = Текущее время - Дата начала работы (в днях)\n\n**Статус по возрасту:**\n- Свежие (< 3 дней): Норма\n- Внимание (3-7 дней): Может потребоваться внимание\n- Критично (> 7 дней): Вероятно заблокировано — исследуйте!\n\nСтарые задачи часто указывают на блокировщики, неясные требования или раздувание рамок проекта.';

  @override
  String get smartTodoCfdTeamBalance => 'Баланс команды';

  @override
  String get smartTodoCfdTeamBalanceExplanation =>
      'Баланс команды показывает распределение задач между участниками.\n\n**Балл баланса:**\nРассчитывается с использованием коэффициента вариации (CV).\nБалл = 1 / (1 + CV)\n\n**Статус:**\n- Сбалансировано (≥80%): Работа распределена равномерно\n- Неравномерно (50-80%): Есть небольшой дисбаланс\n- Дисбаланс (<50%): Значительное различие в нагрузке\n\n**Колонки:**\n- К выполнению: Задачи, ожидающие начала\n- В работе: Задачи в процессе выполнения\n- Готово: Завершенные задачи';

  @override
  String get smartTodoCfdBalanced => 'Сбалансировано';

  @override
  String get smartTodoCfdUneven => 'Неравномерно';

  @override
  String get smartTodoCfdImbalanced => 'Дисбаланс';

  @override
  String get smartTodoCfdMember => 'Участник';

  @override
  String get smartTodoCfdTotal => 'Всего';

  @override
  String get smartTodoCfdToDo => 'К выполнению';

  @override
  String get smartTodoCfdInProgress => 'В работе';

  @override
  String get smartTodoCfdDone => 'Готово';

  @override
  String get smartTodoNewTaskDefault => 'Новая задача';

  @override
  String get smartTodoRename => 'Переименовать';

  @override
  String get smartTodoAddActivity => 'Добавить действие';

  @override
  String get smartTodoAddColumn => 'Добавить колонку';

  @override
  String get smartTodoParticipantManagement => 'Управление участниками';

  @override
  String get smartTodoParticipantsTab => 'Участники';

  @override
  String get smartTodoInvitesTab => 'Приглашения';

  @override
  String get smartTodoAddParticipant => 'Добавить участника';

  @override
  String smartTodoMembers(int count) {
    return 'Участников ($count)';
  }

  @override
  String get smartTodoNoInvitesPending => 'Нет ожидающих приглашений';

  @override
  String smartTodoRoleLabel(String role) {
    return 'Роль: $role';
  }

  @override
  String get smartTodoExpired => 'ИСТЕКЛО';

  @override
  String smartTodoSentBy(String name) {
    return 'Отправлено: $name';
  }

  @override
  String get smartTodoResendEmail => 'Отправить email повторно';

  @override
  String get smartTodoRevoke => 'Отозвать';

  @override
  String get smartTodoSendingEmail => 'Отправка email...';

  @override
  String get smartTodoEmailResent => 'Email отправлен повторно!';

  @override
  String get smartTodoEmailSendError => 'Ошибка при отправке email.';

  @override
  String get smartTodoInvalidSession =>
      'Некорректная сессия для отправки email.';

  @override
  String get smartTodoEmail => 'Электронная почта';

  @override
  String get smartTodoRole => 'Роль';

  @override
  String get smartTodoInviteCreated =>
      'Приглашение создано и успешно отправлено!';

  @override
  String get smartTodoInviteCreatedNoEmail =>
      'Приглашение создано, но email не отправлен (проверьте права доступа Google).';

  @override
  String get smartTodoUserAlreadyInvited => 'Пользователь уже приглашен.';

  @override
  String get smartTodoInviteCollaborator => 'Пригласить соавтора';

  @override
  String get smartTodoEditorRole => 'Редактор (может редактировать)';

  @override
  String get smartTodoViewerRole => 'Наблюдатель (только чтение)';

  @override
  String get smartTodoSendEmailNotification => 'Отправить email-уведомление';

  @override
  String get smartTodoSend => 'Отправить';

  @override
  String get smartTodoInvalidEmail => 'Некорректный email';

  @override
  String get smartTodoUserNotAuthenticated =>
      'Пользователь не аутентифицирован или отсутствует email';

  @override
  String get smartTodoGoogleLoginRequired =>
      'Для отправки писем требуется вход через Google';

  @override
  String smartTodoInviteSent(String email) {
    return 'Приглашение отправлено на $email';
  }

  @override
  String get smartTodoUserAlreadyInvitedOrPending =>
      'Пользователь уже приглашен или ожидается подтверждение.';

  @override
  String get smartTodoFilterToday => 'Сегодня';

  @override
  String get smartTodoFilterMyTasks => 'Мои задачи';

  @override
  String get smartTodoFilterOwner => 'Владелец';

  @override
  String get smartTodoViewGlobalTasks => 'Все задачи';

  @override
  String get smartTodoViewLists => 'Списки';

  @override
  String get smartTodoNewListDialogTitle => 'Новый список';

  @override
  String get smartTodoTitleLabel => 'Название *';

  @override
  String get smartTodoDescriptionLabel => 'Описание';

  @override
  String get smartTodoCancel => 'Отмена';

  @override
  String get smartTodoCreate => 'Создать';

  @override
  String get smartTodoSave => 'Сохранить';

  @override
  String get smartTodoNoListsPresent => 'Нет доступных списков';

  @override
  String get smartTodoCreateFirstList =>
      'Создайте свой первый список, чтобы начать';

  @override
  String smartTodoMembersCount(int count) {
    return 'Участников: $count';
  }

  @override
  String get smartTodoRenameListTitle => 'Переименовать список';

  @override
  String get smartTodoNewNameLabel => 'Новое название';

  @override
  String get smartTodoDeleteListTitle => 'Удалить список';

  @override
  String get smartTodoDeleteListConfirm =>
      'Вы уверены, что хотите удалить этот список и все задачи в нем? Это действие необратимо.';

  @override
  String get smartTodoDelete => 'Удалить';

  @override
  String get smartTodoEdit => 'Редактировать';

  @override
  String get smartTodoSearchHint => 'Поиск списков...';

  @override
  String get smartTodoSearchTasksHint => 'Поиск...';

  @override
  String smartTodoNoSearchResults(String query) {
    return 'Нет результатов по запросу «$query»';
  }

  @override
  String get smartTodoColumnTodo => 'К выполнению';

  @override
  String get smartTodoColumnInProgress => 'В работе';

  @override
  String get smartTodoColumnDone => 'Готово';

  @override
  String get smartTodoAllPeople => 'Все участники';

  @override
  String smartTodoPeopleCount(int count) {
    return 'Участников: $count';
  }

  @override
  String get smartTodoFilterByPerson => 'Фильтр по участнику';

  @override
  String get smartTodoApplyFilters => 'Применить фильтры';

  @override
  String get smartTodoAllTags => 'Все теги';

  @override
  String smartTodoTagsCount(int count) {
    return 'Тегов: $count';
  }

  @override
  String get smartTodoFilterByTag => 'Фильтр по тегу';

  @override
  String get smartTodoTagAlreadyExists => 'Тег уже существует';

  @override
  String smartTodoError(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get profileMenuTitle => 'Профиль';

  @override
  String get profileMenuLogout => 'Выйти';

  @override
  String get profileLogoutDialogTitle => 'Выйти';

  @override
  String get profileLogoutDialogConfirm => 'Вы уверены, что хотите выйти?';

  @override
  String get agileAddToSprint => 'Добавить в спринт';

  @override
  String get agileEstimated => 'Оценено';

  @override
  String get agilePoints => 'pts';

  @override
  String agilePointsValue(int points) {
    return '$points pts';
  }

  @override
  String get agileGuide => 'Руководство';

  @override
  String get backlogProductBacklog => 'Бэклог продукта';

  @override
  String get backlogArchiveCompleted => 'Архив выполненного';

  @override
  String get backlogStories => 'историй';

  @override
  String get backlogEstimated => 'оценено';

  @override
  String get backlogShowActive => 'Показать активный бэклог';

  @override
  String backlogShowArchive(int count) {
    return 'Показать архив ($count завершено)';
  }

  @override
  String get backlogTab => 'Бэклог';

  @override
  String backlogArchiveTab(int count) {
    return 'Архив ($count)';
  }

  @override
  String get backlogFilters => 'Фильтры';

  @override
  String get backlogNewStory => 'Новая история';

  @override
  String get backlogSearchHint => 'Поиск по названию, описанию или ID...';

  @override
  String get backlogStatusFilter => 'Status: ';

  @override
  String get backlogPriorityFilter => 'Priority: ';

  @override
  String get backlogTagFilter => 'Tag: ';

  @override
  String get backlogAllStatuses => 'Все';

  @override
  String get backlogAllPriorities => 'Все';

  @override
  String get backlogRemoveFilters => 'Сбросить фильтры';

  @override
  String get backlogNoStoryFound => 'История не найдена';

  @override
  String get sprintBacklog => 'Бэклог спринта';

  @override
  String get scrumToDo => 'К выполнению';

  @override
  String get agileStatusRefinement => 'Уточнение';

  @override
  String get agileStatusReady => 'Готово к работе';

  @override
  String get agileStatusInProgress => 'В работе';

  @override
  String get agileStatusInReview => 'На проверке';

  @override
  String get agileStatusDone => 'Готово';

  @override
  String get backlog => 'Бэклог';

  @override
  String get kanbanPolicySortPriority => 'Сортировать по бизнес-приоритету';

  @override
  String get kanbanPolicyMax2Days => 'Макс. 2 дня в этой колонке';

  @override
  String get kanbanPolicyReqAcceptance => 'Требуются критерии приемки';

  @override
  String get kanbanPolicyItemReady => 'Элемент готов к работе';

  @override
  String get kanbanPolicyEstimationsDone => 'Оценка завершена (если требуется)';

  @override
  String get kanbanPolicyMax1PerPerson => 'Макс. 1 элемент на человека';

  @override
  String kanbanPolicyMax1PerPersonParam(int count) {
    return 'Макс. $count элементов на человека';
  }

  @override
  String get kanbanPolicyDailyUpdate => 'Ежедневное обновление обязательно';

  @override
  String get kanbanPolicyMax24h => 'Макс. 24 часа в этой колонке';

  @override
  String kanbanPolicyMaxHoursParam(int count) {
    return 'Макс. $count ч. в этой колонке';
  }

  @override
  String kanbanPolicyMaxDaysParam(int count) {
    return 'Макс. $count дн. в этой колонке';
  }

  @override
  String get kanbanPolicyReqCodeReview => 'Требуется одобренное код-ревью';

  @override
  String get kanbanPolicyAllAcceptanceMet => 'Все критерии приемки выполнены';

  @override
  String get kanbanPolicyCheckTitle => 'Проверка правил';

  @override
  String get kanbanPolicyCheckMessage =>
      'Это действие нарушает следующие правила:';

  @override
  String get kanbanPolicyCheckProceed => 'Все равно продолжить';

  @override
  String get kanbanPolicyCheckCancel => 'Отменить и исправить';

  @override
  String get kanbanPolicyActiveLabel => 'Активная проверка';

  @override
  String get kanbanPolicyViolationTitle => 'Нарушение правил';

  @override
  String get kanbanPolicyViolationMessage => 'При перемещении ';

  @override
  String get kanbanPolicyViolationTo => ' в ';

  @override
  String get kanbanPolicyViolationViolations => ' вы нарушаете:';

  @override
  String get kanbanPolicySettingMaxHours => 'Макс. количество часов';

  @override
  String get kanbanPolicySettingMaxDays => 'Макс. количество дней';

  @override
  String get kanbanPolicySettingMaxItems => 'Макс. количество';

  @override
  String get kanbanPolicyUnitHours => 'Часы';

  @override
  String get kanbanPolicyUnitDays => 'Дни';

  @override
  String get kanbanPolicyHelpConfigurable =>
      'Теперь для каждой колонки можно настроить лимиты времени и индивидуальные WIP-лимиты.';

  @override
  String get kanbanPolicyMovingTip =>
      'Вы можете продолжить, если считаете это допустимым исключением.';

  @override
  String get kanbanMoveAnyway => 'Все равно переместить';

  @override
  String get backlogEmpty => 'Бэклог пуст';

  @override
  String get backlogAddFirstStory => 'Добавьте первую User Story';

  @override
  String get kanbanWipExceeded =>
      'Лимит WIP превышен! Завершите текущие задачи перед началом новых.';

  @override
  String get kanbanInfo => 'Инфо';

  @override
  String get kanbanConfigureWip => 'Настроить WIP';

  @override
  String kanbanWipTooltip(int current, int max) {
    return 'WIP: $current из макс. $max';
  }

  @override
  String get kanbanNoWipLimit => 'Без лимита WIP';

  @override
  String get kanbanWipWhyTitle => 'Зачем их использовать?';

  @override
  String get kanbanWipReasonFocus =>
      'Уменьшить многозадачность и повысить фокус';

  @override
  String get kanbanWipReasonBottlenecks => 'Выявить «узкие места»';

  @override
  String get kanbanWipReasonFlow => 'Улучшить рабочий процесс';

  @override
  String get kanbanWipReasonSpeed => 'Ускорить завершение задач';

  @override
  String get kanbanWipOverLimitTitle => 'Что делать, если лимит превышен?';

  @override
  String get kanbanWipOverLimitStep1 =>
      '1. Завершите или переместите текущие задачи перед началом новых';

  @override
  String get kanbanWipOverLimitStep2 =>
      '2. Помогите коллегам разблокировать задачи на проверке';

  @override
  String get kanbanWipOverLimitStep3 =>
      '3. Проанализируйте, почему лимит был превышен';

  @override
  String get kanbanWipMovingTip =>
      'Совет: завершите или переместите другие задачи перед началом новых для поддержания оптимального потока.';

  @override
  String kanbanItems(int count) {
    return 'Элементов: $count';
  }

  @override
  String get kanbanEmpty => 'Пусто';

  @override
  String kanbanWipLimitTitle(String column) {
    return 'Лимит WIP: $column';
  }

  @override
  String get kanbanWipLimitDesc =>
      'Укажите максимальное количество задач, которые могут находиться в этой колонке одновременно.';

  @override
  String get kanbanWipLimitLabel => 'Лимит WIP';

  @override
  String get kanbanWipLimitHint => 'Оставьте пустым, если лимита нет';

  @override
  String kanbanWipLimitSuggestion(int count) {
    return 'Предложение: начните с $count и корректируйте в зависимости от команды.';
  }

  @override
  String get kanbanRemoveLimit => 'Удалить лимит';

  @override
  String get kanbanWipExceededTitle => 'Лимит WIP превышен';

  @override
  String get kanbanWipExceededMessage => 'Перемещение ';

  @override
  String get kanbanWipExceededIn => ' в ';

  @override
  String get kanbanWipExceededWillExceed => ' превысит лимит WIP.';

  @override
  String kanbanColumnLabel(String name) {
    return 'Колонка: $name';
  }

  @override
  String kanbanCurrentCount(int current, int limit) {
    return 'Текущий: $current | Лимит: $limit';
  }

  @override
  String kanbanAfterMove(int count) {
    return 'После перемещения: $count';
  }

  @override
  String get kanbanSuggestion =>
      'Подсказка: завершите или переместите другие задачи перед началом новых, чтобы поддерживать оптимальный рабочий поток.';

  @override
  String get kanbanWipExplanationTitle => 'Что такое лимиты WIP?';

  @override
  String get kanbanWipWhat => 'Что такое лимиты WIP?';

  @override
  String get kanbanWipWhatDesc =>
      'Лимиты WIP (Work In Progress) — это ограничения на количество задач, которые могут находиться в колонке одновременно.';

  @override
  String get kanbanWipWhy => 'Зачем их использовать?';

  @override
  String get kanbanWipBenefit1 =>
      '— Уменьшение многозадачности и повышение фокуса';

  @override
  String get kanbanWipBenefit2 => '— Выявление «узких мест»';

  @override
  String get kanbanWipBenefit3 => '— Улучшение рабочего процесса';

  @override
  String get kanbanWipBenefit4 => '— Ускорение завершения задач';

  @override
  String get kanbanWipWhatToDo => 'Что делать, если лимит превышен?';

  @override
  String get kanbanWipWhatToDoDesc =>
      '1. Завершите или переместите текущие задачи перед началом новых\n2. Помогите коллегам разблокировать задачи на проверке\n3. Проанализируйте, почему лимит был превышен';

  @override
  String get kanbanUnderstood => 'Понятно';

  @override
  String sprintTitle(int count) {
    return 'Спринт ($count)';
  }

  @override
  String get sprintNew => 'Новый спринт';

  @override
  String get sprintNoSprints => 'Нет спринтов';

  @override
  String get sprintCreateFirst => 'Создайте первый спринт, чтобы начать';

  @override
  String sprintNumber(int number) {
    return 'Спринт $number';
  }

  @override
  String get sprintStart => 'Запустить спринт';

  @override
  String get sprintComplete => 'Завершить спринт';

  @override
  String sprintDays(int days) {
    return '$days дн.';
  }

  @override
  String sprintStoriesCount(int count) {
    return '$count';
  }

  @override
  String get sprintStoriesLabel => 'историй';

  @override
  String get sprintPointsPlanned => 'очков';

  @override
  String get sprintPointsCompleted => 'завершено';

  @override
  String get sprintVelocity => 'скорость';

  @override
  String sprintDaysRemaining(int days) {
    return 'осталось $days дн.';
  }

  @override
  String get sprintStartButton => 'Старт';

  @override
  String get sprintCompleteActiveFirst =>
      'Завершите активный спринт перед началом нового';

  @override
  String get sprintPlanningAlreadyExists =>
      'Спринт уже находится на этапе планирования. Удалите его или запустите перед созданием нового.';

  @override
  String get sprintDeletePlanningTitle => 'Удалить планируемый спринт';

  @override
  String sprintDeletePlanningConfirm(String sprintName) {
    return 'Вы хотите удалить спринт «$sprintName»? Связанные истории будут возвращены в бэклог.';
  }

  @override
  String sprintDeletedSuccess(String sprintName) {
    return 'Спринт «$sprintName» удален. Истории были возвращены в бэклог.';
  }

  @override
  String get sprintEditTitle => 'Редактировать спринт';

  @override
  String get sprintNewTitle => 'Новый спринт';

  @override
  String get sprintNameLabel => 'Название спринта';

  @override
  String get sprintNameHint => 'напр. Спринт 1 — MVP';

  @override
  String get sprintNameRequired => 'Введите название';

  @override
  String get sprintGoalLabel => 'Цель спринта';

  @override
  String get sprintGoalHint => 'Задача на спринт';

  @override
  String get sprintStartDateLabel => 'Дата начала';

  @override
  String get sprintEndDateLabel => 'Дата окончания';

  @override
  String sprintDuration(int days) {
    return 'Продолжительность: $days дн.';
  }

  @override
  String sprintAverageVelocity(String velocity) {
    return 'Средняя скорость: $velocity очков/спринт';
  }

  @override
  String sprintTeamMembers(int count) {
    return 'Команда: $count участников';
  }

  @override
  String get sprintPlanningTitle => 'Планирование спринта';

  @override
  String get sprintPlanningSubtitle =>
      'Выберите истории для выполнения в этом спринте';

  @override
  String get sprintPlanningSelected => 'Выбрано';

  @override
  String get sprintPlanningSuggested => 'Рекомендуется';

  @override
  String get sprintPlanningCapacity => 'Емкость';

  @override
  String get sprintPlanningBasedOnVelocity => 'на основе средней скорости';

  @override
  String sprintPlanningDays(int days) {
    return '$days дн.';
  }

  @override
  String get sprintPlanningExceeded =>
      'Внимание: рекомендуемая скорость превышена';

  @override
  String get sprintPlanningNoStories => 'В бэклоге нет доступных историй';

  @override
  String get sprintPlanningNotEstimated => 'Без оценки';

  @override
  String sprintPlanningConfirm(int count) {
    return 'Подтвердить ($count историй)';
  }

  @override
  String get storyFormEditTitle => 'Редактировать задачу';

  @override
  String get storyFormNewTitle => 'Новая User Story';

  @override
  String get storyFormDetailsTab => 'Детали';

  @override
  String get storyFormAcceptanceTab => 'Приемка';

  @override
  String get storyFormOtherTab => 'Прочее';

  @override
  String get storyFormTitleLabel => 'Заголовок *';

  @override
  String get storyFormTitleHint => 'Напр. US-123: Как пользователь я хочу...';

  @override
  String get storyFormTitleRequired => 'Введите заголовок';

  @override
  String get storyFormUseTemplate => 'Использовать шаблон User Story';

  @override
  String get storyFormTemplateSubtitle => 'Как... я хочу... чтобы...';

  @override
  String get storyFormAsA => 'Как...';

  @override
  String get storyFormAsAHint => 'пользователь, админ, клиент...';

  @override
  String get storyFormIWant => 'Я хочу...';

  @override
  String get storyFormIWantHint => 'иметь возможность сделать что-то...';

  @override
  String get storyFormIWantRequired => 'Введите пожелание пользователя';

  @override
  String get storyFormSoThat => 'Чтобы...';

  @override
  String get storyFormSoThatHint => 'получить выгоду...';

  @override
  String get storyFormDescriptionLabel => 'Описание';

  @override
  String get storyFormDescriptionHint => 'Критерии приемки, заметки...';

  @override
  String get storyFormDescriptionRequired => 'Введите описание';

  @override
  String get storyFormPreview => 'Предпросмотр:';

  @override
  String get storyFormEmptyDescription => '(пустое описание)';

  @override
  String get storyFormAcceptanceCriteriaTitle => 'Критерии приемки';

  @override
  String get storyFormAcceptanceCriteriaSubtitle =>
      'Определите, когда задача может считаться выполненной';

  @override
  String get storyFormAddCriterionHint => 'Добавить критерий приемки...';

  @override
  String get storyFormNoCriteria => 'Критерии не определены';

  @override
  String get storyFormSuggestions => 'Предложения:';

  @override
  String get storyFormSuggestion1 => 'Данные сохраняются корректно';

  @override
  String get storyFormSuggestion2 => 'Пользователь получает подтверждение';

  @override
  String get storyFormSuggestion3 => 'Форма показывает ошибки валидации';

  @override
  String get storyFormSuggestion4 =>
      'Функционал доступен с мобильных устройств';

  @override
  String get storyFormPriorityLabel => 'Приоритет (MoSCoW)';

  @override
  String get storyFormBusinessValueLabel => 'Бизнес-ценность';

  @override
  String get storyFormBusinessValueHigh => 'Высокая бизнес-ценность';

  @override
  String get storyFormBusinessValueMedium => 'Средняя ценность';

  @override
  String get storyFormBusinessValueLow => 'Низкая бизнес-ценность';

  @override
  String get storyFormStoryPointsLabel => 'Оценка в Story Points';

  @override
  String get storyFormStoryPointsTooltip =>
      'Story Points представляют относительную сложность работы. Используйте последовательность Фибоначчи: 1 (просто) -> 21 (очень сложно).';

  @override
  String get storyFormNoPoints => 'Нет';

  @override
  String get storyFormPointsSimple => 'Быстрая и простая задача';

  @override
  String get storyFormPointsMedium => 'Задача средней сложности';

  @override
  String get storyFormPointsComplex => 'Сложная задача, требует анализа';

  @override
  String get storyFormPointsVeryComplex =>
      'Очень сложно, подумайте о разделении задачи';

  @override
  String get storyFormTagsLabel => 'Теги';

  @override
  String get storyFormAddTagHint => 'Добавить тег...';

  @override
  String get storyFormExistingTags => 'Существующие теги:';

  @override
  String get storyFormAssigneeLabel => 'Назначить на';

  @override
  String get storyFormAssigneeHint => 'Выберите участника команды';

  @override
  String get storyFormNotAssigned => 'Не назначено';

  @override
  String storyDetailPointsLabel(int points) {
    return '$points очков';
  }

  @override
  String get storyDetailDescriptionTitle => 'Описание';

  @override
  String get storyDetailNoDescription => 'Нет описания';

  @override
  String storyDetailAcceptanceCriteria(int completed, int total) {
    return 'Критерии приемки ($completed/$total)';
  }

  @override
  String get storyDetailNoCriteria => 'Критерии не определены';

  @override
  String get storyDetailEstimationTitle => 'Оценка';

  @override
  String get storyDetailFinalEstimate => 'Финальная оценка: ';

  @override
  String storyDetailEstimatesReceived(int count) {
    return 'Получено оценок: $count';
  }

  @override
  String get storyDetailInfoTitle => 'Информация';

  @override
  String get storyDetailBusinessValue => 'Бизнес-ценность';

  @override
  String get storyDetailAssignedTo => 'Назначено';

  @override
  String get storyDetailSprint => 'Спринт';

  @override
  String get storyDetailCreatedAt => 'Создано';

  @override
  String get storyDetailStartedAt => 'Начато';

  @override
  String get storyDetailCompletedAt => 'Завершено';

  @override
  String get landingBadge => 'Agile Team Tools';

  @override
  String get landingHeroTitle => 'Создавайте лучшие продукты\nс Keisen';

  @override
  String get landingHeroSubtitle =>
      'Приоритизируйте, оценивайте и управляйте своими проектами с помощью инструментов для совместной работы. Все в одном месте, бесплатно.';

  @override
  String get landingStartFree => 'Начать бесплатно';

  @override
  String get landingEverythingNeed => 'Все, что вам нужно';

  @override
  String get landingModernTools => 'Инструменты для современных команд';

  @override
  String get landingSmartTodoBadge => 'Продуктивность';

  @override
  String get landingSmartTodoTitle => 'Умный список задач';

  @override
  String get landingSmartTodoSubtitle =>
      'Интеллектуальное и совместное управление задачами для современных команд';

  @override
  String get landingSmartTodoCollaborativeTitle => 'Совместные списки задач';

  @override
  String get landingSmartTodoCollaborativeDesc =>
      'Smart Todo превращает ежедневное управление деятельностью в плавный и совместный процесс. Создавайте списки, назначайте задачи членам команды и следите за прогрессом в режиме реального времени.\n\nИдеально подходит для распределенных команд, нуждающихся в постоянной синхронизации действий.';

  @override
  String get landingSmartTodoImportTitle => 'Гибкий импорт';

  @override
  String get landingSmartTodoImportDesc =>
      'Импортируйте свои задачи из внешних источников в несколько кликов. Поддержка CSV-файлов, копирование/вставка из Excel или обычный текст. Система автоматически распознает структуру данных.\n\nЛегко мигрируйте из других инструментов без потери информации и ручного ввода каждой задачи.';

  @override
  String get landingSmartTodoShareTitle => 'Общий доступ и приглашения';

  @override
  String get landingSmartTodoShareDesc =>
      'Приглашайте коллег и партнеров в свои списки по электронной почте. Каждый участник может просматривать, комментировать и обновлять статус назначенных задач.\n\nИдеально для управления кросс-функциональными проектами с внешними стейкхолдерами.';

  @override
  String get landingSmartTodoFeaturesTitle => 'Функции Smart Todo';

  @override
  String get landingEisenhowerBadge => 'Приоритизация';

  @override
  String get landingEisenhowerSubtitle =>
      'Метод принятия решений, который лидеры используют для управления временем';

  @override
  String get landingEisenhowerUrgentImportantTitle => 'Срочно vs Важно';

  @override
  String get landingEisenhowerUrgentImportantDesc =>
      'Матрица Эйзенхауэра, разработанная 34-м президентом США Дуайтом Д. Эйзенхауэром, делит действия на четыре квадранта по двум критериям: срочность и важность.\n\nЭтот фреймворк принятия решений помогает отличить то, что требует немедленного внимания, от того, что способствует достижению долгосрочных целей.';

  @override
  String get landingEisenhowerDecisionsTitle => 'Лучшие решения';

  @override
  String get landingEisenhowerDecisionsDesc =>
      'Постоянно применяя матрицу, вы развиваете мышление, ориентированное на результат. Вы учитесь говорить «нет» отвлекающим факторам и сосредотачиваться на том, что создает реальную ценность.\n\nНаш цифровой инструмент делает этот процесс мгновенным: перетаскивайте задачи в нужный квадрант и получайте четкое представление о своих приоритетах.';

  @override
  String get landingEisenhowerBenefitsTitle =>
      'Зачем использовать матрицу Эйзенхауэра?';

  @override
  String get landingEisenhowerBenefitsDesc =>
      'Исследования показывают, что 80% повседневных действий попадают в квадранты 3 и 4 (неважные). Матрица помогает выявить их и освободить время для того, что действительно важно.';

  @override
  String get landingEisenhowerQuadrants =>
      'Квадрант 1: Срочно + Важно → Сделать сейчас\nКвадрант 2: Не срочно + Важно → Запланировать\nКвадрант 3: Срочно + Не важно → Делегировать\nКвадрант 4: Не срочно + Не важно → Исключить';

  @override
  String get landingAgileBadge => 'Методологии';

  @override
  String get landingAgileTitle => 'Agile и Scrum фреймворки';

  @override
  String get landingAgileSubtitle =>
      'Внедряйте лучшие практики итеративной разработки ПО';

  @override
  String get landingAgileIterativeTitle =>
      'Итеративная и инкрементальная разработка';

  @override
  String get landingAgileIterativeDesc =>
      'Agile-подход делит работу на короткие циклы, называемые спринтами (обычно 1–4 недели). Каждая итерация создает работающий инкремент продукта.\n\nС Keisen вы можете управлять бэклогом, планировать спринты и отслеживать скорость команды в реальном времени.';

  @override
  String get landingAgileScrumTitle => 'Фреймворк Scrum';

  @override
  String get landingAgileScrumDesc =>
      'Scrum — самый популярный Agile-фреймворк. Он определяет роли (Product Owner, Scrum Master, Team), события (Planning, Daily, Review, Retro) и артефакты (Product Backlog, Sprint Backlog).\n\nKeisen поддерживает все события Scrum с помощью специальных инструментов для каждой церемонии.';

  @override
  String get landingAgileKanbanTitle => 'Канбан-доска';

  @override
  String get landingAgileKanbanDesc =>
      'Метод Канбан визуализирует рабочий процесс через колонки, представляющие состояния процесса. Он ограничивает количество незавершенной работы (WIP) для максимизации пропускной способности.\n\nНаша Канбан-доска поддерживает настройку колонок, WIP-лимиты и метрики потока.';

  @override
  String get landingEstimationBadge => 'Оценка';

  @override
  String get landingEstimationTitle => 'Техники совместной оценки';

  @override
  String get landingEstimationSubtitle =>
      'Выберите лучший метод для вашей команды для точных оценок';

  @override
  String get landingEstimationFeaturesTitle => 'Функции комнаты оценки';

  @override
  String get landingRetroBadge => 'Ретроспектива';

  @override
  String get landingRetroTitle => 'Интерактивные ретроспективы';

  @override
  String get landingRetroSubtitle =>
      'Инструменты для совместной работы в реальном времени: таймеры, анонимное голосование, задачи по итогам.';

  @override
  String get landingRetroActionTitle => 'Отслеживание задач по улучшению';

  @override
  String get landingRetroActionDesc =>
      'Каждая ретроспектива создает отслеживаемые задачи по улучшению с владельцами, сроками и статусами.';

  @override
  String get landingWorkflowBadge => 'Процесс';

  @override
  String get landingWorkflowTitle => 'Как это работает';

  @override
  String get landingWorkflowSubtitle => 'Начните за 3 простых шага';

  @override
  String get landingStep1Title => 'Создайте проект';

  @override
  String get landingStep1Desc =>
      'Создайте свой Agile-проект и пригласите команду. Настройте спринты, бэклог и доски.';

  @override
  String get landingStep2Title => 'Взаимодействуйте';

  @override
  String get landingStep2Desc =>
      'Оценивайте истории вместе, организуйте спринты и отслеживайте прогресс в реальном времени.';

  @override
  String get landingStep3Title => 'Улучшайте';

  @override
  String get landingStep3Desc =>
      'Анализируйте метрики, проводите ретроспективы и постоянно улучшайте процесс.';

  @override
  String get landingCtaTitle => 'Готовы начать?';

  @override
  String get landingCtaDesc =>
      'Зарегистрируйтесь бесплатно и начните работать вместе со своей командой.';

  @override
  String get landingFooterBrandDesc =>
      'Инструменты для совместной работы Agile-команд.\nПланируйте, оценивайте и улучшайте вместе.';

  @override
  String get landingFooterProduct => 'Продукт';

  @override
  String get landingFooterResources => 'Ресурсы';

  @override
  String get landingFooterCompany => 'Компания';

  @override
  String get landingFooterLegal => 'Юридическая информация';

  @override
  String get landingCopyright => '© 2026 Keisen. Все права защищены.';

  @override
  String get featureSmartImportDesc =>
      'Быстрое создание задач с описанием\nНазначение участников команды\nНастройка приоритета и срока\nУведомления о выполнении';

  @override
  String get featureImportDesc =>
      'Импорт из CSV-файла\nКопирование/вставка из Excel\nУмный текстовый разбор\nАвтоматическое сопоставление полей';

  @override
  String get featureShareDesc =>
      'Приглашения по email\nНастраиваемые права доступа\nКомментарии к задачам\nИстория изменений';

  @override
  String get featureSmartTaskCreation => 'Быстрое создание задач';

  @override
  String get featureTeamAssignment => 'Назначение команды';

  @override
  String get featurePriorityDeadline => 'Приоритет и сроки';

  @override
  String get featureCompletionNotifications => 'Уведомления о выполнении';

  @override
  String get featureCsvImport => 'Импорт CSV';

  @override
  String get featureExcelPaste => 'Копирование/вставка Excel';

  @override
  String get featureSmartParsing => 'Умный разбор';

  @override
  String get featureAutoMapping => 'Автоматическое сопоставление';

  @override
  String get featureEmailInvites => 'Приглашения по email';

  @override
  String get featurePermissions => 'Настраиваемые права';

  @override
  String get featureTaskComments => 'Комментарии к задачам';

  @override
  String get featureHistory => 'История изменений';

  @override
  String get featureAdvancedFilters => 'Продвинутые фильтры';

  @override
  String get featureFullTextSearch => 'Полнотекстовый поиск';

  @override
  String get featureSorting => 'Сортировка';

  @override
  String get featureTagsCategories => 'Теги и категории';

  @override
  String get featureArchiving => 'Архивация';

  @override
  String get featureSort => 'Сортировка';

  @override
  String get featureDataExport => 'Экспорт данных';

  @override
  String get landingIntroFeatures =>
      'Планирование спринта с учетом емкости команды\nПриоритизированный бэклог с drag & drop\nОтслеживание скорости и график сгорания\nУдобные ежедневные стендапы';

  @override
  String get landingAgileScrumFeatures =>
      'Бэклог продукта с оценкой в story points\nБэклог спринта с декомпозицией задач\nИнтегрированная доска ретроспектив\nАвтоматические метрики Scrum';

  @override
  String get landingAgileKanbanFeatures =>
      'Настраиваемые колонки\nWIP-лимиты для каждой колонки\nИнтуитивный drag & drop\nLead time и Cycle time';

  @override
  String get landingEstimationPokerDesc =>
      'Классический метод: каждый участник выбирает карту (1, 2, 3, 5, 8...). Оценки раскрываются одновременно, чтобы избежать предвзятости.';

  @override
  String get landingEstimationTShirtTitle => 'Размеры футболок (T-Shirt)';

  @override
  String get landingEstimationTShirtSubtitle => 'Относительные размеры';

  @override
  String get landingEstimationTShirtDesc =>
      'Быстрая оценка с использованием размеров: XS, S, M, L, XL, XXL. Идеально для начальной проработки бэклога или когда нужна примерная оценка.';

  @override
  String get landingEstimationPertTitle => 'Трехточечная оценка (PERT)';

  @override
  String get landingEstimationPertSubtitle =>
      'Оптимистично / Вероятно / Пессимистично';

  @override
  String get landingEstimationPertDesc =>
      'Статистическая техника: каждый участник дает 3 оценки (О, М, П). Формула PERT рассчитывает взвешенную оценку: (O + 4M + P) / 6.';

  @override
  String get landingEstimationBucketTitle => 'Система корзин (Buckets)';

  @override
  String get landingEstimationBucketSubtitle => 'Быстрая категоризация';

  @override
  String get landingEstimationBucketDesc =>
      'User story распределяются по заранее определенным корзинам. Отлично подходит для быстрой оценки большого количества элементов в сессиях уточнения.';

  @override
  String get landingEstimationChipHiddenVote => 'Скрытое голосование';

  @override
  String get landingEstimationChipTimer => 'Настраиваемый таймер';

  @override
  String get landingEstimationChipStats => 'Статистика в реальном времени';

  @override
  String get landingEstimationChipParticipants => 'До 20 участников';

  @override
  String get landingEstimationChipHistory => 'История оценок';

  @override
  String get landingEstimationChipExport => 'Экспорт результатов';

  @override
  String get landingRetroTemplateStartStopTitle =>
      'Начать / Прекратить / Продолжить';

  @override
  String get landingRetroTemplateStartStopDesc =>
      'Классический формат: что начать делать, что прекратить делать, что продолжить делать.';

  @override
  String get landingRetroTemplateMadSadTitle => 'Mad / Sad / Glad';

  @override
  String get landingRetroTemplateMadSadDesc =>
      'Эмоциональная ретроспектива: что нас расстроило, огорчило или обрадовало.';

  @override
  String get landingRetroTemplate4LsTitle => '4L\'s';

  @override
  String get landingRetroTemplate4LsDesc =>
      'Liked, Learned, Lacked, Longed For - полный анализ спринта.';

  @override
  String get landingRetroTemplateSailboatTitle => 'Sailboat (Парусник)';

  @override
  String get landingRetroTemplateSailboatDesc =>
      'Визуальная метафора: ветер (помощники), якорь (препятствия), камни (риски), остров (цели).';

  @override
  String get landingRetroTemplateWentWellTitle => 'Хорошо / Улучшить';

  @override
  String get landingRetroTemplateWentWellDesc =>
      'Простой и прямой формат: что прошло хорошо и что нужно улучшить.';

  @override
  String get landingRetroTemplateDakiTitle => 'DAKI';

  @override
  String get landingRetroTemplateDakiDesc =>
      'Drop, Add, Keep, Improve - конкретные решения для следующего спринта.';

  @override
  String get landingRetroFeatureTrackingTitle =>
      'Отслеживание задач по улучшению';

  @override
  String get landingRetroFeatureTrackingDesc =>
      'Каждая ретроспектива создает отслеживаемые задачи по улучшению с ответственными, сроками и статусами. Мониторинг выполнения во времени.';

  @override
  String get landingAgileSectionBadge => 'Методологии';

  @override
  String get landingAgileSectionTitle => 'Agile и Scrum фреймворки';

  @override
  String get landingAgileSectionSubtitle =>
      'Внедряйте лучшие практики итеративной разработки программного обеспечения';

  @override
  String get landingSmartTodoCollabTitle => 'Совместные списки задач';

  @override
  String get landingSmartTodoCollabDesc =>
      'Smart Todo превращает повседневное управление задачами в плавный совместный процесс. Создавайте списки, назначайте задачи участникам и следите за прогрессом.';

  @override
  String get landingSmartTodoCollabFeatures =>
      'Быстрое создание задач с описанием\nНазначение участников команды\nНастройка приоритета и срока\nУведомления о выполнении';

  @override
  String get landingSmartTodoImportFeatures =>
      'Импорт из CSV-файла\nКопирование/вставка из Excel\nУмный текстовый разбор\nАвтоматическое сопоставление полей';

  @override
  String get landingSmartTodoSharingTitle => 'Общий доступ и приглашения';

  @override
  String get landingSmartTodoSharingDesc =>
      'Приглашайте коллег и партнеров в свои списки по электронной почте. Каждый участник может просматривать, комментировать и обновлять статус назначенных задач.\n\nИдеально для управления кросс-функциональными проектами.';

  @override
  String get landingSmartTodoSharingFeatures =>
      'Приглашения по email\nНастраиваемые права\nКомментарии к задачам\nИстория изменений';

  @override
  String get landingSmartTodoChipFilters => 'Продвинутые фильтры';

  @override
  String get landingSmartTodoChipSearch => 'Полнотекстовый поиск';

  @override
  String get landingSmartTodoChipSort => 'Сортировка';

  @override
  String get landingSmartTodoChipTags => 'Теги и категории';

  @override
  String get landingSmartTodoChipArchive => 'Архивация';

  @override
  String get landingSmartTodoChipExport => 'Экспорт данных';

  @override
  String get landingEisenhowerTitle => 'Матрица Эйзенхауэра';

  @override
  String get landingEisenhowerUrgentTitle => 'Срочно vs Важно';

  @override
  String get landingEisenhowerUrgentDesc =>
      'Матрица Эйзенхауэра, разработанная 34-м президентом США Дуэйтом Д. Эйзенхауэром, делит задачи на четыре квадранта на основе двух критериев: срочности и важности.\n\nЭтот фреймворк помогает отличить то, что требует немедленного внимания, от того, что способствует достижению долгосрочных целей.';

  @override
  String get landingEisenhowerUrgentFeatures =>
      'Квадрант 1: Срочно + Важно → Сделать сейчас\nКвадрант 2: Не срочно + Важно → Запланировать\nКвадрант 3: Срочно + Не важно → Делегировать\nКвадрант 4: Не срочно + Не важно → Удалить';

  @override
  String get landingEisenhowerDecisionsFeatures =>
      'Интуитивный drag & drop\nСотрудничество в реальном времени\nСтатистика распределения\nЭкспорт для отчетов';

  @override
  String get landingEisenhowerUrgentLabel => 'СРОЧНО';

  @override
  String get landingEisenhowerNotUrgentLabel => 'НЕ СРОЧНО';

  @override
  String get landingEisenhowerImportantLabel => 'ВАЖНО';

  @override
  String get landingEisenhowerNotImportantLabel => 'НЕ ВАЖНО';

  @override
  String get landingEisenhowerDoLabel => 'ДЕЛАЙ';

  @override
  String get landingEisenhowerDoDesc => 'Кризисы, дедлайны, ЧП';

  @override
  String get landingEisenhowerPlanLabel => 'ПЛАНИРУЙ';

  @override
  String get landingEisenhowerPlanDesc => 'Стратегия, развитие, отношения';

  @override
  String get landingEisenhowerDelegateLabel => 'ДЕЛЕГИРУЙ';

  @override
  String get landingEisenhowerDelegateDesc => 'Помехи, встречи, письма';

  @override
  String get landingEisenhowerEliminateLabel => 'ИСКЛЮЧИТЬ';

  @override
  String get landingEisenhowerEliminateDesc =>
      'Отвлечения, соцсети, пустая трата времени';

  @override
  String get landingFooterFeatures => 'Функции';

  @override
  String get landingFooterPricing => 'Цены';

  @override
  String get landingFooterChangelog => 'Список изменений';

  @override
  String get landingFooterRoadmap => 'Дорожная карта';

  @override
  String get landingFooterDocs => 'Документация';

  @override
  String jiraConnectedSuccess(String name) {
    return 'Connected as $name';
  }

  @override
  String get landingFooterAgileGuides => 'Agile-руководства';

  @override
  String get landingFooterBlog => 'Блог';

  @override
  String get landingFooterCommunity => 'Сообщество';

  @override
  String get landingFooterAbout => 'О нас';

  @override
  String get landingFooterContact => 'Контакт';

  @override
  String get landingFooterJobs => 'Вакансии';

  @override
  String get landingFooterPress => 'Пресс-кит';

  @override
  String get landingFooterPrivacy => 'Политика конфиденциальности';

  @override
  String get landingFooterTerms => 'Условия обслуживания';

  @override
  String get landingFooterCookies => 'Политика использования файлов cookie';

  @override
  String get landingFooterGdpr => 'GDPR';

  @override
  String get legalCookieTitle => 'Мы используем файлы cookie';

  @override
  String get legalCookieMessage =>
      'Мы используем файлы cookie для улучшения работы сайта и аналитики. Продолжая работу, вы соглашаетесь с использованием cookie.';

  @override
  String get legalCookieAccept => 'Принять все';

  @override
  String get legalCookieRefuse => 'Только необходимые';

  @override
  String get legalCookiePolicy => 'Политика использования файлов cookie';

  @override
  String get legalPrivacyPolicy => 'Политика конфиденциальности';

  @override
  String get legalTermsOfService => 'Условия использования';

  @override
  String get legalGDPR => 'GDPR';

  @override
  String get legalLastUpdatedLabel => 'Последнее обновление';

  @override
  String get legalLastUpdatedDate => '18 января 2026 г.';

  @override
  String get legalAcceptTerms =>
      'Я принимаю Условия использования и Политику конфиденциальности';

  @override
  String get legalMustAcceptTerms =>
      'Вы должны принять условия, чтобы продолжить';

  @override
  String get legalPrivacyContent =>
      '## 1. Введение\nДобро пожаловать в **Keisen** («мы», «наш», «Платформа»). Ваша конфиденциальность важна для нас. Настоящая Политика конфиденциальности объясняет, как мы собираем, используем, раскрываем и защищаем вашу информацию при использовании нашего веб-приложения.\n\n## 2. Какую информацию мы собираем\nМы собираем два типа данных и информации:\n\n### 2.1 Информация, предоставляемая пользователем\n- **Данные аккаунта:** Когда вы входите через Google-аккаунт или создаете учетную запись, мы собираем ваше имя, адрес электронной почты и фото профиля.\n- **Пользовательский контент:** Мы собираем данные, которые вы добровольно вводите на платформу, включая задачи, оценки, ретроспективы, комментарии и конфигурации команд.\n\n### 2.2 Информация, собираемая автоматически\n- **Системные журналы:** IP-адреса, тип браузера, посещенные страницы и временные метки.\n- **Файлы cookie:** Мы используем необходимые технические файлы cookie для поддержания вашей сессии активной.\n\n## 3. Как мы используем вашу информацию\nМы используем собранную информацию для:\n- Обеспечения, эксплуатации и обслуживания наших Сервисов.\n- Улучшения, персонализации и расширения нашей Платформы.\n- Анализа того, как вы используете веб-сайт, для улучшения пользовательского опыта.\n- Отправки вам служебных писем (напр., приглашений в команду, важных обновлений).\n\n## 4. Обмен информацией\nМы не продаем ваши личные данные. Мы делимся информацией только с:\n- **Поставщиками услуг:** Мы используем **Google Firebase** (Google LLC) для хостинга, аутентификации и работы с базами данных. Данные обрабатываются в соответствии с [Политикой конфиденциальности Google](https://policies.google.com/privacy).\n- **Юридическими обязательствами:** Если это требуется по закону или для защиты наших прав.\n\n## 5. Безопасность данных\nМы внедряем стандартные для отрасли технические и организационные меры безопасности (такие как шифрование при передаче) для защиты ваших данных. Однако ни один метод передачи через Интернет не является на 100% безопасным.\n\n## 6. Ваши права\nВы имеете право:\n- Доступа к своим личным данным.\n- Запрашивать исправление неточных данных.\n- Запрашивать удаление ваших данных («Право на забвение»).\n- Возражать против обработки ваших данных.\n\nДля реализации этих прав свяжитесь с нами по адресу: suppkesien@gmail.com.\n\n## 7. Изменения в настоящей Политике\nМы можем время от времени обновлять настоящую Политику конфиденциальности. Мы уведомим вас о любых изменениях, опубликовав новую Политику на этой странице.';

  @override
  String get legalTermsContent =>
      '## 1. Принятие условий\nЗаходя на сайт или используя **Keisen**, вы соглашаетесь соблюдать настоящие Условия использования. Если вы не согласны с этими Условиями, вы не должны пользоваться нашими Сервисами.\n\n## 2. Описание сервиса\nKeisen — это платформа для совместной работы agile-команд, предлагающая такие инструменты, как Smart Todo, матрица Эйзенхауэра, комната оценок (Estimation Room) и управление Agile-процессами. Мы оставляем за собой право изменять или прекращать работу сервиса в любое время.\n\n## 3. Учетные записи пользователей\nВы несете ответственность за сохранение конфиденциальности данных своей учетной записи и за все действия, которые происходят под вашим аккаунтом. Мы оставляем за собой право приостанавливать или удалять учетные записи, нарушающие настоящие Условия.\n\n## 4. Поведение пользователя\nВы соглашаетесь не использовать Сервис для:\n- Нарушения местных, национальных или международных законов.\n- Загрузки оскорбительного, клеветнического или незаконного контента.\n- Попыток несанкционированного доступа к системам Платформы.\n\n## 5. Интеллектуальная собственность\nВсе права на интеллектуальную собственность, связанные с Платформой и ее оригинальным контентом (за исключением контента, предоставленного пользователями), являются исключительной собственностью Leonardo Torella.\n\n## 6. Ограничение ответственности\nВ максимальной степени, разрешенной законом, Keisen предоставляется на условиях «как есть» и «по возможности». Мы не гарантируем, что сервис будет работать бесперебойно или без ошибок. Мы не несем ответственности за косвенные, случайные или последующие убытки, возникшие в результате использования сервиса.\n\n## 7. Применимое право\nНастоящие Условия регулируются законодательством Итальянской Республики.\n\n## 8. Контакты\nПо вопросам, касающимся настоящих Условий, свяжитесь с нами по адресу: suppkesien@gmail.com.';

  @override
  String get legalCookiesContent =>
      '## 1. Что такое файлы cookie?\nФайлы cookie — это небольшие текстовые файлы, которые сохраняются на вашем устройстве при посещении веб-сайта. Они широко используются для обеспечения более эффективной работы сайтов и предоставления информации владельцам сайтов.\n\n## 2. Как мы используем файлы cookie\nМы используем файлы cookie для нескольких целей:\n\n### 2.1 Технические файлы cookie (Обязательные)\nЭти файлы cookie необходимы для работы веб-сайта и не могут быть отключены в наших системах. Обычно они устанавливаются только в ответ на производимые вами действия, которые приравниваются к запросу услуг, такие как настройка ваших предпочтений конфиденциальности, вход в систему или заполнение форм.\n*Пример:* сессионные файлы cookie Firebase Auth для поддержания входа пользователя в систему.\n\n### 2.2 Аналитические файлы cookie\nЭти файлы cookie позволяют нам подсчитывать посещения и источники трафика, чтобы мы могли измерять и улучшать производительность нашего сайта. Вся информация, собираемая этими файлами cookie, является агрегированной и, следовательно, анонимной.\n\n## 3. Управление файлами cookie\nБольшинство веб-браузеров позволяют вам контролировать большинство файлов cookie через настройки браузера. Однако, если вы отключите основные файлы cookie, некоторые части нашего Сервиса могут работать некорректно (например, вы не сможете войти в систему).\n\n## 4. Сторонние файлы cookie\nМы используем сторонние сервисы, такие как **Google Firebase**, которые могут устанавливать свои собственные файлы cookie. Мы рекомендуем вам ознакомиться с их соответствующими политиками конфиденциальности для получения более подробной информации.';

  @override
  String get legalGdprContent =>
      '## Приверженность защите данных (GDPR)\nВ соответствии с Общим регламентом Европейского союза по защите данных (GDPR), Keisen обязуется защищать личные данные пользователей и обеспечивать прозрачность их обработки.\n\n## Оператор данных\nОператором данных является:\n**Keisen Team**\nEmail: suppkesien@gmail.com\n\n## Правовая основа для обработки\nМы обрабатываем ваши личные данные только при наличии законных оснований. Это включает:\n- **Согласие:** Вы дали нам разрешение на обработку ваших данных для конкретной цели.\n- **Выполнение договора:** Обработка необходима для предоставления запрошенных вами Услуг (например, использование платформы).\n- **Законный интерес:** Обработка необходима для обеспечения наших законных интересов (например, безопасность, улучшение обслуживания), если только ваши фундаментальные права и свободы не перевешивают эти интересы.\n\n## Передача данных\nВаши данные хранятся на защищенных серверах, предоставленных Google Cloud Platform (Google Firebase). Google придерживается международных стандартов безопасности и соблюдает GDPR посредством Стандартных договорных условий (SCC).\n\n## Ваши права в рамках GDPR\nКак пользователь в ЕС, вы имеете следующие права:\n1. **Право на доступ:** Вы имеете право запрашивать копии ваших личных данных.\n2. **Право на исправление:** Вы имеете право запрашивать исправление неточных данных.\n3. **Право на удаление («Право на забвение»):** Вы имеете право запрашивать удаление ваших личных данных при определенных условиях.\n4. **Право на ограничение обработки:** Вы имеете право запрашивать ограничение обработки ваших данных.\n5. **Право на переносимость данных:** Вы имеете право запрашивать передачу данных, которые мы собрали, другой организации или непосредственно вам.\n\n## Реализация прав\nЕсли вы хотите реализовать любое из этих прав, свяжитесь с нами по адресу: suppkesien@gmail.com. Мы ответим на ваш запрос в течение одного месяца.';

  @override
  String get profilePrivacy => 'Конфиденциальность';

  @override
  String get profileExportData => 'Экспортировать мои данные';

  @override
  String get profileDeleteAccountConfirm =>
      'Вы уверены, что хотите навсегда удалить свой аккаунт? Это действие необратимо.';

  @override
  String get subscriptionTitle => 'Подписка';

  @override
  String get subscriptionTabPlans => 'Тарифы';

  @override
  String get subscriptionTabUsage => 'Использование';

  @override
  String get subscriptionTabBilling => 'Оплата';

  @override
  String subscriptionActiveProjects(int count) {
    return 'Активных проектов: $count';
  }

  @override
  String subscriptionActiveLists(int count) {
    return 'Списков Smart Todo: $count';
  }

  @override
  String get subscriptionCurrentPlan => 'Текущий план';

  @override
  String subscriptionUpgradeTo(String plan) {
    return 'Перейти на $plan';
  }

  @override
  String subscriptionDowngradeTo(String plan) {
    return 'Перейти на план $plan';
  }

  @override
  String subscriptionChoose(String plan) {
    return 'Выбрать $plan';
  }

  @override
  String get subscriptionMonthly => 'Ежемесячно';

  @override
  String get subscriptionYearly => 'Ежегодно (-17%)';

  @override
  String get subscriptionLimitReached => 'Лимит достигнут';

  @override
  String get subscriptionLimitProjects =>
      'Вы достигли максимального количества проектов (5). Свяжитесь с разработчиком для увеличения лимита.';

  @override
  String get subscriptionLimitLists =>
      'Вы достигли лимита количества списков для вашего плана. Перейдите на Premium, чтобы создавать больше списков.';

  @override
  String get subscriptionLimitTasks =>
      'Вы достигли максимального количества задач в этом проекте. Перейдите на Premium, чтобы добавить больше задач.';

  @override
  String get subscriptionLimitInvites =>
      'Вы достигли максимального количества приглашений для этого проекта. Перейдите на Premium, чтобы пригласить больше людей.';

  @override
  String get subscriptionLimitEstimations =>
      'Вы достигли максимального количества сессий оценки. Перейдите на Premium, чтобы создавать больше.';

  @override
  String get subscriptionLimitRetrospectives =>
      'Вы достигли максимального количества ретроспектив. Перейдите на Premium, чтобы создавать больше.';

  @override
  String get subscriptionLimitAgileProjects =>
      'Вы достигли максимального количества Agile-проектов (5). Свяжитесь с разработчиком для увеличения лимита.';

  @override
  String get subscriptionLimitDefault =>
      'Вы достигли лимита своего текущего плана.';

  @override
  String get subscriptionCurrentUsage => 'Текущее использование';

  @override
  String get subscriptionUpgradeToPremium => 'Перейти на Premium';

  @override
  String get subscriptionBenefitProjects => '30 активных проектов';

  @override
  String get subscriptionBenefitLists => '30 списков Smart Todo';

  @override
  String get subscriptionBenefitTasks => '100 задач на проект';

  @override
  String get subscriptionBenefitNoAds => 'Без рекламы';

  @override
  String get subscriptionStartingFrom =>
      'Свяжитесь с нами для получения дополнительной информации';

  @override
  String get subscriptionLater => 'Позже';

  @override
  String get subscriptionViewPlans => 'Связаться с разработчиком';

  @override
  String get subscriptionContactDeveloper => 'Связаться с разработчиком';

  @override
  String get subscriptionOfficialEmail => 'leonardo.torella@gmail.com';

  @override
  String subscriptionCanCreateOne(String entity) {
    return 'Вы можете создать еще 1 $entity';
  }

  @override
  String subscriptionCanCreateMany(int count, String entity) {
    return 'Вы можете создать еще $count $entity';
  }

  @override
  String get subscriptionUpgrade => 'UPGRADE';

  @override
  String subscriptionUsed(int count) {
    return 'Использовано: $count';
  }

  @override
  String get subscriptionUnlimited => 'Безлимитно';

  @override
  String subscriptionLimit(int count) {
    return 'Лимит: $count';
  }

  @override
  String get subscriptionPlanUsage => 'Использование плана';

  @override
  String get subscriptionRefresh => 'Обновить';

  @override
  String get subscriptionAdsActive => 'Реклама включена';

  @override
  String get subscriptionRemoveAds =>
      'Перейдите на Premium, чтобы убрать рекламу';

  @override
  String get subscriptionNoAds => 'Без рекламы';

  @override
  String get subscriptionLoadError =>
      'Не удалось загрузить данные об использовании';

  @override
  String get subscriptionAdLabel => 'РЕКЛАМА';

  @override
  String get subscriptionAdPlaceholder => 'Место для рекламы';

  @override
  String get subscriptionDevEnvironment => '(Среда разработки)';

  @override
  String get subscriptionRemoveAdsUnlock =>
      'Убрать рекламу и разблокировать продвинутые функции';

  @override
  String get subscriptionUpgradeButton => 'Обновить';

  @override
  String subscriptionLoadingError(String error) {
    return 'Loading error: $error';
  }

  @override
  String get subscriptionCompletePayment =>
      'Завершите оплату в открывшемся окне';

  @override
  String subscriptionError(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get subscriptionConfirmDowngrade => 'Подтвердить понижение плана';

  @override
  String get subscriptionDowngradeMessage =>
      'Вы уверены, что хотите перейти на бесплатный (Free) план?\n\nВаша подписка останется активной до конца текущего периода, после чего вы автоматически перейдете на Free план.\n\nВы не потеряете свои данные, но некоторые функции могут стать ограничены.';

  @override
  String get subscriptionCancel => 'Отмена';

  @override
  String get subscriptionConfirmDowngradeButton =>
      'Подтвердить понижение плана';

  @override
  String get subscriptionCancelled =>
      'Подписка отменена. Она останется активной до конца оплаченного периода.';

  @override
  String subscriptionPortalError(String error) {
    return 'Portal opening error: $error';
  }

  @override
  String get subscriptionRetry => 'Повторить';

  @override
  String get subscriptionChooseRightPlan => 'Выберите подходящий план';

  @override
  String get subscriptionStartFree =>
      'Начните бесплатно, перейдите на платный план, когда захотите';

  @override
  String subscriptionPlan(String plan) {
    return 'Plan $plan';
  }

  @override
  String subscriptionPlanName(String plan) {
    return 'Текущий план: $plan';
  }

  @override
  String subscriptionTrialUntil(String date) {
    return 'Пробный период до $date';
  }

  @override
  String subscriptionRenewal(String date) {
    return 'Продление: $date';
  }

  @override
  String get subscriptionManage => 'Управление';

  @override
  String get subscriptionLoginRequired =>
      'Пожалуйста, войдите, чтобы просмотреть использование';

  @override
  String get subscriptionSuggestion => 'Предложение';

  @override
  String get subscriptionSuggestionText =>
      'Перейдите на Premium, чтобы разблокировать больше проектов, убрать рекламу и увеличить лимиты. Попробуйте бесплатно в течение 7 дней!';

  @override
  String get subscriptionPaymentManagement => 'Управление платежами';

  @override
  String get subscriptionNoActiveSubscription => 'Нет активной подписки';

  @override
  String get subscriptionUsingFreePlan => 'Вы используете бесплатный план';

  @override
  String get subscriptionViewPaidPlans => 'Просмотреть платные тарифы';

  @override
  String get subscriptionPaymentMethod => 'Способ оплаты';

  @override
  String get subscriptionEditPaymentMethod =>
      'Изменить карту или способ оплаты';

  @override
  String get subscriptionInvoices => 'Счета';

  @override
  String get subscriptionViewInvoices => 'Просмотр и скачивание счетов';

  @override
  String get subscriptionCancelSubscription => 'Отменить подписку';

  @override
  String get subscriptionAccessUntilEnd =>
      'Доступ останется активным до конца периода';

  @override
  String get subscriptionPaymentHistory => 'История платежей';

  @override
  String get subscriptionNoPayments => 'Платежи не найдены';

  @override
  String get subscriptionCompleted => 'Завершено';

  @override
  String get subscriptionDateNotAvailable => 'Дата недоступна';

  @override
  String get subscriptionFaq => 'Часто задаваемые вопросы';

  @override
  String get subscriptionFaqCancel =>
      'Могу ли я отменить подписку в любое время?';

  @override
  String get subscriptionFaqCancelAnswer =>
      'Да, вы можете отменить подписку в любой момент. Доступ останется активным до конца оплаченного периода.';

  @override
  String get subscriptionFaqTrial => 'Как работает бесплатный пробный период?';

  @override
  String get subscriptionFaqTrialAnswer =>
      'С бесплатным пробным периодом у вас есть полный доступ ко всем функциям выбранного плана. По окончании пробного периода платная подписка начнется автоматически.';

  @override
  String get subscriptionFaqChange => 'Могу ли я сменить план?';

  @override
  String get subscriptionFaqChangeAnswer =>
      'Вы можете повысить или понизить уровень плана в любое время. Стоимость будет пересчитана пропорционально.';

  @override
  String get subscriptionFaqData => 'Безопасны ли мои данные?';

  @override
  String get subscriptionFaqDataAnswer =>
      'Безусловно, да. Вы никогда не потеряете свои данные, даже если перейдете на более низкий тарифный план. Некоторые функции могут быть ограничены, но данные всегда останутся доступными.';

  @override
  String get subscriptionStatusActive => 'Активно';

  @override
  String get subscriptionStatusTrialing => 'Пробный период';

  @override
  String get subscriptionStatusPastDue => 'Просрочено';

  @override
  String get subscriptionStatusCancelled => 'Отменено';

  @override
  String get subscriptionStatusExpired => 'Истекло';

  @override
  String get subscriptionStatusPaused => 'Приостановлено';

  @override
  String get subscriptionStatus => 'Статус';

  @override
  String get subscriptionStarted => 'Начало';

  @override
  String get subscriptionNextRenewal => 'Следующее продление';

  @override
  String get subscriptionTrialEnd => 'Конец пробного периода';

  @override
  String get toolSectionTitle => 'Инструменты';

  @override
  String get deadlineTitle => 'Сроки';

  @override
  String get deadlineNoUpcoming => 'Нет ближайших сроков';

  @override
  String get deadlineAll => 'Все';

  @override
  String get deadlineToday => 'Сегодня';

  @override
  String get deadlineTomorrow => 'Завтра';

  @override
  String get deadlineSprint => 'Спринт';

  @override
  String get deadlineTask => 'Задача';

  @override
  String get favTitle => 'Избранное';

  @override
  String get favFilterAll => 'Все';

  @override
  String get favFilterTodo => 'Списки задач';

  @override
  String get favFilterMatrix => 'Матрицы';

  @override
  String get favFilterProject => 'Проекты';

  @override
  String get favFilterPoker => 'Оценка';

  @override
  String get actionRemoveFromFavorites => 'Удалить из избранного';

  @override
  String get favFilterRetro => 'Ретро';

  @override
  String get favNoFavorites => 'Избранное пусто';

  @override
  String get favTypeTodo => 'Список задач';

  @override
  String get favTypeMatrix => 'Матрица Эйзенхауэра';

  @override
  String get favTypeProject => 'Agile-проект';

  @override
  String get favTypeRetro => 'Ретроспектива';

  @override
  String get favTypePoker => 'Planning Poker';

  @override
  String get favTypeTool => 'Инструмент';

  @override
  String get deadline2Days => '2 дня';

  @override
  String get deadline3Days => '3 дня';

  @override
  String get deadline5Days => '5 дней';

  @override
  String get deadlineConfigTitle => 'Настроить ярлыки';

  @override
  String get deadlineConfigDesc =>
      'Выберите временные рамки для отображения в заголовке.';

  @override
  String get smartTodoClose => 'Закрыть';

  @override
  String get smartTodoDone => 'Готово';

  @override
  String get smartTodoAdd => 'Добавить';

  @override
  String get smartTodoEmailLabel => 'Email';

  @override
  String get exceptionLoginGoogleRequired =>
      'Требуется вход через Google для отправки писем';

  @override
  String get exceptionUserNotAuthenticated =>
      'Пользователь не аутентифицирован';

  @override
  String errorLoginFailed(String error) {
    return 'Ошибка входа: $error';
  }

  @override
  String retroParticipantsTitle(int count) {
    return 'Участников ($count)';
  }

  @override
  String get actionReopen => 'Переоткрыть';

  @override
  String get retroWaitingForFacilitator =>
      'Ожидание организатора для начала сессии...';

  @override
  String get retroGeneratingSheet => 'Создание Google Таблицы...';

  @override
  String get retroExportSuccess => 'Экспорт завершен!';

  @override
  String get retroExportSuccessMessage =>
      'Ваша ретроспектива экспортирована в Google Таблицы.';

  @override
  String get retroExportError => 'Ошибка при экспорте в Таблицы.';

  @override
  String get retroReportCopied =>
      'Отчет скопирован в буфер обмена! Вставьте его в Excel или Заметки.';

  @override
  String get retroReopenTitle => 'Переоткрыть ретроспективу';

  @override
  String get retroReopenConfirm =>
      'Вы уверены, что хотите переоткрыть ретроспективу? Она вернется на фазу обсуждения.';

  @override
  String get errorAuthRequired => 'Требуется аутентификация';

  @override
  String get errorRetroIdMissing => 'Отсутствует ID ретроспективы';

  @override
  String get pokerInviteAccepted =>
      'Приглашение принято! Перенаправление на сессию.';

  @override
  String get pokerInviteRefused => 'Приглашение отклонено';

  @override
  String get pokerConfirmRefuseTitle => 'Отклонить приглашение';

  @override
  String get pokerConfirmRefuseContent =>
      'Вы уверены, что хотите отклонить это приглашение?';

  @override
  String get pokerVerifyingInvite => 'Проверка приглашения...';

  @override
  String get actionBackHome => 'Вернуться на главную';

  @override
  String get actionSignin => 'Войти';

  @override
  String get exceptionStoryNotFound => 'История не найдена';

  @override
  String get exceptionNoTasksInProject => 'Задачи в проекте не найдены';

  @override
  String get exceptionInvitePending =>
      'Приглашение для этого email уже ожидает подтверждения';

  @override
  String get exceptionAlreadyParticipant =>
      'Пользователь уже является участником';

  @override
  String get exceptionInviteInvalid =>
      'Приглашение недействительно или истекло';

  @override
  String get exceptionInviteCalculated => 'Приглашение истекло';

  @override
  String get exceptionInviteWrongUser =>
      'Приглашение предназначено для другого пользователя';

  @override
  String get todoImportTasks => 'Импортировать задачи';

  @override
  String get todoExportSheets => 'Экспорт в Таблицы';

  @override
  String get todoDeleteColumnTitle => 'Удалить колонку';

  @override
  String get todoDeleteColumnConfirm =>
      'Вы уверены? Задачи в этой колонке будут потеряны.';

  @override
  String get exceptionListNotFound => 'Список не найден';

  @override
  String get langItalian => 'Итальянский';

  @override
  String get langEnglish => 'Английский';

  @override
  String get langFrench => 'Французский';

  @override
  String get langSpanish => 'Испанский';

  @override
  String get langPortuguese => 'Португальский';

  @override
  String get langRussian => 'Русский';

  @override
  String get langGerman => 'Немецкий';

  @override
  String get langIndonesian => 'Индонезийский';

  @override
  String get jsonExportLabel => 'Скачать копию данных в формате JSON';

  @override
  String errorExporting(String error) {
    return 'Ошибка при экспорте: $error';
  }

  @override
  String get smartTodoViewKanban => 'Канбан';

  @override
  String get smartTodoViewList => 'Список';

  @override
  String get smartTodoViewResource => 'По ресурсам';

  @override
  String get smartTodoInviteTooltip => 'Пригласить';

  @override
  String get smartTodoOptionsTooltip => 'Дополнительные опции';

  @override
  String get smartTodoActionImport => 'Импортировать задачи';

  @override
  String get smartTodoActionExportSheets => 'Экспорт в Таблицы';

  @override
  String get smartTodoDeleteColumnTitle => 'Удалить колонку';

  @override
  String get smartTodoDeleteColumnContent =>
      'Вы уверены? Задачи в этой колонке больше не будут видны.';

  @override
  String get smartTodoNewColumn => 'Новая колонка';

  @override
  String get smartTodoColumnNameHint => 'Название колонки';

  @override
  String get smartTodoColorLabel => 'ЦВЕТ';

  @override
  String get smartTodoMarkAsDone => 'Отметить как готово';

  @override
  String get smartTodoColumnDoneDescription =>
      'Задачи в этой колонке будут считаться «Готовыми» (зачеркнутыми).';

  @override
  String get smartTodoListSettingsTitle => 'Настройки списка';

  @override
  String get smartTodoRenameList => 'Переименовать список';

  @override
  String get smartTodoManageTags => 'Управление тегами';

  @override
  String get smartTodoDeleteList => 'Удалить список';

  @override
  String get smartTodoEditPermissionError =>
      'Вы можете редактировать только назначенные вам задачи';

  @override
  String errorDeletingAccount(String error) {
    return 'Ошибка при удалении аккаунта: $error';
  }

  @override
  String get errorRecentLoginRequired =>
      'Требуется недавний вход в систему. Пожалуйста, выйдите из аккаунта и войдите снова перед удалением аккаунта.';

  @override
  String actionGuide(String framework) {
    return 'Руководство по $framework';
  }

  @override
  String get actionExportSheets => 'Экспорт в Google Таблицы';

  @override
  String get actionAuditLog => 'Журнал аудита';

  @override
  String get actionInviteMember => 'Пригласить участника';

  @override
  String get actionSettings => 'Настройки';

  @override
  String get retroSelectIcebreakerTooltip =>
      'Выберите активность для разминки (icebreaker)';

  @override
  String get retroIcebreakerLabel => 'Начальная активность';

  @override
  String get retroTimePhasesOptional => 'Таймеры фаз (опционально)';

  @override
  String get retroTimePhasesDesc =>
      'Установите длительность в минутах для каждой фазы:';

  @override
  String get retroIcebreakerSectionTitle => 'Разминка (Icebreaker)';

  @override
  String get retroBoardTitle => 'Доска ретроспективы';

  @override
  String get searchPlaceholder => 'Искать везде...';

  @override
  String get searchResultsTitle => 'Результаты поиска';

  @override
  String searchNoResults(Object query) {
    return 'Результаты по запросу «$query» не найдены';
  }

  @override
  String get searchResultTypeProject => 'Проект';

  @override
  String get searchResultTypeTodo => 'Список задач';

  @override
  String get searchResultTypeRetro => 'Ретроспектива';

  @override
  String get searchResultTypeEisenhower => 'Матрица Эйзенхауэра';

  @override
  String get searchResultTypeEstimation => 'Комната оценок';

  @override
  String get searchBackToDashboard => 'Назад в панель управления';

  @override
  String get smartTodoAddItem => 'Добавить элемент';

  @override
  String get smartTodoAddImageUrl => 'Добавить изображение (URL)';

  @override
  String get smartTodoNone => 'Нет';

  @override
  String get smartTodoPointsHint => 'Баллы (напр., 5)';

  @override
  String get smartTodoNewItem => 'Новый элемент';

  @override
  String get smartTodoDeleteComment => 'Удалить';

  @override
  String get priorityHigh => 'ВЫСОКИЙ';

  @override
  String get priorityMedium => 'СРЕДНИЙ';

  @override
  String get priorityLow => 'НИЗКИЙ';

  @override
  String get exportToEstimation => 'Отправить на оценку';

  @override
  String get exportToEstimationDesc => 'Создать сессию оценки с этими задачами';

  @override
  String get exportToEisenhower => 'Отправить в матрицу Эйзенхауэра';

  @override
  String get exportToEisenhowerDesc =>
      'Создать матрицу Эйзенхауэра с этими задачами';

  @override
  String get selectTasksToExport => 'Выберите задачи';

  @override
  String get selectTasksToExportDesc => 'Выберите задачи для включения';

  @override
  String get noTasksSelected => 'Задачи не выбраны';

  @override
  String get selectAtLeastOne => 'Выберите хотя бы одну задачу';

  @override
  String get createEstimationSession => 'Создать сессию оценки';

  @override
  String tasksSelectedCount(int count) {
    return 'Выбрано задач: $count';
  }

  @override
  String get exportSuccess => 'Успешно экспортировано';

  @override
  String get exportFromEstimation => 'Экспортировать в список';

  @override
  String get exportFromEstimationDesc =>
      'Экспортировать оцененные истории в список Smart Todo';

  @override
  String get selectDestinationList => 'Выберите целевой список';

  @override
  String get createNewList => 'Создать новый список';

  @override
  String get existingList => 'Существующий список';

  @override
  String get listName => 'Название списка';

  @override
  String get listNameHint => 'Введите название для нового списка';

  @override
  String get selectList => 'Выберите список';

  @override
  String get selectListHint => 'Выберите список';

  @override
  String get noListsAvailable => 'Нет доступных списков. Будет создан новый.';

  @override
  String storiesSelectedCount(int count) {
    return 'Выбрано историй: $count';
  }

  @override
  String get selectAll => 'Выбрать все';

  @override
  String get deselectAll => 'Снять выделение';

  @override
  String get importStories => 'Импортировать истории';

  @override
  String storiesImportedCount(int count) {
    return 'Импортировано историй: $count';
  }

  @override
  String get noEstimatedStories => 'Нет историй с оценками для импорта';

  @override
  String get selectDestinationMatrix => 'Выберите целевую матрицу';

  @override
  String get existingMatrix => 'Существующая матрица';

  @override
  String get createNewMatrix => 'Создать новую матрицу';

  @override
  String get matrixName => 'Название матрицы';

  @override
  String get matrixNameHint => 'Введите название для новой матрицы';

  @override
  String get selectMatrix => 'Выберите матрицу';

  @override
  String get selectMatrixHint => 'Выберите целевую матрицу';

  @override
  String get noMatricesAvailable => 'Нет доступных матриц. Создайте новую.';

  @override
  String activitiesCreated(int count) {
    return 'Создано элементов: $count';
  }

  @override
  String get importFromEisenhower => 'Импорт из матрицы Эйзенхауэра';

  @override
  String get importFromEisenhowerDesc =>
      'Добавить приоритетные задачи в этот список';

  @override
  String get quadrantQ1 => 'Срочно и важно (Q1)';

  @override
  String get quadrantQ2 => 'Не срочно и важно (Q2)';

  @override
  String get quadrantQ3 => 'Срочно и неважно (Q3)';

  @override
  String get quadrantQ4 => 'Не срочно и неважно (Q4)';

  @override
  String get warningQ4Tasks =>
      'Задачи Q4 обычно не стоят того, чтобы их делать. Вы уверены?';

  @override
  String get priorityMappingInfo =>
      'Маппинг приоритетов: Q1=Высокий, Q2=Средний, Q3/Q4=Низкий';

  @override
  String get selectColumns => 'Выбрать колонки';

  @override
  String get allTasks => 'Все задачи';

  @override
  String get filterByColumn => 'Фильтр по колонке';

  @override
  String get exportFromEisenhower => 'Отправить в список задач';

  @override
  String get exportFromEisenhowerDesc =>
      'Выберите элементы для экспорта в Smart Todo';

  @override
  String get filterByQuadrant => 'Фильтр по квадранту:';

  @override
  String get allActivities => 'Все';

  @override
  String activitiesSelectedCount(int count) {
    return 'Выбрано элементов: $count';
  }

  @override
  String get noActivitiesSelected => 'Нет элементов в этом фильтре';

  @override
  String get unvoted => 'БЕЗ ГОЛОСОВ';

  @override
  String tasksCreated(int count) {
    return 'Создано задач: $count';
  }

  @override
  String get exportToUserStories => 'Отправить в Agile-проект';

  @override
  String get exportToUserStoriesDesc =>
      'Отправить пользовательские истории в Agile-проект';

  @override
  String get selectDestinationProject => 'Выберите целевой проект';

  @override
  String get existingProject => 'Существующий проект';

  @override
  String get createNewProject => 'Создать новый проект';

  @override
  String get projectName => 'Название проекта';

  @override
  String get projectNameHint => 'Введите название для нового проекта';

  @override
  String get selectProject => 'Выберите проект';

  @override
  String get selectProjectHint => 'Выберите целевой проект';

  @override
  String get noProjectsAvailable => 'Нет доступных проектов. Создайте новый.';

  @override
  String get userStoryFieldMappingInfo =>
      'Маппинг: Название → Название истории, Описание → Описание истории, Затраты → Story points, Приоритет → Бизнес-ценность';

  @override
  String storiesCreated(int count) {
    return 'Создано задач: $count';
  }

  @override
  String get configureNewProject => 'Настроить новый проект';

  @override
  String get exportToAgileSprint => 'Отправить в спринт';

  @override
  String get actionSend => 'Отправить';

  @override
  String get exportToAgileSprintDesc =>
      'Добавить оцененные истории в Agile-проект';

  @override
  String get selectSprint => 'Выберите спринт';

  @override
  String get selectSprintHint => 'Выберите целевой спринт';

  @override
  String get noSprintsAvailable =>
      'Нет доступных спринтов. Сначала создайте спринт в состоянии планирования.';

  @override
  String get sprintExportFieldMappingInfo =>
      'Маппинг: Название → Название истории, Описание → Описание, Оценка → Story points';

  @override
  String get exportToSprint => 'Экспорт в Agile-проект';

  @override
  String totalStoryPoints(int count) {
    return 'Всего баллов (Story Points): $count';
  }

  @override
  String storiesAddedToSprint(int count, String sprintName) {
    return 'Добавлено задач ($count) в спринт $sprintName';
  }

  @override
  String storiesAddedToProject(int count, String projectName) {
    return 'Добавлено задач ($count) в проект $projectName';
  }

  @override
  String get exportEisenhowerToSprintDesc =>
      'Превратить элементы матрицы Эйзенхауэра в пользовательские истории в Agile-проекте';

  @override
  String get exportEisenhowerToEstimationDesc =>
      'Создать сессию оценки на основе элементов матрицы';

  @override
  String get selectedActivities => 'выбрано элементов';

  @override
  String get noActivitiesToExport => 'Нет элементов для экспорта';

  @override
  String get hiddenQ4Activities => 'Скрыто';

  @override
  String get q4Activities => 'Элементы Q4 (Удалить)';

  @override
  String get showQ4 => 'Показать Q4';

  @override
  String get hideQ4 => 'Скрыть Q4';

  @override
  String get showingAllActivities => 'Отображаются все элементы';

  @override
  String get eisenhowerMappingInfo =>
      'Q1→Must, Q2→Should, Q3→Could, Q4→Won\'t. Важность→Бизнес-ценность.';

  @override
  String get estimationExportInfo =>
      'Элементы будут добавлены как истории для оценки. Элементы Q4 не будут перенесены.';

  @override
  String get createSession => 'Создать сессию';

  @override
  String get estimationType => 'Тип оценки';

  @override
  String activitiesAddedToSprint(int count, String sprintName) {
    return 'Активностей добавлено в $sprintName: $count';
  }

  @override
  String activitiesAddedToProject(int count, String projectName) {
    return 'Активностей добавлено в проект $projectName: $count';
  }

  @override
  String estimationSessionCreated(int count) {
    return 'Сессия оценки создана с $count активностями';
  }

  @override
  String activitiesExportedToSprint(int count, String sprintName) {
    return 'Элементов ($count) экспортировано в спринт $sprintName';
  }

  @override
  String activitiesExportedToEstimation(int count, String sessionName) {
    return 'Элементов ($count) экспортировано в сессию оценки $sessionName';
  }

  @override
  String get archiveAction => 'В архив';

  @override
  String get archiveRestoreAction => 'Восстановить';

  @override
  String get archiveShowArchived => 'Показать архивные';

  @override
  String get archiveHideArchived => 'Скрыть архивные';

  @override
  String archiveConfirmTitle(String itemType) {
    return 'Архивировать $itemType';
  }

  @override
  String get archiveConfirmMessage =>
      'Вы уверены, что хотите архивировать этот элемент? Его можно будет восстановить позже.';

  @override
  String archiveRestoreConfirmTitle(String itemType) {
    return 'Восстановить $itemType';
  }

  @override
  String get archiveRestoreConfirmMessage =>
      'Вы хотите восстановить этот элемент из архива?';

  @override
  String get archiveSuccessMessage => 'Элемент успешно архивирован';

  @override
  String get archiveRestoreSuccessMessage => 'Элемент успешно восстановлен';

  @override
  String get archiveErrorMessage => 'Ошибка при архивации';

  @override
  String get archiveRestoreErrorMessage => 'Ошибка при восстановлении';

  @override
  String get archiveFilterLabel => 'Архив';

  @override
  String get archiveFilterActive => 'Активные';

  @override
  String get archiveFilterArchived => 'Архивированные';

  @override
  String get archiveFilterAll => 'Все';

  @override
  String get archiveBadge => 'В архиве';

  @override
  String get archiveEmptyMessage => 'В архиве нет элементов';

  @override
  String get completeAction => 'Завершить';

  @override
  String get reopenAction => 'Переоткрыть';

  @override
  String completeConfirmTitle(String itemType) {
    return 'Завершить $itemType';
  }

  @override
  String get completeConfirmMessage =>
      'Вы уверены, что хотите завершить этот элемент?';

  @override
  String get completeSuccessMessage => 'Элемент успешно завершен';

  @override
  String get reopenSuccessMessage => 'Элемент успешно переоткрыт';

  @override
  String get completedBadge => 'Завершен';

  @override
  String get inviteNewInvite => 'НОВОЕ ПРИГЛАШЕНИЕ';

  @override
  String get inviteRole => 'Роль:';

  @override
  String get inviteSendEmailNotification => 'Отправить уведомление по email';

  @override
  String get inviteSendInvite => 'Отправить приглашение';

  @override
  String get inviteLink => 'Ссылка для приглашения:';

  @override
  String get inviteList => 'ПРИГЛАШЕНИЯ';

  @override
  String get inviteResend => 'Отправить повторно';

  @override
  String get inviteRevokeMessage =>
      'Приглашение больше не будет действительным.';

  @override
  String get inviteResent => 'Приглашение отправлено повторно';

  @override
  String inviteSentByEmail(String email) {
    return 'Приглашение отправлено по email на $email';
  }

  @override
  String get inviteStatusPending => 'В ожидании';

  @override
  String get inviteStatusAccepted => 'Принято';

  @override
  String get inviteStatusDeclined => 'Отклонено';

  @override
  String get inviteStatusExpired => 'Истекло';

  @override
  String get inviteStatusRevoked => 'Отозвано';

  @override
  String get inviteGmailAuthTitle => 'Авторизация Gmail';

  @override
  String get inviteGmailAuthMessage =>
      'Для отправки приглашений по email необходимо повторно авторизоваться в Google.\n\nХотите продолжить?';

  @override
  String get inviteGmailAuthNo => 'Нет, только ссылка';

  @override
  String get inviteGmailAuthYes => 'Авторизовать';

  @override
  String get inviteGmailNotAvailable =>
      'Авторизация Gmail недоступна. Попробуйте выйти из системы и войти снова.';

  @override
  String get inviteGmailNoPermission =>
      'Разрешение для Gmail не предоставлено.';

  @override
  String get inviteEnterEmail => 'Введите email';

  @override
  String get inviteInvalidEmail => 'Некорректный email';

  @override
  String get pendingInvites => 'Ожидающие приглашения';

  @override
  String get noPendingInvites => 'Нет ожидающих приглашений';

  @override
  String invitedBy(String name) {
    return 'Приглашен $name';
  }

  @override
  String get inviteOpenInstance => 'Открыть';

  @override
  String get inviteAcceptFirst => 'Примите приглашение, чтобы открыть';

  @override
  String get inviteAccept => 'Принять';

  @override
  String get inviteDecline => 'Отклонить';

  @override
  String get inviteAcceptedSuccess => 'Приглашение успешно принято!';

  @override
  String get inviteAcceptedError => 'Не удалось принять приглашение';

  @override
  String get inviteDeclinedSuccess => 'Приглашение отклонено';

  @override
  String get inviteDeclinedError => 'Не удалось отклонить приглашение';

  @override
  String get inviteDeclineTitle => 'Отклонить приглашение?';

  @override
  String get inviteDeclineMessage =>
      'Вы уверены, что хотите отклонить это приглашение?';

  @override
  String expiresInHours(int hours) {
    return 'Истекает через $hours ч.';
  }

  @override
  String expiresInDays(int days) {
    return 'Истекает через $days дн.';
  }

  @override
  String get close => 'Закрыть';

  @override
  String get cancel => 'Отмена';

  @override
  String get raciTitle => 'Матрица RACI';

  @override
  String get raciNoActivities => 'Нет доступных активностей';

  @override
  String get raciAddActivity => 'Добавить активность';

  @override
  String get raciAddColumn => 'Добавить колонку';

  @override
  String get raciActivities => 'АКТИВНОСТИ';

  @override
  String get raciAssignRole => 'Назначить роль';

  @override
  String get raciNone => 'Нет';

  @override
  String get raciSaving => 'Сохранение...';

  @override
  String get raciSaveChanges => 'Сохранить изменения';

  @override
  String get raciSavedSuccessfully => 'Изменения успешно сохранены';

  @override
  String get raciErrorSaving => 'Ошибка при сохранении';

  @override
  String get raciMissingAccountable => 'Отсутствует Ответственный (A)';

  @override
  String get raciOnlyOneAccountable =>
      'Только один Ответственный (A) на активность';

  @override
  String get raciDuplicateRoles => 'Дублирование ролей';

  @override
  String get raciNoResponsible => 'Исполнитель (R) не назначен';

  @override
  String get raciTooManyInformed =>
      'Слишком много Уведомляемых (I): подумайте об уменьшении количества';

  @override
  String get raciNewColumn => 'Новая колонка';

  @override
  String get raciRemoveColumn => 'Удалить колонку';

  @override
  String raciRemoveColumnConfirm(String name) {
    return 'Удалить колонку «$name»? Все назначения ролей для этой колонки будут удалены.';
  }

  @override
  String get votingDialogTitle => 'Голосование';

  @override
  String votingDialogVoteOf(String participant) {
    return 'Голос $participant';
  }

  @override
  String get votingDialogUrgency => 'СРОЧНОСТЬ';

  @override
  String get votingDialogImportance => 'ВАЖНОСТЬ';

  @override
  String get votingDialogNotUrgent => 'Не срочно';

  @override
  String get votingDialogVeryUrgent => 'Очень срочно';

  @override
  String get votingDialogNotImportant => 'Не важно';

  @override
  String get votingDialogVeryImportant => 'Очень важно';

  @override
  String get votingDialogConfirmVote => 'Подтвердить голос';

  @override
  String get votingDialogQuadrant => 'Квадрант:';

  @override
  String get voteCollectionTitle => 'Сбор голосов';

  @override
  String get voteCollectionParticipants => 'участников';

  @override
  String get voteCollectionResult => 'Результат:';

  @override
  String get voteCollectionAverage => 'Среднее:';

  @override
  String get voteCollectionSaveVotes => 'Сохранить голоса';

  @override
  String get scatterChartTitle => 'Распределение активностей';

  @override
  String get scatterChartNoActivities => 'Нет оцененных активностей';

  @override
  String get scatterChartVoteToShow =>
      'Проголосуйте за активности, чтобы увидеть их на графике';

  @override
  String get scatterChartUrgencyLabel => 'Срочность:';

  @override
  String get scatterChartImportanceLabel => 'Важность:';

  @override
  String get scatterChartAxisUrgency => 'СРОЧНОСТЬ';

  @override
  String get scatterChartAxisImportance => 'ВАЖНОСТЬ';

  @override
  String get scatterChartQ1Label => 'Квадрант 1 - СДЕЛАТЬ';

  @override
  String get scatterChartQ2Label => 'Квадрант 2 - ЗАПЛАНИРОВАТЬ';

  @override
  String get scatterChartQ3Label => 'Квадрант 3 - ДЕЛЕГИРОВАТЬ';

  @override
  String get scatterChartQ4Label => 'Квадрант 4 - УДАЛИТЬ';

  @override
  String get scatterChartCardTitle => 'График распределения';

  @override
  String get votingStatusYou => 'Вы';

  @override
  String get votingStatusReset => 'Сбросить';

  @override
  String get estimationDecimalHintPlaceholder => 'Напр., 2.5';

  @override
  String get estimationDecimalSuffixDays => 'дн.';

  @override
  String get estimationDecimalVote => 'Голосовать';

  @override
  String estimationDecimalVoteValue(String value) {
    return 'Голос: $value дн.';
  }

  @override
  String get estimationDecimalQuickSelect => 'Быстрый выбор:';

  @override
  String get estimationDecimalEnterValue => 'Введите значение';

  @override
  String get estimationDecimalInvalidValue => 'Некорректное значение';

  @override
  String estimationDecimalMinValue(String value) {
    return 'Мин: $value';
  }

  @override
  String estimationDecimalMaxValue(String value) {
    return 'Макс: $value';
  }

  @override
  String get estimationThreePointTitle => 'Трехточечная оценка (PERT)';

  @override
  String get estimationThreePointOptimistic => 'Оптимистично (O)';

  @override
  String get estimationThreePointRealistic => 'Реалистично (M)';

  @override
  String get estimationThreePointPessimistic => 'Пессимистично (P)';

  @override
  String get estimationThreePointBestCase => 'Лучший вариант';

  @override
  String get estimationThreePointMostLikely => 'Наиболее вероятно';

  @override
  String get estimationThreePointWorstCase => 'Худший вариант';

  @override
  String get estimationThreePointAllFieldsRequired =>
      'Все поля обязательны для заполнения';

  @override
  String get estimationThreePointInvalidValues => 'Некорректные значения';

  @override
  String get estimationThreePointOptMustBeLteReal =>
      'Оптимистичное значение должно быть <= реалистичному';

  @override
  String get estimationThreePointRealMustBeLtePess =>
      'Реалистичное значение должно быть <= пессимистичному';

  @override
  String get estimationThreePointOptMustBeLtePess =>
      'Оптимистичное значение должно быть <= пессимистичному';

  @override
  String get estimationThreePointGuide => 'Руководство:';

  @override
  String get estimationThreePointGuideO =>
      'О: Оценка в лучшем случае (все идет идеально)';

  @override
  String get estimationThreePointGuideM =>
      'M: Наиболее вероятная оценка (нормальные условия)';

  @override
  String get estimationThreePointGuideP =>
      'P: Оценка в худшем случае (непредвиденные проблемы)';

  @override
  String get estimationThreePointStdDev => 'Станд. откл.';

  @override
  String get estimationThreePointDaysSuffix => 'д';

  @override
  String get storyFormNewStory => 'Новая задача';

  @override
  String get storyFormEnterTitle => 'Введите заголовок';

  @override
  String get sessionSearchHint => 'Поиск сессий...';

  @override
  String get sessionSearchFilters => 'Фильтры';

  @override
  String get sessionSearchFiltersTooltip => 'Filters';

  @override
  String get sessionSearchStatusLabel => 'Статус: ';

  @override
  String get sessionSearchStatusAll => 'Все';

  @override
  String get sessionSearchStatusDraft => 'Черновик';

  @override
  String get sessionSearchStatusActive => 'Активно';

  @override
  String get sessionSearchStatusCompleted => 'Завершено';

  @override
  String get sessionSearchModeLabel => 'Режим: ';

  @override
  String get sessionSearchModeAll => 'Все';

  @override
  String get sessionSearchRemoveFilters => 'Удалить фильтры';

  @override
  String get sessionSearchActiveFilters => 'Активные фильтры:';

  @override
  String get sessionSearchRemoveAllFilters => 'Удалить все';

  @override
  String participantsTitle(int count) {
    return 'Участников ($count)';
  }

  @override
  String get participantRoleFacilitator => 'Фасилитатор';

  @override
  String get participantRoleVoters => 'Голосующие';

  @override
  String get participantRoleObservers => 'Наблюдатели';

  @override
  String get votingBoardVotesRevealed => 'Голоса раскрыты';

  @override
  String get votingBoardVotingInProgress => 'Идет голосование';

  @override
  String votingBoardVotesCount(int voted, int total) {
    return 'Голосов: $voted/$total';
  }

  @override
  String get estimationSelectYourEstimate => 'Выберите вашу оценку';

  @override
  String estimationVoteSelected(String value) {
    return 'Выбрана оценка: $value';
  }

  @override
  String get estimationDotVotingTitle => 'Точечное голосование (Dot Voting)';

  @override
  String get estimationDotVotingDesc =>
      'Режим голосования с распределением баллов.\nСкоро появится...';

  @override
  String get estimationBucketSystemTitle => 'Система корзин (Bucket System)';

  @override
  String get estimationBucketSystemDesc =>
      'Оценка по схожести с группировкой.\nСкоро появится...';

  @override
  String get estimationModeTitle => 'Режим оценки';

  @override
  String get statisticsTitle => 'Статистика голосования';

  @override
  String get statisticsAverage => 'Среднее';

  @override
  String get statisticsMedian => 'Медиана';

  @override
  String get statisticsMode => 'Мода';

  @override
  String get statisticsVoters => 'Голосующие';

  @override
  String get statisticsPertStats => 'Статистика PERT';

  @override
  String get statisticsPertAvg => 'Среднее PERT';

  @override
  String get statisticsStdDev => 'Стандартное отклонение';

  @override
  String get statisticsVariance => 'Дисперсия';

  @override
  String get statisticsRange => 'Диапазон:';

  @override
  String get statisticsConsensusReached => 'Консенсус достигнут!';

  @override
  String get retroGuideTooltip => 'Руководство по ретроспективам';

  @override
  String get retroSearchPlaceholder => 'Поиск ретроспективы...';

  @override
  String get retroNoSearchResults => 'Ничего не найдено';

  @override
  String get retroNewRetro => 'Новая ретроспектива';

  @override
  String get retroNoProjectsFound => 'Проекты не найдены.';

  @override
  String retroDeleteMessage(String retroName) {
    return 'Вы уверены, что хотите навсегда удалить ретроспективу «$retroName»?\n\nЭто действие необратимо и приведет к удалению всех связанных данных (карточек, голосов, планов действий).';
  }

  @override
  String get retroDeletePermanently => 'Удалить навсегда';

  @override
  String get retroDeletedSuccess => 'Ретроспектива успешно удалена';

  @override
  String retroDeleteActionItemsWarning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Это также удалит $count связанных пунктов плана действий.',
      one: 'Это также удалит 1 связанный пункт плана действий.',
    );
    return '$_temp0';
  }

  @override
  String get actionIrreversible => 'Это действие невозможно отменить.';

  @override
  String get lessonsLearnedSearchPlaceholder => 'Поиск уроков...';

  @override
  String errorPrefix(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get loaderProjectIdMissing => 'Отсутствует ID проекта';

  @override
  String get loaderProjectNotFound => 'Проект не найден';

  @override
  String get loaderLoadError => 'Ошибка загрузки';

  @override
  String get loaderError => 'Ошибка';

  @override
  String get loaderUnknownError => 'Неизвестная ошибка';

  @override
  String get actionGoBack => 'Вернуться назад';

  @override
  String get authRequired => 'Требуется аутентификация';

  @override
  String get retroIdMissing => 'Отсутствует ID ретроспективы';

  @override
  String get pokerInviteStatusAccepted => 'уже было принято';

  @override
  String get pokerInviteStatusDeclined => 'было отклонено';

  @override
  String get pokerInviteStatusExpired => 'истекло';

  @override
  String get pokerInviteStatusRevoked => 'было отозвано';

  @override
  String get pokerInviteStatusPending => 'ожидает подтверждения';

  @override
  String get pokerInviteYouAreInvited => 'Вы приглашены!';

  @override
  String pokerInviteInvitedBy(String name) {
    return '$name пригласил(а) вас поучаствовать';
  }

  @override
  String get pokerInviteSessionLabel => 'Сессия';

  @override
  String get pokerInviteProjectLabel => 'Проект';

  @override
  String get pokerInviteRoleLabel => 'Назначенная роль';

  @override
  String get pokerInviteExpiryLabel => 'Срок действия';

  @override
  String pokerInviteExpiryDays(int days) {
    return 'Через $days дн.';
  }

  @override
  String get pokerInviteDecline => 'Отклонить';

  @override
  String get pokerInviteAccept => 'Принять приглашение';

  @override
  String loadingMatrixError(String error) {
    return 'Ошибка загрузки матрицы: $error';
  }

  @override
  String loadingDataError(String error) {
    return 'Error loading data: $error';
  }

  @override
  String loadingActivitiesError(String error) {
    return 'Ошибка загрузки элементов: $error';
  }

  @override
  String smartTodoSprintDays(int days) {
    return '$days дн./спринт';
  }

  @override
  String smartTodoHoursPerDay(int hours) {
    return '$hours ч/день';
  }

  @override
  String get smartTodoImageFromClipboardFound =>
      'Изображение найдено в буфере обмена';

  @override
  String get smartTodoAddImageFromClipboard =>
      'Добавить изображение из буфера обмена';

  @override
  String get smartTodoInviteCreatedAndSent =>
      'Приглашение создано и отправлено';

  @override
  String get retroColumnDropDesc =>
      'Что не приносит ценности и должно быть исключено?';

  @override
  String get retroColumnAddDesc => 'Какие новые практики нам следует внедрить?';

  @override
  String get retroColumnKeepDesc =>
      'Что работает хорошо и должно быть продолжено?';

  @override
  String get retroColumnImproveDesc => 'Что мы можем сделать лучше?';

  @override
  String get retroColumnStart => 'Начать';

  @override
  String get retroColumnStartDesc =>
      'Какие новые действия или процессы нам стоит начать для улучшения?';

  @override
  String get retroColumnStop => 'Прекратить';

  @override
  String get retroColumnStopDesc =>
      'Что не приносит ценности и что нам стоит прекратить делать?';

  @override
  String get retroColumnContinue => 'Продолжить';

  @override
  String get retroColumnContinueDesc =>
      'Что работает хорошо и что нам стоит продолжать делать?';

  @override
  String get retroColumnLongedFor => 'Желаемое';

  @override
  String get retroColumnLikedDesc => 'Что вам понравилось в этом спринте?';

  @override
  String get retroColumnLearnedDesc => 'Чему вы научились?';

  @override
  String get retroColumnLackedDesc => 'Чего не хватало в этом спринте?';

  @override
  String get retroColumnLongedForDesc =>
      'Что бы вы хотели иметь в ближайшем будущем?';

  @override
  String get retroColumnMadDesc => 'Что вызвало у вас гнев или разочарование?';

  @override
  String get retroColumnSadDesc => 'Что вас расстроило или огорчило?';

  @override
  String get retroColumnGladDesc =>
      'Что принесло вам радость или удовлетворение?';

  @override
  String get retroColumnWindDesc =>
      'Что двигало нас вперед? Сильные стороны и поддержка.';

  @override
  String get retroColumnAnchorDesc =>
      'Что нас замедляло? Препятствия и блокираторы.';

  @override
  String get retroColumnRockDesc =>
      'Какие будущие риски мы видим на горизонте?';

  @override
  String get retroColumnGoalDesc => 'Какова наша идеальная цель?';

  @override
  String get retroColumnMoreDesc => 'Чего нам стоит делать больше?';

  @override
  String get retroColumnLessDesc => 'Чего нам стоит делать меньше?';

  @override
  String get actionTypeMaintain => 'Поддерживать';

  @override
  String get actionTypeStop => 'Прекратить';

  @override
  String get actionTypeBegin => 'Начать';

  @override
  String get actionTypeIncrease => 'Увеличить';

  @override
  String get actionTypeDecrease => 'Уменьшить';

  @override
  String get actionTypePrevent => 'Предотвратить';

  @override
  String get actionTypeCelebrate => 'Отпраздновать';

  @override
  String get actionTypeReplicate => 'Тиражировать';

  @override
  String get actionTypeShare => 'Поделиться';

  @override
  String get actionTypeProvide => 'Предоставить';

  @override
  String get actionTypePlan => 'Запланировать';

  @override
  String get actionTypeLeverage => 'Использовать потенциал';

  @override
  String get actionTypeRemove => 'Удалить';

  @override
  String get actionTypeMitigate => 'Смягчить';

  @override
  String get actionTypeAlign => 'Согласовать';

  @override
  String get actionTypeEliminate => 'Исключить';

  @override
  String get actionTypeImplement => 'Внедрить';

  @override
  String get actionTypeEnhance => 'Улучшить';

  @override
  String get actionItemStatus => 'Статус';

  @override
  String get actionStatusOpen => 'Открыто';

  @override
  String get actionStatusInProgress => 'В процессе';

  @override
  String get actionStatusCompleted => 'Завершено';

  @override
  String get actionStatusDeferred => 'Отложено';

  @override
  String get retroSectionActive => 'Активные';

  @override
  String get retroSectionHistory => 'История';

  @override
  String get retroSectionActionTracker => 'Планы действий';

  @override
  String get retroSectionLessonsLearned => 'Выученные уроки';

  @override
  String get retroNoActiveRetro => 'Нет активных ретроспектив';

  @override
  String get retroStartNew => 'Начать новую ретроспективу';

  @override
  String get retroHistoryEmpty => 'Завершенных ретроспектив пока нет';

  @override
  String get retroViewSummary => 'Просмотр итогов';

  @override
  String get retroSummaryTitle => 'Итоги ретроспективы';

  @override
  String retroSummaryCards(Object count) {
    return 'Карточки ($count)';
  }

  @override
  String retroSummaryActions(Object count) {
    return 'Действия ($count)';
  }

  @override
  String get retroSummarySentiment => 'Настроение команды';

  @override
  String get actionTrackerTitle => 'Трекер планов действий';

  @override
  String get actionTrackerEmpty => 'Планов действий пока нет';

  @override
  String get actionTrackerFilterByAssignee => 'Фильтр по исполнителю';

  @override
  String get actionTrackerFilterByStatus => 'Фильтр по статусу';

  @override
  String get actionTrackerFilterByRetro => 'Фильтр по ретроспективе';

  @override
  String get actionTrackerCompletionRate => 'Процент выполнения';

  @override
  String get actionTrackerCarryForward => 'Перенос';

  @override
  String get actionTrackerCarryForwardDesc =>
      'Эти пункты плана из предыдущих ретроспектив всё еще открыты:';

  @override
  String get actionTrackerCarryForwardConfirm => 'Перенести выбранные элементы';

  @override
  String get lessonsLearnedTitle => 'Реестр выученных уроков';

  @override
  String get lessonsLearnedEmpty => 'Записей об уроках пока нет';

  @override
  String get lessonsLearnedCreate => 'Добавить урок';

  @override
  String get lessonsLearnedEdit => 'Редактировать урок';

  @override
  String get lessonsLearnedDelete => 'Удалить урок';

  @override
  String get lessonsLearnedDeleteConfirm =>
      'Вы уверены, что хотите удалить этот урок?';

  @override
  String get lessonCategoryProcess => 'Процесс';

  @override
  String get lessonCategoryTechnical => 'Техническое';

  @override
  String get lessonCategoryTeam => 'Команда';

  @override
  String get lessonCategoryCommunication => 'Коммуникации';

  @override
  String get lessonCategoryTools => 'Инструменты';

  @override
  String get lessonCategoryQuality => 'Качество';

  @override
  String get lessonCategoryEstimation => 'Оценка';

  @override
  String get lessonTypeStrength => 'Сильная сторона';

  @override
  String get lessonTypeWeakness => 'Слабая сторона';

  @override
  String get lessonTypeRecommendation => 'Рекомендация';

  @override
  String get lessonFieldTitle => 'Заголовок';

  @override
  String get lessonFieldDescription => 'Описание';

  @override
  String get lessonFieldRootCause => 'Первопричина';

  @override
  String get lessonFieldRecommendation => 'Рекомендация';

  @override
  String get lessonFieldTags => 'Теги';

  @override
  String get lessonIsRecurring => 'Повторяющийся паттерн';

  @override
  String lessonOccurrenceCount(Object count) {
    return 'Случаев: $count';
  }

  @override
  String get lessonIsResolved => 'Решено';

  @override
  String get generateLessonsTitle => 'Генерация выученных уроков';

  @override
  String get generateLessonsDesc =>
      'Просмотрите выводы этой ретроспективы и сохраните их как усвоенные уроки.';

  @override
  String get generateLessonsFromCards => 'Предложено на основе карточек';

  @override
  String get generateLessonsFromActions =>
      'Предложено на основе планов действий';

  @override
  String get generateLessonsSelectToSave =>
      'Выберите элементы для сохранения как уроков';

  @override
  String get generateLessonsSave => 'Сохранить выбранные уроки';

  @override
  String get retroTrendTitle => 'Тренды улучшения команды';

  @override
  String get retroTrendSentiment => 'Динамика настроения';

  @override
  String get retroTrendActionCompletion => 'Выполнение планов действий';

  @override
  String get retroTrendImproving => 'Команда совершенствуется!';

  @override
  String get retroTrendStable => 'Показатели стабильны';

  @override
  String get retroTrendDeclining => 'Требуется внимание';

  @override
  String get crossProjectImport => 'Импорт из других проектов';

  @override
  String get crossProjectImportActions => 'Импортировать планы действий';

  @override
  String get crossProjectImportLessons => 'Импортировать выученные уроки';

  @override
  String get crossProjectSelectProject => 'Выберите проект';

  @override
  String get crossProjectNoProjects => 'Других ваших проектов не найдено';

  @override
  String crossProjectImportSuccess(Object count) {
    return 'Успешно импортировано элементов: $count';
  }

  @override
  String get crossProjectAggregatedView => 'Уроки по всем проектам';

  @override
  String get tooltipTrackerStatusClick => 'Нажмите, чтобы изменить статус';

  @override
  String get tooltipTrackerFilterStatus =>
      'Фильтровать планы действий по текущему статусу';

  @override
  String get tooltipTrackerFilterAssignee =>
      'Фильтровать по исполнителю, назначенному на задачу';

  @override
  String get tooltipTrackerFilterRetro =>
      'Фильтровать по исходной ретроспективе';

  @override
  String get tooltipTrackerCompletionRate =>
      'Процент всех выполненных планов действий';

  @override
  String get tooltipTrackerOverdue =>
      'Срок выполнения этого пункта плана действий истек';

  @override
  String get tooltipPriorityCritical =>
      'Критический: требуется немедленное решение';

  @override
  String get tooltipPriorityHigh => 'Высокий: решение в рамках спринта';

  @override
  String get tooltipPriorityMedium =>
      'Средний: планирование на ближайшие спринты';

  @override
  String get tooltipPriorityLow =>
      'Низкий: желательно сделать, когда будет возможность';

  @override
  String get tooltipLessonCategoryFilter =>
      'Фильтровать уроки по области влияния';

  @override
  String get tooltipLessonTypeFilter =>
      'Фильтровать по типу урока: сильная сторона, слабая сторона или рекомендация';

  @override
  String get tooltipLessonResolvedFilter =>
      'Показывать все, только нерешенные или только решенные уроки';

  @override
  String get tooltipLessonRecurring =>
      'Этот урок повторялся в нескольких ретроспективах';

  @override
  String get tooltipLessonResolved => 'Этот вопрос был рассмотрен и решен';

  @override
  String get tooltipLessonImport =>
      'Импорт выученных уроков из других ваших проектов';

  @override
  String get tooltipLessonAdd =>
      'Записать новый выученный урок для этого проекта';

  @override
  String get tooltipLessonLongPressDelete =>
      'Долгое нажатие на карточку урока, чтобы удалить его';

  @override
  String get tooltipCarryForwardDesc =>
      'Перенос незавершенных задач из предыдущих ретроспектив в новую';

  @override
  String get tooltipCarryForwardSelectAll =>
      'Выбрать или отменить выбор всех ожидающих задач';

  @override
  String get tooltipCrossProjectImportDesc =>
      'Уроки будут скопированы в текущий проект со ссылкой на источник';

  @override
  String get tooltipTrendSentiment =>
      'Средняя оценка настроения команды (1-5) по итогам ретроспектив';

  @override
  String get tooltipTrendCompletion =>
      'Процент выполненных задач по каждой ретроспективе';

  @override
  String get tooltipTrendImproving =>
      'Метрики команды показывают положительную динамику';

  @override
  String get tooltipTrendDeclining =>
      'Метрики команды снижаются — рассмотрите первопричины';

  @override
  String get tooltipTrendStable =>
      'Метрики команды стабильны в последних ретроспективах';

  @override
  String get tooltipHistoryRetroCard =>
      'Нажмите, чтобы просмотреть полные итоги ретроспективы';

  @override
  String get tooltipHistorySentiment =>
      'Среднее настроение команды на этой ретроспективе';

  @override
  String get tooltipHistoryActionCount =>
      'Выполненные задачи по отношению к общему количеству на этой ретроспективе';

  @override
  String get tooltipFormRootCause =>
      'Опишите первопричину, которая привела к этому наблюдению';

  @override
  String get tooltipFormRecommendation =>
      'Предложите конкретные действия для решения проблемы или закрепления успеха';

  @override
  String get tooltipFormTags =>
      'Добавьте теги через запятую для категорий и поиска';

  @override
  String get tooltipFormRecurring =>
      'Включите, если этот урок повторялся в нескольких ретроспективах';

  @override
  String get tooltipFormResolved =>
      'Отметьте как решенное, когда команда отработает этот урок';

  @override
  String get guideActionTrackingTitle => 'Лучшие практики по планам действий';

  @override
  String get guideActionTrackingDesc =>
      'Используйте критерии SMART: конкретность, измеримость, достижимость, актуальность, ограниченность по времени. Назначьте ответственного, установите срок в рамках спринта и проверяйте прогресс на следующей ретроспективе.';

  @override
  String get guideLessonsLearnedTitle => 'Методика выученных уроков';

  @override
  String get guideLessonsLearnedDesc =>
      'Фиксируйте как сильные стороны (что тиражировать), так и слабые (что улучшить). Документируйте первопричины и рекомендации. Используйте теги для повторного использования в других проектах.';

  @override
  String get guideContinuousImprovementTitle => 'Цикл непрерывного улучшения';

  @override
  String get guideContinuousImprovementDesc =>
      'Отслеживайте тренды ретроспектив для измерения прогресса. Переносите незавершенные действия. Импортируйте уроки из других проектов. Сосредоточьтесь на системных изменениях, а не на разовых исправлениях.';

  @override
  String get guideCarryForwardTitle => 'Процесс переноса (Carry Forward)';

  @override
  String get guideCarryForwardDesc =>
      'При создании новой ретроспективы просмотрите открытые задачи из предыдущих. Переносите те, которые всё еще актуальны, и переоценивайте их приоритет в новом контексте.';

  @override
  String retroFromSprint(Object name) {
    return 'Из: Спринта $name';
  }

  @override
  String actionItemsCompleted(Object completed, Object total) {
    return '$completed/$total выполнено';
  }

  @override
  String get coachTipSSCWriting =>
      'Сосредоточьтесь на конкретных, наблюдаемых действиях. Каждый пункт должен быть тем, на что команда может повлиять напрямую. Избегайте расплывчатых формулировок.';

  @override
  String get coachTipSSCVoting =>
      'Голосуйте исходя из влияния и осуществимости. Элементы с наибольшим количеством голосов станут вашими обязательствами на спринт.';

  @override
  String get coachTipSSCDiscuss =>
      'Для каждого популярного элемента определите, КТО, ЧТО и к КАКОМУ СРОКУ сделает. Превращайте инсайты в конкретные действия.';

  @override
  String get coachTipMSGWriting =>
      'Создайте безопасное пространство для выражения эмоций. Все чувства важны. Сосредоточьтесь на ситуации, а не на личности. Используйте «Я чувствую...».';

  @override
  String get coachTipMSGVoting =>
      'Голосуйте, чтобы выявить общий опыт. Паттерны в эмоциях раскрывают динамику команды, требующую внимания.';

  @override
  String get coachTipMSGDiscuss =>
      'Признайте эмоции, прежде чем переходить к решению проблем. Спрашивайте «Что бы помогло?», а не просто предлагайте готовые решения. Слушайте активно.';

  @override
  String get coachTip4LsWriting =>
      'Размышляйте об усвоенных уроках, а не только о событиях. Подумайте о том, какие выводы вы возьмете с собой. Каждая «L» представляет разную перспективу.';

  @override
  String get coachTip4LsVoting =>
      'Приоритизируйте уроки, которые могут улучшить будущие спринты. Сосредоточьтесь на передаваемых знаниях.';

  @override
  String get coachTip4LsDiscuss =>
      'Превращайте выводы в документацию или изменения процессов. Спрашивайте: «Как мы можем поделиться этим знанием с другими?»';

  @override
  String get coachTipSailboatWriting =>
      'Используйте метафору: Ветер толкает нас вперед (помощники), Якоря замедляют (препятствия), Скалы — будущие риски, Остров — наша цель.';

  @override
  String get coachTipSailboatVoting =>
      'Приоритизируйте на основе влияния рисков и потенциала помощников. Соблюдайте баланс между устранением препятствий и использованием преимуществ.';

  @override
  String get coachTipSailboatDiscuss =>
      'Создайте реестр рисков для «скал». Определите стратегии смягчения. Используйте «ветер», чтобы преодолеть «якоря».';

  @override
  String get coachTipDAKIWriting =>
      'Будьте решительны: Убирайте (Drop) то, что тратит время; Добавляйте (Add) то, чего не хватает; Сохраняйте (Keep) то, что работает; Улучшайте (Improve) то, что может быть лучше.';

  @override
  String get coachTipDAKIVoting =>
      'Голосуйте прагматично. Сосредоточьтесь на изменениях, которые дадут немедленный измеримый результат.';

  @override
  String get coachTipDAKIDiscuss =>
      'Принимайте четкие командные решения. Для каждого пункта либо наметьте конкретное действие, либо явно решите ничего не предпринимать.';

  @override
  String get coachTipStarfishWriting =>
      'Используйте градации: Сохранить (Keep), Больше (More), Меньше (Less), Прекратить (Stop), Начать (Start). Это дает более нюансированную обратную связь.';

  @override
  String get coachTipStarfishVoting =>
      'Учитывайте соотношение усилий и влияния. Изменения в категориях «Больше» и «Меньше» могут быть проще в реализации, чем «Начать» или «Прекратить».';

  @override
  String get coachTipStarfishDiscuss =>
      'Определите конкретные метрики для «Больше» и «Меньше». Насколько больше? Как мы это измерим? Установите четкие цели.';

  @override
  String get discussPromptSSCStart =>
      'Какую новую практику нам следует начать? Подумайте о пробелах в наших процессах, которые может заполнить новая привычка.';

  @override
  String get discussPromptSSCStop =>
      'Что тратит наше время или энергию? Рассмотрите действия, ценность которых не соответствует затратам.';

  @override
  String get discussPromptSSCContinue =>
      'Что работает хорошо? Признайте и закрепите эффективные практики.';

  @override
  String get discussPromptMSGMad =>
      'Что вызвало у вас разочарование? Помните, мы обсуждаем ситуации, а не ищем виноватых.';

  @override
  String get discussPromptMSGSad =>
      'Что вас огорчило? Какие ожидания не оправдались?';

  @override
  String get discussPromptMSGGlad =>
      'Что принесло вам радость? Какие моменты принесли удовлетворение в этом спринте?';

  @override
  String get discussPrompt4LsLiked =>
      'Что вам понравилось? Что сделало работу приятной?';

  @override
  String get discussPrompt4LsLearned =>
      'Какой новый навык, идею или знания вы получили?';

  @override
  String get discussPrompt4LsLacked =>
      'Чего не хватало? Какие ресурсы, поддержка или ясность помогли бы?';

  @override
  String get discussPrompt4LsLonged =>
      'О чем вы мечтаете? Что сделало бы будущие спринты лучше?';

  @override
  String get discussPromptSailboatWind =>
      'Что двигало нас вперед? Каковы наши сильные стороны и внешняя поддержка?';

  @override
  String get discussPromptSailboatAnchor =>
      'Что нас замедляло? Какие внутренние или внешние препятствия мешали нам?';

  @override
  String get discussPromptSailboatRock =>
      'Какие риски мы видим впереди? Что может сбить нас с пути, если не принять меры?';

  @override
  String get discussPromptSailboatGoal =>
      'Какова наша цель? Согласны ли все с направлением нашего движения?';

  @override
  String get discussPromptDAKIDrop =>
      'Что нам следует исключить? Что не приносит никакой ценности?';

  @override
  String get discussPromptDAKIAdd =>
      'Что нам следует внедрить? Чего не хватает в нашем инструментарии?';

  @override
  String get discussPromptDAKIKeep =>
      'Что нам необходимо сохранить? Что критически важно для нашего успеха?';

  @override
  String get discussPromptDAKIImprove =>
      'Что можно улучшить? Где мы можем стать лучше?';

  @override
  String get discussPromptStarfishKeep =>
      'Что нам следует оставить ровно в таком виде, как есть сейчас?';

  @override
  String get discussPromptStarfishMore =>
      'Что нам следует увеличить? Чего делать больше?';

  @override
  String get discussPromptStarfishLess =>
      'Что нам следует сократить? Чего делать меньше?';

  @override
  String get discussPromptStarfishStop =>
      'От чего нам следует полностью отказаться?';

  @override
  String get discussPromptStarfishStart =>
      'Какое новое дело нам следует начать?';

  @override
  String get discussPromptGeneric =>
      'Какие идеи возникли при обсуждении этой колонки? Какие паттерны вы видите?';

  @override
  String get smartPromptSSCStartQuestion =>
      'Какую конкретно новую практику вы начнете и как вы измерите её внедрение?';

  @override
  String get smartPromptSSCStartExample =>
      'напр., «Начать ежедневные 15-минутные стендапы в 9:30, отслеживать посещаемость в течение 2 недель»';

  @override
  String get smartPromptSSCStartPlaceholder =>
      'Мы начнем [практику] к [дате], измеряя результат по [метрике]';

  @override
  String get smartPromptSSCStopQuestion =>
      'Что вы прекратите делать и что вы будете делать взамен?';

  @override
  String get smartPromptSSCStopExample =>
      'напр., «Прекратить рассылку обновлений статуса по email, использовать вместо этого канал Slack #updates»';

  @override
  String get smartPromptSSCStopPlaceholder =>
      'Мы прекратим [практику] и вместо этого будем [альтернатива]';

  @override
  String get smartPromptSSCContinueQuestion =>
      'Какую практику вы продолжите и как вы обеспечите её сохранение?';

  @override
  String get smartPromptSSCContinueExample =>
      'напр., «Продолжать код-ревью в течение 4 часов, добавить в Definition of Done»';

  @override
  String get smartPromptSSCContinuePlaceholder =>
      'Мы продолжим [практику], закрепив её с помощью [механизма]';

  @override
  String get smartPromptMSGMadQuestion =>
      'Какое действие решит причину этого недовольства и кто его возглавит?';

  @override
  String get smartPromptMSGMadExample =>
      'напр., «Запланировать встречу с PM для уточнения процесса работы с требованиями — Мария к пятнице»';

  @override
  String get smartPromptMSGMadPlaceholder =>
      '[Действие по решению проблемы], ответственный: [имя], к: [дате]';

  @override
  String get smartPromptMSGSadQuestion =>
      'Какое изменение предотвратит повторение этого разочарования?';

  @override
  String get smartPromptMSGSadExample =>
      'напр., «Создать чек-лист коммуникаций для обновлений стейкхолдеров — еженедельный обзор»';

  @override
  String get smartPromptMSGSadPlaceholder =>
      '[Превентивное действие], отслеживается через [метод]';

  @override
  String get smartPromptMSGGladQuestion =>
      'Как мы можем тиражировать или усилить то, что принесло нам радость?';

  @override
  String get smartPromptMSGGladExample =>
      'напр., «Задокументировать формат парных сессий и поделиться с другими командами до конца недели»';

  @override
  String get smartPromptMSGGladPlaceholder =>
      '[Действие по тиражированию/усилению], поделиться с [аудитория]';

  @override
  String get smartPrompt4LsLikedQuestion =>
      'Как нам закрепить этот положительный опыт?';

  @override
  String get smartPrompt4LsLikedExample =>
      'напр., «Сделать моб-программирование еженедельным событием в календаре»';

  @override
  String get smartPrompt4LsLikedPlaceholder =>
      '[Действие для закрепления положительного опыта]';

  @override
  String get smartPrompt4LsLearnedQuestion =>
      'Как вы задокументируете этот урок и поделитесь им?';

  @override
  String get smartPrompt4LsLearnedExample =>
      'напр., «Написать статью в вики о новом подходе к тестированию, выступить на тех-токе в следующем месяце»';

  @override
  String get smartPrompt4LsLearnedPlaceholder =>
      'Задокументировать в [место], поделиться через [способ] к [дата]';

  @override
  String get smartPrompt4LsLackedQuestion =>
      'Какие конкретные ресурсы или поддержка вам нужны и от кого?';

  @override
  String get smartPrompt4LsLackedExample =>
      'напр., «Запросить бюджет на обучение CI/CD у менеджера — подать до следующего планирования»';

  @override
  String get smartPrompt4LsLackedPlaceholder =>
      'Запросить [ресурс] у [лицо/команда], срок: [дата]';

  @override
  String get smartPrompt4LsLongedQuestion =>
      'Какой конкретный первый шаг приблизит вас к этому пожеланию?';

  @override
  String get smartPrompt4LsLongedExample =>
      'напр., «Подготовить предложение о выделении 20% времени на побочные проекты — передать тимлиду в понедельник»';

  @override
  String get smartPrompt4LsLongedPlaceholder =>
      'Первый шаг к [пожелание]: [действие] к [дата]';

  @override
  String get smartPromptSailboatWindQuestion =>
      'Как вы используете этот фактор ускорения для прогресса?';

  @override
  String get smartPromptSailboatWindExample =>
      'напр., «Использовать сильную экспертизу QA для обучения джунов — запланировать первую сессию на этой неделе»';

  @override
  String get smartPromptSailboatWindPlaceholder =>
      'Использовать [фактор] через [конкретное действие]';

  @override
  String get smartPromptSailboatAnchorQuestion =>
      'Какое конкретное действие устранит или ослабит это препятствие?';

  @override
  String get smartPromptSailboatAnchorExample =>
      'напр., «Эскалировать проблему инфраструктуры CTO — подготовить краткий отчет к среде»';

  @override
  String get smartPromptSailboatAnchorPlaceholder =>
      'Устранить [препятствие] через [действие], эскалировать [лицо] при необходимости';

  @override
  String get smartPromptSailboatRockQuestion =>
      'Какую стратегию смягчения вы примените для этого риска?';

  @override
  String get smartPromptSailboatRockExample =>
      'напр., «Подготовить план отката для зависимости от вендора — задокументировать альтернативы до конца спринта»';

  @override
  String get smartPromptSailboatRockPlaceholder =>
      'Смягчить [риск] через [стратегия], триггер: [условие]';

  @override
  String get smartPromptSailboatGoalQuestion =>
      'Какая веха подтвердит прогресс в достижении этой цели?';

  @override
  String get smartPromptSailboatGoalExample =>
      'напр., «Показать демо MVP стейкхолдерам к 15 февраля, собрать фидбек через опрос»';

  @override
  String get smartPromptSailboatGoalPlaceholder =>
      'Веха на пути к [цель]: [результат] к [дата]';

  @override
  String get smartPromptDAKIDropQuestion =>
      'Что вы исключите и как вы гарантируете, что это не повторится?';

  @override
  String get smartPromptDAKIDropExample =>
      'напр., «Убрать ручные шаги развертывания — автоматизировать до конца спринта»';

  @override
  String get smartPromptDAKIDropPlaceholder =>
      'Исключить [практика], предотвратить возвращение через [механизм]';

  @override
  String get smartPromptDAKIAddQuestion =>
      'Какую новую практику вы внедрите и как вы проверите её эффективность?';

  @override
  String get smartPromptDAKIAddExample =>
      'напр., «Добавить систему фиче-флагов — протестировать на 2 функциях, оценить результат через 2 недели»';

  @override
  String get smartPromptDAKIAddPlaceholder =>
      'Добавить [практика], проверить успех через [метрика]';

  @override
  String get smartPromptDAKIKeepQuestion =>
      'Как вы защитите эту практику от снижения приоритета?';

  @override
  String get smartPromptDAKIKeepExample =>
      'напр., «Соблюдать стандарты код-ревью — добавить в командный устав, аудит ежемесячно»';

  @override
  String get smartPromptDAKIKeepPlaceholder =>
      'Защитить [практика] через [механизм]';

  @override
  String get smartPromptDAKIImproveQuestion =>
      'Какое конкретное улучшение вы внесете и как вы его измерите?';

  @override
  String get smartPromptDAKIImproveExample =>
      'напр., «Увеличить покрытие тестами с 60% до 80% — сначала сфокусироваться на модуле оплаты»';

  @override
  String get smartPromptDAKIImprovePlaceholder =>
      'Улучшить [практика] с [текущий] до [целевой] к [дата]';

  @override
  String get smartPromptStarfishKeepQuestion =>
      'Какую практику вы сохраните и кто отвечает за её соблюдение?';

  @override
  String get smartPromptStarfishKeepExample =>
      'напр., «Проводить демо по пятницам — Том бронирует переговорную, повестка готова к четвергу»';

  @override
  String get smartPromptStarfishKeepPlaceholder =>
      'Сохранить [практика], ответственный: [имя]';

  @override
  String get smartPromptStarfishMoreQuestion =>
      'Что вы увеличите и на сколько?';

  @override
  String get smartPromptStarfishMoreExample =>
      'напр., «Увеличить время парного программирования с 2 ч до 6 ч в неделю на разработчика»';

  @override
  String get smartPromptStarfishMorePlaceholder =>
      'Увеличить [практика] с [текущий уровень] до [целевой уровень]';

  @override
  String get smartPromptStarfishLessQuestion =>
      'Что вы сократите и на сколько?';

  @override
  String get smartPromptStarfishLessExample =>
      'напр., «Сократить время встреч с 10 ч до 6 ч в неделю — отменить повторяющееся ревью»';

  @override
  String get smartPromptStarfishLessPlaceholder =>
      'Сократить [практика] с [текущий уровень] до [целевой уровень]';

  @override
  String get smartPromptStarfishStopQuestion =>
      'Что вы полностью прекратите и что это заменит (если требуется)?';

  @override
  String get smartPromptStarfishStopExample =>
      'напр., «Прекратить детальный учет времени по задачам — использовать доверительные оценки»';

  @override
  String get smartPromptStarfishStopPlaceholder =>
      'Прекратить [практику], заменить на [альтернативу] или убрать совсем';

  @override
  String get smartPromptStarfishStartQuestion =>
      'Какую новую практику вы начнете и когда будет первое применение?';

  @override
  String get smartPromptStarfishStartExample =>
      'напр., «Начать Вторники Тех-Долга — первая сессия на следующей неделе, 2 часа защищенного времени»';

  @override
  String get smartPromptStarfishStartPlaceholder =>
      'Начать [практика], первое применение: [дата/время]';

  @override
  String get smartPromptGenericQuestion =>
      'Какое конкретное действие решит этот вопрос?';

  @override
  String get smartPromptGenericExample =>
      'напр., «Определить конкретное действие с ответственным, сроком и критериями успеха»';

  @override
  String get smartPromptGenericPlaceholder =>
      '[Действие], ответственный: [имя], к: [дата]';

  @override
  String get methodologyFocusAction =>
      'Ориентировано на действия: фокус на конкретных поведенческих изменениях';

  @override
  String get methodologyFocusEmotion =>
      'Ориентировано на эмоции: исследование чувств команды для психологической безопасности';

  @override
  String get methodologyFocusLearning =>
      'Ориентировано на обучение: акцент на фиксации и обмене знаниями';

  @override
  String get methodologyFocusRisk =>
      'Риски и Цели: баланс между помощниками, препятствиями, рисками и задачами';

  @override
  String get methodologyFocusCalibration =>
      'Калибровка: использует градации (больше/меньше) для тонкой настройки';

  @override
  String get methodologyFocusDecision =>
      'Решения: стимулирует четкие командные решения по практикам';

  @override
  String get exportSheetOverview => 'Обзор';

  @override
  String get exportSheetActionItems => 'Планы действий';

  @override
  String get exportSheetBoardItems => 'Элементы доски';

  @override
  String get exportSheetTeamHealth => 'Состояние команды';

  @override
  String get exportSheetLessonsLearned => 'Выученные уроки';

  @override
  String get exportSheetRiskRegister => 'Реестр рисков';

  @override
  String get exportSheetCalibrationMatrix => 'Матрица калибровки';

  @override
  String get exportSheetDecisionLog => 'Журнал решений';

  @override
  String get exportHeaderRetrospectiveReport => 'ОТЧЕТ ПО РЕТРОСПЕКТИВЕ';

  @override
  String get exportHeaderTitle => 'Заголовок:';

  @override
  String get exportHeaderDate => 'Дата:';

  @override
  String get exportHeaderTemplate => 'Шаблон:';

  @override
  String get exportHeaderMethodology => 'Методология:';

  @override
  String get exportHeaderSentiments => 'Настроение (среднее):';

  @override
  String get exportHeaderParticipants => 'УЧАСТНИКИ';

  @override
  String get exportHeaderSummary => 'ИТОГИ';

  @override
  String get exportHeaderTotalItems => 'Всего элементов:';

  @override
  String get exportHeaderActionItems => 'Планы действий:';

  @override
  String get exportHeaderSuggestedFollowUp => 'Рекомендуемые шаги:';

  @override
  String get exportTeamHealthTitle => 'АНАЛИЗ СОСТОЯНИЯ КОМАНДЫ';

  @override
  String get exportTeamHealthEmotionalDistribution => 'Распределение эмоций';

  @override
  String get exportTeamHealthMadCount => 'Недовольство (Mad):';

  @override
  String get exportTeamHealthSadCount => 'Огорчение (Sad):';

  @override
  String get exportTeamHealthGladCount => 'Радость (Glad):';

  @override
  String get exportTeamHealthMadItems => 'НЕУДОВЛЕТВОРЕННОСТЬ (Mad)';

  @override
  String get exportTeamHealthSadItems => 'РАЗОЧАРОВАНИЯ (Sad)';

  @override
  String get exportTeamHealthGladItems => 'УСПЕХИ (Glad)';

  @override
  String get exportTeamHealthRecommendation =>
      'Рекомендации по состоянию команды:';

  @override
  String get exportTeamHealthHighFrustration =>
      'Обнаружен высокий уровень неудовлетворенности. Рекомендуется провести отдельную сессию по решению проблем.';

  @override
  String get exportTeamHealthBalanced =>
      'Сбалансированное эмоциональное состояние. Команда демонстрирует здоровые способности к рефлексии.';

  @override
  String get exportTeamHealthPositive =>
      'Позитивный моральный дух. Используйте эту энергию для внедрения сложных улучшений.';

  @override
  String get exportLessonsLearnedTitle => 'ЖУРНАЛ УСВОЕННЫХ УРОКОВ';

  @override
  String get exportLessonsLearnedWhatWorked => 'ЧТО СРАБОТАЛО (Liked)';

  @override
  String get exportLessonsLearnedNewSkills =>
      'НОВЫЕ НАВЫКИ И ИНСАЙТЫ (Learned)';

  @override
  String get exportLessonsLearnedGaps =>
      'ПРОБЕЛЫ И НЕДОСТАЮЩИЕ ЭЛЕМЕНТЫ (Lacked)';

  @override
  String get exportLessonsLearnedWishes => 'БУДУЩИЕ ПОЖЕЛАНИЯ (Longed For)';

  @override
  String get exportLessonsLearnedKnowledgeActions =>
      'Действия по обмену знаниями';

  @override
  String get exportLessonsLearnedDocumentationNeeded =>
      'Необходимая документация:';

  @override
  String get exportLessonsLearnedTrainingNeeded =>
      'Требуется обучение/обмен знаниями:';

  @override
  String get exportRiskRegisterTitle => 'РЕЕСТР РИСКОВ И ФАКТОРОВ УСКОРЕНИЯ';

  @override
  String get exportRiskRegisterEnablers => 'ПОМОЩНИКИ (Ветер)';

  @override
  String get exportRiskRegisterBlockers => 'ПРЕПЯТСТВИЯ (Якорь)';

  @override
  String get exportRiskRegisterRisks => 'РИСКИ (Скалы)';

  @override
  String get exportRiskRegisterGoals => 'ЦЕЛИ (Остров)';

  @override
  String get exportRiskRegisterRiskItem => 'Риск';

  @override
  String get exportRiskRegisterImpact => 'Потенциальное влияние';

  @override
  String get exportRiskRegisterMitigation => 'Действие по смягчению';

  @override
  String get exportRiskRegisterStatus => 'Статус';

  @override
  String get exportRiskRegisterGoalAlignment => 'Проверка соответствия целям:';

  @override
  String get exportRiskRegisterGoalAlignmentNote =>
      'Проверьте, соответствуют ли текущие действия поставленным целям.';

  @override
  String get exportCalibrationTitle => 'МАТРИЦА КАЛИБРОВКИ';

  @override
  String get exportCalibrationKeepDoing => 'ПРОДОЛЖАТЬ';

  @override
  String get exportCalibrationDoMore => 'ДЕЛАТЬ БОЛЬШЕ';

  @override
  String get exportCalibrationDoLess => 'ДЕЛАТЬ МЕНЬШЕ';

  @override
  String get exportCalibrationStopDoing => 'ПРЕКРАТИТЬ';

  @override
  String get exportCalibrationStartDoing => 'НАЧАТЬ';

  @override
  String get exportCalibrationPractice => 'Практика';

  @override
  String get exportCalibrationCurrentState => 'Текущее состояние';

  @override
  String get exportCalibrationTargetState => 'Целевое состояние';

  @override
  String get exportCalibrationAdjustment => 'Корректировка';

  @override
  String get exportCalibrationNote =>
      'Калибровка направлена на тонкую настройку существующих практик, а не на радикальные изменения.';

  @override
  String get exportDecisionLogTitle => 'ЖУРНАЛ РЕШЕНИЙ';

  @override
  String get exportDecisionLogDrop => 'РЕШЕНИЯ ОБ ОТКАЗЕ (Drop)';

  @override
  String get exportDecisionLogAdd => 'РЕШЕНИЯ О ДОБАВЛЕНИИ';

  @override
  String get exportDecisionLogKeep => 'РЕШЕНИЯ О СОХРАНЕНИИ (Keep)';

  @override
  String get exportDecisionLogImprove => 'РЕШЕНИЯ ОБ УЛУЧШЕНИИ (Improve)';

  @override
  String get exportDecisionLogDecision => 'Решение';

  @override
  String get exportDecisionLogRationale => 'Обоснование';

  @override
  String get exportDecisionLogOwner => 'Ответственный';

  @override
  String get exportDecisionLogDeadline => 'Срок';

  @override
  String get exportDecisionLogPrioritizationNote =>
      'Рекомендации по приоритизации:';

  @override
  String get exportDecisionLogPrioritizationHint =>
      'Сначала сосредоточьтесь на решениях об отказе (DROP), чтобы высвободить ресурсы, а затем внедряйте новые практики (ADD).';

  @override
  String get exportNoItems => 'Записи отсутствуют';

  @override
  String get exportNoActionItems => 'Планов действий нет';

  @override
  String get exportNotApplicable => 'Н/Д';

  @override
  String get facilitatorGuideTitle => 'Гайд по сбору действий';

  @override
  String get facilitatorGuideCoverage => 'Покрытие';

  @override
  String get facilitatorGuideComplete => 'Завершено';

  @override
  String get facilitatorGuideIncomplete => 'Не завершено';

  @override
  String get facilitatorGuideSuggestedOrder => 'Рекомендуемый порядок:';

  @override
  String get facilitatorGuideMissingRequired =>
      'Отсутствуют обязательные действия';

  @override
  String get facilitatorGuideColumnHasAction => 'Действие есть';

  @override
  String get facilitatorGuideColumnNoAction => 'Действий пока нет';

  @override
  String get facilitatorGuideRequired => 'Обязательно';

  @override
  String get facilitatorGuideOptional => 'Опционально';

  @override
  String get agileEdit => 'Редактировать';

  @override
  String get agileSettings => 'Настройки';

  @override
  String get agileDelete => 'Удалить';

  @override
  String get agileDeleteProjectTitle => 'Удалить проект';

  @override
  String agileDeleteProjectConfirm(String projectName) {
    return 'Вы уверены, что хотите удалить проект «$projectName»?';
  }

  @override
  String get agileDeleteProjectWarning => 'Это действие безвозвратно удалит:';

  @override
  String agileDeleteWarningUserStories(int count) {
    return 'Пользовательских историй: $count';
  }

  @override
  String agileDeleteWarningSprints(int count) {
    return 'Спринтов: $count';
  }

  @override
  String get agileDeleteProjectData => 'Все данные проекта';

  @override
  String get agileProjectSettingsTitle => 'Настройки проекта';

  @override
  String get agileKeyRoles => 'Ключевые роли';

  @override
  String get agileKeyRolesSubtitle =>
      'Назначьте основные роли для Scrum-команды';

  @override
  String get agileRoleProductOwner => 'Product Owner';

  @override
  String get agileRoleProductOwnerDesc =>
      'Управляет бэклогом и определяет приоритеты продукта';

  @override
  String get agileRoleScrumMaster => 'Scrum Master';

  @override
  String get agileRoleScrumMasterDesc =>
      'Содействует процессу Scrum и устраняет препятствия';

  @override
  String get agileRoleDevTeam => 'Команда разработки (Dev Team)';

  @override
  String get agileNoDevTeamMembers =>
      'В команде нет участников. Нажмите «+», чтобы добавить.';

  @override
  String get agileRolesInfo =>
      'Роли будут отображаться со специальными иконками в списке проектов. Вы можете добавить больше участников в команду проекта.';

  @override
  String agileAssignedTo(String name) {
    return 'Назначено: $name';
  }

  @override
  String get agileUnassigned => 'Не назначено';

  @override
  String get agileAssignableLater => 'Можно назначить после создания';

  @override
  String get agileAddToTeam => 'Добавить в команду';

  @override
  String get agileAllMembersAssigned => 'Все доступные участники уже назначены';

  @override
  String get agileClose => 'Закрыть';

  @override
  String get agileProjectNameLabel => 'Название проекта *';

  @override
  String get agileProjectNameHint => 'Напр.: Дизайн сайта v2';

  @override
  String get agileEnterProjectName => 'Введите название проекта';

  @override
  String get agileProjectDescLabel => 'Описание';

  @override
  String get agileProjectDescHint => 'Необязательное описание проекта';

  @override
  String get agileFrameworkLabel => 'Agile-фреймворк';

  @override
  String get agileDiscoverDifferences => 'Узнать о различиях';

  @override
  String get agileSprintConfig => 'Конфигурация спринта';

  @override
  String get agileSprintDuration => 'Длительность спринта (дни)';

  @override
  String get agileHoursPerDay => 'Часов/день';

  @override
  String get agileCreateProjectTitle => 'Новый Agile-проект';

  @override
  String get agileEditProjectTitle => 'Редактировать проект';

  @override
  String get agileSelectParticipant => 'Выберите участника';

  @override
  String get agileAssignRolesHint =>
      'Назначьте ключевые роли в команде. Вы также сможете изменить их в настройках проекта.';

  @override
  String get agileArchiveAction => 'Архивировать';

  @override
  String get agileRestoreAction => 'Восстановить';

  @override
  String get agileSetupTitle => 'Настройка проекта';

  @override
  String agileStepComplete(int completed, int total) {
    return '$completed из $total шагов выполнено';
  }

  @override
  String get agileSetupCompleteTitle => 'Настройка завершена!';

  @override
  String get agileSetupCompleteMessage => 'Ваш проект готов к запуску.';

  @override
  String get agileChecklistAddMembers => 'Добавить участников команды';

  @override
  String get agileChecklistAddMembersDesc =>
      'Пригласите команду для совместной работы';

  @override
  String get agileChecklistInvite => 'Пригласить';

  @override
  String agileChecklistCreateStories(String itemType) {
    return 'Создать первый $itemType';
  }

  @override
  String get agileChecklistAddItems => 'Добавьте минимум 3 элемента в бэклог';

  @override
  String get agileChecklistAdd => 'Добавить';

  @override
  String get agileChecklistWipLimits => 'Настроить лимиты WIP';

  @override
  String get agileChecklistWipLimitsDesc =>
      'Установите лимиты для каждой колонки Kanban';

  @override
  String get agileChecklistConfigure => 'Настроить';

  @override
  String agileChecklistEstimate(String itemType) {
    return 'Оценить $itemType';
  }

  @override
  String get agileChecklistEstimateDesc =>
      'Назначьте Story Points для лучшего планирования';

  @override
  String get agileChecklistCreateSprint => 'Создать первый спринт';

  @override
  String get agileChecklistSprintDesc => 'Выберите истории и начните работу';

  @override
  String get agileChecklistCreateSprintAction => 'Создать спринт';

  @override
  String get agileChecklistStartWork => 'Начать работу';

  @override
  String get agileChecklistStartWorkDesc =>
      'Переместите элемент в колонку «В работе»';

  @override
  String get agileTipStartSprintTitle => 'Готовы к спринту?';

  @override
  String get agileTipStartSprintMessage =>
      'У вас достаточно задач в бэклоге. Рассмотрите возможность планирования первого спринта.';

  @override
  String get agileTipWipTitle => 'Настройте лимиты WIP';

  @override
  String get agileTipWipMessage =>
      'Лимиты WIP — ключевой элемент в Kanban. Ограничивайте объем работы в процессе для улучшения потока.';

  @override
  String get agileTipHybridTitle => 'Настройте свой Scrumban';

  @override
  String get agileTipHybridMessage =>
      'Вы можете использовать спринты для ритмичности или лимиты WIP для непрерывного потока. Экспериментируйте!';

  @override
  String get agileTipDiscover => 'Узнать';

  @override
  String get agileTipClose => 'Закрыть';

  @override
  String get agileNextStepInviteTitle => 'Пригласить команду';

  @override
  String get agileNextStepInviteDesc =>
      'Добавьте участников для совместной работы над проектом.';

  @override
  String get agileNextStepBacklogTitle => 'Создать бэклог';

  @override
  String agileNextStepBacklogDesc(String itemType) {
    return 'Добавьте первый $itemType в бэклог.';
  }

  @override
  String get agileNextStepSprintTitle => 'Запланировать спринт';

  @override
  String agileNextStepSprintDesc(int count) {
    return 'У вас готово элементов: $count. Создайте первый спринт!';
  }

  @override
  String get agileNextStepWipTitle => 'Настроить лимиты WIP';

  @override
  String get agileNextStepWipDesc =>
      'Ограничьте объем работы в процессе, чтобы улучшить поток.';

  @override
  String get agileNextStepWorkTitle => 'Начать работу';

  @override
  String get agileNextStepWorkDesc =>
      'Переместите элемент в колонку «В работе», чтобы начать.';

  @override
  String get agileNextStepAddToSprintDesc =>
      'Переместите элемент в колонку «К выполнению», чтобы добавить историю в спринт.';

  @override
  String get agileNextStepGoToKanban => 'Перейти к Kanban';

  @override
  String get agileActionNewStory => 'Новая история';

  @override
  String get agileBacklogTitle => 'Бэклог продукта';

  @override
  String get agileBacklogArchiveTitle => 'Архив завершенных задач';

  @override
  String get agileBacklogToggleActive => 'Показать активный бэклог';

  @override
  String agileBacklogToggleArchive(int count) {
    return 'Показать архив ($count завершено)';
  }

  @override
  String agileBacklogArchiveBadge(int count) {
    return 'Архив ($count)';
  }

  @override
  String get agileBacklogSearchHint => 'Поиск по названию, описанию или ID...';

  @override
  String agileBacklogStatsStories(int count) {
    return 'историй: $count';
  }

  @override
  String agileBacklogStatsPoints(int points) {
    return '$points бал.';
  }

  @override
  String agileBacklogStatsEstimated(int count) {
    return 'оценено: $count';
  }

  @override
  String get agileFiltersStatus => 'Статус:';

  @override
  String get agileFiltersPriority => 'Приоритет:';

  @override
  String get agileFiltersTags => 'Теги:';

  @override
  String get agileFiltersAll => 'Все';

  @override
  String get agileFiltersClear => 'Очистить фильтры';

  @override
  String get agileEmptyBacklogMatch => 'Историй не найдено';

  @override
  String get agileEmptyBacklog => 'Бэклог пуст';

  @override
  String get agileEmptyBacklogHint =>
      'Добавьте первую пользовательскую историю';

  @override
  String get agileEstTitle => 'Оценить историю';

  @override
  String get agileEstMethod => 'Метод оценки';

  @override
  String get agileEstSelectValue => 'Выберите значение';

  @override
  String get agileEstSubmit => 'Подтвердить оценку';

  @override
  String get agileEstCancel => 'Отмена';

  @override
  String get agileEstPokerTitle => 'Planning Poker (Фибоначчи)';

  @override
  String get agileEstPokerDesc => 'Выберите сложность истории в Story Points';

  @override
  String get agileEstTShirtTitle => 'Размеры футболок (T-Shirt)';

  @override
  String get agileEstTShirtDesc => 'Выберите относительный размер истории';

  @override
  String get agileEstThreePointTitle => 'Трехточечная оценка (PERT)';

  @override
  String get agileEstThreePointDesc =>
      'Введите три значения для расчета оценки по PERT';

  @override
  String get agileEstBucketTitle => 'Система корзин (Bucket System)';

  @override
  String get agileEstBucketDesc =>
      'Поместите историю в соответствующую корзину';

  @override
  String get agileEstBucketHint =>
      'Большие корзины означают более сложные истории';

  @override
  String get agileEstReference => 'Пример:';

  @override
  String get agileEstRefXS => 'XS = Несколько часов';

  @override
  String get agileEstRefS => 'S = ~1 день';

  @override
  String get agileEstRefM => 'M = ~2-3 дня';

  @override
  String get agileEstRefL => 'L = ~1 неделя';

  @override
  String get agileEstRefXL => 'XL = ~2 недели';

  @override
  String get agileEstRefXXL => 'XXL = Слишком большая, разделите';

  @override
  String get agileEstOptimistic => 'Оптимистичная (O)';

  @override
  String get agileEstOptimisticHint => 'Лучший случай';

  @override
  String get agileEstMostLikely => 'Наиболее вероятно (M)';

  @override
  String get agileEstMostLikelyHint => 'Наиболее вероятно';

  @override
  String get agileEstPessimistic => 'Pessimistic (P)';

  @override
  String get agileEstPessimisticHint => 'Худший случай';

  @override
  String get agileEstPointsSuffix => 'pts';

  @override
  String get agileEstFormula => 'Формула PERT: (O + 4M + P) / 6';

  @override
  String agileEstResult(String value) {
    return 'Оценка: $value бал.';
  }

  @override
  String get agileEstErrorThreePoint => 'Введите все три значения';

  @override
  String get agileEstErrorSelect => 'Выберите значение';

  @override
  String agileEstExisting(int count) {
    return 'Существующие оценки ($count)';
  }

  @override
  String get agileEstYou => 'Вы';

  @override
  String get scrumPermBacklogTitle => 'Полномочия в бэклоге';

  @override
  String get scrumPermBacklogDesc =>
      'Только Product Owner может создавать, редактировать, удалять и приоритизировать задачи';

  @override
  String get scrumPermSprintTitle => 'Полномочия в спринте';

  @override
  String get scrumPermSprintDesc =>
      'Только Scrum Master может создавать, запускать и завершать спринты';

  @override
  String get scrumPermEstimateTitle => 'Полномочия в оценке';

  @override
  String get scrumPermEstimateDesc =>
      'Только Команда разработки может оценивать задачи';

  @override
  String get scrumPermKanbanTitle => 'Полномочия на доске Kanban';

  @override
  String get scrumPermKanbanDesc =>
      'Команда разработки может перемещать свои задачи, PO и SM — любые задачи';

  @override
  String get scrumPermTeamTitle => 'Полномочия в команде';

  @override
  String get scrumPermTeamDesc =>
      'PO и SM могут приглашать участников, только PO может менять роли';

  @override
  String get scrumPermDeniedBacklogCreate =>
      'Только Product Owner может создавать новые задачи';

  @override
  String get scrumPermDeniedBacklogEdit =>
      'Только Product Owner может редактировать задачи';

  @override
  String get scrumPermDeniedBacklogDelete =>
      'Только Product Owner может удалять задачи';

  @override
  String get scrumPermDeniedBacklogPrioritize =>
      'Только Product Owner может менять порядок бэклога';

  @override
  String get scrumPermDeniedSprintCreate =>
      'Только Scrum Master может создавать новые спринты';

  @override
  String get scrumPermDeniedSprintStart =>
      'Только Scrum Master может запускать спринты';

  @override
  String get scrumPermDeniedSprintComplete =>
      'Только Scrum Master может завершать спринты';

  @override
  String get scrumPermDeniedEstimate =>
      'Только Команда разработки может оценивать задачи';

  @override
  String get scrumPermDeniedInvite =>
      'Только PO и SM могут приглашать новых участников';

  @override
  String get scrumPermDeniedRoleChange =>
      'Только Product Owner может менять роли в команде';

  @override
  String get scrumPermDeniedWipConfig =>
      'Только Scrum Master может настраивать лимиты WIP';

  @override
  String get scrumRoleProductOwner => 'Product Owner';

  @override
  String get scrumRoleScrumMaster => 'Scrum-мастер';

  @override
  String get scrumRoleDeveloper => 'Разработчик';

  @override
  String get scrumRoleDesigner => 'Дизайнер';

  @override
  String get scrumRoleQA => 'QA';

  @override
  String get scrumRoleStakeholder => 'Stakeholder';

  @override
  String get scrumMatrixTitle => 'Матрица полномочий Scrum';

  @override
  String get scrumMatrixSubtitle =>
      'Кто и что может делать согласно Руководству по Scrum 2020';

  @override
  String get scrumMatrixLegend => 'Легенда';

  @override
  String get scrumMatrixLegendFull => 'Управляет';

  @override
  String get scrumMatrixLegendPartial => 'Частично';

  @override
  String get scrumMatrixLegendView => 'Только просмотр';

  @override
  String get scrumMatrixLegendNone => 'Нет';

  @override
  String get scrumMatrixCategoryBacklog => 'БЭКЛОГ';

  @override
  String get scrumMatrixCategorySprint => 'СПРИНТ';

  @override
  String get scrumMatrixCategoryEstimation => 'ОЦЕНКА';

  @override
  String get scrumMatrixCategoryKanban => 'КАНБАН';

  @override
  String get scrumMatrixCategoryTeam => 'КОМАНДА';

  @override
  String get scrumMatrixCategoryRetro => 'РЕТРОСПЕКТИВА';

  @override
  String get scrumMatrixActionCreateStory => 'Создать задачу';

  @override
  String get scrumMatrixActionEditStory => 'Редактировать задачу';

  @override
  String get scrumMatrixActionDeleteStory => 'Удалить задачу';

  @override
  String get scrumMatrixActionPrioritize => 'Приоритизировать бэклог';

  @override
  String get scrumMatrixActionAddAcceptance => 'Определить критерии приемки';

  @override
  String get scrumMatrixActionCreateSprint => 'Создать спринт';

  @override
  String get scrumMatrixActionStartSprint => 'Запустить спринт';

  @override
  String get scrumMatrixActionCompleteSprint => 'Завершить спринт';

  @override
  String get scrumMatrixActionConfigWip => 'Настроить лимиты WIP';

  @override
  String get scrumMatrixActionEstimate => 'Оценивать задачи';

  @override
  String get scrumMatrixActionFinalEstimate => 'Установить финальную оценку';

  @override
  String get scrumMatrixActionMoveOwn => 'Перемещать свои задачи';

  @override
  String get scrumMatrixActionMoveAny => 'Перемещать любую задачу';

  @override
  String get scrumMatrixActionSelfAssign => 'Назначать задачу себе';

  @override
  String get scrumMatrixActionAssignOthers => 'Назначать других';

  @override
  String get scrumMatrixActionChangeStatus => 'Изменять статус задачи';

  @override
  String get scrumMatrixActionInvite => 'Приглашать участников';

  @override
  String get scrumMatrixActionRemove => 'Удалять участников';

  @override
  String get scrumMatrixActionChangeRole => 'Изменять роли';

  @override
  String get scrumMatrixActionFacilitateRetro => 'Фасилитировать ретроспективу';

  @override
  String get scrumMatrixActionParticipateRetro => 'Участвовать в ретроспективе';

  @override
  String get scrumMatrixActionAddRetroItem => 'Добавить элемент ретро';

  @override
  String get scrumMatrixActionVoteRetro => 'Голосовать за элементы';

  @override
  String get scrumMatrixColPO => 'PO';

  @override
  String get scrumMatrixColSM => 'SM';

  @override
  String get scrumMatrixColDev => 'Разраб.';

  @override
  String get scrumMatrixColStake => 'Стейкх.';

  @override
  String get agileInviteTitle => 'Пригласить в команду';

  @override
  String get agileInviteNew => 'НОВОЕ ПРИГЛАШЕНИЕ';

  @override
  String get agileInviteEmailLabel => 'Email';

  @override
  String get agileInviteEmailHint => 'name@example.com';

  @override
  String get agileInviteEnterEmail => 'Введите email';

  @override
  String get agileInviteInvalidEmail => 'Некорректный email';

  @override
  String get agileInviteProjectRole => 'Роль в проекте';

  @override
  String get agileInviteTeamRole => 'Роль в команде';

  @override
  String get agileInviteSendEmail => 'Отправить уведомление по email';

  @override
  String get agileInviteSendBtn => 'Отправить приглашение';

  @override
  String get agileInviteLink => 'Ссылка-приглашение:';

  @override
  String get agileInviteLinkCopied => 'Ссылка скопирована!';

  @override
  String get agileInviteListTitle => 'ПРИГЛАШЕНИЯ';

  @override
  String get agileInviteClose => 'Закрыть';

  @override
  String get agileInviteGmailAuthTitle => 'Авторизация Gmail';

  @override
  String get agileInviteGmailAuthContent =>
      'Для отправки приглашений по email необходимо повторно авторизоваться в Google.\n\nХотите продолжить?';

  @override
  String get agileInviteGmailAuthNo => 'Нет, только ссылка';

  @override
  String get agileInviteGmailAuthYes => 'Авторизовать';

  @override
  String agileInviteSentEmail(String email) {
    return 'Приглашение отправлено на $email';
  }

  @override
  String agileInviteCreated(String email) {
    return 'Приглашение создано для $email';
  }

  @override
  String get agileInviteRevokeTitle => 'Отозвать приглашение?';

  @override
  String get agileInviteRevokeContent => 'Приглашение станет недействительным.';

  @override
  String get agileInviteRevokeBtn => 'Отозвать';

  @override
  String get agileInviteResend => 'Отправить повторно';

  @override
  String get agileInviteResent => 'Приглашение отправлено повторно';

  @override
  String get agileInviteStatusPending => 'Ожидает';

  @override
  String get agileInviteStatusAccepted => 'Принято';

  @override
  String get agileInviteStatusDeclined => 'Отклонено';

  @override
  String get agileInviteStatusExpired => 'Истекло';

  @override
  String get agileInviteStatusRevoked => 'Отозвано';

  @override
  String get agileRoleMember => 'Участник';

  @override
  String get agileRoleAdmin => 'Админ';

  @override
  String get agileRoleViewer => 'Зритель';

  @override
  String get agileRoleOwner => 'Владелец';

  @override
  String get agileEditStory => 'Редактировать задачу';

  @override
  String get agileNewStory => 'Новая User Story';

  @override
  String get agileDetailsTab => 'Детали';

  @override
  String get agileAcceptanceCriteriaTab => 'Критерии приемки';

  @override
  String get agileOtherTab => 'Другое';

  @override
  String get agileTitleLabel => 'Заголовок';

  @override
  String get agileTitleHint => 'Краткое описание функционала';

  @override
  String get agileUseStoryTemplate => 'Использовать шаблон User Story';

  @override
  String get agileStoryTemplateSubtitle => 'Как... я хочу... чтобы...';

  @override
  String get agileAsA => 'Как...';

  @override
  String get agileAsAHint => 'пользователь, админ, клиент...';

  @override
  String get agileIWant => 'Я хочу...';

  @override
  String get agileIWantHint => 'иметь возможность сделать что-то...';

  @override
  String get agileSoThat => 'Чтобы...';

  @override
  String get agileSoThatHint => 'получить выгоду...';

  @override
  String get agileDescriptionLabel => 'Описание';

  @override
  String get agileDescriptionHint => 'Произвольное описание истории';

  @override
  String get agilePreview => 'Предпросмотр:';

  @override
  String get agileEmptyDescription => '(описание пусто)';

  @override
  String get agileDefineComplete =>
      'Определите, когда история может считаться завершенной';

  @override
  String get agileAddCriterionHint => 'Добавить критерий приемки...';

  @override
  String get agileNoCriteria => 'Критерии не определены';

  @override
  String get agileSuggestions => 'Предложения:';

  @override
  String get agilePriorityMoscow => 'Приоритет (MoSCoW)';

  @override
  String get agileBusinessValueLow => 'Низкая бизнес-ценность';

  @override
  String get agileBusinessValueMedium => 'Средняя ценность';

  @override
  String get agileBusinessValueHigh => 'Высокая бизнес-ценность';

  @override
  String get agileEstimatedStoryPoints => 'Оценено в Story Points';

  @override
  String get agileStoryPointsTooltip =>
      'Story Points представляют относительную сложность. Используйте последовательность Фибоначчи: 1 (просто) -> 21 (очень сложно).';

  @override
  String get agileNoPoints => 'Нет';

  @override
  String get agileAddTagHint => 'Добавить тег...';

  @override
  String get agileExistingTags => 'Существующие теги:';

  @override
  String get agileAssignTo => 'Назначить на';

  @override
  String get agileSelectMemberHint => 'Выберите участника команды';

  @override
  String get agilePointsComplexityVeryLow => 'Быстрая и простая задача';

  @override
  String get agilePointsComplexityLow => 'Задача средней сложности';

  @override
  String get agilePointsComplexityMedium => 'Сложная задача, требует анализа';

  @override
  String get agilePointsComplexityHigh =>
      'Очень сложная, подумайте о разделении';

  @override
  String agileDurationDays(Object days) {
    return 'Длительность: $days дн.';
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
  String get agileSelectedPoints => 'Выбрано';

  @override
  String get agileSuggestedPoints => 'Рекомендуется';

  @override
  String agileDaysRemaining(Object days) {
    return 'Осталось дней: $days';
  }

  @override
  String get agileSelectAtLeastOne => 'Выберите хотя бы 1 историю';

  @override
  String agileConfirmStories(String count) {
    return 'Подтвердить ($count ист.)';
  }

  @override
  String get kanbanPoliciesDescription =>
      'Явные правила определяют порядок работы в этой колонке (Практика Kanban #4)';

  @override
  String get kanbanPoliciesEmpty => 'Правила не определены';

  @override
  String get kanbanPoliciesAdd => 'Добавить правило';

  @override
  String get kanbanPoliciesHint => 'Напр.: Макс. 24 часа в этой колонке';

  @override
  String kanbanPoliciesIndicator(int count) {
    return 'Активных правил: $count';
  }

  @override
  String get sprintReviewTitle => 'Обзор спринта (Review)';

  @override
  String get sprintReviewSubtitle =>
      'Обзор выполненной работы со стейкхолдерами';

  @override
  String get sprintReviewConductBy => 'Проводит';

  @override
  String get sprintReviewDate => 'Дата обзора';

  @override
  String get sprintReviewAttendees => 'Участники';

  @override
  String get sprintReviewSelectAttendees => 'Выберите участников';

  @override
  String get sprintReviewDemoNotes => 'Заметки по демо';

  @override
  String get sprintReviewDemoNotesHint =>
      'Опишите продемонстрированный функционал';

  @override
  String get sprintReviewFeedback => 'Полученный фидбек';

  @override
  String get sprintReviewFeedbackHint => 'Отзывы стейкхолдеров';

  @override
  String get sprintReviewBacklogUpdates => 'Обновления бэклога';

  @override
  String get sprintReviewBacklogUpdatesHint =>
      'Обсужденные изменения в бэклоге';

  @override
  String get sprintReviewNextFocus => 'Фокус следующего спринта';

  @override
  String get sprintReviewNextFocusHint => 'Приоритеты на следующий спринт';

  @override
  String get sprintReviewMarketNotes => 'Заметки о рынке/бюджете';

  @override
  String get sprintReviewMarketNotesHint => 'Рыночные условия, сроки, бюджет';

  @override
  String get sprintReviewStoriesCompleted => 'Завершено историй';

  @override
  String get sprintReviewStoriesNotCompleted => 'Не завершено историй';

  @override
  String get sprintReviewPointsCompleted => 'Завершено баллов';

  @override
  String get sprintReviewSave => 'Сохранить обзор';

  @override
  String get sprintReviewWarning => 'Внимание: Обзор спринта';

  @override
  String get sprintReviewWarningMessage =>
      'Обзор спринта (Sprint Review) еще не проводился. Согласно Руководству по Scrum 2020, это обязательное событие перед завершением спринта.';

  @override
  String get sprintReviewCompleteAnyway => 'Все равно завершить';

  @override
  String get sprintReviewDoReview => 'Провести обзор';

  @override
  String get sprintReviewCompleted => 'Обзор спринта завершен';

  @override
  String get swimlaneTitle => 'Swimlanes (Дорожки)';

  @override
  String get swimlaneDescription => 'Группировка карточек по атрибутам';

  @override
  String get swimlaneTypeNone => 'Нет';

  @override
  String get swimlaneTypeNoneDesc => 'Стандартный вид без группировки';

  @override
  String get swimlaneTypeClassOfService => 'Класс обслуживания (CoS)';

  @override
  String get swimlaneTypeClassOfServiceDesc =>
      'Группировка по приоритету/срочности';

  @override
  String get swimlaneTypeAssignee => 'Исполнитель';

  @override
  String get swimlaneTypeAssigneeDesc => 'Группировка по участникам команды';

  @override
  String get swimlaneTypePriority => 'Приоритет';

  @override
  String get swimlaneTypePriorityDesc => 'Группировка по уровню приоритета';

  @override
  String get swimlaneTypeTag => 'Тег';

  @override
  String get swimlaneTypeTagDesc => 'Группировка по тегам историй';

  @override
  String get swimlaneUnassigned => 'Не назначено';

  @override
  String get swimlaneNoTag => 'Без тега';

  @override
  String get agileMetricsVelocityTitle => 'Velocity (Скорость)';

  @override
  String get agileMetricsVelocityDesc =>
      'Измеряет количество Story Points, выполненных за спринт. Помогает прогнозировать потенциал команды.';

  @override
  String get agileMetricsLeadTimeDesc =>
      'Общее время от создания истории до её завершения. Включает время ожидания в бэклоге.';

  @override
  String get agileMetricsCycleTimeDesc =>
      'Формула: Время, проведенное в активных статусах (В работе / На проверке). Не включает время ожидания в бэклоге.';

  @override
  String get agileMetricsThroughputDesc =>
      'Количество элементов, выполненных за единицу времени. Указывает на продуктивность команды.';

  @override
  String get agileMetricsDistributionDesc =>
      'Визуализирует распределение историй по статусам. Помогает выявить узкие места.';

  @override
  String get agilePredictability => 'Предсказуемость';

  @override
  String agilePredictabilityDesc(int days) {
    return '85% элементов выполняются за ≤$days дн.';
  }

  @override
  String agileThroughputWeekly(int weeks) {
    return 'Задач выполнено в неделю (последние $weeks недель)';
  }

  @override
  String get agileNoDataVelocity => 'Нет данных по скорости';

  @override
  String get agileNoDataLeadTime => 'Нет данных по Lead Time';

  @override
  String get agileNoDataCycleTime => 'Нет данных по Cycle Time';

  @override
  String get agileNoDataThroughput => 'Нет данных по пропускной способности';

  @override
  String get agileNoDataAccuracy => 'Нет данных по точности';

  @override
  String get agileStartFinishOneItem =>
      'Выполните хотя бы одну задачу для расчета';

  @override
  String get timeDays => 'дн.';

  @override
  String get auditLogTitle => 'Лог аудита';

  @override
  String auditLogEventCount(int count) {
    return 'событий: $count';
  }

  @override
  String get actionRefresh => 'Обновить';

  @override
  String get auditLogFilterEntityType => 'Тип';

  @override
  String get auditLogFilterAction => 'Действие';

  @override
  String get auditLogFilterFromDate => 'С';

  @override
  String get actionDetails => 'Details';

  @override
  String get auditLogDetailsTitle => 'Детали изменений';

  @override
  String get auditLogPreviousValue => 'Предыдущее значение:';

  @override
  String get auditLogNewValue => 'Новое значение:';

  @override
  String get auditLogNoEvents => 'Событий не зафиксировано';

  @override
  String get auditLogNoEventsDesc =>
      'Здесь будут регистрироваться действия в проекте';

  @override
  String get recentActivityTitle => 'Недавняя активность';

  @override
  String get actionViewAll => 'Показать все';

  @override
  String get recentActivityNone => 'Недавней активности нет';

  @override
  String get burndownChartTitle => 'Диаграмма сгорания (Burndown)';

  @override
  String get agileIdeal => 'Идеал';

  @override
  String get agileActual => 'Факт';

  @override
  String get agileRemaining => 'Остаток';

  @override
  String get agileBurndownNoDataDesc => 'Данные появятся после запуска спринта';

  @override
  String get agileCompleteActiveFirst => 'Сначала завершите активный спринт';

  @override
  String get kanbanSwimlanes => 'Swimlanes:';

  @override
  String get kanbanSwimlaneLabel => 'Дорожка (Swimlane)';

  @override
  String get agileNoTags => 'Тегов нет';

  @override
  String get kanbanWipExceededBanner =>
      'Лимит WIP превышен! Завершите текущие задачи перед началом новых.';

  @override
  String get kanbanConfigWip => 'Настроить WIP';

  @override
  String get kanbanPoliciesDesc =>
      'Явные правила помогают команде понять принципы работы в этом столбце.';

  @override
  String get kanbanNewPolicyHint => 'Новое правило...';

  @override
  String kanbanWipLimitOf(int count, int limit) {
    return 'WIP: $count из макс. $limit';
  }

  @override
  String get kanbanWipExplanationDesc =>
      'Лимиты WIP (Work In Progress) ограничивают количество элементов, которые могут находиться в колонке одновременно.';

  @override
  String get kanbanUnderstand => 'Понятно';

  @override
  String get agileHours => 'Часы';

  @override
  String get agileStoriesPerSprint => 'Задач / Спринт';

  @override
  String get agileSprints => 'Спринты';

  @override
  String get agileTeamComposition => 'Состав команды';

  @override
  String get agileHoursNote =>
      'Часы являются внутренним справочным показателем. Для планирования в Scrum используйте вид Story Points.';

  @override
  String agileWorkloadBalanceTooltip(String avg, String min, String max) {
    return 'Среднее по команде: $avg SP. Сбалансированный диапазон: $min - $max SP. Статус основан на отклонении от среднего.';
  }

  @override
  String get agileHealthTimeTooltip =>
      'Прошло дней / Всего дней (на основе дат начала/окончания).';

  @override
  String get agileHealthWorkTooltip =>
      'Выполнено vs Всего запланировано Story Points.';

  @override
  String get agileHealthProgressTooltip =>
      'Количество историй, находящихся в работе.';

  @override
  String get agileHealthDoneTooltip =>
      'Завершено историй vs Всего историй в спринте.';

  @override
  String get agileHealthCommitmentTooltip =>
      'Надежность (Завершено / Запланировано) на основе прошлых спринтов.';

  @override
  String get agileHealthVelocityTooltip =>
      'Среднесуточное количество завершенных Story Points в этом спринте.';

  @override
  String get agileSprintScopeTooltip =>
      'Отслеживает изменения в рамках спринта. \"Исходный\" — очки, запланированные при старте, \"Текущий\" — очки задач, находящихся в спринте на данный момент.';

  @override
  String get agileEstimationAccuracyTooltip =>
      'Формула: (Завершено очков / Запланировано очков) x 100. Показывает надежность команды в выполнении обязательств.';

  @override
  String get agileCommitmentTrendTooltip =>
      'Отображает тренд надежности команды, сравнивая запланированные и завершенные очки для каждого спринта.';

  @override
  String get agileNoTeamMembers => 'Нет участников команды';

  @override
  String get agileGmailAuthError =>
      'Авторизация Gmail недоступна. Попробуйте выйти и войти снова.';

  @override
  String get agileGmailPermissionDenied => 'В доступе к Gmail отказано.';

  @override
  String get agileResend => 'Отправить повторно';

  @override
  String get agileRevoke => 'Отозвать';

  @override
  String get agileVelocityUnits => 'Очков сложности / Спринт';

  @override
  String get agileFiltersTitle => 'Фильтры';

  @override
  String get agilePlanned => 'Запланировано';

  @override
  String get archiveDeleteSuccess => 'Успешно архивировано/удалено';

  @override
  String get agileNoItems => 'Нет элементов для отображения';

  @override
  String agileItemsOfTotal(int completed, int total) {
    return '$completed из $total';
  }

  @override
  String get agileItemsCompletedLabel => 'Завершенные элементы';

  @override
  String get agileDaysRemainingSuffix => 'дн. осталось';

  @override
  String get agileItemsMore => 'еще элементы';

  @override
  String get wipAgeTitle => 'Возраст рабочих элементов';

  @override
  String get wipAgeEmpty => 'Нет элементов в работе';

  @override
  String wipAgeDays(int count) {
    return '$count дн.';
  }

  @override
  String get wipAgeWarning =>
      'Некоторые элементы слишком долго находятся в работе. Возможно, есть препятствия.';

  @override
  String get agilePerWeekSuffix => '/нед.';

  @override
  String get average => 'Среднее';

  @override
  String get agileAvgVelocitySprint => 'Velocity (Спринт)';

  @override
  String get agileAvgVelocityWeekly => 'Скорость (еженедельно)';

  @override
  String get agileAvgVelocitySprintTooltip =>
      'Среднее количество Story Points, завершаемых за спринт.';

  @override
  String get agileAvgVelocityWeeklyTooltip =>
      'Среднее количество очков сложности, завершенных за неделю.';

  @override
  String get agileFiltersDoneTooltip =>
      'Завершенные истории или истории из закрытых спринтов архивируются по умолчанию. Выберите этот фильтр, чтобы увидеть их.';

  @override
  String agileBacklogDoneBadge(Object count) {
    return '($count) Завершено';
  }

  @override
  String get agileBacklogDoneBadgeTooltip =>
      'Эти истории скрыты по умолчанию. Используйте фильтр статуса «Завершено», чтобы увидеть их.';

  @override
  String get agileFlowEfficiencyTooltip =>
      'Формула: (Общее активное время / Общее системное время) * 100. Рассчитывается в реальном времени для всех элементов потока.';

  @override
  String get getAgileFlowCycleTimeTooltip =>
      'Среднее время, проведенное в активных статусах (В работе / На проверке). Ожидающие элементы снижают среднее значение.';

  @override
  String get agileFlowLeadTimeTooltip =>
      'Среднее общее время пребывания в системе (от создания до сегодня или завершения). Включает ожидание и работу.';

  @override
  String get agileFlowWipTooltip =>
      'Work In Progress: количество историй, над которыми ведется работа (исключая бэклог и завершенные).';

  @override
  String get agileBlockedItemsTooltip =>
      'Истории, имеющие неудовлетворенные зависимости (другие незавершенные истории).';

  @override
  String agileItemsCount(int count) {
    return 'элементов: $count';
  }

  @override
  String get agileDaysLeft => 'Дней осталось';

  @override
  String get all => 'Все';

  @override
  String get kanbanGuidePoliciesTitle => 'Явные правила (Explicit Policies)';

  @override
  String get agileDaysLabel => 'Дни';

  @override
  String get agileStatRemaining => 'осталось';

  @override
  String get agileStatsCompletedLabel => 'Завершено';

  @override
  String get agileStatsPlannedLabel => 'Запланировано';

  @override
  String get agileProgressLabel => 'Прогресс';

  @override
  String get agileDurationLabel => 'Длительность';

  @override
  String get agileVelocityLabel => 'Скорость (Velocity)';

  @override
  String get agileStoriesLabel => 'Задачи';

  @override
  String get agileSprintSummary => 'Итоги спринта';

  @override
  String get agileStoriesTotal => 'Всего задач';

  @override
  String get agileStoriesCompleted => 'Выполненные задачи';

  @override
  String get agilePointsCompletedLabel => 'Завершено баллов (SP)';

  @override
  String get agileStoriesIncomplete => 'Незавершенные задачи';

  @override
  String get agileIncompleteReturnToBacklog => '(вернутся в бэклог)';

  @override
  String get agilePointsLabel => 'Story Points';

  @override
  String get agileRecordReview => 'Провести обзор спринта';

  @override
  String get agileCompleteSprintAction => 'Завершить спринт';

  @override
  String get agileMissingReview => 'Обзор спринта отсутствует';

  @override
  String get agileSprintReviewCompleted => 'Обзор спринта завершен';

  @override
  String get agileReviewNotesLabel => 'Заметки по обзору';

  @override
  String get agileReviewFeedbackLabel => 'Отзывы стейкхолдеров';

  @override
  String get agileReviewNextFocus => 'Фокус следующего спринта';

  @override
  String get agileBacklogUpdatesLabel => 'Обновления бэклога';

  @override
  String get agileSaveReview => 'Сохранить обзор';

  @override
  String get agileConductedBy => 'Проводит';

  @override
  String get agileReviewDate => 'Дата обзора';

  @override
  String get agileReviewOutcome => 'Итог обзора';

  @override
  String get agileStoriesRejected => 'Отклоненные задачи';

  @override
  String get agileRejectedWarning =>
      'Незавершенные или отклоненные истории автоматически вернутся в бэклог.';

  @override
  String get agileReviewDemoHint => 'Что было показано на демо?';

  @override
  String get agileReviewFeedbackHint => 'Отзывы, полученные от стейкхолдеров';

  @override
  String get agileReviewBacklogHint => 'Новое обновление бэклога...';

  @override
  String get agileReviewNextFocusHint =>
      'На чем команде стоит сфокусироваться?';

  @override
  String get agileReviewScrumGuide =>
      'Согласно Руководству по Scrum 2020, рекомендуется проводить обзор спринта перед его закрытием для совместной проверки выполненной работы со стейкхолдерами.';

  @override
  String agileSprintCompleteConfirm(String name) {
    return 'Вы уверены, что хотите завершить \"$name\"?';
  }

  @override
  String agileSprintCompleteSuccess(String velocity) {
    return 'Спринт завершен! Скорость: $velocity очков/неделя';
  }

  @override
  String get agileSprintReviewSaveSuccess => 'Обзор спринта сохранен';

  @override
  String get agileEstimationAccuracy => 'Точность планирования';

  @override
  String get agileCompleteOneSprintFirst =>
      'Сначала завершите хотя бы один спринт';

  @override
  String get agileNoDataAccuracyFix => 'Нет данных по точности';

  @override
  String get agileScrumGuideRecommends =>
      'Руководство по Scrum рекомендует планировать на основе исторической скорости (Velocity), а не часов.';

  @override
  String get agileNoSkillsDefined => 'Навыки не определены';

  @override
  String get agileAddSkillsToMembers => 'Добавьте навыки участникам команды';

  @override
  String get retroNoSprintWarningTitle => 'Нет завершенных спринтов';

  @override
  String get retroNoSprintWarningMessage =>
      'Для создания Scrum-ретроспективы необходимо сначала завершить хотя бы один спринт. Ретроспективы связаны со спринтами для отслеживания улучшений между итерациями.';

  @override
  String get agileGoToSprints => 'Перейти к спринтам';

  @override
  String get agileSprintReviewHistory => 'История обзоров спринта';

  @override
  String get agileNoSprintReviews => 'Нет обзоров спринта';

  @override
  String get agileNoSprintReviewsHint =>
      'Complete a sprint and conduct a Sprint Review to see it here';

  @override
  String get agileAttendees => 'Участники';

  @override
  String get agileStoryEvaluations => 'Оценка задач';

  @override
  String get agileDecisions => 'Решения';

  @override
  String get agileDemoNotes => 'Заметки по демо';

  @override
  String get agileFeedback => 'Фидбек';

  @override
  String get agileStoryApproved => 'Одобрена';

  @override
  String get agileStoryNeedsRefinement => 'Нуждается в доработке';

  @override
  String get agileStoryRejected => 'Отклонена';

  @override
  String get agileAddAttendee => 'Добавить участника';

  @override
  String get agileAddDecision => 'Добавить решение';

  @override
  String get agileNoDecisions => 'Решения не добавлены';

  @override
  String get agileTooltipApproved => 'Одобрена';

  @override
  String get agileTooltipRefinement => 'Требуется доработка';

  @override
  String get agileTooltipRejected => 'Отклонена';

  @override
  String get agileReviewGuidance =>
      'Выберите итог. «Нуждается в доработке» и «Отклонена» вернут историю назад в бэклог.';

  @override
  String get agileEvaluateStories => 'Оценить истории';

  @override
  String get agileSelectRole => 'Выберите роль';

  @override
  String get agileStatsNotCompleted => 'Не завершено';

  @override
  String get agileFramework => 'Фреймворк';

  @override
  String get teamMembers => 'Участники команды';

  @override
  String get eisenhowerImportCsv => 'Импорт CSV';

  @override
  String get eisenhowerImportPreview => 'Предпросмотр активностей';

  @override
  String get eisenhowerImportSelectFile => 'Выберите файл CSV для импорта';

  @override
  String get eisenhowerImportFormatHint =>
      'Ожидаемый формат: Активность, Описание, Квадрант, Срочность, Важность';

  @override
  String get eisenhowerImportClickToSelect => 'Нажмите, чтобы выбрать файл';

  @override
  String get eisenhowerImportSupportedFormats =>
      'Поддерживаемые форматы: .csv (UTF-8 или Latin-1)';

  @override
  String get eisenhowerImportNoActivities => 'Активности в файле не найдены';

  @override
  String get eisenhowerImportMarkRevealed => 'Пометить как проголосованные';

  @override
  String get eisenhowerImportMarkRevealedHint =>
      'Задачи появятся сразу в расчетном квадранте';

  @override
  String eisenhowerImportSuccess(int count) {
    return 'Импортировано активностей: $count';
  }

  @override
  String get actionSelectAll => 'Выбрать все';

  @override
  String get actionDeselectAll => 'Снять выделение';

  @override
  String get actionImport => 'Импорт';

  @override
  String get eisenhowerImportShowInstructions => 'Показать/скрыть инструкции';

  @override
  String get eisenhowerImportInstructionsTitle => 'Требуемый формат CSV';

  @override
  String get eisenhowerImportInstructionsBody =>
      'Файл CSV должен содержать как минимум колонку «Activity» или «Title». Опциональные колонки: Description, Urgency (1-10), Importance (1-10). Первая строка должна быть заголовком.';

  @override
  String get eisenhowerImportExampleFormat =>
      'Activity,Description,Urgency,Importance\n«Название активности»,«Описание»,8.5,7.2';

  @override
  String get eisenhowerImportChangeFile => 'Изменить файл';

  @override
  String eisenhowerImportSkippedRows(int count) {
    return 'Пропущено строк из-за ошибок: $count';
  }

  @override
  String eisenhowerImportAndMore(int count) {
    return '...и еще $count строк';
  }

  @override
  String eisenhowerImportFoundActivities(int valid, int total) {
    return 'Найдено $valid корректных активностей из $total строк';
  }

  @override
  String eisenhowerImportErrorEmptyTitle(int row) {
    return 'Строка $row: пустой заголовок';
  }

  @override
  String eisenhowerImportErrorInvalidRow(int row) {
    return 'Строка $row: некорректный формат';
  }

  @override
  String get eisenhowerImportErrorMissingColumn =>
      'Колонки «Activity» или «Title» не найдены в заголовке';

  @override
  String get eisenhowerImportErrorEmptyFile => 'Файл пуст';

  @override
  String get eisenhowerImportErrorNoHeader =>
      'Заголовок первой строки не найден';

  @override
  String eisenhowerImportErrorRow(int row) {
    return 'Строка $row';
  }

  @override
  String get eisenhowerImportErrorReadFile => 'Не удалось прочитать файл';

  @override
  String get agileSprintHealthTitle => 'Здоровье спринта';

  @override
  String get agileSprintHealthNoSprint => 'Нет активного спринта';

  @override
  String get agileSprintHealthNoSprintDesc =>
      'Запустите спринт, чтобы увидеть метрики здоровья';

  @override
  String get agileSprintHealthGoal => 'Цель спринта';

  @override
  String get agileSprintHealthOnTrack => 'В графике';

  @override
  String get agileSprintHealthAtRisk => 'Под угрозой';

  @override
  String get agileSprintHealthOffTrack => 'Вне графика';

  @override
  String get agileSprintHealthTime => 'Время';

  @override
  String get agileSprintHealthWork => 'Работа';

  @override
  String get agileSprintHealthDaysLeft => 'дней осталось';

  @override
  String get agileSprintHealthSpRemaining => 'Осталось очков';

  @override
  String get agileSprintHealthStoriesInProgress => 'Задач в работе';

  @override
  String get agileSprintHealthStoriesDone => 'Выполнено задач';

  @override
  String get agileSprintHealthCommitment => 'Обязательство';

  @override
  String get agileSprintHealthDailyVelocity => 'Дневная скорость';

  @override
  String get agileSprintHealthPrediction => 'Прогноз';

  @override
  String get agileSprintHealthOnTime => 'Вовремя';

  @override
  String get agileSprintHealthStoriesBreakdown => 'Разбивка задач';

  @override
  String get agileSprintBurndownTitle => 'График сгорания задач';

  @override
  String get agileSprintBurndownNoData => 'Нет данных по сгоранию';

  @override
  String get agileSprintBurndownNoDataDesc =>
      'Назначьте задачи в спринт, чтобы увидеть график сгорания';

  @override
  String get agileWorkloadTitle => 'Загрузка команды';

  @override
  String get agileWorkloadBalanced => 'Сбалансировано';

  @override
  String get agileWorkloadUnbalanced => 'Разбалансировано';

  @override
  String get agileWorkloadTotalStories => 'Всего задач';

  @override
  String get agileWorkloadAssigned => 'Назначено';

  @override
  String get agileWorkloadAvgSp => 'Ср. SP на человека';

  @override
  String get agileWorkloadStories => 'задач';

  @override
  String get agileWorkloadInProgress => 'в работе';

  @override
  String get agileWorkloadUnassigned => 'Не назначено';

  @override
  String get agileWorkloadUnassignedWarning => 'задач без исполнителя';

  @override
  String get agileWorkloadNoStories => 'Нет задач для анализа';

  @override
  String get agileWorkloadNoStoriesDesc =>
      'Создайте задачи и назначьте их участникам команды';

  @override
  String get agileWorkloadOverloaded => 'Перегружено';

  @override
  String get agileCommitmentTrendTitle => 'Тренд надежности обязательств';

  @override
  String get agileCommitmentTrendNoData => 'Данные недоступны';

  @override
  String get agileCommitmentTrendNoDataDesc =>
      'Завершите хотя бы один спринт, чтобы увидеть тренд';

  @override
  String get agileCommitmentTrendPlanned => 'План';

  @override
  String get agileCommitmentTrendCompleted => 'Факт';

  @override
  String get agileCommitmentTrendAvg => 'Среднее';

  @override
  String get agileFlowEfficiencyTitle => 'Flow Efficiency & WIP';

  @override
  String get agileFlowEfficiencyNoData => 'Нет данных';

  @override
  String get agileFlowEfficiencyNoDataDesc =>
      'Добавьте задачи для анализа потока';

  @override
  String get agileFlowEfficiency => 'Flow Efficiency';

  @override
  String get agileFlowCycleTime => 'Cycle Time';

  @override
  String get agileFlowLeadTime => 'Lead Time';

  @override
  String get agileFlowDays => 'дн.';

  @override
  String get agileFlowWipByStatus => 'WIP by Status';

  @override
  String get agileFlowAvg => 'сред.';

  @override
  String get agileBlockedItemsTitle => 'Заблокированные элементы';

  @override
  String get agileBlockedItemsNone => 'Нет заблокированных элементов';

  @override
  String get agileBlockedItemsNoneDesc => 'Все зависимости удовлетворены';

  @override
  String agileBlockedItemsCount(Object count) {
    return 'Заблокировано: $count';
  }

  @override
  String get agileBlockedItemsSp => 'SP blocked';

  @override
  String get agileBlockedItemsBlockedBy => 'Blocked by';

  @override
  String get agileBlockedItemsDependency => 'зависимость';

  @override
  String get agileBlockedItemsDependencies => 'зависимости';

  @override
  String get agileSprintScopeTitle => 'Рамки спринта';

  @override
  String get agileSprintScopeNoSprint => 'Нет активного спринта';

  @override
  String get agileSprintScopeNoSprintDesc =>
      'Запустите спринт для мониторинга изменений рамок';

  @override
  String get agileSprintScopeOriginal => 'Исходный';

  @override
  String get agileSprintScopeCurrent => 'Текущий';

  @override
  String get agileSprintScopeDelta => 'Дельта';

  @override
  String get agileSprintScopeCreep => 'Раздувание рамок';

  @override
  String get agileSprintScopeReduction => 'Сокращение рамок';

  @override
  String get agileSprintScopeStable => 'Стабильный';

  @override
  String get agileSprintScopeSp => 'SP';

  @override
  String get landingIntegrationBadge => 'Интеграция';

  @override
  String get landingIntegrationTitle => 'Связанная экосистема';

  @override
  String get landingIntegrationSubtitle =>
      'Ваши инструменты работают вместе. Пройдите путь от идеи до реализации без перерывов.';

  @override
  String get landingIntegrationFlowTitle =>
      'От списка до поставки в одном потоке';

  @override
  String get landingIntegrationStep1 => 'Сбор';

  @override
  String get landingIntegrationStep1Desc => 'Smart Todo';

  @override
  String get landingIntegrationStep2 => 'Приоритет';

  @override
  String get landingIntegrationStep2Desc => 'Эйзенхауэр';

  @override
  String get landingIntegrationStep3 => 'Оценка';

  @override
  String get landingIntegrationStep3Desc => 'Комната оценки';

  @override
  String get landingIntegrationStep4 => 'Исполнение';

  @override
  String get landingIntegrationStep4Desc => 'Agile-процесс';

  @override
  String get landingIntegrationStep5 => 'Улучшение';

  @override
  String get landingIntegrationStep5Desc => 'Ретроспективы';

  @override
  String get landingIntegrationExport0Title =>
      'Smart Todo → Эйзенхауэр / Оценка / Спринт';

  @override
  String get landingIntegrationExport0Desc =>
      'Превращайте свои задачи в приоритизированные активности, задачи для оценки или элементы бэклога спринта.';

  @override
  String get landingIntegrationExport1Title =>
      'Эйзенхауэр → Todo / Оценка / Спринт';

  @override
  String get landingIntegrationExport1Desc =>
      'Экспортируйте приоритизированные активности в задачи, истории для оценки или пользовательские истории спринта.';

  @override
  String get landingIntegrationExport2Title => 'Комната оценки → Todo / Спринт';

  @override
  String get landingIntegrationExport2Desc =>
      'После оценки отправляйте задачи с согласованными очками сложности в свои списки или бэклог спринта.';

  @override
  String get landingIntegrationExport3Title => 'Agile-процесс → Ретроспективы';

  @override
  String get landingIntegrationExport3Desc =>
      'Связывайте ретроспективы со спринтами с доступом к метрикам во время обсуждения.';

  @override
  String get landingIntegrationDashboardTitle => 'Единый дашборд';

  @override
  String get landingIntegrationDashboardDesc =>
      'Избранное, дедлайны и ожидающие приглашения из каждого инструмента в одном месте.';

  @override
  String jiraTransitionTitle(Object transitionName) {
    return 'Завершить переход: $transitionName';
  }

  @override
  String get jiraTransitionInfo =>
      'Jira требует дополнительную информацию для этого перехода.';

  @override
  String get jiraTransitionConfirm => 'Подтвердить';

  @override
  String get jiraTransitionCancel => 'Отмена';

  @override
  String get jiraFieldRequired => 'Обязательное поле';

  @override
  String jiraSyncSuccess(Object transitionName) {
    return 'Jira: $transitionName завершено';
  }

  @override
  String jiraSyncedTo(Object statusName) {
    return 'Jira: Синхронизировано со статусом $statusName';
  }

  @override
  String jiraSyncFromSuccess(Object issueKey) {
    return 'Синхронизировано из Jira: $issueKey';
  }

  @override
  String jiraSyncFailed(Object error) {
    return 'Ошибка синхронизации: $error';
  }

  @override
  String jiraSyncWarning(Object warning) {
    return 'Предупреждение синхронизации Jira: $warning';
  }

  @override
  String get actionSyncJira => 'Синхронизировать с Jira';

  @override
  String get validationRequired => 'Обязательно';

  @override
  String get jiraInvalidDomain => 'Некорректный домен';

  @override
  String get jiraInvalidEmail => 'Некорректный email';

  @override
  String get jiraCreateTokenLink => 'Создать токен API >';

  @override
  String get agileHelpTitle => 'Краткое руководство';

  @override
  String get agileHelpStep1Title => 'Наполните бэклог';

  @override
  String get agileHelpStep1Desc =>
      'Создайте User Stories во вкладке «Бэклог», чтобы определить объем работы.';

  @override
  String get agileHelpStep2Title => 'Запланируйте спринт';

  @override
  String get agileHelpStep2Desc =>
      'Перейдите во вкладку «Спринт», создайте новый спринт и выберите истории из бэклога.';

  @override
  String get agileHelpStep3Title => 'Работайте на доске';

  @override
  String get agileHelpStep3Desc =>
      'Используйте вкладку «Доска» для визуализации прогресса. Перетаскивайте карточки для обновления статусов.';

  @override
  String get agileHelpStep4Title => 'Синхронизация и завершение';

  @override
  String get agileHelpStep4Desc =>
      'При подключении Jira статусы синхронизируются автоматически. Используйте «Завершить спринт» для финализации.';

  @override
  String get actionNext => 'Далее';

  @override
  String get actionBack => 'Назад';

  @override
  String get actionFinish => 'Завершить';

  @override
  String get agileStartSprintHint =>
      'Запустите спринт, чтобы увидеть активные задачи';

  @override
  String get workflowTitle => 'Процесс истории';

  @override
  String get workflowShowButton => 'Показать процесс';

  @override
  String get workflowDiagramTitle => 'Диаграмма переходов статусов';

  @override
  String get workflowLegend => 'Легенда';

  @override
  String get workflowScrumDesc =>
      'В Scrum истории проходят через планирование спринта, разработку, обзор и завершение. Процесс итеративен с фиксированными по времени спринтами.';

  @override
  String get workflowKanbanDesc =>
      'В Kanban работа течет непрерывно. Истории проходят через систему на основе лимитов WIP и мощности.';

  @override
  String get workflowHybridDesc =>
      'Гибрид сочетает спринты Scrum с потоком Kanban. Истории могут планироваться или браться непрерывно.';

  @override
  String get workflowFromAny => 'Из любого';

  @override
  String get workflowFromAnyDesc => 'Возможен переход из любого статуса';

  @override
  String get workflowCycleLabel => 'Доработка';

  @override
  String get workflowCycleDesc => 'Двусторонний переход (цикл)';

  @override
  String get workflowOptionalDesc => 'Опциональный шаг (можно пропустить)';

  @override
  String get kanbanPoliciesActive => 'Активные правила (Автоматические)';

  @override
  String get kanbanPoliciesExplicit => 'Явные правила (Заметки команды)';

  @override
  String get agileTeam => 'Команда';

  @override
  String get agileRoleDevelopmentTeam => 'Команда разработки';

  @override
  String get agileRoleDevelopmentTeamDesc => 'Участники, выполняющие работу';
}
