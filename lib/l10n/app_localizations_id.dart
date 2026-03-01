// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get smartTodoListOrigin => 'Daftar Keanggotaan';

  @override
  String get smartTodoSortTooltip => 'Opsi Pengurutan';

  @override
  String get smartTodoSortManual => 'Manual';

  @override
  String get smartTodoSortDate => 'Terbaru';

  @override
  String get smartTodoActionSortPriority => 'Urutkan Berdasarkan Prioritas';

  @override
  String get smartTodoActionSortDeadline => 'Urutkan Berdasarkan Tenggat Waktu';

  @override
  String get smartTodoOrderUpdated => 'Urutan diperbarui secara manual';

  @override
  String get newRetro => 'Retro Baru';

  @override
  String get appTitle => 'Keisen';

  @override
  String get goToHome => 'Ke Beranda';

  @override
  String get actionSave => 'Simpan';

  @override
  String get actionCancel => 'Batal';

  @override
  String get actionDelete => 'Hapus';

  @override
  String get actionEdit => 'Ubah';

  @override
  String get actionCreate => 'Buat';

  @override
  String get actionAdd => 'Tambah';

  @override
  String get actionClose => 'Tutup';

  @override
  String get agileSprint => 'Sprint';

  @override
  String get agileStatus => 'Status';

  @override
  String get agilePermissionErrorBacklog =>
      'Izin Ditolak: Hanya PO/SM che bisa memindahkan ke Backlog';

  @override
  String get actionHide => 'Sembunyikan Kartu';

  @override
  String get actionRetry => 'Coba Lagi';

  @override
  String get exportAllData => 'Ekspor Semua Data (Laporan Lengkap)';

  @override
  String get actionConfirm => 'Konfirmasi';

  @override
  String get actionSearch => 'Cari';

  @override
  String get actionFilter => 'Filter';

  @override
  String get actionExport => 'Ekspor';

  @override
  String get actionExportCsv => 'Ekspor CSV';

  @override
  String get actionExportPdf => 'Ekspor Laporan PDF';

  @override
  String get retroBoard => 'Elemen Board';

  @override
  String get actionCopy => 'Salin';

  @override
  String get actionShare => 'Bagikan';

  @override
  String get actionDone => 'Selesai';

  @override
  String get actionReset => 'Reset';

  @override
  String get actionOpen => 'Buka';

  @override
  String get stateLoading => 'Memuat...';

  @override
  String get stateEmpty => 'Tidak ada elemen';

  @override
  String get stateError => 'Kesalahan';

  @override
  String get stateSuccess => 'Berhasil';

  @override
  String get subscriptionCurrent => 'SAAT INI';

  @override
  String get subscriptionRecommended => 'DIREKOMENDASIKAN';

  @override
  String get subscriptionFree => 'Gratis';

  @override
  String get subscriptionPerMonth => '/bulan';

  @override
  String get subscriptionPerYear => '/tahun';

  @override
  String subscriptionSaveYearly(String amount) {
    return 'Hemat €$amount/tahun';
  }

  @override
  String subscriptionTrialDays(int days) {
    return 'Uji coba gratis $days hari';
  }

  @override
  String get subscriptionUnlimitedProjects => 'Proyek tak terbatas';

  @override
  String subscriptionProjectsActive(int count) {
    return '$count proyek aktif';
  }

  @override
  String get subscriptionUnlimitedLists => 'Daftar tak terbatas';

  @override
  String subscriptionSmartTodoLists(int count) {
    return 'Daftar Smart Todo';
  }

  @override
  String get subscriptionActiveProjectsLabel => 'Proyek aktif';

  @override
  String get subscriptionSmartTodoListsLabel => 'Daftar Smart Todo';

  @override
  String get subscriptionUnlimitedTasks => 'Task tak terbatas';

  @override
  String subscriptionTasksPerProject(int count) {
    return '$count task per proyek';
  }

  @override
  String get subscriptionUnlimitedInvites => 'Undangan tak terbatas';

  @override
  String subscriptionInvitesPerProject(int count) {
    return '$count undangan per proyek';
  }

  @override
  String get subscriptionWithAds => 'Dengan iklan';

  @override
  String get subscriptionWithoutAds => 'Tanpa iklan';

  @override
  String get authSignInGoogle => 'Masuk dengan Google';

  @override
  String get authSignOut => 'Keluar';

  @override
  String get authLogoutConfirm => 'Apakah Anda yakin ingin keluar?';

  @override
  String get formNameRequired => 'Masukkan nama Anda';

  @override
  String get authError => 'Kesalahan autentikasi';

  @override
  String get authUserNotFound => 'Pengguna tidak ditemukan';

  @override
  String get authWrongPassword => 'Kata sandi salah';

  @override
  String get authEmailInUse => 'Email sudah digunakan';

  @override
  String get authWeakPassword => 'Kata sandi terlalu lemah';

  @override
  String get authInvalidEmail => 'Email tidak valid';

  @override
  String get appSubtitle => 'Keisen untuk Tim';

  @override
  String get authOr => 'atau';

  @override
  String get authPassword => 'Kata Sandi';

  @override
  String get authRegister => 'Daftar';

  @override
  String get authLogin => 'Masuk';

  @override
  String get authHaveAccount => 'Sudah punya akun?';

  @override
  String get authNoAccount => 'Belum punya akun?';

  @override
  String get authForgotPassword => 'Lupa kata sandi?';

  @override
  String get authResetPasswordSent =>
      'Email reset telah dikirim. Periksa kotak masuk Anda.';

  @override
  String get authVerifyEmail => 'Verifikasi email Anda';

  @override
  String authVerifyEmailDesc(String email) {
    return 'Kami telah mengirimkan email verifikasi ke $email. Klik tautan untuk mengaktifkan akun Anda.';
  }

  @override
  String get authResendVerification => 'Kirim ulang email verifikasi';

  @override
  String get authVerificationSent => 'Email verifikasi terkirim!';

  @override
  String get authEmailVerified => 'Email terverifikasi!';

  @override
  String get authIVerified => 'Saya telah memverifikasi email saya';

  @override
  String get authWaitingVerification => 'Menunggu verifikasi...';

  @override
  String get authChangePassword => 'Ubah kata sandi';

  @override
  String get authCurrentPassword => 'Kata sandi saat ini';

  @override
  String get authNewPassword => 'Kata sandi baru';

  @override
  String get authConfirmNewPassword => 'Konfirmasi kata sandi baru';

  @override
  String get authPasswordChanged => 'Kata sandi berhasil diubah';

  @override
  String get authPasswordMismatch => 'Kata sandi tidak cocok';

  @override
  String get authPasswordTooShort => 'Minimal 6 karakter';

  @override
  String get authReauthRequired => 'Konfirmasi identitas Anda';

  @override
  String get authReauthDesc =>
      'Demi keamanan, konfirmasi identitas Anda untuk melanjutkan.';

  @override
  String get authSignInWithEmail => 'Masuk dengan Email';

  @override
  String get authWrongCurrentPassword => 'Kata sandi saat ini tidak benar';

  @override
  String get profileSecurity => 'Keamanan';

  @override
  String authCooldownWait(int seconds) {
    return 'Tunggu $seconds detik sebelum mengirim ulang';
  }

  @override
  String get navHome => 'Beranda';

  @override
  String get navProfile => 'Profil';

  @override
  String get navSettings => 'Pengaturan';

  @override
  String get eisenhowerTitle => 'Matriks Eisenhower';

  @override
  String get eisenhowerYourMatrices => 'Matriks Anda';

  @override
  String get eisenhowerNoMatrices => 'Belum ada matriks yang dibuat';

  @override
  String get eisenhowerNewMatrix => 'Matriks Baru';

  @override
  String get eisenhowerViewGrid => 'Grid';

  @override
  String get eisenhowerViewChart => 'Grafik';

  @override
  String get eisenhowerViewList => 'Daftar';

  @override
  String get eisenhowerViewRaci => 'RACI';

  @override
  String get quadrantUrgent => 'MENDESAK';

  @override
  String get quadrantNotUrgent => 'TIDAK MENDESAK';

  @override
  String get quadrantImportant => 'PENTING';

  @override
  String get quadrantNotImportant => 'TIDAK PENTING';

  @override
  String get quadrantQ1Title => 'LAKUKAN SEGERA';

  @override
  String get quadrantQ2Title => 'RENCANAKAN';

  @override
  String get quadrantQ3Title => 'DELEGASIKAN';

  @override
  String get quadrantQ4Title => 'HAPUS';

  @override
  String get quadrantQ1Subtitle => 'Mendesak dan Penting';

  @override
  String get quadrantQ2Subtitle => 'Penting, Tidak Mendesak';

  @override
  String get quadrantQ3Subtitle => 'Mendesak, Tidak Penting';

  @override
  String get quadrantQ4Subtitle => 'Tidak Mendesak, Tidak Penting';

  @override
  String get eisenhowerNoActivities => 'Tidak ada aktivitas';

  @override
  String get eisenhowerNewActivity => 'Aktivitas Baru';

  @override
  String get eisenhowerExportSheets => 'Ekspor ke Google Sheets';

  @override
  String get eisenhowerInviteParticipants => 'Undang Peserta';

  @override
  String get eisenhowerDeleteMatrix => 'Hapus Matriks';

  @override
  String get eisenhowerDeleteMatrixConfirm =>
      'Apakah Anda yakin ingin menghapus matriks ini?';

  @override
  String get eisenhowerActivityTitle => 'Judul aktivitas';

  @override
  String get eisenhowerActivityNotes => 'Catatan';

  @override
  String get eisenhowerDueDate => 'Tanggal jatuh tempo';

  @override
  String get eisenhowerPriority => 'Prioritas';

  @override
  String get eisenhowerAssignee => 'Penerima tugas';

  @override
  String get eisenhowerCompleted => 'Selesai';

  @override
  String get eisenhowerMoveToQuadrant => 'Pindahkan ke kuadran';

  @override
  String get eisenhowerMatrixSettings => 'Pengaturan Matriks';

  @override
  String get eisenhowerBackToList => 'Daftar';

  @override
  String get eisenhowerPriorityList => 'Daftar Prioritas';

  @override
  String get eisenhowerAllActivities => 'Semua aktivitas';

  @override
  String get eisenhowerToVote => 'Untuk voting';

  @override
  String get eisenhowerVoted => 'Sudah voting';

  @override
  String get eisenhowerTotal => 'Total';

  @override
  String get eisenhowerEditParticipants => 'Ubah peserta';

  @override
  String eisenhowerActivityCountLabel(int count) {
    return '$count aktivitas';
  }

  @override
  String eisenhowerVoteCountLabel(int count) {
    return '$count vote';
  }

  @override
  String get eisenhowerModifyVotes => 'Ubah vote';

  @override
  String get eisenhowerVote => 'Vote';

  @override
  String get eisenhowerQuadrant => 'Kuadran';

  @override
  String get eisenhowerUrgencyAvg => 'Rata-rata urgensi';

  @override
  String get eisenhowerImportanceAvg => 'Rata-rata kepentingan';

  @override
  String get eisenhowerVotesLabel => 'Vote:';

  @override
  String get eisenhowerNoVotesYet => 'Belum ada vote yang masuk';

  @override
  String get eisenhowerEditMatrix => 'Ubah Matriks';

  @override
  String get eisenhowerAddActivity => 'Tambah Aktivitas';

  @override
  String get eisenhowerDeleteActivity => 'Hapus Aktivitas';

  @override
  String eisenhowerDeleteActivityConfirm(String title) {
    return 'Apakah Anda yakin ingin menghapus \"$title\"?';
  }

  @override
  String get eisenhowerMatrixCreated => 'Matriks berhasil dibuat';

  @override
  String get eisenhowerMatrixUpdated => 'Matriks diperbarui';

  @override
  String get eisenhowerMatrixDeleted => 'Matriks dihapus';

  @override
  String get eisenhowerActivityAdded => 'Aktivitas ditambahkan';

  @override
  String get eisenhowerActivityDeleted => 'Aktivitas dihapus';

  @override
  String get eisenhowerVotesSaved => 'Vote disimpan';

  @override
  String get eisenhowerExportCompleted => 'Ekspor selesai!';

  @override
  String get eisenhowerExportAll => 'Ekspor Semua Data';

  @override
  String get eisenhowerExportCompletedDialog => 'Ekspor Selesai';

  @override
  String get eisenhowerExportDialogContent =>
      'File Google Sheets telah dibuat.\nApakah Anda ingin membukanya di browser?';

  @override
  String get eisenhowerOpen => 'Buka';

  @override
  String get eisenhowerAddParticipantsFirst =>
      'Tambahkan peserta ke matriks terlebih dahulu';

  @override
  String get eisenhowerSearchLabel => 'Cari:';

  @override
  String get eisenhowerSearchHint => 'Cari matriks...';

  @override
  String get eisenhowerNoMatrixFound => 'Tidak ada matriks yang ditemukan';

  @override
  String get eisenhowerCreateFirstMatrix =>
      'Buat Matriks Eisenhower pertama Anda\nuntuk mengatur prioritas Anda';

  @override
  String get eisenhowerCreateMatrix => 'Buat Matriks';

  @override
  String get eisenhowerClickToOpen => 'Matriks Eisenhower\nKlik untuk membuka';

  @override
  String get eisenhowerTotalActivities => 'Total aktivitas dalam matriks';

  @override
  String get eisenhowerVotedActivities => 'Aktivitas yang sudah di-vote';

  @override
  String get eisenhowerPendingVoting => 'Aktivitas yang menunggu voting';

  @override
  String get eisenhowerStartVoting => 'Mulai Voting Mandiri';

  @override
  String eisenhowerStartVotingDesc(String title) {
    return 'Apakah Anda ingin memulai sesi voting mandiri untuk \"$title\"?\n\nSetiap peserta akan memberikan suara tanpa melihat pilihan orang lain, sampai semua orang selesai voting dan hasilnya diungkapkan.';
  }

  @override
  String get eisenhowerStart => 'Mulai';

  @override
  String get eisenhowerVotingStarted => 'Voting dimulai';

  @override
  String get eisenhowerResetVoting => 'Reset Voting?';

  @override
  String get eisenhowerResetVotingDesc => 'Semua suara akan dihapus.';

  @override
  String get eisenhowerVotingReset => 'Voting di-reset';

  @override
  String get eisenhowerMinVotersRequired =>
      'Dibutuhkan minimal 2 pemilih untuk voting mandiri';

  @override
  String eisenhowerDeleteMatrixWithActivities(int count) {
    return 'Semua $count aktivitas juga akan dihapus.';
  }

  @override
  String eisenhowerYourMatricesCount(int filtered, int total) {
    return 'Matriks Anda ($filtered/$total)';
  }

  @override
  String get formTitleRequired => 'Masukkan judul';

  @override
  String get formTitleHint => 'Misal: Prioritas Q1 2025';

  @override
  String get formDescriptionHint => 'Deskripsi opsional';

  @override
  String get formParticipantHint => 'Nama peserta';

  @override
  String get formAddParticipantHint =>
      'Tambahkan setidaknya satu peserta untuk dapat melakukan voting';

  @override
  String get formActivityTitleHint => 'Misal: Menyelesaikan dokumentasi API';

  @override
  String get errorCreatingMatrix => 'Kesalahan saat membuat matriks';

  @override
  String get errorUpdatingMatrix => 'Kesalahan saat memperbarui';

  @override
  String get errorDeletingMatrix => 'Kesalahan saat menghapus';

  @override
  String get errorAddingActivity => 'Kesalahan saat menambahkan aktivitas';

  @override
  String get errorSavingVotes => 'Kesalahan saat menyimpan suara';

  @override
  String get errorExport => 'Kesalahan saat ekspor';

  @override
  String get errorStartingVoting => 'Kesalahan saat memulai voting';

  @override
  String get errorResetVoting => 'Kesalahan saat me-reset';

  @override
  String get errorLoadingActivities => 'Kesalahan saat memuat aktivitas';

  @override
  String get eisenhowerWaitingForVotes => 'Menunggu suara';

  @override
  String eisenhowerVotedParticipants(int ready, int total) {
    return '$ready/$total suara';
  }

  @override
  String get eisenhowerVoteSubmit => 'VOTE';

  @override
  String get eisenhowerVotedSuccess => 'Anda telah memilih';

  @override
  String get eisenhowerRevealVotes => 'UNGKAPKAN HASIL';

  @override
  String get eisenhowerQuickVote => 'Voting Cepat';

  @override
  String get eisenhowerTeamVote => 'Voting Tim';

  @override
  String get eisenhowerUrgency => 'URGENSI';

  @override
  String get eisenhowerImportance => 'KEPENTINGAN';

  @override
  String get eisenhowerUrgencyShort => 'U:';

  @override
  String get eisenhowerImportanceShort => 'K:';

  @override
  String get eisenhowerVoting => 'Voting';

  @override
  String get eisenhowerVotingInProgress => 'VOTING SEDANG BERLANGSUNG';

  @override
  String get eisenhowerWaitingForOthers =>
      'Menunggu semua orang selesai voting. Fasilitator akan mengungkapkan hasilnya.';

  @override
  String get eisenhowerReady => 'Siap';

  @override
  String get eisenhowerWaiting => 'Menunggu';

  @override
  String get eisenhowerIndividualVotes => 'SUARA INDIVIDUAL';

  @override
  String get eisenhowerResult => 'HASIL';

  @override
  String get eisenhowerAverage => 'RATA-RATA';

  @override
  String get eisenhowerVotesRevealed => 'Hasil Diungkapkan';

  @override
  String get eisenhowerNextActivity => 'Aktivitas Berikutnya';

  @override
  String get eisenhowerNoVotesRecorded => 'Tidak ada suara yang tercatat';

  @override
  String get eisenhowerWaitingForStart => 'Menunggu';

  @override
  String get eisenhowerPreVotesTooltip =>
      'Suara awal yang akan dihitung saat fasilitator memulai voting';

  @override
  String get eisenhowerObserverWaiting =>
      'Menunggu fasilitator memulai voting kolektif';

  @override
  String get eisenhowerPreVoteTooltip =>
      'Berikan suara Anda lebih awal. Ini akan dihitung saat voting dimulai.';

  @override
  String get eisenhowerPreVote => 'Pre-vote';

  @override
  String get eisenhowerPreVoted => 'Anda telah melakukan pre-vote';

  @override
  String get eisenhowerStartVotingTooltip =>
      'Mulai sesi voting kolektif. Pre-vote yang ada akan tetap disimpan.';

  @override
  String get eisenhowerResetVotingTooltip =>
      'Reset voting dan hapus semua suara';

  @override
  String get eisenhowerObserverWaitingVotes =>
      'Mengamati voting yang sedang berlangsung...';

  @override
  String get eisenhowerWaitingForAllVotes =>
      'Menunggu semua peserta memberikan suara';

  @override
  String get eisenhowerRevealTooltipReady =>
      'Semua orang telah memilih! Klik untuk mengungkapkan hasil.';

  @override
  String eisenhowerRevealTooltipNotReady(int count) {
    return 'Masih kurang $count suara';
  }

  @override
  String get eisenhowerVotingLocked => 'Voting ditutup';

  @override
  String get eisenhowerVotingLockedTooltip =>
      'Hasil telah diungkapkan. Anda tidak bisa lagi melakukan voting untuk aktivitas ini.';

  @override
  String eisenhowerOnlineParticipants(int online, int total) {
    return '$online dari $total peserta online';
  }

  @override
  String get eisenhowerAllActivitiesVoted => 'Semua aktivitas telah di-vote!';

  @override
  String get eisenhowerAlreadyVotedError =>
      'Aktivitas ini sudah di-vote. Fasilitator harus membuka kembali voting untuk mengubahnya.';

  @override
  String eisenhowerYourVote(Object urgency, Object importance) {
    return 'Pilihan Anda: U=$urgency, K=$importance';
  }

  @override
  String eisenhowerVoterName(Object name) {
    return 'Suara dari $name';
  }

  @override
  String get eisenhowerUrgencyLow => 'Tidak mendesak';

  @override
  String get eisenhowerUrgencyHigh => 'Sangat mendesak';

  @override
  String get eisenhowerImportanceLow => 'Tidak penting';

  @override
  String get eisenhowerImportanceHigh => 'Sangat penting';

  @override
  String eisenhowerQuadrantLabel(Object name) {
    return 'Kuadran: $name';
  }

  @override
  String get eisenhowerQ1Name => 'Q1 - LAKUKAN SEGERA';

  @override
  String get eisenhowerQ1Desc => 'Mendesak + Penting';

  @override
  String get eisenhowerQ2Name => 'Q2 - RENCANAKAN';

  @override
  String get eisenhowerQ2Desc => 'Tidak mendesak + Penting';

  @override
  String get eisenhowerQ3Name => 'Q3 - DELEGASIKAN';

  @override
  String get eisenhowerQ3Desc => 'Mendesak + Tidak penting';

  @override
  String get eisenhowerQ4Name => 'Q4 - HAPUS';

  @override
  String get eisenhowerQ4Desc => 'Tidak mendesak + Tidak penting';

  @override
  String eisenhowerPreVotes(Object count) {
    return '$count pre-vote';
  }

  @override
  String get eisenhowerVotesVisibleAfterReveal =>
      'Suara akan terlihat saat fasilitator mengklik \"Ungkapkan Hasil\"';

  @override
  String eisenhowerNextActivityError(Object error) {
    return 'Kesalahan saat memulai voting berikutnya: $error';
  }

  @override
  String get eisenhowerReopenVotes => 'Buka kembali voting';

  @override
  String get eisenhowerReopenVotesTooltip =>
      'Mulai ulang voting formal berdasarkan estimasi saat ini';

  @override
  String get eisenhowerReopenVotesConfirm => 'Buka kembali semua voting?';

  @override
  String get eisenhowerReopenVotesDesc =>
      'Operasi ini akan memulai ulang sesi voting formal untuk semua aktivitas, dengan tetap mempertahankan estimasi saat ini sebagai titik awal. Apakah Anda ingin melanjutkan?';

  @override
  String get estimationTitle => 'Ruang Estimasi';

  @override
  String get estimationYourSessions => 'Sesi Anda';

  @override
  String get estimationNoSessions => 'Belum ada sesi yang dibuat';

  @override
  String get estimationNewSession => 'Sesi Baru';

  @override
  String get estimationEditSession => 'Ubah Sesi';

  @override
  String get estimationJoinSession => 'Gabung Sesi';

  @override
  String get estimationSessionCode => 'Kode Sesi';

  @override
  String get estimationEnterCode => 'Masukkan kode';

  @override
  String get sessionStatusDraft => 'Draf';

  @override
  String get sessionStatusActive => 'Aktif';

  @override
  String get sessionStatusCompleted => 'Selesai';

  @override
  String get sessionName => 'Nama sesi';

  @override
  String get sessionNameRequired => 'Nama Sesi *';

  @override
  String get sessionNameHint => 'Misal: Sprint 15 - Estimasi User Stories';

  @override
  String get sessionDescription => 'Deskripsi';

  @override
  String get sessionCardSet => 'Set Kartu';

  @override
  String get cardSetFibonacci =>
      'Fibonacci (0, 1, 2, 3, 5, 8, 13, 20, 40, 100, ?, ?)';

  @override
  String get cardSetSimplified => 'Sederhana (1, 2, 3, 5, 8, 13, ?, ?)';

  @override
  String get sessionEstimationMode => 'Mode Estimasi';

  @override
  String get sessionEstimationModeLocked =>
      'Tidak bisa mengubah mode setelah voting dimulai';

  @override
  String get sessionAutoReveal => 'Auto-reveal';

  @override
  String get sessionAutoRevealDesc =>
      'Ungkapkan saat semua orang selesai voting';

  @override
  String get sessionAllowObservers => 'Pengamat';

  @override
  String get sessionAllowObserversDesc => 'Izinkan peserta yang tidak memilih';

  @override
  String get sessionConfiguration => 'Konfigurasi';

  @override
  String get voteConsensus => 'Konsensus tercapai!';

  @override
  String get voteResults => 'Hasil Voting';

  @override
  String get voteRevote => 'Vote ulang';

  @override
  String get voteReveal => 'Ungkapkan';

  @override
  String get voteHide => 'Sembunyikan';

  @override
  String get voteAverage => 'Rata-rata';

  @override
  String get voteMedian => 'Median';

  @override
  String get voteMode => 'Modus';

  @override
  String get voteVoters => 'Pemilih';

  @override
  String get voteDistribution => 'Distribusi suara';

  @override
  String get voteFinalEstimate => 'Estimasi akhir';

  @override
  String get voteSelectFinal => 'Pilih estimasi akhir';

  @override
  String get voteAverageTooltip => 'Rata-rata aritmetika dari suara numerik';

  @override
  String get voteMedianTooltip => 'Nilai tengah saat suara diurutkan';

  @override
  String get voteModeTooltip =>
      'Suara yang paling sering muncul (nilai yang paling banyak dipilih)';

  @override
  String get voteVotersTooltip => 'Total peserta yang telah memberikan suara';

  @override
  String get voteWaiting => 'Menunggu suara...';

  @override
  String get voteSubmitted => 'Suara terkirim';

  @override
  String get voteNotSubmitted => 'Belum memilih';

  @override
  String get storyToEstimate => 'Story yang akan diestimasi';

  @override
  String get storyTitle => 'Judul story';

  @override
  String get storyDescription => 'Deskripsi story';

  @override
  String get storyAddNew => 'Tambah story baru';

  @override
  String get storyNoStories => 'Tidak ada story untuk diestimasi';

  @override
  String get retrospectivesVoted => 'Sudah Voting';

  @override
  String get storyComplete => 'Story selesai';

  @override
  String get storySkip => 'Lewati story';

  @override
  String get estimationModeFibonacci => 'Fibonacci';

  @override
  String get estimationModeTshirt => 'Ukuran Kaos';

  @override
  String get estimationModeDecimal => 'Desimal';

  @override
  String get estimationModeThreePoint => 'Three-Point (PERT)';

  @override
  String get estimationModeDotVoting => 'Dot Voting';

  @override
  String get estimationModeBucketSystem => 'Sistem Ember';

  @override
  String get estimationModeFiveFingers => 'Lima Jari';

  @override
  String get estimationVotesRevealed => 'Suara Diungkapkan';

  @override
  String get estimationVotingInProgress => 'Voting Sedang Berlangsung';

  @override
  String estimationVotesCountFormatted(int count, int total) {
    return '$count/$total suara';
  }

  @override
  String get estimationConsensusReached => 'Konsensus tercapai!';

  @override
  String get estimationVotingResults => 'Hasil Voting';

  @override
  String get estimationRevote => 'Vote ulang';

  @override
  String get estimationAverage => 'Rata-rata';

  @override
  String get estimationAverageTooltip =>
      'Rata-rata aritmetika dari suara numerik';

  @override
  String get estimationMedian => 'Median';

  @override
  String get estimationMedianTooltip => 'Nilai tengah saat suara diurutkan';

  @override
  String get estimationMode => 'Modus';

  @override
  String get estimationModeTooltip =>
      'Suara yang paling sering muncul (nilai yang paling banyak dipilih)';

  @override
  String get estimationVoters => 'Pemilih';

  @override
  String get estimationVotersTooltip =>
      'Total peserta yang telah memberikan suara';

  @override
  String get estimationVoteDistribution => 'Distribusi suara';

  @override
  String get estimationSelectFinalEstimate => 'Pilih estimasi akhir';

  @override
  String get estimationFinalEstimate => 'Estimasi akhir';

  @override
  String get eisenhowerChartTitle => 'Distribusi Aktivitas';

  @override
  String get quadrantLabelDo => 'Q1 - LAKUKAN';

  @override
  String get quadrantLabelPlan => 'Q2 - RENCANAKAN';

  @override
  String get quadrantLabelDelegate => 'Q3 - DELEGASI';

  @override
  String get quadrantLabelEliminate => 'Q4 - HAPUS';

  @override
  String get eisenhowerNoRatedActivities => 'Belum ada aktivitas yang di-vote';

  @override
  String get eisenhowerVoteToSeeChart =>
      'Vote aktivitas untuk melihatnya di grafik';

  @override
  String get eisenhowerChartCardTitle => 'Grafik Distribusi';

  @override
  String get eisenhowerPdfLegend => 'Legenda Aktivitas';

  @override
  String get eisenhowerPdfRaciTitle => 'Matriks Tanggung Jawab RACI';

  @override
  String get marketingPdfFeatureTitle => 'Laporan PDF Profesional';

  @override
  String get marketingPdfFeatureDesc =>
      'Hasilkan laporan siap cetak dengan Kotak Kuadran, Grafik Scatter, dan matriks RACI untuk pertemuan tim Anda.';

  @override
  String get raciAddColumnTitle => 'Tambah Kolom RACI';

  @override
  String get raciColumnType => 'Tipe';

  @override
  String get raciTypePerson => 'Orang (Peserta)';

  @override
  String get raciTypeCustom => 'Kustom (Tim/Lainnya)';

  @override
  String get raciSelectParticipant => 'Pilih peserta';

  @override
  String get raciColumnName => 'Nama kolom';

  @override
  String get raciColumnNameHint => 'Misal: Tim Pengembang';

  @override
  String get raciDeleteColumnTitle => 'Hapus Kolom';

  @override
  String raciDeleteColumnConfirm(String name) {
    return 'Hapus kolom \'$name\'? Penugasan yang terkait akan hilang.';
  }

  @override
  String estimationOnlineParticipants(int online, int total) {
    return '$online dari $total peserta online';
  }

  @override
  String get estimationNewStoryTitle => 'Story Baru';

  @override
  String get estimationStoryTitleLabel => 'Judul *';

  @override
  String get estimationStoryTitleHint =>
      'Misal: US-123: Sebagai pengguna saya ingin...';

  @override
  String get estimationStoryDescriptionLabel => 'Deskripsi';

  @override
  String get estimationStoryDescriptionHint =>
      'Kriteria penerimaan, catatan...';

  @override
  String get estimationEnterTitleAlert => 'Masukkan judul';

  @override
  String get estimationParticipantsHeader => 'Peserta';

  @override
  String get estimationRoleFacilitator => 'Fasilitator';

  @override
  String get estimationRoleVoters => 'Pemilih';

  @override
  String get estimationRoleObservers => 'Pengamat';

  @override
  String get estimationYouSuffix => '(Anda)';

  @override
  String get estimationDecimalTitle => 'Estimasi Desimal';

  @override
  String get estimationDecimalHint =>
      'Masukkan estimasi dalam hari (misal: 1.5, 2.25)';

  @override
  String get estimationQuickSelect => 'Pilihan cepat:';

  @override
  String get estimationDaysSuffix => 'hari';

  @override
  String estimationVoteValue(String value) {
    return 'Suara: $value hari';
  }

  @override
  String get estimationEnterValueAlert => 'Masukkan nilai';

  @override
  String get estimationInvalidValueAlert => 'Nilai tidak valid';

  @override
  String estimationMinAlert(double value) {
    return 'Min: $value';
  }

  @override
  String estimationMaxAlert(double value) {
    return 'Max: $value';
  }

  @override
  String get retroTitle => 'Retrospektif Saya';

  @override
  String get retroNoRetros => 'Tidak ada retrospektif';

  @override
  String get retroNoRetrosFound => 'Tidak ada retrospektif ditemukan';

  @override
  String get retroCreateNew => 'Buat Baru';

  @override
  String get retroContinueAction => 'Lanjutkan';

  @override
  String get retroCurrentPhase => 'Fase';

  @override
  String get retroNoCompletedRetros => 'Tidak ada retrospektif yang selesai';

  @override
  String get retroStandalone => 'Standalone';

  @override
  String get retroCompletedOn => 'Selesai pada';

  @override
  String get retroSummaryDetails => 'Detail';

  @override
  String get retroSummaryCompleted => 'Selesai';

  @override
  String get retroSummaryFacilitator => 'Fasilitator';

  @override
  String get retroSummaryNotAvailable => 'T/A';

  @override
  String get retroSummarySprint => 'Sprint';

  @override
  String get retroSummaryFeedback => 'Feedback';

  @override
  String get retroSummaryNoCards => 'Tidak ada kartu';

  @override
  String get retroChooseMode => 'Pilih Mode Retrospektif';

  @override
  String get retroQuickForm => 'Formulir Cepat';

  @override
  String get retroInteractiveBoard => 'Papan Interaktif';

  @override
  String get retroQuickModeDesc =>
      'Isi formulir cepat untuk mencatat poin-poin penting sprint.';

  @override
  String get retroInteractiveModeDesc =>
      'Mulai papan waktu nyata untuk berkolaborasi dengan seluruh tim.';

  @override
  String get retroNoOperationsReview => 'Tidak ada Operations Review';

  @override
  String get retroOperationsReview => 'Operations Review';

  @override
  String get retroOperationsReviewDesc =>
      'Buat Operations Review untuk meningkatkan alur kerja';

  @override
  String get retroWentWell => 'Apa yang berjalan baik?';

  @override
  String get retroToImprove => 'Apa yang perlu ditingkatkan?';

  @override
  String get retroWentWellHint => 'Tambah poin positif...';

  @override
  String get retroToImproveHint => 'Tambah poin peningkatan...';

  @override
  String get retroActionItemHint => 'Tambah item tindakan...';

  @override
  String get retroSave => 'Simpan Retrospektif';

  @override
  String get agileEstimate => 'ESTIMASI';

  @override
  String get agileAssign => 'Tugaskan';

  @override
  String get agileCardMenuTooltip => 'Opsi (Prioritas, Estimasi, dll.)';

  @override
  String get kanbanPolicyHelpTitle => 'Policy Kolom (Aturan)';

  @override
  String get kanbanPolicyHelpIntro =>
      'Policy adalah aturan eksplisit yang menentukan kapan sebuah kartu bisa masuk atau keluar dari sebuah kolom. Aturan ini menjamin kualitas dan alur. Aktifkan dari ikon \'Pengaturan\' di tajuk kolom.';

  @override
  String get kanbanPolicyRule1Title => '1. Memerlukan Kriteria Penerimaan';

  @override
  String get kanbanPolicyRule1Desc =>
      'Kartu harus memiliki setidaknya satu kriteria penerimaan yang ditentukan untuk melanjutkan. Berguna untuk memastikan bahwa persyaratan sudah jelas sebelum pengembangan.';

  @override
  String get kanbanPolicyRule2Title => '2. Estimasi Selesai';

  @override
  String get kanbanPolicyRule2Desc =>
      'Kartu harus memiliki estimasi dalam Story Points (atau metode lain) > 0. Penting untuk Perencanaan dan Velocity.';

  @override
  String get kanbanPolicyRule3Title => '3. Maksimal 2 Hari di Kolom';

  @override
  String get kanbanPolicyRule3Desc =>
      'Memberi sinyal jika sebuah kartu tetap diam di status yang sama selama lebih dari 48 jam. Membantu mengidentifikasi hambatan atau tugas yang terhambat.';

  @override
  String get kanbanPolicyRule4Title => '4. Semua Kriteria Terpenuhi';

  @override
  String get kanbanPolicyRule4Desc =>
      'Memblokir perpindahan ke \'Done\' jika tidak semua kriteria penerimaan dicentang. Menjamin Definition of Done.';

  @override
  String get retroOpenInteractiveBoard => 'Buka Papan Interaktif';

  @override
  String get retroSentimentTeam => 'Sentimen Tim';

  @override
  String get retroExcellent => 'Luar Biasa';

  @override
  String get retroGood => 'Baik';

  @override
  String get retroNormal => 'Normal';

  @override
  String get retroNeedsImprovement => 'Perlu Peningkatan';

  @override
  String get retroCritical => 'Kritis';

  @override
  String get retroNoElements => 'Tidak ada elemen';

  @override
  String get retroNoActionItemsFound => 'Tidak ada item tindakan';

  @override
  String retroAssignedTo(String email) {
    return 'Ditugaskan kepada: $email';
  }

  @override
  String retroVotesCount(int count) {
    return '+$count suara';
  }

  @override
  String get retroGuidance => 'Panduan Retrospektif';

  @override
  String retroResultLabel(String score, String label) {
    return 'Rata-rata sentimen: $score ($label)';
  }

  @override
  String get retroSearchHint => 'Cari retrospektif...';

  @override
  String get agileProgressManual => 'Manual';

  @override
  String get agileProgress => 'Kemajuan';

  @override
  String get agileProgressAuto => 'Otomatis';

  @override
  String agileProgressTooltipManual(int percent) {
    return 'Diatur secara manual ke $percent%';
  }

  @override
  String agileProgressTooltipCriteria(int completed, int total) {
    return 'Selesai $completed/$total kriteria';
  }

  @override
  String agileProgressTooltipStatus(String status) {
    return 'Diestimasi berdasarkan status: $status';
  }

  @override
  String get agileProcessTitle => 'Manajer Proses Agile';

  @override
  String get agileSearchProjects => 'Cari proyek...';

  @override
  String get agileMethodologyGuide => 'Panduan Metodologi';

  @override
  String get agileMethodologyGuideTitle => 'Panduan Metodologi Agile';

  @override
  String get agileMethodologyGuideSubtitle =>
      'Pilih metodologi yang paling sesuai untuk proyek Anda';

  @override
  String get agileNewProject => 'Proyek Baru';

  @override
  String get agileRoles => 'PERAN';

  @override
  String get agileProcessFlow => 'ALUR PROSES';

  @override
  String get agileArtifacts => 'ARTEFAK';

  @override
  String get agileBestPractices => 'Praktik Terbaik';

  @override
  String get agileAntiPatterns => 'Anti-Pattern yang Harus Dihindari';

  @override
  String get agileFAQ => 'Pertanyaan Umum';

  @override
  String get agileScrumShortDesc =>
      'Sprint waktu tetap, Velocity, Burndown. Ideal untuk produk dengan persyaratan yang terus berkembang.';

  @override
  String get agileKanbanShortDesc =>
      'Alur berkelanjutan, WIP Limits, Lead Time. Ideal untuk dukungan dan permintaan terus-menerus.';

  @override
  String get agileScrumbanShortDesc =>
      'Campuran Sprint dan alur berkelanjutan. Ideal untuk tim yang menginginkan fleksibilitas.';

  @override
  String get agileRolePODesc => 'Mengelola backlog dan prioritas';

  @override
  String get agileRoleSMDesc =>
      'Memfasilitasi proses dan menghilangkan hambatan';

  @override
  String get agileRoleDevTeamDesc => 'Anggota yang mengembangkan produk';

  @override
  String get agileRoleStakeholdersDesc =>
      'Memberikan umpan balik dan persyaratan';

  @override
  String get agileRoleSRMDesc =>
      'Mengelola permintaan yang masuk dan memfasilitasi prioritas (menggantikan Product Owner)';

  @override
  String get agileRoleSDMDesc =>
      'Mengelola alur kerja dan memfasilitasi pengiriman (menggantikan Scrum Master)';

  @override
  String get agileRoleTeamDesc =>
      'Melaksanakan pekerjaan dengan mematuhi WIP limits';

  @override
  String get agileRoleFlowMasterDesc => 'Mengoptimalkan alur dan memfasilitasi';

  @override
  String get agileRoleTeamHybridDesc => 'Lintas fungsi, terorganisir mandiri';

  @override
  String get scrumOverview =>
      'Scrum adalah kerangka kerja Agile yang iteratif dan inkremental untuk manajemen pengembangan produk.\nIni didasarkan pada siklus kerja waktu tetap yang disebut Sprint, biasanya 2-4 minggu.\n\nScrum ideal untuk:\n• Tim yang mengerjakan produk dengan persyaratan yang terus berkembang\n• Proyek yang mendapat manfaat dari umpan balik rutin\n• Organisasi yang ingin meningkatkan prediksi dan transparansi';

  @override
  String get scrumRolesTitle => 'Peran-peran Scrum';

  @override
  String get scrumRolesContent =>
      'Scrum menentukan tiga peran kunci yang berkolaborasi untuk keberhasilan proyek.';

  @override
  String get scrumRolesPO =>
      'Product Owner: Mewakili pemangku kepentingan, mengelola Product Backlog, dan memaksimalkan nilai produk';

  @override
  String get scrumRolesSM =>
      'Scrum Master: Memfasilitasi proses Scrum, menghilangkan hambatan, dan membantu tim untuk meningkatkan diri';

  @override
  String get scrumRolesDev =>
      'Development Team: Tim lintas fungsi dan terorganisir mandiri yang memberikan inkremen produk';

  @override
  String get scrumEventsTitle => 'Acara-acara Scrum';

  @override
  String get scrumEventsContent =>
      'Scrum menyediakan acara rutin untuk menciptakan keteraturan dan meminimalkan pertemuan yang tidak direncanakan.';

  @override
  String get scrumEventsPlanning =>
      'Sprint Planning: Perencanaan pekerjaan Sprint (maks 8 jam untuk Sprint 4 minggu)';

  @override
  String get scrumEventsDaily =>
      'Daily Scrum: Sinkronisasi harian tim (15 menit)';

  @override
  String get scrumEventsRetro => 'Retrospektif';

  @override
  String get scrumEventsRetroContent =>
      'Buat retrospektif untuk menganalisis sprint terakhir dan mengidentifikasi area peningkatan.';

  @override
  String get scrumEventsReview =>
      'Sprint Review: Demo pekerjaan yang selesai kepada pemangku kepentingan (maks 4 jam)';

  @override
  String get scrumArtifactsTitle => 'Artefak-artefak Scrum';

  @override
  String get scrumArtifactsContent =>
      'Artefak mewakili pekerjaan atau nilai dan dirancang untuk memaksimalkan transparansi.';

  @override
  String get scrumArtifactsPB =>
      'Product Backlog: Daftar terurut dari segala sesuatu yang mungkin dibutuhkan dalam produk';

  @override
  String get scrumArtifactsSB =>
      'Sprint Backlog: Item yang dipilih untuk Sprint + rencana untuk memberikan inkremen';

  @override
  String get scrumArtifactsIncrement =>
      'Inkremen: Jumlah dari semua item yang diselesaikan selama Sprint, berpotensi untuk dirilis';

  @override
  String get scrumStoryPointsTitle => 'Story Points dan Velocity';

  @override
  String get scrumStoryPointsContent =>
      'Story Points adalah unit pengukuran relatif dari kompleksitas User Stories.\nMereka tidak mengukur waktu, tetapi upaya, kompleksitas, dan ketidakpastian.\n\nUrutan Fibonacci (1, 2, 3, 5, 8, 13, 21) umum digunakan karena:\n• Mencerminkan ketidakpastian yang meningkat untuk item yang lebih besar\n• Membuat presisi palsu menjadi sulit\n• Mempermudah diskusi selama estimasi\n\nVelocity adalah rata-rata Story Points yang diselesaikan dalam sprint terakhir dan digunakan untuk:\n• Memprediksi berapa banyak pekerjaan yang dapat dimasukkan dalam sprint berikutnya\n• Mengidentifikasi tren produktivitas tim\n• Tidak membandingkan tim yang berbeda (setiap tim memiliki skalanya sendiri)';

  @override
  String get scrumBP1 => 'Jaga durasi Sprint tetap dan hormati timebox';

  @override
  String get scrumBP2 =>
      'Product Backlog harus selalu diprioritaskan dan diperhalus (refined)';

  @override
  String get scrumBP3 => 'User Stories harus mematuhi kriteria INVEST';

  @override
  String get scrumBP4 => 'Definition of Done harus jelas dan dibagikan bersama';

  @override
  String get scrumBP5 => 'Jangan mengubah Sprint Goal selama Sprint';

  @override
  String get scrumBP6 => 'Rayakan keberhasilan dalam Sprint Review';

  @override
  String get scrumBP7 =>
      'Retrospektif harus menghasilkan tindakan nyata untuk peningkatan';

  @override
  String get scrumBP8 => 'Tim harus lintas fungsi dan terorganisir mandiri';

  @override
  String get scrumBP9 =>
      'Gunakan fase penutupan terpandu untuk menyelesaikan Sprint Review sebelum finalisasi';

  @override
  String get scrumBP10 =>
      'Jangan membuat beberapa sprint dalam perencanaan sekaligus: selesaikan atau hapus yang sudah ada sebelum membuat yang baru';

  @override
  String get scrumAP1 => 'Sprint tanpa Sprint Goal yang jelas';

  @override
  String get scrumAP2 => 'Daily Scrum berubah menjadi rapat laporan status';

  @override
  String get scrumAP3 =>
      'Melewatkan Retrospektif saat merasa \"terlalu sibuk\"';

  @override
  String get scrumAP4 => 'Product Owner absen atau tidak tersedia';

  @override
  String get scrumAP5 =>
      'Menambah pekerjaan selama Sprint tanpa menghapus yang lain';

  @override
  String get scrumAP6 =>
      'Story Points dikonversi menjadi jam (kehilangan maknanya)';

  @override
  String get scrumAP7 => 'Tim terlalu besar (ideal 5-9 orang)';

  @override
  String get scrumAP8 => 'Scrum Master yang \"menugaskan\" tugas kepada tim';

  @override
  String get scrumAP9 =>
      'Menutup sprint tanpa Sprint Review dan tanpa memilih penempatan story yang belum selesai';

  @override
  String get scrumSprintClosingTitle => 'Penutupan Sprint Terpandu';

  @override
  String get scrumSprintClosingContent =>
      'Alur penutupan sprint mengikuti proses 2 fase sesuai dengan Scrum Guide 2020:\n\n1. **Sprint Review**: Fase kualitatif. Pemangku kepentingan menginspeksi Inkremen. Setiap story dinilai sebagai \'Disetujui\' (ditandai sebagai Selesai) atau \'Perlu Perbaikan\' (dikembalikan ke Backlog untuk pengerjaan di masa mendatang). Catatan: story yang dipindahkan ke Backlog selama fase review (misal ke \'To Do\') tidak termasuk dalam review — mereka akan tersedia untuk Sprint Planning berikutnya.\n\n2. **Finalisasi Sprint**: Fase administratif. Tim memutuskan nasib pekerjaan yang belum selesai: Kembali ke Backlog (untuk perencanaan di masa mendatang), Pindah ke Ready (jika segera bisa dikerjakan), atau Pindah ke Refinement (jika perlu analisis).';

  @override
  String get scrumFAQ1Q => 'Berapa lama durasi Sprint?';

  @override
  String get scrumFAQ1A =>
      'Durasi tipikal adalah 2 minggu, tetapi bisa berkisar antara 1 hingga 4 minggu. Sprint yang lebih pendek memungkinkan umpan balik yang lebih sering dan koreksi arah yang cepat. Sprint yang lebih panjang memberikan lebih banyak waktu untuk menyelesaikan item yang kompleks. Yang penting adalah menjaga durasi tetap konsisten.';

  @override
  String get scrumFAQ2Q =>
      'Bagaimana cara menangani pekerjaan yang belum selesai di akhir Sprint?';

  @override
  String get scrumFAQ2A =>
      'User Stories yang belum selesai kembali ke Product Backlog dan diprioritaskan ulang. Jangan pernah memperpanjang Sprint atau mengurangi Definition of Done. Gunakan Retrospektif untuk memahami mengapa itu terjadi dan bagaimana mencegahnya.';

  @override
  String get scrumFAQ3Q =>
      'Bisakah saya mengubah Sprint Backlog selama Sprint?';

  @override
  String get scrumFAQ3A =>
      'Sprint Goal tidak boleh berubah, tetapi Sprint Backlog bisa berkembang. Tim dapat bernegosiasi dengan PO untuk menukar item dengan nilai yang setara. Jika Sprint Goal menjadi tidak relevan, PO dapat membatalkan Sprint.';

  @override
  String get scrumFAQ4Q => 'Bagaimana cara menghitung Velocity awal?';

  @override
  String get scrumFAQ4A =>
      'Untuk 3 Sprint pertama, buatlah estimasi yang konservatif. Setelah 3 Sprint, Anda akan memiliki Velocity yang and dalkan. Jangan gunakan Velocity tim lain sebagai referensi.';

  @override
  String get kanbanOverview =>
      'Kanban adalah metode untuk mengelola pekerjaan yang menekankan visualisasi alur,\npembatasan Work In Progress (WIP), dan peningkatan proses secara berkelanjutan.\n\nKanban ideal untuk:\n• Tim pendukung/pemeliharaan dengan permintaan terus-menerus\n• Lingkungan di mana prioritas sering berubah\n• Ketika perencanaan dalam iterasi tetap tidak memungkinkan\n• Transisi bertahap menuju Agile';

  @override
  String get kanbanPrinciplesTitle => 'Prinsip-prinsip Kanban';

  @override
  String get kanbanPrinciplesContent =>
      'Kanban didasarkan pada prinsip-prinsip perubahan inkremental dan penghormatan terhadap peran yang sudah ada.';

  @override
  String get kanbanPrinciple1 =>
      'Visualisasikan alur kerja: Buat semua pekerjaan terlihat';

  @override
  String get agileItems => 'item';

  @override
  String get agileItemsShort => 'item';

  @override
  String get agileWorkloadAvgItems => 'Rata-rata Item/Orang';

  @override
  String get agileKanbanCapacityNote =>
      'Kapasitas dihitung berdasarkan mingguan (5 hari kerja).';

  @override
  String get agilePriority => 'Prioritas';

  @override
  String get agileRoleSRM => 'Service Request Manager';

  @override
  String get agileRoleSDM => 'Service Delivery Manager';

  @override
  String get agileRoleTeamMember => 'Anggota Tim';

  @override
  String get agileFrameworkLocked =>
      'Tidak dapat mengubah framework untuk proyek dengan aktivitas yang sudah ada';

  @override
  String get agileComingSoon => 'Segera hadir';

  @override
  String get kanbanPrinciple2 =>
      'Batasi WIP: Selesaikan pekerjaan sebelum memulai yang baru';

  @override
  String get kanbanPrinciple3 =>
      'Kelola alur: Optimalkan untuk memaksimalkan throughput';

  @override
  String get kanbanPrinciple4 =>
      'Buat policy eksplisit: Tentukan aturan yang jelas';

  @override
  String get kanbanPrinciple5 =>
      'Implementasikan feedback loops: Tingkatkan terus secara berkelanjutan';

  @override
  String get kanbanPrinciple6 =>
      'Tingkatkan secara kolaboratif: Berkembang melalui eksperimen';

  @override
  String get kanbanBoardTitle => 'Papan Kanban';

  @override
  String get kanbanBoardContent =>
      'Papan memvisualisasikan alur kerja melalui fase-fasenya.\nSetiap kolom mewakili status pekerjaan (misal: To Do, In Progress, Done).\n\nElemen kunci dari papan:\n• Kolom: Status alur kerja\n• Kartu/Tiket: Unit pekerjaan\n• WIP Limits: Batasan per kolom\n• Swimlanes: Pengelompokan horizontal (opsional)';

  @override
  String get kanbanWIPTitle => 'WIP Limits';

  @override
  String get kanbanWIPContent =>
      'Batasan Work In Progress (WIP) adalah inti dari Kanban.\nMembatasi WIP:\n\n• Mengurangi context switching\n• Menonjolkan hambatan\n• Mempercepat throughput\n• Meningkatkan kualitas (sedikit kesalahan dari multitasking)\n• Meningkatkan prediksi\n\nCara mengatur WIP limits:\n• Mulai dengan (jumlah anggota tim × 2) per kolom\n• Amati alur dan sesuaikan\n• Batas yang \'tepat\' menciptakan ketegangan ringan';

  @override
  String get kanbanMetricsTitle => 'Metrik Kanban';

  @override
  String get kanbanMetricsContent =>
      'Kanban menggunakan metrik alur untuk mengukur dan meningkatkan proses.';

  @override
  String get kanbanMetric1 =>
      'Lead Time: Waktu dari permintaan sampai selesai (termasuk waktu tunggu)';

  @override
  String get kanbanMetric2 =>
      'Cycle Time: Waktu dari awal pekerjaan sampai selesai';

  @override
  String get kanbanMetric3 =>
      'Throughput: Item yang diselesaikan per unit waktu';

  @override
  String get kanbanMetric4 =>
      'WIP: Jumlah pekerjaan yang sedang berlangsung setiap saat';

  @override
  String get kanbanMetric5 =>
      'Cumulative Flow Diagram (CFD): Memvisualisasikan akumulasi pekerjaan dari waktu ke waktu';

  @override
  String get kanbanCadencesTitle => 'Kadensi Kanban';

  @override
  String get kanbanCadencesContent =>
      'Berbeda dengan Scrum, Kanban tidak mengharuskan acara tetap.\nNamun, kadensi rutin membantu peningkatan berkelanjutan:\n\n• Standup Meeting: Sinkronisasi harian di depan papan\n• Replenishment Meeting: Prioritas backlog\n• Delivery Planning: Perencanaan rilis\n• Service Delivery Review: Review metrik\n• Risk Review: Analisis risiko dan hambatan\n• Operations Review: Peningkatan proses';

  @override
  String get kanbanSwimlanesTitle => 'Swimlanes';

  @override
  String get kanbanSwimlanesContent =>
      'Swimlanes adalah baris horizontal yang mengelompokkan kartu di papan berdasarkan atribut umum.\n\nTipe swimlane yang tersedia:\n• Sesuai Kelas Layanan: Mengelompokkan berdasarkan prioritas/urgensi pekerjaan\n• Penerima Tugas: Mengelompokkan berdasarkan anggota tim yang ditugaskan\n• Prioritas: Mengelompokkan berdasarkan level MoSCoW\n• Tag: Mengelompokkan berdasarkan tag story\n\nSwimlanes membantu untuk:\n• Memvisualisasikan beban kerja per orang\n• Mengelola berbagai kelas layanan (mendesak, standar)\n• Mengidentifikasi hambatan untuk tipe pekerjaan tertentu';

  @override
  String kanbanPoliciesTitle(String columnName) {
    return 'Policy: $columnName';
  }

  @override
  String get kanbanPoliciesContent =>
      'Praktik ke-4 Kanban: \'Make Policies Explicit\' memerlukan definisi aturan yang jelas untuk setiap kolom.\n\nContoh policy:\n• \'Maks 24 jam di kolom ini\' – batas waktu\n• \'Memerlukan code review yang disetujui\' – kriteria keluar\n• \'Maks 1 item per orang\' – batas individual\n• \'Pembaruan harian wajib\' – komunikasi\n\nPolicy:\n• Membuat ekspektasi menjadi transparan bagi semua orang\n• Mengurangi ambiguitas dan konflik\n• Mempermudah orientasi anggota baru\n• Memungkinkan untuk mengidentifikasi kapan aturan dilanggar';

  @override
  String get kanbanBP1 =>
      'Visualisasikan SEMUA pekerjaan, termasuk pekerjaan tersembunyi';

  @override
  String get kanbanBP2 => 'Patuhi WIP limits dengan ketat';

  @override
  String get kanbanBP3 => 'Fokus pada menyelesaikan, bukan memulai';

  @override
  String get kanbanBP4 =>
      'Gunakan metrik untuk keputusan, bukan untuk menghakimi orang';

  @override
  String get kanbanBP5 => 'Meningkatkan langkah demi langkah';

  @override
  String get kanbanBP6 =>
      'Blokir pekerjaan baru jika WIP sudah mencapai batasnya';

  @override
  String velocityTooltipAverage(int count) {
    return 'Berdasarkan semua $count sprint yang telah selesai';
  }

  @override
  String get kanbanBP7 => 'Analisis hambatan dan hapus dengan cepat';

  @override
  String get kanbanBP8 =>
      'Gunakan swimlanes untuk prioritas atau tipe pekerjaan';

  @override
  String get kanbanAP1 => 'WIP limits terlalu tinggi (atau tidak ada)';

  @override
  String get kanbanAP2 => 'Mengabaikan hambatan di board';

  @override
  String get kanbanAP3 => 'Tidak mematuhi batas saat merasa \"mendesak\"';

  @override
  String get kanbanAP4 => 'Kolom terlalu umum (misal: hanya To Do/Done)';

  @override
  String get kanbanAP5 => 'Tidak melacak kapan item masuk/keluar';

  @override
  String get kanbanAP6 =>
      'Menggunakan Kanban hanya sebagai task board tanpa prinsip';

  @override
  String get kanbanAP7 => 'Tidak pernah menganalisis Cumulative Flow Diagram';

  @override
  String get kanbanAP8 => 'Terlalu banyak swimlanes yang memperumit tampilan';

  @override
  String get kanbanFAQ1Q => 'Bagaimana cara menangani urgensi di Kanban?';

  @override
  String get kanbanFAQ1A =>
      'Buat swimlane \"Expedite\" dengan WIP limit 1. Item expedite melewati antrean tetapi harus jarang terjadi. Jika semua mendesak, berarti tidak ada yang mendesak.';

  @override
  String get kanbanFAQ2Q =>
      'Apakah Kanban berfungsi untuk pengembangan perangkat lunak?';

  @override
  String get kanbanFAQ2A =>
      'Tentu saja ya. Kanban lahir di Toyota tetapi digunakan secara luas dalam pengembangan perangkat lunak. Sangat cocok untuk tim pemeliharaan, DevOps, dan dukungan.';

  @override
  String get kanbanFAQ3Q => 'Bagaimana cara mengatur WIP limits awal?';

  @override
  String get kanbanFAQ3A =>
      'Rumus awal: (jumlah anggota tim + 1) per kolom. Amati selama 2 minggu dan kurangi secara bertahap sampai tercipta sedikit ketegangan. Batas optimal bervariasi untuk setiap tim dan konteks.';

  @override
  String get kanbanFAQ4Q =>
      'Berapa lama waktu yang dibutuhkan untuk melihat hasil dengan Kanban?';

  @override
  String get kanbanFAQ4A =>
      'Peningkatan pertama (visibilitas) terjadi segera. Pengurangan Lead Time terlihat dalam 2-4 minggu. Peningkatan proses yang signifikan membutuhkan waktu 2-3 bulan.';

  @override
  String get hybridOverview =>
      'Scrumban menggabungkan elemen Scrum dan Kanban untuk menciptakan pendekatan fleksibel yang menyesuaikan dengan konteks tim. Menjaga struktur Sprint dengan fleksibilitas alur berkelanjutan dan WIP limits.\n\nScrumban ideal untuk:\n• Tim yang ingin beralih dari Scrum ke Kanban (atau sebaliknya)\n• Proyek dengan campuran pengembangan fitur dan pemeliharaan\n• Tim yang menginginkan Sprint tetapi dengan fleksibilitas lebih\n• Ketika Scrum \"murni\" terlalu kaku untuk konteks tersebut';

  @override
  String get hybridFromScrumTitle => 'Dari Scrum: Struktur';

  @override
  String get hybridFromScrumContent =>
      'Scrumban menjaga beberapa elemen terstruktur Scrum untuk prediksi.';

  @override
  String get hybridFromScrum1 =>
      'Sprint (opsional): Iterasi waktu tetap untuk kadensi';

  @override
  String get hybridFromScrum2 =>
      'Sprint Planning: Pemilihan pekerjaan untuk periode tersebut';

  @override
  String get hybridFromScrum3 => 'Retrospektif: Refleksi dan peningkatan';

  @override
  String get hybridFromScrum4 => 'Demo/Review: Berbagi nilai yang dihasilkan';

  @override
  String get hybridFromScrum5 =>
      'Story Points: Untuk estimasi dan prediksi (opsional)';

  @override
  String get hybridFromKanbanTitle => 'Dari Kanban: Alur';

  @override
  String get hybridFromKanbanContent =>
      'Scrumban mengadopsi prinsip alur Kanban untuk efisiensi.';

  @override
  String get hybridFromKanban1 =>
      'WIP Limits: Pembatasan pekerjaan yang sedang berlangsung';

  @override
  String get hybridFromKanban2 =>
      'Pull System: Tim \"menarik\" pekerjaan saat memiliki kapasitas';

  @override
  String get hybridFromKanban3 => 'Visualisasi: Board bersama yang transparan';

  @override
  String get hybridFromKanban4 =>
      'Metrik alur: Lead Time, Cycle Time, Throughput';

  @override
  String get hybridFromKanban5 =>
      'Peningkatan berkelanjutan: Policy eksplisit dan eksperimen';

  @override
  String get hybridOnDemandTitle => 'Planning Sesuai Kebutuhan';

  @override
  String get hybridOnDemandContent =>
      'Dalam Scrumban, perencanaan bisa dilakukan \"sesuai kebutuhan\" (on-demand) daripada interval tetap.\n\nPerencanaan diaktifkan saat:\n• Backlog \"Ready\" turun di bawah ambang batas\n• Perlu memprioritaskan permintaan mendesak yang baru\n• Sebuah milestone mendekat\n\nIni mengurangi sesi perencanaan saat tidak diperlukan dan memungkinkan reaksi lebih cepat terhadap perubahan.';

  @override
  String get hybridWhenTitle => 'Kapan Menggunakan Apa';

  @override
  String get hybridWhenContent =>
      'Scrumban bukan berarti \"melakukan semuanya\". Ini tentang memilih elemen yang tepat untuk konteksnya.\n\nGunakan elemen Scrum saat:\n• Membutuhkan prediksi dalam pengiriman\n• Pemangku kepentingan menginginkan demo rutin\n• Tim mendapat manfaat dari ritme tetap\n\nGunakan elemen Kanban saat:\n• Pekerjaan tidak terprediksi (dukungan, perbaikan bug)\n• Perlu responsivitas terhadap urgensi\n• Fokus pada throughput berkelanjutan';

  @override
  String get hybridBP1 =>
      'Mulai dengan apa yang Anda ketahui dan tambahkan elemen secara bertahap';

  @override
  String get hybridBP2 =>
      'WIP limits tidak dapat dinegosiasikan, bahkan dengan Sprint';

  @override
  String get hybridBP3 =>
      'Gunakan Sprint untuk kadensi, bukan sebagai komitmen kaku';

  @override
  String get hybridBP4 =>
      'Pertahankan Retrospektif, ini adalah mesin peningkatan';

  @override
  String get hybridBP5 =>
      'Metrik alur membantu lebih dari sekadar Velocity murni';

  @override
  String get hybridBP6 => 'Bereksperimenlah dengan satu hal pada satu waktu';

  @override
  String get hybridBP7 => 'Dokumentasikan policy tim dan tinjau secara rutin';

  @override
  String get hybridBP8 =>
      'Pertimbangkan swimlanes untuk memisahkan fitur dari pemeliharaan';

  @override
  String get hybridAP1 =>
      'Mengambil hal terburuk dari keduanya (kekakuan Scrum + kekacauan Kanban)';

  @override
  String get hybridAP2 =>
      'Menghapus Retrospektif karena merasa \"sudah fleksibel\"';

  @override
  String get hybridAP3 =>
      'Mengabaikan WIP limits karena sudah merasa \"punya Sprint\"';

  @override
  String get hybridAP4 => 'Mengubah framework di setiap Sprint';

  @override
  String get hybridAP5 =>
      'Tidak memiliki kadensi sama sekali (tidak ada Sprint, tidak ada apa-apa)';

  @override
  String get hybridAP6 =>
      'Mencampuradukkan fleksibilitas dengan ketiadaan aturan';

  @override
  String get hybridAP7 => 'Tidak mengukur apa pun';

  @override
  String get hybridAP8 => 'Terlalu banyak kompleksitas untuk konteksnya';

  @override
  String get hybridFAQ1Q => 'Apakah Scrumban memiliki Sprint atau tidak?';

  @override
  String get hybridFAQ1A =>
      'Tergantung timnya. Anda bisa memiliki Sprint untuk kadensi (review, planning) tetapi mengizinkan alur kerja berkelanjutan di dalam Sprint. Atau Anda bisa menghapus Sprint dan hanya menggunakan kadensi Kanban.';

  @override
  String get hybridFAQ2Q => 'Bagaimana cara mengukur kinerja dalam Scrumban?';

  @override
  String get hybridFAQ2A =>
      'Gunakan metrik Scrum (Velocity jika menggunakan Sprint dan Story Points) dan metrik Kanban (Lead Time, Cycle Time, Throughput). Metrik alur seringkali lebih berguna untuk peningkatan.';

  @override
  String get hybridFAQ3Q => 'Dari mana memulai Scrumban?';

  @override
  String get hybridFAQ3A =>
      'Jika Anda dari Scrum: tambahkan WIP limits dan visualisasikan alur. Jika Anda dari Kanban: tambahkan kadensi rutin untuk review dan planning. Mulailah dari apa yang tim sudah ketahui.';

  @override
  String get hybridFAQ4Q =>
      'Apakah Scrumban \"kurang Agile\" dibanding Scrum murni?';

  @override
  String get hybridFAQ4A =>
      'Tidak. Agile bukan tentang mengikuti kerangka kerja tertentu. Scrumban bisa lebih Agile karena menyesuaikan dengan konteks. Yang penting adalah inspeksi dan adaptasi terus-menerus.';

  @override
  String get retroNoResults => 'Tidak ada hasil ditemukan';

  @override
  String get agileNoAssignee => 'Tidak ditugaskan';

  @override
  String get retroFilterAll => 'Semua';

  @override
  String get retroFilterActive => 'Aktif';

  @override
  String get retroFilterCompleted => 'Selesai';

  @override
  String get retroFilterDraft => 'Draf';

  @override
  String get retroDeleteTitle => 'Hapus Retrospektif';

  @override
  String retroDeleteConfirm(String title) {
    return 'Apakah Anda yakin?';
  }

  @override
  String get retroDeleteSuccess => 'Retrospektif berhasil dihapus';

  @override
  String retroDeleteError(String error) {
    return 'Kesalahan saat menghapus: $error';
  }

  @override
  String get retroDeleteConfirmAction => 'Hapus permanen';

  @override
  String get retroNewRetroTitle => 'Retrospektif Baru';

  @override
  String get retroLinkToSprint => 'Hubungkan ke Sprint?';

  @override
  String get retroNoProjectFound => 'Tidak ada proyek ditemukan.';

  @override
  String get retroSelectProject => 'Pilih Proyek';

  @override
  String get retroSelectSprint => 'Pilih Sprint';

  @override
  String retroSprintLabel(int number, String name) {
    return 'Sprint $number: $name';
  }

  @override
  String retroSprintOnlyLabel(int number) {
    return 'Sprint $number';
  }

  @override
  String get retroOwner => 'Pemilik';

  @override
  String get retroGuest => 'Tamu';

  @override
  String get retroSessionTitle => 'Judul Sesi';

  @override
  String get retroSessionTitleHint =>
      'Misal: Sinkronisasi Mingguan, Review Proyek...';

  @override
  String get retroTemplateLabel => 'Templat';

  @override
  String get retroVotesPerUser => 'Suara per pengguna:';

  @override
  String get retroActionClose => 'Tutup';

  @override
  String get retroActionCreate => 'Buat';

  @override
  String get retroStatusDraft => 'Draf';

  @override
  String get retroStatusActive => 'Sedang Berlangsung';

  @override
  String get agileBurndownInfoTitle => 'Cara Membaca Burndown Chart';

  @override
  String get agileBurndownInfoIdeal =>
      'Garis **Ideal** (putus-putus) menunjukkan target kemajuan jika pekerjaan selesai secara seragam.';

  @override
  String get agileBurndownInfoActual =>
      'Garis **Aktual** (bersambung) menunjukkan sisa pekerjaan. Story yang selesai akan menurunkan garis ini.';

  @override
  String get agileBurndownInfoGoal =>
      'Tujuan Anda adalah menjaga garis aktual tetap di bawah garis ideal untuk selesai tepat waktu.';

  @override
  String get guideToolsTitle => 'Alat & Integrasi';

  @override
  String get guideJiraContent =>
      'Aplikasi terintegrasi dengan Jira untuk menjaga pekerjaan tetap sinkron.\n\nFitur utama:\n• **Impor**: Story yang dibuat di Jira muncul di sini.\n• **Link**: Klik pada ID story (mis. PROJ-123) membuka Jira secara langsung.\n• **Sync**: Status diperbarui secara dua arah (jika dikonfigurasi).';

  @override
  String get guideWorkflowTitle => 'Workflow & Kualitas';

  @override
  String get guideAcceptanceCriteriaContent =>
      'Untuk menjamin kualitas, setiap story harus memiliki Kriteria Penerimaan yang jelas.\n\n• **Tambah Cepat**: Anda bisa menambah kriteria langsung dari detail story.\n• **Verifikasi**: Centang kriteria saat sudah terpenuhi.\n• **Definition of Done**: Sebuah story dianggap \'Done\' hanya jika semua kriteria terpenuhi.';

  @override
  String get scrumWorkflowStatusContent =>
      'Dalam Scrum, siklus hidup story mengikuti status berikut:\n\n**Product Backlog** (hanya terlihat di tab Backlog):\n1. **Backlog**: Tempat ide lahir. Story belum dianalisis.\n2. **Refinement**: Story sedang dalam fase analisis/detail. Aktivitas kolaboratif seluruh tim (menuju Definition of Ready).\n3. **Ready**: Story memenuhi DoR dan bisa dipilih saat Sprint Planning. Hanya PO yang bisa menandai story sebagai Ready.\n\n**Sprint Board** (terlihat pada board selama Sprint):\n4. **To Do**: Story \'Ready\' yang dimasukkan ke Sprint.\n5. **In Progress**: Pekerjaan aktif tim.\n6. **Review**: Tahap peninjauan/Code Review.\n7. **Done**: Story selesai dan diverifikasi.';

  @override
  String get kanbanWorkflowStatusContent =>
      'Dalam Kanban, alur bersifat berkelanjutan:\n\n1. **Refinement**: Kolom khusus untuk menganalisis permintaan masuk.\n2. **Ready**: Antrean untuk pekerjaan yang siap (pull system).\n3. **Active Board**: Story mengalir melalui kolom-kolom pekerjaan.\n4. **WIP Limits**: Setiap kolom memiliki batas untuk menghindari hambatan.';

  @override
  String get hybridWorkflowStatusContent =>
      'Scrumban menggunakan pendekatan hibrida:\n\n• Bisa menggunakan Sprint untuk perencanaan, tetapi mengelola alur harian seperti Kanban.\n• Story \'Ready\' bisa ditarik (pull) saat ada kapasitas, tanpa tergantung Sprint Planning, jika tim lebih menyukainya.';

  @override
  String get contextualHelpButton => 'Bantuan';

  @override
  String get contextualHelpTips => 'Tips';

  @override
  String get contextualHelpBacklogTitle => 'Product Backlog';

  @override
  String get contextualHelpBacklogDesc =>
      'Backlog adalah daftar terprioritaskan dari semua pekerjaan. Story di bagian atas adalah yang terpenting.';

  @override
  String get contextualHelpBacklogTip1 =>
      'Jaga backlog tetap urut berdasarkan prioritas';

  @override
  String get contextualHelpBacklogTip2 =>
      'Berkolaborasi dengan tim dalam Refinement untuk mendetailkan story';

  @override
  String get contextualHelpBacklogTip3 =>
      'Story dianggap \'Ready\' saat memenuhi Definition of Ready';

  @override
  String get contextualHelpSprintTitle => 'Sprint';

  @override
  String get contextualHelpSprintDesc =>
      'Sprint adalah periode waktu tetap (1-4 minggu) di mana tim mengerjakan story yang dipilih.';

  @override
  String get contextualHelpSprintTip1 =>
      'Jangan mengubah cakupan selama sprint';

  @override
  String get contextualHelpSprintTip2 =>
      'Pantau burndown untuk memverifikasi kemajuan';

  @override
  String get contextualHelpSprintTip3 =>
      'Gunakan daily standup untuk sinkronisasi tim';

  @override
  String get contextualHelpSprintTip4 =>
      'Di akhir sprint, gunakan \'Tutup Sprint\' untuk penutupan terpandu dengan Review dan pengaturan story';

  @override
  String get contextualHelpKanbanTitle => 'Papan Kanban';

  @override
  String get contextualHelpKanbanDescFlow =>
      'Papan Kanban memvisualisasikan alur kerja. Item berpindah dari kiri ke kanan melalui kolom.';

  @override
  String get contextualHelpKanbanDescScrum =>
      'Dalam Scrum, board menunjukkan status story di sprint saat ini.';

  @override
  String get contextualHelpKanbanTip1 =>
      'Patuhi WIP limits untuk menghindari hambatan';

  @override
  String get contextualHelpKanbanTip2 =>
      'Tarik (pull) pekerjaan baru hanya saat ada kapasitas';

  @override
  String get contextualHelpKanbanTip3 =>
      'Pantau usia item untuk mengidentifikasi hambatan';

  @override
  String get contextualHelpKanbanTipScrum1 =>
      'Pindahkan kartu dari kiri ke kanan saat bekerja';

  @override
  String get contextualHelpKanbanTipScrum2 =>
      'Selesaikan sebuah story sebelum memulai yang lain';

  @override
  String get contextualHelpTeamTitle => 'Tim';

  @override
  String get contextualHelpTeamDesc =>
      'Di sini Anda bisa mengelola anggota tim, peran, dan kompetensi mereka.';

  @override
  String get contextualHelpTeamTip1 =>
      'Tugaskan peran yang jelas kepada setiap anggota';

  @override
  String get contextualHelpTeamTip2 => 'Seimbangkan beban kerja antar anggota';

  @override
  String get contextualHelpMetricsTitle => 'Metrik';

  @override
  String get contextualHelpMetricsDescScrum =>
      'Pantau velocity, burndown, dan akurasi estimasi untuk meningkatkan prediksi.';

  @override
  String get contextualHelpMetricsDescKanban =>
      'Pantau Lead Time, Cycle Time, dan Throughput untuk mengoptimalkan alur.';

  @override
  String get contextualHelpMetricsDescHybrid =>
      'Gabungkan metrik Scrum dan Kanban untuk gambaran lengkap.';

  @override
  String get contextualHelpMetricsTipScrum1 =>
      'Gunakan rata-rata velocity untuk merencanakan sprint mendatang';

  @override
  String get contextualHelpMetricsTipScrum2 =>
      'Analisis estimasi untuk meningkatkan presisi';

  @override
  String get contextualHelpMetricsTipKanban1 =>
      'Kurangi Lead Time untuk mengirimkan nilai lebih cepat';

  @override
  String get contextualHelpMetricsTipKanban2 =>
      'Pantau Throughput mingguan untuk prediksi';

  @override
  String get contextualHelpMetricsTipKanban3 =>
      'Gunakan usia item untuk mengidentifikasi hambatan';

  @override
  String get contextualHelpMetricsTipHybrid1 =>
      'Seimbangkan metrik velocity dan alur';

  @override
  String get contextualHelpMetricsTipHybrid2 =>
      'Sesuaikan metrik dengan cara kerja Anda';

  @override
  String get contextualHelpRetroTitle => 'Retrospektif';

  @override
  String get contextualHelpRetroDescScrum =>
      'Retrospektif adalah mesin peningkatan berkelanjutan melalui 4 area utama.';

  @override
  String get contextualHelpRetroDescKanban =>
      'Dalam Kanban (Operations Review), fokus pada analisis alur dan hambatan.';

  @override
  String get contextualHelpRetroTabActiveTitle => 'Tab Aktif: Sesi Inti';

  @override
  String get contextualHelpRetroTabActive =>
      'Kelola brainstorm saat ini. Dalam fase \'Writing\', kartu disembunyikan (hindari bias penjangkaran). Gunakan \'Carry Forward\' untuk poin yang belum selesai.';

  @override
  String get contextualHelpRetroTabHistoryTitle => 'Tab Riwayat: Tren';

  @override
  String get contextualHelpRetroTabHistory =>
      'Tinjau sesi selesai melalui grafik tren. Analisis Sentimen vs Tingkat Penyelesaian.';

  @override
  String get contextualHelpRetroTabActionItemsTitle => 'Pelacak Item Tindakan';

  @override
  String get contextualHelpRetroTabActionItems =>
      'Eksekusi strategis. Gunakan kriteria SMART. Gunakan filter untuk item yang jatuh tempo.';

  @override
  String get contextualHelpRetroTabLessonsLearnedTitle =>
      'Register Lessons Learned';

  @override
  String get contextualHelpRetroTabLessonsLearned =>
      'Repository pengetahuan institusional (strategis). Bisa impor dari proyek lain.';

  @override
  String get contextualHelpRetroIntegrationTitle => 'Siklus Peningkatan';

  @override
  String get contextualHelpRetroIntegration =>
      'Kartu board disuling menjadi Item Tindakan, masuk ke riwayat, dan diformalkan sebagai Lessons Learned.';

  @override
  String get contextualHelpRetroModeQuickTitle =>
      'Formulir Cepat vs Papan Interaktif';

  @override
  String get contextualHelpRetroModeQuick =>
      'Formulir cepat untuk satu orang mencatat highlight. Mengisi riwayat tanpa kolaborasi waktu nyata.';

  @override
  String get contextualHelpRetroModeInteractiveTitle => 'Sesi Interaktif';

  @override
  String get contextualHelpRetroModeInteractive =>
      'Icebreaker, Brainstorming, Pengelompokan, Voting. Semua suara didengar, bias dikurangi.';

  @override
  String get contextualHelpRetroTip1 =>
      'Tugaskan pemilik dan tenggat waktu yang jelas untuk setiap Item Tindakan';

  @override
  String get contextualHelpRetroTip2 =>
      'Rayakan kekuatan di tab Lessons Learned';

  @override
  String get contextualHelpRetroTip3 =>
      'Gunakan \'Formulir Cepat\' untuk mendigitalisasi hasil workshop fisik';

  @override
  String get retroStatusCompleted => 'Selesai';

  @override
  String get profileIntegrations => 'Integrasi';

  @override
  String get profileJiraIntegration => 'Integrasi Jira';

  @override
  String get profileJiraIntegrationDesc => 'Hubungkan untuk impor story';

  @override
  String get jiraDomain => 'Domain Jira';

  @override
  String get jiraEmail => 'Email Atlassian';

  @override
  String get jiraApiToken => 'Token API';

  @override
  String get jiraConnect => 'Hubungkan';

  @override
  String get jiraDisconnect => 'Putuskan';

  @override
  String get jiraSettingsSaved => 'Pengaturan disimpan';

  @override
  String get jiraSettingsCleared => 'Pengaturan dihapus';

  @override
  String get retroTemplateStartStopContinue => 'Mulai, Berhenti, Lanjutkan';

  @override
  String get retroTemplateSailboat => 'Kapal Layar';

  @override
  String get retroTemplate4Ls => '4 L';

  @override
  String get retroTemplateStarfish => 'Bintang Laut';

  @override
  String get retroTemplateMadSadGlad => 'Marah Sedih Senang';

  @override
  String get retroTemplateDAKI => 'DAKI (Drop Add Keep Improve)';

  @override
  String get retroDescStartStopContinue =>
      'Berorientasi aksi: Mulai lakukan, Berhenti lakukan, Lanjutkan lakukan.';

  @override
  String get retroDescSailboat => 'Visual: Angin, Sauh, Karang, Pulau.';

  @override
  String get retroDesc4Ls => 'Liked, Learned, Lacked, Longed For.';

  @override
  String get retroDescStarfish => 'Keep, Stop, Start, More, Less.';

  @override
  String get retroDescMadSadGlad => 'Emosional: Marah, Sedih, Senang.';

  @override
  String get retroDescDAKI =>
      'Pragmatis: Hapus, Tambah, Pertahankan, Tingkatkan.';

  @override
  String get retroUsageStartStopContinue =>
      'Ideal untuk umpan balik yang bisa ditindaklanjuti.';

  @override
  String get retroUsageSailboat =>
      'Ideal untuk tujuan dan risiko (pemikiran kreatif).';

  @override
  String get retroUsage4Ls => 'Refleksi: Belajar dari masa lalu.';

  @override
  String get retroUsageStarfish =>
      'Kalibrasi: Menyesuaikan upaya (lebih banyak/kurang).';

  @override
  String get retroUsageMadSadGlad =>
      'Check-in emosional, setelah sprint yang berat.';

  @override
  String get retroUsageDAKI => 'Tegas: Fokus pada keputusan Hapus atau Tambah.';

  @override
  String get retroIcebreakerSentiment => 'Vote Sentimen';

  @override
  String get retroIcebreakerOneWord => 'Satu Kata';

  @override
  String get retroIcebreakerWeather => 'Cuaca';

  @override
  String get retroIcebreakerSentimentDesc =>
      'Vote 1-5 tentang perasaan selama sprint.';

  @override
  String get retroIcebreakerOneWordDesc => 'Gambarkan sprint dalam satu kata.';

  @override
  String get retroIcebreakerWeatherDesc => 'Pilih ikon cuaca untuk sprint.';

  @override
  String get retroPhaseIcebreaker => 'ICEBREAKER';

  @override
  String get retroPhaseWriting => 'PENULISAN';

  @override
  String get retroPhaseVoting => 'VOTING';

  @override
  String get retroPhaseDiscuss => 'DISKUSI';

  @override
  String get retroActionItemsLabel => 'Item Tindakan';

  @override
  String get retroActionDragToCreate =>
      'Seret kartu ke sini untuk membuat Item Tindakan';

  @override
  String get retroNoActionItems => 'Belum ada Item Tindakan yang dibuat.';

  @override
  String get facilitatorGuideNextColumn => 'Aksi berikutnya dari';

  @override
  String get collectionRationaleSSC =>
      'Berhenti dulu, lalu Mulai, lalu Lanjutkan.';

  @override
  String get collectionRationaleMSG =>
      'Hadapi frustrasi, lalu kekecewaan, baru rayakan sukses.';

  @override
  String get collectionRationale4Ls =>
      'Isi kekurangan, lalu aspirasi, simpan yang berhasil, berbagi pelajaran.';

  @override
  String get collectionRationaleSailboat =>
      'Mitigasi risiko, hapus penahan, lalu gunakan pendorong.';

  @override
  String get collectionRationaleStarfish => 'Stop, Less, Keep, More, Start.';

  @override
  String get collectionRationaleDAKI => 'Drop, Add, Improve, Keep.';

  @override
  String get missingSuggestionSSCStop => 'Praktik mana yang harus dihentikan?';

  @override
  String get missingSuggestionSSCStart =>
      'Praktik baru mana yang bisa membantu?';

  @override
  String get missingSuggestionMSGMad => 'Hadapi frustrasi tim.';

  @override
  String get missingSuggestionMSGSad => 'Selesaikan kekecewaan.';

  @override
  String get missingSuggestion4LsLacked => 'Apa yang kurang bagi tim?';

  @override
  String get missingSuggestion4LsLonged => 'Apa yang diinginkan tim?';

  @override
  String get missingSuggestionSailboatAnchor => 'Apa yang menahan tim?';

  @override
  String get missingSuggestionSailboatRock => 'Identifikasi risiko.';

  @override
  String get missingSuggestionStarfishStop => 'Ganti praktik negatif.';

  @override
  String get missingSuggestionStarfishStart => 'Mulai praktik baru.';

  @override
  String get missingSuggestionDAKIDrop => 'Apa yang harus dihapus?';

  @override
  String get missingSuggestionDAKIAdd => 'Keputusan baru apa yang diperlukan?';

  @override
  String get missingSuggestionGeneric => 'Buat item tindakan dari kolom ini.';

  @override
  String get facilitatorGuideAllCovered => 'Semua kolom sudah tertangani!';

  @override
  String get facilitatorGuideMissing => 'Item tindakan kurang untuk';

  @override
  String get retroPhaseStart => 'Mulai';

  @override
  String get retroPhaseStop => 'Berhenti';

  @override
  String get retroPhaseContinue => 'Lanjutkan';

  @override
  String get retroColumnMad => 'Marah';

  @override
  String get retroColumnSad => 'Sedih';

  @override
  String get retroColumnGlad => 'Senang';

  @override
  String get retroColumnLiked => 'Suka';

  @override
  String get retroColumnLearned => 'Belajar';

  @override
  String get retroColumnLacked => 'Kurang';

  @override
  String get retroColumnLonged => 'Ingin';

  @override
  String get retroColumnWind => 'Angin';

  @override
  String get retroColumnAnchor => 'Sauh';

  @override
  String get retroColumnRock => 'Karang';

  @override
  String get retroColumnGoal => 'Pulau';

  @override
  String get retroColumnKeep => 'Simpan';

  @override
  String get retroColumnMore => 'Lebih';

  @override
  String get retroColumnLess => 'Kurang';

  @override
  String get retroColumnDrop => 'Hapus';

  @override
  String get retroColumnAdd => 'Tambah';

  @override
  String get retroColumnImprove => 'Tingkatkan';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeLight => 'Terang';

  @override
  String get settingsThemeDark => 'Gelap';

  @override
  String get settingsThemeSystem => 'Sistem';

  @override
  String get formTitle => 'Judul';

  @override
  String get formDescription => 'Deskripsi';

  @override
  String get formName => 'Nama';

  @override
  String get formRequired => 'Wajib diisi';

  @override
  String get formHint => 'Masukkan nilai';

  @override
  String get formOptional => 'Opsional';

  @override
  String errorGeneric(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get errorLoading => 'Gagal memuat data';

  @override
  String get errorSaving => 'Gagal menyimpan';

  @override
  String get errorNetwork => 'Masalah koneksi';

  @override
  String get errorPermission => 'Izin ditolak';

  @override
  String get errorNotFound => 'Tidak ditemukan';

  @override
  String get successSaved => 'Berhasil disimpan';

  @override
  String get successDeleted => 'Berhasil dihapus';

  @override
  String get successCopied => 'Disalin ke papan klip';

  @override
  String get filterAll => 'Semua';

  @override
  String get filterRemove => 'Hapus filter';

  @override
  String get filterActive => 'Aktif';

  @override
  String get filterCompleted => 'Selesai';

  @override
  String get participants => 'Peserta';

  @override
  String get agileAcceptanceCriteria => 'Kriteria Penerimaan';

  @override
  String agileAcceptanceCriteriaCount(int completed, int total) {
    return '$completed dari $total';
  }

  @override
  String get agileEstimateRequired => 'Perlu estimasi (klik)';

  @override
  String get agileNoActiveSprint => 'Tidak ada sprint aktif';

  @override
  String get agileKanbanBoardHint =>
      'Board menunjukkan story dari sprint aktif.';

  @override
  String get agileStartSprintFromTab => 'Mulai sprint dari tab Sprint';

  @override
  String get agileDisableFilterHint =>
      'Nonaktifkan filter untuk melihat semua story';

  @override
  String get agileShowAllStories => 'Lihat semua story';

  @override
  String get agileFilterActiveSprint => 'Filter Sprint Aktif: ';

  @override
  String get agileFilterActive => 'Aktif';

  @override
  String get agileFilterAll => 'Semua';

  @override
  String get agileActionInvite => 'Undang';

  @override
  String agileTeamTitle(int count) {
    return 'Tim ($count)';
  }

  @override
  String get agileNoMembers => 'Tidak ada anggota tim';

  @override
  String get agileYouBadge => 'Anda';

  @override
  String agileStatsPlannedCount(int count) {
    return '$count direncanakan';
  }

  @override
  String agileStatsTotalCount(int count) {
    return '$count total';
  }

  @override
  String get agileStatsPtsPerSprint => 'pts/sprint';

  @override
  String get agileStatsWorkInProgress => 'sedang dikerjakan';

  @override
  String get agileStatsItemsPerWeek => 'item/minggu';

  @override
  String get agileStatsCompletedTooltip =>
      'Jumlah sprint dengan status \'Selesai\'.\nKlik \'Selesaikan Sprint\' untuk memfinalisasi sprint aktif.';

  @override
  String get agileAverageVelocityTooltip =>
      'Rata-rata Story Points yang diselesaikan per sprint.\nDihitung dari sprint selesai yang memiliki story dengan status \'Done\'.\nSemakin tinggi = tim semakin produktif.';

  @override
  String get agileStatsStoriesCompletedTooltip =>
      'Jumlah User Stories dengan status \'Done\'.\nUntuk meningkatkan nilai ini, pindahkan story ke kolom \'Done\' di Papan Kanban.';

  @override
  String get agileStatsPointsTooltip =>
      'Jumlah Story Points dari story yang selesai.\n\'Direncanakan\' mencakup semua story yang diestimasi di backlog.';

  @override
  String get agileItemsCompletedTooltip =>
      'Jumlah Work Item dengan status \'Done\'.\nPindahkan item ke kolom \'Done\' untuk menyelesaikannya.';

  @override
  String get agileInProgressTooltip =>
      'Item yang sedang dikerjakan saat ini (WIP).\nJaga angka ini tetap rendah untuk meningkatkan alur kerja.';

  @override
  String get agileCycleTimeTooltip =>
      'Rata-rata waktu yang dihabiskan dalam status aktif (misal: In Progress, Review).\nTidak termasuk waktu tunggu di Backlog atau Ready.';

  @override
  String get agileThroughputTooltip =>
      'Rata-rata item yang diselesaikan per minggu (4 minggu terakhir).\nMenunjukkan produktivitas tim dari waktu ke waktu.';

  @override
  String get agileHybridSprintTooltip =>
      'Sprint selesai dibandingkan dengan total.';

  @override
  String get agileHybridCompletedTooltip =>
      'Item dengan status \'Done\' dibandingkan dengan total.\nPindahkan item ke kolom \'Done\' untuk menyelesaikannya.';

  @override
  String get agileAddSkillsHint => 'Tambahkan kompetensi ke anggota tim';

  @override
  String get agileSkillMatrixTitle => 'Matriks Kompetensi';

  @override
  String get agileCriticalSkills => 'Kompetensi kritis';

  @override
  String agileCriticalSkillsWarning(String skills) {
    return 'Hanya 1 orang yang menguasai: $skills';
  }

  @override
  String get agileSkills => 'Kompetensi';

  @override
  String get agileNoSkills => 'Tidak ada kompetensi';

  @override
  String get agileAddSkill => 'Tambah kompetensi';

  @override
  String get agileNewSkill => 'Kompetensi baru...';

  @override
  String get agileNewSkillDialogTitle => 'Kompetensi Baru';

  @override
  String get agileNewSkillName => 'Nama kompetensi';

  @override
  String get agileNewSkillHint => 'Misal: Flutter, Python, AWS...';

  @override
  String get agileSkillCoverage => 'Cakupan Kompetensi';

  @override
  String get agileNoSkillsAvailable => 'Tidak ada skill tersedia';

  @override
  String agileBasedOnCompletedItems(int count) {
    return 'Berdasarkan $count item selesai';
  }

  @override
  String get agileNoAcceptanceCriteria =>
      'Tidak ada kriteria penerimaan yang ditentukan';

  @override
  String get agileDescription => 'Deskripsi';

  @override
  String get agileNoDescription => 'Tidak ada deskripsi';

  @override
  String get agileTags => 'Tag';

  @override
  String get agileEstimates => 'Estimasi';

  @override
  String get agileFinalEstimate => 'Estimasi Akhir';

  @override
  String agileEstimatesReceived(int count) {
    return '$count estimasi diterima';
  }

  @override
  String get agileInformation => 'Informasi';

  @override
  String get agileBusinessValue => 'Nilai Bisnis';

  @override
  String get agileAssignee => 'Penerima Tugas';

  @override
  String get agileCreatedBy => 'Dibuat oleh';

  @override
  String get agileCreatedAt => 'Dibuat pada';

  @override
  String get agileStartedAt => 'Dimulai pada';

  @override
  String get agileCompletedAt => 'Selesai pada';

  @override
  String get agileSprintTitle => 'Sprint';

  @override
  String get agileNewSprint => 'Sprint Baru';

  @override
  String get agileNoSprints => 'Tidak ada sprint';

  @override
  String get agileCreateFirstSprint => 'Buat sprint pertama untuk memulai';

  @override
  String get agileSprintStatusPlanning => 'Perencanaan';

  @override
  String get agileSprintStatusActive => 'Aktif';

  @override
  String get agileSprintStatusReview => 'Review';

  @override
  String get agileSprintStatusCompleted => 'Selesai';

  @override
  String get agileStartSprint => 'Mulai Sprint';

  @override
  String get agileCompleteSprint => 'Selesaikan Sprint';

  @override
  String get agileStartClosing => 'Tutup Sprint';

  @override
  String get agileFinalizeSprint => 'Finalisasi Sprint';

  @override
  String get agileSprintClosingPhase => 'Dalam Penutupan';

  @override
  String get agileSprintClosingDesc =>
      'Sprint berada dalam fase penutupan. Selesaikan Sprint Review dan finalisasi sprint.';

  @override
  String get agileSprintClosingBanner =>
      'Sprint dalam fase penutupan - selesaikan review dan finalisasi';

  @override
  String get agileSprintClosingStarted => 'Sprint dalam fase penutupan';

  @override
  String get agileSprintClosingBoardVisible =>
      'Board terus menunjukkan story dari sprint';

  @override
  String get agileSprintClosingNoNewStories =>
      'Tidak bisa menambah story baru ke sprint';

  @override
  String get agileSprintClosingReviewFirst =>
      'Lakukan Sprint Review sebelum finalisasi';

  @override
  String agileSprintOverdue(int days) {
    return 'Terlambat $days hari';
  }

  @override
  String agileSprintDaysWarning(int days) {
    return 'Tersisa $days hari';
  }

  @override
  String get agileStoryDisposition => 'Pengaturan Story';

  @override
  String get agileStoryDispositionDesc =>
      'Pilih apa yang harus dilakukan dengan story yang belum selesai';

  @override
  String get agileDispositionBacklog => 'Backlog';

  @override
  String get agileDispositionReady => 'Ready';

  @override
  String get agileDispositionRefinement => 'Dalam Refinement';

  @override
  String get agileDispositionBacklogDesc =>
      'Kembali ke backlog untuk diprioritaskan ulang';

  @override
  String get agileDispositionReadyDesc =>
      'Siap untuk perencanaan sprint berikutnya';

  @override
  String get agileDispositionRefinementDesc =>
      'Perlu dianalisis lebih lanjut sebelum sprint berikutnya';

  @override
  String get agileRetroSuggestion =>
      'Apakah Anda ingin membuat retrospektif untuk sprint ini?';

  @override
  String get agileCreateRetro => 'Buat Retrospektif';

  @override
  String get agileNotNow => 'Nanti saja';

  @override
  String get agileSprintReviewSection => 'Sprint Review';

  @override
  String get agileSprintSummarySection => 'Ringkasan Sprint';

  @override
  String get agileReviewRecapTitle => 'Ringkasan Sprint Review';

  @override
  String get agileReviewApproved => 'Disetujui';

  @override
  String get agileReviewRefinement => 'Perlu Perbaikan';

  @override
  String get agileReviewRejected => 'Ditolak';

  @override
  String get agileDeleteSprint => 'Hapus';

  @override
  String get agileSprintName => 'Nama Sprint';

  @override
  String get agileSprintGoal => 'Sprint Goal';

  @override
  String get agileSprintGoalHint => 'Tujuan sprint';

  @override
  String get agileStartDate => 'Tanggal Mulai';

  @override
  String get agileEndDate => 'Tanggal Selesai';

  @override
  String get agileStatsStories => 'story';

  @override
  String get agileStatsPoints => 'pti';

  @override
  String get agileStatsCompleted => 'selesai';

  @override
  String get agileStatsVelocity => 'velocity';

  @override
  String agileDaysRemainingCount(String count) {
    return '$count hari tersisa';
  }

  @override
  String get agileAverageVelocity => 'Rata-rata Velocity';

  @override
  String agileTeamMembersCount(String count) {
    return 'Tim: $count anggota';
  }

  @override
  String get agileActionCancel => 'Batal';

  @override
  String get agileActionSave => 'Simpan';

  @override
  String get agileActionCreate => 'Buat';

  @override
  String get agileSprintPlanningTitle => 'Perencanaan Sprint';

  @override
  String get agileSprintPlanningSubtitle =>
      'Pilih story yang akan diselesaikan dalam sprint ini';

  @override
  String get agileBurndownChart => 'Burndown Chart';

  @override
  String get agileBurndownIdeal => 'Ideal';

  @override
  String get agileBurndownActual => 'Aktual';

  @override
  String get agileBurndownPlanned => 'Direncanakan';

  @override
  String get agileBurndownRemaining => 'Tersisa';

  @override
  String get agileBurndownNoData => 'Tidak ada data burndown';

  @override
  String get agileBurndownNoDataHint => 'Data akan muncul saat sprint aktif';

  @override
  String get agileVelocityTrend => 'Tren Velocity';

  @override
  String get agileVelocityNoData => 'Tidak ada data velocity';

  @override
  String get agileVelocityNoDataHint =>
      'Selesaikan setidaknya satu sprint untuk melihat tren';

  @override
  String get agileTeamCapacity => 'Kapasitas Tim';

  @override
  String get agileTeamCapacityScrum => 'Kapasitas Tim (Scrum)';

  @override
  String get agileTeamCapacityHours => 'Kapasitas Tim (Jam)';

  @override
  String get agileThroughput => 'Throughput';

  @override
  String get agileSuggestedCapacity =>
      'Kapasitas yang Disarankan untuk Perencanaan Sprint';

  @override
  String get agileSuggestedCapacityHint =>
      'Berdasarkan rata-rata velocity ± standar deviasi (±10%)';

  @override
  String get agileSuggestedCapacityNoData =>
      'Selesaikan minimal 1 sprint untuk mendapatkan saran kapasitas';

  @override
  String get agileScrumGuideNote =>
      'Scrum Guide merekomendasikan perencanaan berdasarkan Velocity historis, bukan jam.';

  @override
  String get agileHoursAvailable => 'Tersedia';

  @override
  String get agileHoursAssigned => 'Ditugaskan';

  @override
  String get agileHoursOverloaded => 'Kelebihan Beban';

  @override
  String get agileHoursTotal => 'Total Kapasitas';

  @override
  String get agileHoursUtilization => 'Utilitas';

  @override
  String agileMetricsTitle(String framework) {
    return 'Metrik $framework';
  }

  @override
  String get agileItemsCompleted => 'Item Selesai';

  @override
  String get agileInProgress => 'Sedang Dikerjakan';

  @override
  String get agileCycleTime => 'Cycle Time';

  @override
  String get agileLeadTime => 'Lead Time';

  @override
  String get agileDistribution => 'Distribusi Story';

  @override
  String get agileCompletionRate => 'Tingkat Penyelesaian';

  @override
  String get agileAccuracy => 'Akurasi Estimasi';

  @override
  String get agileEfficiency => 'Flow Efficiency';

  @override
  String get removeParticipant => 'Hapus peserta';

  @override
  String get noParticipants => 'Tidak ada peserta';

  @override
  String get participantJoined => 'telah bergabung';

  @override
  String get participantLeft => 'telah keluar';

  @override
  String get participantRole => 'Peran';

  @override
  String get participantVoter => 'Pemilih';

  @override
  String get participantObserver => 'Pengamat';

  @override
  String get participantModerator => 'Moderator';

  @override
  String get confirmDelete => 'Konfirmasi penghapusan';

  @override
  String get confirmDeleteMessage => 'Tindakan ini tidak dapat dibatalkan.';

  @override
  String get yes => 'Ya';

  @override
  String get no => 'Tidak';

  @override
  String get ok => 'OK';

  @override
  String get today => 'Hari ini';

  @override
  String get yesterday => 'Kemarin';

  @override
  String get tomorrow => 'Besok';

  @override
  String daysAgo(int count) {
    return '$count hari yang lalu';
  }

  @override
  String hoursAgo(int count) {
    return '$count jam yang lalu';
  }

  @override
  String minutesAgo(int count) {
    return '$count menit yang lalu';
  }

  @override
  String itemCount(int count) {
    return '$count elemen';
  }

  @override
  String get welcomeBack => 'Selamat datang kembali';

  @override
  String greeting(String name) {
    return 'Halo, $name!';
  }

  @override
  String get copyLink => 'Salin tautan';

  @override
  String get shareSession => 'Bagikan sesi';

  @override
  String get inviteByEmail => 'Undang lewat email';

  @override
  String get inviteByLink => 'Undang lewat tautan';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileDisplayName => 'Nama tampilan';

  @override
  String get profilePhotoUrl => 'Foto profil';

  @override
  String get profileEditProfile => 'Ubah profil';

  @override
  String get profileReload => 'Muat ulang';

  @override
  String get profilePersonalInfo => 'Informasi Pribadi';

  @override
  String get profileLastName => 'Nama belakang';

  @override
  String get profileCompany => 'Perusahaan';

  @override
  String get profileJobTitle => 'Jabatan';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileSubscription => 'Langganan';

  @override
  String get profilePlan => 'Paket';

  @override
  String get profileBillingCycle => 'Siklus penagihan';

  @override
  String get profilePrice => 'Harga';

  @override
  String get profileActivationDate => 'Tanggal aktivasi';

  @override
  String get profileTrialEnd => 'Akhir masa percobaan';

  @override
  String get profileNextRenewal => 'Pembaruan berikutnya';

  @override
  String get profileDaysRemaining => 'Hari tersisa';

  @override
  String get profileUpgrade => 'Berlangganan Premium';

  @override
  String get profileUpgradePlan => 'Upgrade Paket';

  @override
  String get planFree => 'Gratis';

  @override
  String get planPremium => 'Premium';

  @override
  String get planElite => 'Elite';

  @override
  String get statusActive => 'Aktif';

  @override
  String get statusTrialing => 'Masa percobaan';

  @override
  String get statusPastDue => 'Pembayaran tertunda';

  @override
  String get statusPaused => 'Ditangguhkan';

  @override
  String get statusCancelled => 'Dibatalkan';

  @override
  String get statusExpired => 'Kedaluwarsa';

  @override
  String get cycleMonthly => 'Bulanan';

  @override
  String get cycleQuarterly => 'Triwulanan';

  @override
  String get cycleYearly => 'Tahunan';

  @override
  String get cycleLifetime => 'Selamanya';

  @override
  String get pricePerMonth => 'bulan';

  @override
  String get pricePerQuarter => 'trim';

  @override
  String get pricePerYear => 'tahun';

  @override
  String get priceForever => 'selamanya';

  @override
  String get priceFree => 'Gratis';

  @override
  String get profileGeneralSettings => 'Pengaturan Umum';

  @override
  String get profileAnimations => 'Animasi';

  @override
  String get profileAnimationsDesc => 'Aktifkan animasi UI';

  @override
  String get profileFeatures => 'Fitur';

  @override
  String get profileCalendarIntegration => 'Integrasi Kalender';

  @override
  String get profileCalendarIntegrationDesc =>
      'Sinkronisasi sprint dan tenggat waktu';

  @override
  String get profileExportSheets => 'Ekspor Google Sheets';

  @override
  String get profileExportSheetsDesc => 'Ekspor data ke spreadsheet';

  @override
  String get profileBetaFeatures => 'Fitur Beta';

  @override
  String get profileBetaFeaturesDesc => 'Akses awal ke fitur baru';

  @override
  String get profileAdvancedMetrics => 'Metrik Lanjutan';

  @override
  String get profileAdvancedMetricsDesc => 'Statistik dan laporan detail';

  @override
  String get profileNotifications => 'Notifikasi';

  @override
  String get profileEmailNotifications => 'Notifikasi Email';

  @override
  String get profileEmailNotificationsDesc => 'Terima pembaruan lewat email';

  @override
  String get profilePushNotifications => 'Notifikasi Push';

  @override
  String get profilePushNotificationsDesc => 'Notifikasi di browser';

  @override
  String get profileSprintReminders => 'Pengingat Sprint';

  @override
  String get profileSprintRemindersDesc =>
      'Peringatan untuk tenggat waktu sprint';

  @override
  String get profileSessionInvites => 'Undangan Sesi';

  @override
  String get profileSessionInvitesDesc => 'Notifikasi untuk sesi baru';

  @override
  String get profileWeeklySummary => 'Ringkasan Mingguan';

  @override
  String get profileWeeklySummaryDesc => 'Laporan aktivitas mingguan';

  @override
  String get profileDangerZone => 'Zona Bahaya';

  @override
  String get profileDeleteAccount => 'Hapus akun';

  @override
  String get profileDeleteAccountDesc =>
      'Ajukan penghapusan permanen akun Anda dan semua data terkait';

  @override
  String get profileDeleteAccountRequest => 'Ajukan';

  @override
  String get profileDeleteAccountIrreversible =>
      'Tindakan ini tidak dapat dibatalkan. Semua data Anda akan dihapus secara permanen.';

  @override
  String get profileDeleteAccountReason => 'Alasan (opsional)';

  @override
  String get profileDeleteAccountReasonHint =>
      'Mengapa Anda ingin menghapus akun Anda?';

  @override
  String get profileRequestDeletion => 'Ajukan Penghapusan';

  @override
  String get profileDeletionInProgress => 'Penghapusan sedang diproses';

  @override
  String profileDeletionRequestedAt(String date) {
    return 'Diajukan pada $date';
  }

  @override
  String get profileCancelRequest => 'Batalkan permintaan';

  @override
  String get profileDeletionRequestSent =>
      'Permintaan penghapusan telah dikirim';

  @override
  String get profileDeletionRequestCancelled => 'Permintaan dibatalkan';

  @override
  String get profileUpdated => 'Profil diperbarui';

  @override
  String get profileLogout => 'Keluar';

  @override
  String get profileLogoutDesc => 'Putuskan akun Anda dari perangkat ini';

  @override
  String get profileLogoutConfirm => 'Apakah Anda yakin ingin keluar?';

  @override
  String get profileSubscriptionCancelled => 'Langganan dibatalkan';

  @override
  String get profileCancelSubscription => 'Batalkan Langganan';

  @override
  String get profileCancelSubscriptionConfirm =>
      'Apakah Anda yakin ingin membatalkan langganan? Anda tetap bisa menggunakan fitur premium sampai masa berlaku saat ini berakhir.';

  @override
  String get profileKeepSubscription => 'Tidak, pertahankan';

  @override
  String get profileYesCancel => 'Ya, batalkan';

  @override
  String profileUpgradeComingSoon(String plan) {
    return 'Upgrade ke $plan segera hadir...';
  }

  @override
  String get profileFree => 'Gratis';

  @override
  String get profileMonthly => 'EUR/bulan';

  @override
  String get profileUser => 'Pengguna';

  @override
  String profileErrorPrefix(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get stateSaving => 'Menyimpan...';

  @override
  String get cardCoffee => 'Istirahat';

  @override
  String get cardQuestion => 'Tidak tahu';

  @override
  String get toolEisenhower => 'Matriks Eisenhower';

  @override
  String get toolEisenhowerDesc =>
      'Atur aktivitas berdasarkan urgensi dan kepentingan. Kuadran untuk memutuskan apa yang harus dilakukan segera, direncanakan, didelegasikan, atau dihapus.';

  @override
  String get toolEisenhowerDescShort =>
      'Prioritaskan berdasarkan urgensi dan kepentingan';

  @override
  String get toolEstimation => 'Ruang Estimasi';

  @override
  String get toolEstimationDesc =>
      'Sesi estimasi kolaboratif untuk tim. Planning Poker, T-Shirt sizing, dan metode lain untuk mengestimasi user stories.';

  @override
  String get toolEstimationDescShort => 'Sesi estimasi kolaboratif';

  @override
  String get toolSmartTodo => 'Smart Todo';

  @override
  String get toolSmartTodoDesc =>
      'Daftar tugas cerdas dan kolaboratif. Impor dari CSV/teks, undang peserta, dan kelola tugas dengan filter lanjutan.';

  @override
  String get toolSmartTodoDescShort =>
      'Daftar cerdas dan kolaboratif. Impor CSV, undang, dan kelola.';

  @override
  String get toolAgileProcess => 'Manajer Proses Agile';

  @override
  String get toolAgileProcessDesc =>
      'Kelola proyek agile lengkap dengan backlog, perencanaan sprint, papan kanban, metrik, dan retrospektif.';

  @override
  String get toolAgileProcessDescShort =>
      'Kelola proyek agile dengan backlog, sprint, kanban, dan metrik.';

  @override
  String get toolRetro => 'Papan Retrospektif';

  @override
  String get toolRetroDesc =>
      'Kumpulkan umpan balik dari tim tentang apa yang berjalan baik, apa yang perlu ditingkatkan, dan tindakan yang harus diambil.';

  @override
  String get toolRetroDescShort =>
      'Kumpulkan umpan balik tim tentang apa yang berjalan baik dan yang perlu diperbaiki.';

  @override
  String get homeUtilities => 'Utilitas';

  @override
  String get homeSelectTool => 'Pilih alat untuk memulai';

  @override
  String get statusOnline => 'Online';

  @override
  String get comingSoon => 'Segera Hadir';

  @override
  String get featureComingSoon => 'Fitur ini akan segera tersedia!';

  @override
  String get featureSmartImport => 'Impor Cerdas';

  @override
  String get featureCollaboration => 'Kolaborasi';

  @override
  String get featureFilters => 'Filter';

  @override
  String get feature4Quadrants => '4 Kuadran';

  @override
  String get featureDragDrop => 'Drag & Drop';

  @override
  String get featureCollaborative => 'Kolaboratif';

  @override
  String get featurePlanningPoker => 'Planning Poker';

  @override
  String get featureTshirtSize => 'Ukuran Kaos';

  @override
  String get featureRealtime => 'Real-time';

  @override
  String get featureScrum => 'Scrum';

  @override
  String get featureKanban => 'Kanban';

  @override
  String get featureHybrid => 'Hibrida';

  @override
  String get featureWentWell => 'Berjalan Baik';

  @override
  String get featureToImprove => 'Perlu Peningkatan';

  @override
  String get featureActions => 'Tindakan';

  @override
  String get themeLightMode => 'Tema Terang';

  @override
  String get themeDarkMode => 'Tema Gelap';

  @override
  String get estimationBackToSessions => 'Kembali ke sesi';

  @override
  String get estimationSessionSettings => 'Pengaturan Sesi';

  @override
  String get estimationList => 'Daftar';

  @override
  String estimationSessionsCount(int filtered, int total) {
    return 'Sesi Anda ($filtered/$total)';
  }

  @override
  String get estimationNoSessionFound => 'Sesi tidak ditemukan';

  @override
  String get estimationCreateFirstSession =>
      'Buat sesi estimasi pertama Anda\nuntuk menilai aktivitas bersama tim';

  @override
  String get estimationStoriesTotal => 'Total story';

  @override
  String get estimationStoriesCompleted => 'Story selesai';

  @override
  String get estimationParticipantsActive => 'Peserta aktif';

  @override
  String estimationProgress(int completed, int total, String percent) {
    return 'Kemajuan: $completed/$total story';
  }

  @override
  String get estimationStart => 'Mulai';

  @override
  String get estimationComplete => 'Selesai';

  @override
  String get estimationAllStoriesEstimated => 'Semua story telah diestimasi!';

  @override
  String get estimationNoVotingInProgress =>
      'Tidak ada voting sedang berlangsung';

  @override
  String estimationCompletedLabel(
    int completed,
    int total,
    String total_estimate,
  ) {
    return 'Selesai: $completed/$total | Total estimasi: $total_estimate pt';
  }

  @override
  String estimationVoteStory(String title) {
    return 'Vote: $title';
  }

  @override
  String get estimationAddStoriesToStart => 'Tambah story untuk memulai';

  @override
  String get estimationInVoting => 'DALAM VOTING';

  @override
  String get estimationReveal => 'Buka';

  @override
  String get estimationSkip => 'Lewati';

  @override
  String get estimationStories => 'Story';

  @override
  String get estimationVotingTab => 'Voting';

  @override
  String get estimationTeamTab => 'Tim';

  @override
  String get estimationAddStory => 'Tambah Story';

  @override
  String get estimationStartVoting => 'Mulai voting';

  @override
  String get estimationViewVotes => 'Lihat suara';

  @override
  String get estimationViewDetail => 'Lihat detail';

  @override
  String get estimationFinalEstimateLabel => 'Estimasi akhir:';

  @override
  String estimationVotesOf(String title) {
    return 'Suara: $title';
  }

  @override
  String get estimationParticipantVotes => 'Suara peserta:';

  @override
  String get estimationPointsOrDays => 'poin / hari';

  @override
  String get estimationEstimateRationale => 'Alasan estimasi (opsional)';

  @override
  String get estimationExplainRationale =>
      'Jelaskan alasan estimasi...\nMisal: Kompleksitas teknis tinggi, dependensi eksternal...';

  @override
  String get estimationRationaleHelp =>
      'Alasan membantu tim mengingat keputusan yang diambil selama estimasi.';

  @override
  String get estimationConfirmFinalEstimate => 'Konfirmasi Estimasi Akhir';

  @override
  String get estimationEnterValidEstimate => 'Masukkan estimasi yang valid';

  @override
  String get estimationHintEstimate => 'Misal: 5, 8, 13...';

  @override
  String get estimationStatus => 'Status';

  @override
  String get estimationOrder => 'Urutan';

  @override
  String get estimationVotesReceived => 'Suara diterima';

  @override
  String get estimationAverageVotes => 'Rata-rata suara';

  @override
  String get estimationConsensus => 'Konsensus';

  @override
  String get storyStatusPending => 'Menunggu';

  @override
  String get storyStatusVoting => 'Dalam voting';

  @override
  String get storyStatusRevealed => 'Suara dibuka';

  @override
  String get participantManagement => 'Manajemen Peserta';

  @override
  String get participantCopySessionLink => 'Salin link sesi';

  @override
  String get participantInvitesTab => 'Undangan';

  @override
  String get participantSessionLink => 'Link Sesi (bagikan ke peserta)';

  @override
  String get participantAddDirect =>
      'Tambah Peserta Langsung (misal: voting terbuka)';

  @override
  String get participantEmailRequired => 'Email *';

  @override
  String get participantEmailHint => 'email@contoh.com';

  @override
  String get participantNameHint => 'Nama tampilan';

  @override
  String participantVotersAndObservers(int voters, int observers) {
    return '$voters pemilih, $observers pengamat';
  }

  @override
  String get participantYou => '(anda)';

  @override
  String get participantMakeVoter => 'Jadikan Pemilih';

  @override
  String get participantMakeObserver => 'Jadikan Pengamat';

  @override
  String get participantRemoveTitle => 'Hapus Peserta';

  @override
  String participantRemoveConfirm(String name) {
    return 'Apakah Anda yakin ingin menghapus \"$name\" dari sesi?';
  }

  @override
  String participantAddedToSession(String email) {
    return '$email ditambahkan ke sesi';
  }

  @override
  String participantRemovedFromSession(String name) {
    return '$name dihapus dari sesi';
  }

  @override
  String participantRoleUpdated(String email) {
    return 'Peran diperbarui untuk $email';
  }

  @override
  String get participantFacilitator => 'Fasilitator';

  @override
  String get inviteSendNew => 'Kirim Undangan Baru';

  @override
  String get inviteRecipientEmail => 'Email penerima *';

  @override
  String get inviteCreate => 'Buat Undangan';

  @override
  String get invitesSent => 'Undangan Terkirim';

  @override
  String get inviteNoInvites => 'Belum ada undangan terkirim';

  @override
  String inviteCreatedFor(String email) {
    return 'Undangan dibuat untuk $email';
  }

  @override
  String inviteSentTo(String email) {
    return 'Undangan dikirim via email ke $email';
  }

  @override
  String inviteExpiresIn(int days) {
    return 'Kedaluwarsa dalam ${days}h';
  }

  @override
  String get inviteCopyLink => 'Salin tautan';

  @override
  String get inviteRevokeAction => 'Batalkan undangan';

  @override
  String get inviteDeleteAction => 'Hapus undangan';

  @override
  String get inviteRevokeTitle => 'Batalkan Undangan?';

  @override
  String inviteRevokeConfirm(String email) {
    return 'Apakah Anda yakin ingin membatalkan undangan untuk $email?';
  }

  @override
  String get inviteRevoke => 'Batalkan';

  @override
  String inviteRevokedFor(String email) {
    return 'Undangan dibatalkan untuk $email';
  }

  @override
  String get inviteDeleteTitle => 'Hapus Undangan';

  @override
  String inviteDeleteConfirm(String email) {
    return 'Apakah Anda yakin ingin menghapus undangan untuk $email?\n\nTindakan ini permanen.';
  }

  @override
  String inviteDeletedFor(String email) {
    return 'Undangan dihapus untuk $email';
  }

  @override
  String get inviteLinkCopied => 'Tautan disalin!';

  @override
  String get linkCopied => 'Tautan disalin ke papan klip';

  @override
  String get enterValidEmail => 'Masukkan alamat email yang valid';

  @override
  String get sessionCreatedSuccess => 'Sesi berhasil dibuat';

  @override
  String get sessionUpdated => 'Sesi diperbarui';

  @override
  String get sessionDeleted => 'Sesi dihapus';

  @override
  String get sessionStarted => 'Sesi dimulai';

  @override
  String get sessionCompletedSuccess => 'Sesi selesai';

  @override
  String get sessionNotFound => 'Sesi tidak ditemukan';

  @override
  String get storyAdded => 'Story ditambahkan';

  @override
  String get storyDeleted => 'Story dihapus';

  @override
  String estimateSaved(String estimate) {
    return 'Estimasi disimpan: $estimate';
  }

  @override
  String get deleteSessionTitle => 'Hapus Sesi';

  @override
  String deleteSessionConfirm(String name, int count) {
    return 'Apakah Anda yakin ingin menghapus \"$name\"?\nSemua $count story juga akan dihapus.';
  }

  @override
  String get deleteStoryTitle => 'Hapus Story';

  @override
  String deleteStoryConfirm(String title) {
    return 'Apakah Anda yakin ingin menghapus \"$title\"?';
  }

  @override
  String get errorLoadingSession => 'Gagal memuat sesi';

  @override
  String get errorLoadingStories => 'Gagal memuat story';

  @override
  String get errorCreatingSession => 'Gagal membuat sesi';

  @override
  String get errorUpdatingSession => 'Gagal memperbarui';

  @override
  String get errorDeletingSession => 'Gagal menghapus';

  @override
  String get errorAddingStory => 'Gagal menambah story';

  @override
  String get errorStartingSession => 'Gagal memulai sesi';

  @override
  String get errorCompletingSession => 'Gagal menyelesaikan sesi';

  @override
  String get errorSubmittingVote => 'Gagal mengirim suara';

  @override
  String get errorRevealingVotes => 'Gagal membuka suara';

  @override
  String get errorSavingEstimate => 'Gagal menyimpan estimasi';

  @override
  String get errorSkipping => 'Gagal melewati';

  @override
  String get retroIcebreakerTitle => 'Icebreaker: Moral Tim';

  @override
  String get retroIcebreakerQuestion =>
      'Bagaimana perasaanmu tentang sprint ini?';

  @override
  String retroParticipantsVoted(int count) {
    return '$count peserta telah memberikan suara';
  }

  @override
  String get retroEndIcebreakerStartWriting =>
      'Akhiri Icebreaker & Mulai Menulis';

  @override
  String get retroMoodTerrible => 'Sangat Buruk';

  @override
  String get retroMoodBad => 'Buruk';

  @override
  String get retroMoodNeutral => 'Netral';

  @override
  String get retroMoodGood => 'Baik';

  @override
  String get retroMoodExcellent => 'Luar Biasa';

  @override
  String get actionSubmit => 'Kirim';

  @override
  String get retroIcebreakerOneWordTitle => 'Icebreaker: Satu Kata';

  @override
  String get retroIcebreakerOneWordQuestion =>
      'Gambarkan sprint ini dengan HANYA satu kata';

  @override
  String get retroIcebreakerOneWordHint => 'Kata-mu...';

  @override
  String get retroIcebreakerSubmitted => 'Terkirim!';

  @override
  String retroIcebreakerWordsSubmitted(int count) {
    return '$count kata terkirim';
  }

  @override
  String get retroIcebreakerWeatherTitle => 'Icebreaker: Cuaca';

  @override
  String get retroIcebreakerWeatherQuestion =>
      'Cuaca apa yang paling mewakili perasaanmu tentang sprint ini?';

  @override
  String get retroWeatherSunny => 'Cerah';

  @override
  String get retroWeatherPartlyCloudy => 'Berawan sebagian';

  @override
  String get retroWeatherCloudy => 'Mendung';

  @override
  String get retroWeatherRainy => 'Hujan';

  @override
  String get retroWeatherStormy => 'Badai';

  @override
  String get retroAgileCoach => 'Agile Coach';

  @override
  String get retroCoachSetup =>
      'Pilih templat. \"Mulai/Berhenti/Lanjutkan\" sangat bagus untuk tim baru. Pastikan semua orang hadir.';

  @override
  String get retroCoachIcebreaker =>
      'Mencairkan suasana! Tanya kabar setiap orang atau gunakan pertanyaan lucu.';

  @override
  String get retroCoachWriting =>
      'Kita berada dalam mode INCOGNITO. Tulis kartu dengan bebas, tidak ada yang bisa melihat apa yang kamu tulis sampai akhir. Hindari bias!';

  @override
  String get retroCoachVoting =>
      'Waktunya Review! Semua kartu terlihat. Baca dan gunakan 3 suara-mu untuk memilih hal yang perlu dibahas.';

  @override
  String get retroCoachDiscuss =>
      'Fokus pada kartu dengan suara terbanyak. Tentukan Item Tindakan yang jelas: Siapa melakukan apa sampai kapan?';

  @override
  String get retroCoachCompleted =>
      'Kerja bagus! Retrospektif selesai. Item tindakan telah dikirim ke Backlog.';

  @override
  String retroStep(int step, String title) {
    return 'Langkah $step: $title';
  }

  @override
  String retroCurrentFocus(String title) {
    return 'Fokus saat ini: $title';
  }

  @override
  String get retroCanvasMinColumns =>
      'Templat membutuhkan minimal 4 kolom (gaya Sailboat)';

  @override
  String retroAddTo(String title) {
    return 'Tambah ke $title';
  }

  @override
  String get retroNoColumnsConfigured => 'Tidak ada kolom dikonfigurasi.';

  @override
  String get retroNewActionItem => 'Item Tindakan Baru';

  @override
  String get retroEditActionItem => 'Ubah Item Tindakan';

  @override
  String get retroActionWhatToDo => 'Apa yang harus dilakukan?';

  @override
  String get retroActionDescriptionHint => 'Gambarkan tindakan nyata...';

  @override
  String get retroActionRequired => 'Wajib';

  @override
  String get retroActionLinkedCard => 'Terhubung ke Kartu Retro (Opsional)';

  @override
  String get retroActionNone => 'Tidak ada';

  @override
  String get retroActionType => 'Tipe Tindakan';

  @override
  String get retroActionNoType => 'Tidak ada tipe spesifik';

  @override
  String get retroActionAssignee => 'Penerima tugas';

  @override
  String get retroActionNoAssignee => 'Tidak ada';

  @override
  String get retroActionPriority => 'Prioritas';

  @override
  String get retroActionDueDate => 'Tenggat waktu (Deadline)';

  @override
  String get retroActionSelectDate => 'Pilih tanggal...';

  @override
  String get retroActionSupportResources => 'Sumber Daya Pendukung';

  @override
  String get retroActionResourcesHint =>
      'Alat, anggaran, orang tambahan yang dibutuhkan...';

  @override
  String get retroActionMonitoring => 'Cara Pemantauan';

  @override
  String get retroActionMonitoringHint =>
      'Bagaimana kita memverifikasi kemajuan? (misal: Daily, Review...)';

  @override
  String get retroActionResourcesShort => 'Res';

  @override
  String get retroTableRef => 'Ref.';

  @override
  String get retroTableSourceColumn => 'Kolom';

  @override
  String get retroTableDescription => 'Deskripsi';

  @override
  String get retroTableOwner => 'Pemilik';

  @override
  String get retroTablePriority => 'Prioritas';

  @override
  String get retroTableDueDate => 'Tenggat';

  @override
  String get retroIcebreakerTwoTruths => 'Dua Kebenaran dan Satu Kebohongan';

  @override
  String get retroDescTwoTruths => 'Sederhana dan klasik.';

  @override
  String get retroIcebreakerCheckin => 'Check-in Emosional';

  @override
  String get retroDescCheckin => 'Bagaimana perasaan semua orang?';

  @override
  String get retroTableActions => 'Tindakan';

  @override
  String get retroSupportResources => 'Sumber Daya Pendukung';

  @override
  String get retroMonitoringMethod => 'Metode Pemantauan';

  @override
  String get retroUnassigned => 'Tidak ditugaskan';

  @override
  String get retroDeleteActionItem => 'Hapus Item Tindakan';

  @override
  String get retroChooseMethodology => 'Pilih Metodologi';

  @override
  String get retroHidingWhileTyping => 'Disembunyikan saat sedang menulis...';

  @override
  String retroVoteLimitReached(int max) {
    return 'Anda telah mencapai batas $max suara!';
  }

  @override
  String get retroAddCardHint => 'Apa pendapatmu?';

  @override
  String get retroAddCard => 'Tambah Kartu';

  @override
  String get retroTimeUp => 'Waktu Habis!';

  @override
  String get retroTimeUpMessage =>
      'Waktu untuk fase ini telah habis. Selesaikan diskusi atau tambah waktu.';

  @override
  String get retroTimeUpOk => 'Ok, mengerti';

  @override
  String get retroStopTimer => 'Hentikan Timer';

  @override
  String get retroStartTimer => 'Mulai Timer';

  @override
  String retroTimerMinutes(int minutes) {
    return '$minutes mnt';
  }

  @override
  String get retroAddCardButton => 'Tambah Kartu';

  @override
  String get retroDeleteRetro => 'Hapus Retrospektif';

  @override
  String get retroParticipantsLabel => 'Peserta';

  @override
  String get retroNotesCreated => 'Catatan dibuat';

  @override
  String retroStatusLabel(String status) {
    return 'Status: $status';
  }

  @override
  String retroDateLabel(String date) {
    return 'Tanggal: $date';
  }

  @override
  String retroSprintDefault(int number) {
    return 'Sprint $number';
  }

  @override
  String get smartTodoNoTasks => 'Tidak ada aktivitas di daftar ini';

  @override
  String get smartTodoNoTasksInColumn => 'Tidak ada tugas';

  @override
  String smartTodoCompletionStats(int completed, int total) {
    return '$completed/$total selesai';
  }

  @override
  String get smartTodoCreatedDate => 'Tanggal dibuat';

  @override
  String get smartTodoParticipantRole => 'Peserta';

  @override
  String get smartTodoUnassigned => 'Tidak Ditugaskan';

  @override
  String get smartTodoNewTask => 'Tugas Baru';

  @override
  String get smartTodoEditTask => 'Ubah Tugas';

  @override
  String get smartTodoTaskTitle => 'Judul tugas';

  @override
  String get smartTodoDescription => 'DESKRIPSI';

  @override
  String get smartTodoDescriptionHint => 'Tambah deskripsi detail...';

  @override
  String get smartTodoChecklist => 'CHECKLIST';

  @override
  String get smartTodoAddChecklistItem => 'Tambah poin';

  @override
  String get smartTodoEditItem => 'Ubah poin';

  @override
  String get smartTodoItemTitle => 'Judul poin';

  @override
  String get smartTodoAttachments => 'LAMPIRAN';

  @override
  String get smartTodoAddLink => 'Tambah Link';

  @override
  String get smartTodoComments => 'KOMENTAR';

  @override
  String get smartTodoWriteComment => 'Tulis komentar...';

  @override
  String get smartTodoAddImageTooltip => 'Tambah Gambar (URL)';

  @override
  String get smartTodoStatus => 'STATUS';

  @override
  String get smartTodoPriority => 'PRIORITAS';

  @override
  String get smartTodoAssignees => 'PENERIMA TUGAS';

  @override
  String get smartTodoNoAssignee => 'Tidak ada';

  @override
  String get smartTodoTags => 'TAG';

  @override
  String get smartTodoNoTags => 'Tidak ada tag';

  @override
  String get smartTodoDueDate => 'TENGGAT';

  @override
  String get smartTodoSetDate => 'Atur tanggal';

  @override
  String get smartTodoEffort => 'EFFORT';

  @override
  String get smartTodoEffortHint => 'Poin (misal: 5)';

  @override
  String get smartTodoAssignTo => 'Tugaskan ke';

  @override
  String get smartTodoSelectTags => 'Pilih Tag';

  @override
  String get smartTodoNoTagsAvailable => 'Tidak ada tag tersedia';

  @override
  String get smartTodoNewSubtask => 'Status baru';

  @override
  String get smartTodoAddLinkTitle => 'Tambah Link';

  @override
  String get smartTodoLinkName => 'Nama';

  @override
  String get smartTodoLinkUrl => 'URL';

  @override
  String get smartTodoCannotOpenLink => 'Tidak bisa membuka tautan';

  @override
  String get smartTodoPasteImage => 'Tempel Gambar';

  @override
  String get smartTodoPasteImageFound => 'Gambar ditemukan di papan klip.';

  @override
  String get smartTodoPasteImageConfirm =>
      'Apakah Anda ingin menambahkan gambar ini dari papan klip?';

  @override
  String get smartTodoYesAdd => 'Ya, tambah';

  @override
  String get smartTodoAddImage => 'Tambah Gambar';

  @override
  String get smartTodoImageUrlHint =>
      'Tempel URL gambar (misal dari CleanShot/Gyazo)';

  @override
  String get smartTodoImageUrl => 'URL Gambar';

  @override
  String get smartTodoPasteFromClipboard => 'Tempel dari papan klip';

  @override
  String get smartTodoEditComment => 'Ubah';

  @override
  String get smartTodoSortBy => 'Urutan';

  @override
  String get smartTodoColumnSortTitle => 'Urutkan Kolom';

  @override
  String get smartTodoPendingTasks => 'Aktivitas yang belum selesai';

  @override
  String get smartTodoCompletedTasks => 'Aktivitas selesai';

  @override
  String get smartTodoEnterTitle => 'Masukkan judul';

  @override
  String get smartTodoUser => 'Pengguna';

  @override
  String get smartTodoImportTasks => 'Impor Aktivitas';

  @override
  String get smartTodoImportStep1 => 'Langkah 1: Pilih Sumber';

  @override
  String get smartTodoImportStep2 => 'Langkah 2: Petakan Kolom';

  @override
  String get smartTodoImportStep3 => 'Langkah 3: Tinjauan & Konfirmasi';

  @override
  String get smartTodoImportRetry => 'Coba lagi';

  @override
  String get smartTodoImportPasteText => 'Tempel Teks (CSV/Txt)';

  @override
  String get smartTodoImportUploadFile => 'Unggah File (CSV)';

  @override
  String get smartTodoImportPasteHint =>
      'Tempel aktivitas Anda di sini. Gunakan koma sebagai pemisah.';

  @override
  String get smartTodoImportPasteExample =>
      'misal: Beli susu\nTelepon Mario\nSelesaikan laporan';

  @override
  String get smartTodoImportSelectFile => 'Pilih File CSV';

  @override
  String smartTodoImportFileSelected(String fileName) {
    return 'File dipilih: $fileName';
  }

  @override
  String smartTodoImportFileError(String error) {
    return 'Gagal membaca file: $error';
  }

  @override
  String get smartTodoImportNoData => 'Data tidak ditemukan';

  @override
  String get smartTodoImportColumnMapping =>
      'Kami mendeteksi kolom berikut. Petakan setiap kolom ke bidang yang benar.';

  @override
  String smartTodoImportColumnLabel(int index, String value) {
    return 'Kolom $index: \"$value\"';
  }

  @override
  String smartTodoImportSampleValue(String value) {
    return 'Contoh nilai: \"$value\"';
  }

  @override
  String smartTodoImportFoundTasks(int count) {
    return 'Ditemukan $count tugas valid. Periksa sebelum mengimpor.';
  }

  @override
  String get smartTodoImportDestinationColumn => 'Tujuan:';

  @override
  String get smartTodoImportBack => 'Kembali';

  @override
  String get smartTodoImportNext => 'Lanjut';

  @override
  String smartTodoImportButton(int count) {
    return 'Impor $count Tugas';
  }

  @override
  String get smartTodoImportEnterText => 'Masukkan teks atau unggah file.';

  @override
  String get smartTodoImportNoValidRows => 'Tidak ada baris valid ditemukan.';

  @override
  String get smartTodoImportMapTitle =>
      'Anda harus memetakan minimal \"Title\".';

  @override
  String smartTodoImportParsingError(String error) {
    return 'Kesalahan Parsing: $error';
  }

  @override
  String smartTodoImportSuccess(int count) {
    return 'Berhasil mengimpor $count tugas!';
  }

  @override
  String smartTodoImportError(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get smartTodoImportHelpTitle => 'Bagaimana cara mengimpor aktivitas?';

  @override
  String get smartTodoImportHelpSimpleTitle =>
      'Daftar sederhana (satu aktivitas per baris)';

  @override
  String get smartTodoImportHelpSimpleDesc =>
      'Tempel daftar sederhana dengan satu judul per baris. Setiap baris akan menjadi aktivitas.';

  @override
  String get smartTodoImportHelpSimpleExample =>
      'Beli susu\nTelepon Mario\nSelesaikan laporan';

  @override
  String get smartTodoImportHelpCsvTitle => 'Format CSV (dengan kolom)';

  @override
  String get smartTodoImportHelpCsvDesc =>
      'Gunakan nilai yang dipisahkan koma dengan baris header. Baris pertama mendefinisikan kolom.';

  @override
  String get smartTodoImportHelpCsvExample =>
      'title,priority,assignee\nBeli susu,high,mario@email.com\nTelepon Mario,medium,';

  @override
  String get smartTodoImportHelpFieldsTitle => 'Bidang yang tersedia:';

  @override
  String get smartTodoImportHelpFieldTitle => 'Judul aktivitas (wajib)';

  @override
  String get smartTodoImportHelpFieldDesc => 'Deskripsi aktivitas';

  @override
  String get smartTodoImportHelpFieldPriority =>
      'high, medium, low (atau tinggi, sedang, rendah)';

  @override
  String get smartTodoImportHelpFieldStatus =>
      'Nama kolom (misal: To Do, Sedang dikerjakan)';

  @override
  String get smartTodoImportHelpFieldAssignee => 'Email pengguna';

  @override
  String get smartTodoImportHelpFieldEffort => 'Jam (angka)';

  @override
  String get smartTodoImportHelpFieldTags => 'Tag (#tag atau dipisahkan koma)';

  @override
  String smartTodoImportStatusHint(String columns) {
    return 'Kolom tersedia untuk STATUS: $columns';
  }

  @override
  String get smartTodoImportEmptyColumn => '(kolom kosong)';

  @override
  String get smartTodoImportFieldIgnore => '-- Abaikan --';

  @override
  String get smartTodoImportFieldTitle => 'Judul';

  @override
  String get smartTodoImportFieldDescription => 'Deskripsi';

  @override
  String get smartTodoImportFieldPriority => 'Prioritas';

  @override
  String get smartTodoImportFieldStatus => 'Status (Kolom)';

  @override
  String get smartTodoImportFieldAssignee => 'Penerima tugas';

  @override
  String get smartTodoImportFieldEffort => 'Effort';

  @override
  String get smartTodoImportFieldTags => 'Tag';

  @override
  String get smartTodoDeleteTaskTitle => 'Hapus Aktivitas';

  @override
  String get smartTodoDeleteTaskContent =>
      'Apakah Anda yakin ingin menghapus aktivitas ini? Tindakan ini tidak dapat dibatalkan.';

  @override
  String get smartTodoDeleteNoPermission =>
      'Anda tidak memiliki izin untuk menghapus aktivitas ini';

  @override
  String get smartTodoSheetsExportTitle => 'Ekspor Google Sheets';

  @override
  String get smartTodoSheetsExportExists =>
      'Sudah ada dokumen Google Sheets untuk daftar ini.';

  @override
  String get smartTodoSheetsOpen => 'Buka';

  @override
  String get smartTodoSheetsUpdate => 'Perbarui';

  @override
  String get smartTodoSheetsUpdating => 'Sedang memperbarui Google Sheets...';

  @override
  String get smartTodoSheetsCreating => 'Sedang membuat Google Sheets...';

  @override
  String get smartTodoSheetsUpdated => 'Google Sheets diperbarui!';

  @override
  String get smartTodoSheetsCreated => 'Google Sheets dibuat!';

  @override
  String get smartTodoSheetsError => 'Gagal mengekspor (lihat log)';

  @override
  String get error => 'Kesalahan';

  @override
  String smartTodoAuditLogTitle(String title) {
    return 'Audit Log - $title';
  }

  @override
  String get smartTodoAuditFilterUser => 'Pengguna';

  @override
  String get smartTodoAuditFilterType => 'Tipe';

  @override
  String get smartTodoAuditFilterAction => 'Tindakan';

  @override
  String get smartTodoAuditFilterTag => 'Tag';

  @override
  String get smartTodoAuditFilterSearch => 'Cari';

  @override
  String get smartTodoAuditFilterAll => 'Semua';

  @override
  String get smartTodoAuditFilterAllFemale => 'Semua';

  @override
  String get smartTodoAuditPremiumRequired =>
      'Premium diperlukan untuk riwayat lengkap';

  @override
  String smartTodoAuditLastDays(int days) {
    return '$days hari terakhir';
  }

  @override
  String get smartTodoAuditClearFilters => 'Hapus Filter';

  @override
  String get smartTodoAuditViewTimeline => 'Tampilan Timeline';

  @override
  String get smartTodoAuditViewColumns => 'Tampilan Kolom';

  @override
  String get smartTodoAuditNoActivity => 'Tidak ada aktivitas tercatat';

  @override
  String get smartTodoAuditNoResults =>
      'Tidak ada hasil untuk filter yang dipilih';

  @override
  String smartTodoAuditActivities(int count) {
    return '$count aktivitas';
  }

  @override
  String get smartTodoAuditNoUserActivity => 'Tidak ada aktivitas';

  @override
  String get smartTodoAuditLoadMore => 'Muat 50 lagi...';

  @override
  String get smartTodoAuditEmptyValue => '(kosong)';

  @override
  String get smartTodoAuditEntityList => 'Daftar';

  @override
  String get smartTodoAuditEntityTask => 'Tugas';

  @override
  String get smartTodoAuditEntityInvite => 'Undangan';

  @override
  String get smartTodoAuditEntityParticipant => 'Peserta';

  @override
  String get smartTodoAuditEntityColumn => 'Kolom';

  @override
  String get smartTodoAuditEntityTag => 'Tag';

  @override
  String get smartTodoAuditActionCreate => 'Dibuat';

  @override
  String get smartTodoAuditActionUpdate => 'Diubah';

  @override
  String get smartTodoAuditActionDelete => 'Dihapus';

  @override
  String get smartTodoAuditActionArchive => 'Diarsipkan';

  @override
  String get smartTodoAuditActionRestore => 'Dipulihkan';

  @override
  String get smartTodoAuditActionMove => 'Dipindahkan';

  @override
  String get smartTodoAuditActionAssign => 'Ditugaskan';

  @override
  String get smartTodoAuditActionInvite => 'Diundang';

  @override
  String get smartTodoAuditActionJoin => 'Bergabung';

  @override
  String get smartTodoAuditActionRevoke => 'Dibatalkan';

  @override
  String get smartTodoAuditActionReorder => 'Urutan diubah';

  @override
  String get smartTodoAuditActionBatchCreate => 'Impor';

  @override
  String get smartTodoAuditTimeNow => 'Sekarang';

  @override
  String smartTodoAuditTimeMinutesAgo(int count) {
    return '$count mnt yang lalu';
  }

  @override
  String smartTodoAuditTimeHoursAgo(int count) {
    return '$count jam yang lalu';
  }

  @override
  String smartTodoAuditTimeDaysAgo(int count) {
    return '$count hari yang lalu';
  }

  @override
  String get smartTodoCfdTitle => 'Analitik CFD';

  @override
  String get smartTodoCfdTooltip => 'Analitik CFD';

  @override
  String get smartTodoCfdDateRange => 'Periode:';

  @override
  String get smartTodoCfd7Days => '7 hari';

  @override
  String get smartTodoCfd14Days => '14 hari';

  @override
  String get smartTodoCfd30Days => '30 hari';

  @override
  String get smartTodoCfd90Days => '90 hari';

  @override
  String get smartTodoCfdError => 'Gagal memuat data';

  @override
  String get smartTodoCfdRetry => 'Muat ulang';

  @override
  String get smartTodoCfdNoData => 'Data tidak tersedia';

  @override
  String get smartTodoCfdNoDataHint => 'Pergerakan tugas akan dilacak di sini';

  @override
  String get smartTodoCfdKeyMetrics => 'Metrik Utama';

  @override
  String get smartTodoCfdLeadTime => 'Lead Time';

  @override
  String get smartTodoCfdLeadTimeTooltip =>
      'Waktu dari pembuatan hingga selesai';

  @override
  String get smartTodoCfdCycleTime => 'Cycle Time';

  @override
  String get smartTodoCfdCycleTimeTooltip =>
      'Waktu dari mulai pengerjaan hingga selesai';

  @override
  String get smartTodoCfdThroughput => 'Throughput';

  @override
  String get smartTodoCfdThroughputTooltip => 'Tugas yang selesai per minggu';

  @override
  String get smartTodoCfdWip => 'WIP';

  @override
  String get smartTodoCfdWipTooltip => 'Pekerjaan sedang berjalan';

  @override
  String get smartTodoCfdLimit => 'Batas';

  @override
  String get smartTodoCfdCompleted => 'selesai';

  @override
  String get smartTodoCfdFlowAnalysis => 'Analisis Alur';

  @override
  String get smartTodoCfdArrived => 'Masuk';

  @override
  String get smartTodoCfdBacklogShrinking => 'Backlog berkurang';

  @override
  String get smartTodoCfdBacklogGrowing => 'Backlog bertambah';

  @override
  String get smartTodoCfdBottlenecks => 'Deteksi Hambatan';

  @override
  String get smartTodoCfdNoBottlenecks => 'Tidak ada hambatan';

  @override
  String get smartTodoCfdTasks => 'tugas';

  @override
  String get smartTodoCfdAvgAge => 'Usia rata-rata';

  @override
  String get smartTodoCfdAgingWip => 'WIP yang Usang';

  @override
  String get smartTodoCfdTask => 'Tugas';

  @override
  String get smartTodoCfdColumn => 'Kolom';

  @override
  String get smartTodoCfdAge => 'Usia';

  @override
  String get smartTodoCfdDays => 'hari';

  @override
  String get smartTodoCfdHowCalculated => 'Bagaimana cara menghitungnya?';

  @override
  String get smartTodoCfdMedian => 'Median';

  @override
  String get smartTodoCfdP85 => 'P85';

  @override
  String get smartTodoCfdP95 => 'P95';

  @override
  String get smartTodoCfdMin => 'Min';

  @override
  String get smartTodoCfdMax => 'Max';

  @override
  String get smartTodoCfdSample => 'Sampel';

  @override
  String get smartTodoCfdVsPrevious => 'vs periode sebelumnya';

  @override
  String get smartTodoCfdArrivalRate => 'Laju Masuk';

  @override
  String get smartTodoCfdCompletionRate => 'Laju Selesai';

  @override
  String get smartTodoCfdNetFlow => 'Alur Bersih';

  @override
  String get smartTodoCfdPerDay => '/hari';

  @override
  String get smartTodoCfdPerWeek => '/minggu';

  @override
  String get smartTodoCfdSeverity => 'Tingkat Keparahan';

  @override
  String get smartTodoCfdAssignee => 'Penerima tugas';

  @override
  String get smartTodoCfdUnassigned => 'Tidak ditugaskan';

  @override
  String get smartTodoCfdLeadTimeExplanation =>
      'Lead Time mengukur total waktu dari saat tugas dibuat hingga selesai.\n\n**Rumus:**\nLead Time = Tanggal Selesai - Tanggal Dibuat\n\n**Metrik:**\n- **Rata-rata**: Rata-rata dari semua lead time\n- **Median**: Nilai tengah (lebih tahan terhadap outlier)\n- **P85**: 85% tugas selesai dalam waktu ini\n- **P95**: 95% tugas selesai dalam waktu ini\n\n**Mengapa ini penting:**\nLead Time mewakili pengalaman pelanggan - total waktu tunggu. Gunakan P85 untuk memberikan estimasi pengiriman kepada pelanggan.';

  @override
  String get smartTodoCfdCycleTimeExplanation =>
      'Cycle Time mengukur waktu dari saat pengerjaan benar-benar dimulai (tugas keluar dari \'To Do\') hingga selesai.\n\n**Rumus:**\nCycle Time = Tanggal Selesai - Tanggal Mulai Kerja\n\n**Perbedaan dengan Lead Time:**\n- **Lead Time** = Perspektif pelanggan (termasuk waktu tunggu)\n- **Cycle Time** = Perspektif tim (hanya pengerjaan aktif)\n\n**Bagaimana \'Mulai Kerja\' dideteksi:**\nPertama kali tugas keluar dari kolom \'To Do\' akan dicatat sebagai tanggal mulai kerja.';

  @override
  String get smartTodoCfdThroughputExplanation =>
      'Throughput mengukur berapa banyak tugas yang diselesaikan dalam satu satuan waktu.\n\n**Rumus:**\n- Rata-rata Harian = Tugas Selesai / Jumlah Hari\n- Rata-rata Mingguan = Rata-rata Harian x 7\n\n**Cara menggunakannya:**\nPrediksi tanggal pengiriman:\nSisa Tugas / Throughput Mingguan = Minggu untuk Menyelesaikan\n\n**Contoh:**\n30 sisa tugas, throughput 10/minggu = ~3 minggu';

  @override
  String get smartTodoCfdWipExplanation =>
      'WIP (Work In Progress) menghitung tugas yang sedang dikerjakan - tidak di \'To Do\' dan tidak di \'Done\'.\n\n**Rumus:**\nWIP = Total Tugas - Tugas di To Do - Tugas di Done\n\n**Hukum Little:**\nLead Time = WIP / Throughput\n\nMengurangi WIP akan secara langsung mengurangi Lead Time!\n\n**Batas WIP yang Disarankan:**\nJumlah Tim x 2 (kanban best practice)\n\n**Status:**\n- Sehat: WIP <= Batas\n- Waspada: WIP > Batas x 1.25\n- Kritis: WIP > Batas x 1.5';

  @override
  String get smartTodoCfdFlowExplanation =>
      'Analisis Alur membandingkan laju masuk tugas baru vs tugas yang selesai.\n\n**Rumus:**\n- Laju Masuk = Tugas Baru Dibuat / Hari\n- Laju Selesai = Tugas Selesai / Hari\n- Alur Bersih = Selesai - Masuk\n\n**Interpretasi status:**\n- **Berkurang** (Selesai > Masuk): WIP menyusut - bagus!\n- **Seimbang** (dalam +/-10%): Alur stabil\n- **Bertambah** (Masuk > Selesai): WIP meningkat - perlu tindakan';

  @override
  String get smartTodoCfdBottleneckExplanation =>
      'Deteksi Hambatan mengidentifikasi kolom di mana tugas menumpuk atau tertahan terlalu lama.\n\n**Algoritma:**\nTingkat Keparahan = (Skor Jumlah + Skor Usia) / 2\n\nDi mana:\n- Skor Jumlah = Tugas dalam Kolom / 10\n- Skor Usia = Usia Rata-rata / 7 hari\n\n**Dilaporkan jika:**\n- 2+ tugas dalam kolom, ATAU\n- Usia rata-rata > 2 hari\n\n**Tingkat keparahan:**\n- Rendah (< 0.3): Pantau\n- Sedang (0.3-0.6): Investigasi\n- Tinggi (> 0.6): Intervensi';

  @override
  String get smartTodoCfdAgingExplanation =>
      'WIP Berdasarkan Usia (Aging WIP) menunjukkan tugas yang sedang dikerjakan, diurutkan berdasarkan berapa lama tugas tersebut telah dikerjakan.\n\n**Rumus:**\nUsia = Waktu Sekarang - Tanggal Mulai Kerja (dalam hari)\n\n**Status berdasarkan usia:**\n- Baru (< 3 hari): Normal\n- Waspada (3-7 hari): Mungkin butuh perhatian\n- Kritis (> 7 hari): Kemungkinan terhambat - investigasi!\n\nTugas yang usang sering kali menunjukkan adanya hambatan, persyaratan tidak jelas, atau scope creep.';

  @override
  String get smartTodoCfdTeamBalance => 'Keseimbangan Tim';

  @override
  String get smartTodoCfdTeamBalanceExplanation =>
      'Keseimbangan Tim menunjukkan distribusi tugas di antara anggota.\n\n**Skor Keseimbangan:**\nDihitung menggunakan koefisien variasi (CV).\nSkor = 1 / (1 + CV)\n\n**Status:**\n- Seimbang (≥80%): Pekerjaan terdistribusi rata\n- Kurang Seimbang (50-80%): Ada ketimpangan minor\n- Tidak Seimbang (<50%): Perbedaan signifikan\n\n**Kolom:**\n- To Do: Tugas menunggu\n- WIP: Tugas sedang dikerjakan\n- Done: Tugas selesai';

  @override
  String get smartTodoCfdBalanced => 'Seimbang';

  @override
  String get smartTodoCfdUneven => 'Kurang Seimbang';

  @override
  String get smartTodoCfdImbalanced => 'Tidak Seimbang';

  @override
  String get smartTodoCfdMember => 'Anggota';

  @override
  String get smartTodoCfdTotal => 'Total';

  @override
  String get smartTodoCfdToDo => 'To Do';

  @override
  String get smartTodoCfdInProgress => 'In Progress';

  @override
  String get smartTodoCfdDone => 'Done';

  @override
  String get smartTodoNewTaskDefault => 'Tugas Baru';

  @override
  String get smartTodoRename => 'Ubah Nama';

  @override
  String get smartTodoAddActivity => 'Tambah aktivitas';

  @override
  String get smartTodoAddColumn => 'Tambah Kolom';

  @override
  String get smartTodoParticipantManagement => 'Manajemen Peserta';

  @override
  String get smartTodoParticipantsTab => 'Peserta';

  @override
  String get smartTodoInvitesTab => 'Undangan';

  @override
  String get smartTodoAddParticipant => 'Tambah Peserta';

  @override
  String smartTodoMembers(int count) {
    return 'Anggota ($count)';
  }

  @override
  String get smartTodoNoInvitesPending => 'Tidak ada undangan tertunda';

  @override
  String smartTodoRoleLabel(String role) {
    return 'Peran: $role';
  }

  @override
  String get smartTodoExpired => 'KEDALUWARSA';

  @override
  String smartTodoSentBy(String name) {
    return 'Dikirim oleh $name';
  }

  @override
  String get smartTodoResendEmail => 'Kirim Ulang Email';

  @override
  String get smartTodoRevoke => 'Batalkan';

  @override
  String get smartTodoSendingEmail => 'Mengirim email...';

  @override
  String get smartTodoEmailResent => 'Email berhasil dikirim ulang!';

  @override
  String get smartTodoEmailSendError => 'Gagal mengirim.';

  @override
  String get smartTodoInvalidSession =>
      'Sesi tidak valid untuk mengirim email.';

  @override
  String get smartTodoEmail => 'Email';

  @override
  String get smartTodoRole => 'Peran';

  @override
  String get smartTodoInviteCreated =>
      'Undangan dibuat dan dikirim dengan sukses!';

  @override
  String get smartTodoInviteCreatedNoEmail =>
      'Undangan dibuat, tapi email gagal dikirim (cek login/izin Google).';

  @override
  String get smartTodoUserAlreadyInvited => 'Pengguna sudah diundang.';

  @override
  String get smartTodoInviteCollaborator => 'Undang Kolaborator';

  @override
  String get smartTodoEditorRole => 'Editor (Bisa mengubah)';

  @override
  String get smartTodoViewerRole => 'Viewer (Hanya lihat)';

  @override
  String get smartTodoSendEmailNotification => 'Kirim notifikasi email';

  @override
  String get smartTodoSend => 'Kirim';

  @override
  String get smartTodoInvalidEmail => 'Email tidak valid';

  @override
  String get smartTodoUserNotAuthenticated =>
      'Pengguna tidak terautentikasi atau email kosong';

  @override
  String get smartTodoGoogleLoginRequired =>
      'Perlu login Google untuk mengirim email';

  @override
  String smartTodoInviteSent(String email) {
    return 'Undangan dikirim ke $email';
  }

  @override
  String get smartTodoUserAlreadyInvitedOrPending =>
      'Pengguna sudah diundang atau undangan tertunda.';

  @override
  String get smartTodoFilterToday => 'Hari ini';

  @override
  String get smartTodoFilterMyTasks => 'Tugas Saya';

  @override
  String get smartTodoFilterOwner => 'Pemilik';

  @override
  String get smartTodoViewGlobalTasks => 'Lihat Tugas Global';

  @override
  String get smartTodoViewLists => 'Lihat Daftar';

  @override
  String get smartTodoNewListDialogTitle => 'Daftar Baru';

  @override
  String get smartTodoTitleLabel => 'Judul *';

  @override
  String get smartTodoDescriptionLabel => 'Deskripsi';

  @override
  String get smartTodoCancel => 'Batal';

  @override
  String get smartTodoCreate => 'Buat';

  @override
  String get smartTodoSave => 'Simpan';

  @override
  String get smartTodoNoListsPresent => 'Belum ada daftar';

  @override
  String get smartTodoCreateFirstList => 'Buat daftar pertama untuk memulai';

  @override
  String smartTodoMembersCount(int count) {
    return '$count anggota';
  }

  @override
  String get smartTodoRenameListTitle => 'Ubah Nama Daftar';

  @override
  String get smartTodoNewNameLabel => 'Nama Baru';

  @override
  String get smartTodoDeleteListTitle => 'Hapus Daftar';

  @override
  String get smartTodoDeleteListConfirm =>
      'Apakah Anda yakin ingin menghapus daftar ini dan semua tugas di dalamnya? Tindakan ini permanen.';

  @override
  String get smartTodoDelete => 'Hapus';

  @override
  String get smartTodoEdit => 'Ubah';

  @override
  String get smartTodoSearchHint => 'Cari daftar...';

  @override
  String get smartTodoSearchTasksHint => 'Cari...';

  @override
  String smartTodoNoSearchResults(String query) {
    return 'Tidak ada hasil untuk \"$query\"';
  }

  @override
  String get smartTodoColumnTodo => 'To Do';

  @override
  String get smartTodoColumnInProgress => 'Sedang dikerjakan';

  @override
  String get smartTodoColumnDone => 'Selesai';

  @override
  String get smartTodoAllPeople => 'Semua orang';

  @override
  String smartTodoPeopleCount(int count) {
    return '$count orang';
  }

  @override
  String get smartTodoFilterByPerson => 'Filter per orang';

  @override
  String get smartTodoApplyFilters => 'Terapkan Filter';

  @override
  String get smartTodoAllTags => 'Semua tag';

  @override
  String smartTodoTagsCount(int count) {
    return '$count tag';
  }

  @override
  String get smartTodoFilterByTag => 'Filter per tag';

  @override
  String get smartTodoTagAlreadyExists => 'Tag sudah ada';

  @override
  String smartTodoError(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get profileMenuTitle => 'Profil';

  @override
  String get profileMenuLogout => 'Keluar';

  @override
  String get profileLogoutDialogTitle => 'Keluar';

  @override
  String get profileLogoutDialogConfirm => 'Apakah Anda yakin ingin keluar?';

  @override
  String get agileAddToSprint => 'Tambah ke Sprint';

  @override
  String get agileEstimated => 'Terestimasi';

  @override
  String get agilePoints => 'pt';

  @override
  String agilePointsValue(int points) {
    return '$points pt';
  }

  @override
  String get agileGuide => 'Panduan';

  @override
  String get backlogProductBacklog => 'Product Backlog';

  @override
  String get backlogArchiveCompleted => 'Arsip Selesai';

  @override
  String get backlogStories => 'story';

  @override
  String get backlogEstimated => 'terestimasi';

  @override
  String get backlogShowActive => 'Tampilkan Backlog aktif';

  @override
  String backlogShowArchive(int count) {
    return 'Tampilkan Arsip ($count selesai)';
  }

  @override
  String get backlogTab => 'Backlog';

  @override
  String backlogArchiveTab(int count) {
    return 'Arsip ($count)';
  }

  @override
  String get backlogFilters => 'Filter';

  @override
  String get backlogNewStory => 'Story Baru';

  @override
  String get backlogSearchHint => 'Cari judul, deskripsi atau ID...';

  @override
  String get backlogStatusFilter => 'Status: ';

  @override
  String get backlogPriorityFilter => 'Prioritas: ';

  @override
  String get backlogTagFilter => 'Tag: ';

  @override
  String get backlogAllStatuses => 'Semua';

  @override
  String get backlogAllPriorities => 'Semua';

  @override
  String get backlogRemoveFilters => 'Hapus filter';

  @override
  String get backlogNoStoryFound => 'Story tidak ditemukan';

  @override
  String get sprintBacklog => 'Sprint Backlog';

  @override
  String get scrumToDo => 'To Do';

  @override
  String get agileStatusRefinement => 'Refining';

  @override
  String get agileStatusReady => 'Siap';

  @override
  String get agileStatusInProgress => 'Sedang dikerjakan';

  @override
  String get agileStatusInReview => 'Dalam tinjauan';

  @override
  String get agileStatusDone => 'Selesai';

  @override
  String get backlog => 'Backlog';

  @override
  String get kanbanPolicySortPriority => 'Urutkan berdasarkan prioritas bisnis';

  @override
  String get kanbanPolicyMax2Days => 'Maks 2 hari di kolom ini';

  @override
  String get kanbanPolicyReqAcceptance =>
      'Memerlukan kriteria penerimaan yang jelas';

  @override
  String get kanbanPolicyItemReady => 'Item siap untuk dikerjakan';

  @override
  String get kanbanPolicyEstimationsDone => 'Estimasi selesai (jika diminta)';

  @override
  String get kanbanPolicyMax1PerPerson => 'Maks 1 item per orang';

  @override
  String kanbanPolicyMax1PerPersonParam(int count) {
    return 'Maks $count item per orang';
  }

  @override
  String get kanbanPolicyDailyUpdate => 'Wajib update harian';

  @override
  String get kanbanPolicyMax24h => 'Maks 24 jam di kolom ini';

  @override
  String kanbanPolicyMaxHoursParam(int count) {
    return 'Maks $count jam di kolom ini';
  }

  @override
  String kanbanPolicyMaxDaysParam(int count) {
    return 'Maks $count hari di kolom ini';
  }

  @override
  String get kanbanPolicyReqCodeReview =>
      'Memerlukan tinjauan kode yang disetujui';

  @override
  String get kanbanPolicyAllAcceptanceMet =>
      'Semua kriteria penerimaan terpenuhi';

  @override
  String get kanbanPolicyCheckTitle => 'Pengecekan Kebijakan';

  @override
  String get kanbanPolicyCheckMessage =>
      'Tindakan ini melanggar kebijakan berikut:';

  @override
  String get kanbanPolicyCheckProceed => 'Tetap lanjutkan';

  @override
  String get kanbanPolicyCheckCancel => 'Batal dan perbaiki';

  @override
  String get kanbanPolicyActiveLabel => 'Pengecekan Aktif';

  @override
  String get kanbanPolicyViolationTitle => 'Pelanggaran Kebijakan';

  @override
  String get kanbanPolicyViolationMessage => 'Memindahkan ';

  @override
  String get kanbanPolicyViolationTo => ' ke ';

  @override
  String get kanbanPolicyViolationViolations => ' Anda melanggar:';

  @override
  String get kanbanPolicySettingMaxHours => 'Maks jam';

  @override
  String get kanbanPolicySettingMaxDays => 'Maks hari';

  @override
  String get kanbanPolicySettingMaxItems => 'Maks item';

  @override
  String get kanbanPolicyUnitHours => 'Jam';

  @override
  String get kanbanPolicyUnitDays => 'Hari';

  @override
  String get kanbanPolicyHelpConfigurable =>
      'Setiap kolom kini dapat memiliki batas waktu dan WIP induvidual yang dikustomisasi.';

  @override
  String get kanbanPolicyMovingTip =>
      'Anda dapat tetap lanjut jika menganggap ini pengecualian yang valid.';

  @override
  String get kanbanMoveAnyway => 'Tetap pindahkan';

  @override
  String get backlogEmpty => 'Backlog kosong';

  @override
  String get backlogAddFirstStory => 'Tambah User Story pertama';

  @override
  String get kanbanWipExceeded =>
      'Batas WIP terlampaui! Selesaikan beberapa item sebelum memulai yang baru.';

  @override
  String get kanbanInfo => 'Info';

  @override
  String get kanbanConfigureWip => 'Atur WIP';

  @override
  String kanbanWipTooltip(int current, int max) {
    return 'WIP: $current dari maks $max';
  }

  @override
  String get kanbanNoWipLimit => 'Tidak ada batas WIP';

  @override
  String get kanbanWipWhyTitle => 'Mengapa menggunakannya?';

  @override
  String get kanbanWipReasonFocus =>
      'Mengurangi multitasking dan meningkatkan fokus';

  @override
  String get kanbanWipReasonBottlenecks => 'Menyoroti hambatan (bottlenecks)';

  @override
  String get kanbanWipReasonFlow => 'Meningkatkan alur kerja';

  @override
  String get kanbanWipReasonSpeed => 'Mempercepat penyelesaian item';

  @override
  String get kanbanWipOverLimitTitle =>
      'Apa yang harus dilakukan jika batas terlampaui?';

  @override
  String get kanbanWipOverLimitStep1 =>
      '1. Selesaikan item yang ada sebelum memulai yang baru';

  @override
  String get kanbanWipOverLimitStep2 =>
      '2. Bantu rekan tim untuk menyelesaikan item yang sedang ditinjau';

  @override
  String get kanbanWipOverLimitStep3 => '3. Analisis mengapa batas terlampaui';

  @override
  String get kanbanWipMovingTip =>
      'Tips: selesaikan atau pindahkan item lain sebelum memulai yang baru untuk menjaga alur kerja optimal.';

  @override
  String kanbanItems(int count) {
    return '$count item';
  }

  @override
  String get kanbanEmpty => 'Kosong';

  @override
  String kanbanWipLimitTitle(String column) {
    return 'Batas WIP: $column';
  }

  @override
  String get kanbanWipLimitDesc =>
      'Atur jumlah maksimal item yang boleh ada di kolom ini secara bersamaan.';

  @override
  String get kanbanWipLimitLabel => 'Batas WIP';

  @override
  String get kanbanWipLimitHint => 'Kosongkan jika tidak ada batas';

  @override
  String kanbanWipLimitSuggestion(int count) {
    return 'Tips: mulai dengan $count dan sesuaikan dengan tim.';
  }

  @override
  String get kanbanRemoveLimit => 'Hapus Batas';

  @override
  String get kanbanWipExceededTitle => 'Batas WIP Terlampaui';

  @override
  String get kanbanWipExceededMessage => 'Memindahkan ';

  @override
  String get kanbanWipExceededIn => ' ke ';

  @override
  String get kanbanWipExceededWillExceed => ' akan melampaui batas WIP.';

  @override
  String kanbanColumnLabel(String name) {
    return 'Kolom: $name';
  }

  @override
  String kanbanCurrentCount(int current, int limit) {
    return 'Saat ini: $current | Batas: $limit';
  }

  @override
  String kanbanAfterMove(int count) {
    return 'Setelah dipindah: $count';
  }

  @override
  String get kanbanSuggestion =>
      'Tips: selesaikan atau pindahkan item lain sebelum memulai yang baru untuk menjaga alur kerja optimal.';

  @override
  String get kanbanWipExplanationTitle => 'Apa itu Batas WIP?';

  @override
  String get kanbanWipWhat => 'Apa itu Batas WIP?';

  @override
  String get kanbanWipWhatDesc =>
      'Batas WIP (Work In Progress) adalah batasan jumlah item yang boleh ada di sebuah kolom secara bersamaan.';

  @override
  String get kanbanWipWhy => 'Mengapa menggunakannya?';

  @override
  String get kanbanWipBenefit1 =>
      '- Mengurangi multitasking dan meningkatkan fokus';

  @override
  String get kanbanWipBenefit2 => '- Menyoroti hambatan';

  @override
  String get kanbanWipBenefit3 => '- Meningkatkan alur kerja';

  @override
  String get kanbanWipBenefit4 => '- Mempercepat penyelesaian item';

  @override
  String get kanbanWipWhatToDo => 'Apa yang harus dilakukan jika terlampaui?';

  @override
  String get kanbanWipWhatToDoDesc =>
      '1. Selesaikan item sebelum memulai yang baru\n2. Bantu buka blokir item yang sedang ditinjau\n3. Analisis penyebabnya';

  @override
  String get kanbanUnderstood => 'Mengerti';

  @override
  String sprintTitle(int count) {
    return 'Sprint ($count)';
  }

  @override
  String get sprintNew => 'Sprint Baru';

  @override
  String get sprintNoSprints => 'Tidak ada sprint';

  @override
  String get sprintCreateFirst => 'Buat sprint pertama untuk memulai';

  @override
  String sprintNumber(int number) {
    return 'Sprint $number';
  }

  @override
  String get sprintStart => 'Mulai Sprint';

  @override
  String get sprintComplete => 'Selesaikan Sprint';

  @override
  String sprintDays(int days) {
    return '${days}h';
  }

  @override
  String sprintStoriesCount(int count) {
    return '$count';
  }

  @override
  String get sprintStoriesLabel => 'story';

  @override
  String get sprintPointsPlanned => 'pt';

  @override
  String get sprintPointsCompleted => 'selesai';

  @override
  String get sprintVelocity => 'kecepatan';

  @override
  String sprintDaysRemaining(int days) {
    return 'sisa ${days}h';
  }

  @override
  String get sprintStartButton => 'Mulai';

  @override
  String get sprintCompleteActiveFirst =>
      'Selesaikan sprint aktif sebelum memulai yang baru';

  @override
  String get sprintPlanningAlreadyExists =>
      'Sudah ada sprint dalam perencanaan. Hapus atau mulai dulu sebelum membuat yang baru.';

  @override
  String get sprintDeletePlanningTitle => 'Hapus Perencanaan Sprint';

  @override
  String sprintDeletePlanningConfirm(String sprintName) {
    return 'Ingin menghapus sprint \"$sprintName\"? Story di dalamnya akan kembali ke backlog.';
  }

  @override
  String sprintDeletedSuccess(String sprintName) {
    return 'Sprint \"$sprintName\" dihapus. Story telah dipindahkan ke backlog.';
  }

  @override
  String get sprintEditTitle => 'Ubah Sprint';

  @override
  String get sprintNewTitle => 'Sprint Baru';

  @override
  String get sprintNameLabel => 'Nama Sprint';

  @override
  String get sprintNameHint => 'misal: Sprint 1 - MVP';

  @override
  String get sprintNameRequired => 'Masukkan nama';

  @override
  String get sprintGoalLabel => 'Sprint Goal';

  @override
  String get sprintGoalHint => 'Tujuan sprint ini';

  @override
  String get sprintStartDateLabel => 'Tanggal Mulai';

  @override
  String get sprintEndDateLabel => 'Tanggal Selesai';

  @override
  String sprintDuration(int days) {
    return 'Durasi: $days hari';
  }

  @override
  String sprintAverageVelocity(String velocity) {
    return 'Rata-rata kecepatan: $velocity pt/sprint';
  }

  @override
  String sprintTeamMembers(int count) {
    return 'Tim: $count anggota';
  }

  @override
  String get sprintPlanningTitle => 'Sprint Planning';

  @override
  String get sprintPlanningSubtitle =>
      'Pilih story yang akan dikerjakan di sprint ini';

  @override
  String get sprintPlanningSelected => 'Terpilih';

  @override
  String get sprintPlanningSuggested => 'Disarankan';

  @override
  String get sprintPlanningCapacity => 'Kapasitas';

  @override
  String get sprintPlanningBasedOnVelocity => 'berdasarkan rata-rata kecepatan';

  @override
  String sprintPlanningDays(int days) {
    return '$days hari';
  }

  @override
  String get sprintPlanningExceeded => 'Peringatan: melampaui saran kecepatan';

  @override
  String get sprintPlanningNoStories => 'Tidak ada story tersedia di backlog';

  @override
  String get sprintPlanningNotEstimated => 'Belum diestimasi';

  @override
  String sprintPlanningConfirm(int count) {
    return 'Konfirmasi ($count story)';
  }

  @override
  String get storyFormEditTitle => 'Ubah Story';

  @override
  String get storyFormNewTitle => 'User Story Baru';

  @override
  String get storyFormDetailsTab => 'Detail';

  @override
  String get storyFormAcceptanceTab => 'Kriteria Penerimaan';

  @override
  String get storyFormOtherTab => 'Lainnya';

  @override
  String get storyFormTitleLabel => 'Judul *';

  @override
  String get storyFormTitleHint =>
      'Misal: US-123: Sebagai pengguna saya ingin...';

  @override
  String get storyFormTitleRequired => 'Masukkan judul';

  @override
  String get storyFormUseTemplate => 'Gunakan templat User Story';

  @override
  String get storyFormTemplateSubtitle => 'Sebagai... saya ingin... Agar...';

  @override
  String get storyFormAsA => 'Sebagai...';

  @override
  String get storyFormAsAHint => 'pengguna, admin, pelanggan...';

  @override
  String get storyFormIWant => 'Saya ingin...';

  @override
  String get storyFormIWantHint => 'bisa melakukan sesuatu...';

  @override
  String get storyFormIWantRequired => 'Masukkan apa yang diinginkan pengguna';

  @override
  String get storyFormSoThat => 'Supaya...';

  @override
  String get storyFormSoThatHint => 'mendapatkan manfaat...';

  @override
  String get storyFormDescriptionLabel => 'Deskripsi';

  @override
  String get storyFormDescriptionHint => 'Kriteria penerimaan, catatan...';

  @override
  String get storyFormDescriptionRequired => 'Masukkan deskripsi';

  @override
  String get storyFormPreview => 'Pratinjau:';

  @override
  String get storyFormEmptyDescription => '(deskripsi kosong)';

  @override
  String get storyFormAcceptanceCriteriaTitle => 'Kriteria Penerimaan';

  @override
  String get storyFormAcceptanceCriteriaSubtitle =>
      'Tentukan kapan story dianggap selesai';

  @override
  String get storyFormAddCriterionHint => 'Tambah kriteria penerimaan...';

  @override
  String get storyFormNoCriteria => 'Belum ada kriteria';

  @override
  String get storyFormSuggestions => 'Saran:';

  @override
  String get storyFormSuggestion1 => 'Data disimpan dengan benar';

  @override
  String get storyFormSuggestion2 => 'Pengguna menerima konfirmasi';

  @override
  String get storyFormSuggestion3 => 'Form menampilkan kesalahan validasi';

  @override
  String get storyFormSuggestion4 => 'Fitur dapat diakses dari mobile';

  @override
  String get storyFormPriorityLabel => 'Prioritas (MoSCoW)';

  @override
  String get storyFormBusinessValueLabel => 'Nilai Bisnis';

  @override
  String get storyFormBusinessValueHigh => 'Nilai bisnis tinggi';

  @override
  String get storyFormBusinessValueMedium => 'Nilai sedang';

  @override
  String get storyFormBusinessValueLow => 'Nilai bisnis rendah';

  @override
  String get storyFormStoryPointsLabel => 'Estimasi dalam Story Points';

  @override
  String get storyFormStoryPointsTooltip =>
      'Story Points mewakili kompleksitas relatif pekerjaan.\nGunakan urutan Fibonacci: 1 (mudah) -> 21 (sangat kompleks).';

  @override
  String get storyFormNoPoints => 'Tidak ada';

  @override
  String get storyFormPointsSimple => 'Tugas cepat dan mudah';

  @override
  String get storyFormPointsMedium => 'Tugas kompleksitas sedang';

  @override
  String get storyFormPointsComplex => 'Tugas kompleks, butuh analisis';

  @override
  String get storyFormPointsVeryComplex =>
      'Sangat kompleks, pertimbangkan untuk memecah story';

  @override
  String get storyFormTagsLabel => 'Tag';

  @override
  String get storyFormAddTagHint => 'Tambah tag...';

  @override
  String get storyFormExistingTags => 'Tag yang ada:';

  @override
  String get storyFormAssigneeLabel => 'Tugaskan ke';

  @override
  String get storyFormAssigneeHint => 'Pilih anggota tim';

  @override
  String get storyFormNotAssigned => 'Tidak ditugaskan';

  @override
  String storyDetailPointsLabel(int points) {
    return '$points poin';
  }

  @override
  String get storyDetailDescriptionTitle => 'Deskripsi';

  @override
  String get storyDetailNoDescription => 'Tidak ada deskripsi';

  @override
  String storyDetailAcceptanceCriteria(int completed, int total) {
    return 'Kriteria Penerimaan ($completed/$total)';
  }

  @override
  String get storyDetailNoCriteria => 'Belum ada kriteria';

  @override
  String get storyDetailEstimationTitle => 'Estimasi';

  @override
  String get storyDetailFinalEstimate => 'Estimasi akhir: ';

  @override
  String storyDetailEstimatesReceived(int count) {
    return '$count estimasi diterima';
  }

  @override
  String get storyDetailInfoTitle => 'Informasi';

  @override
  String get storyDetailBusinessValue => 'Nilai Bisnis';

  @override
  String get storyDetailAssignedTo => 'Ditugaskan kepada';

  @override
  String get storyDetailSprint => 'Sprint';

  @override
  String get storyDetailCreatedAt => 'Dibuat pada';

  @override
  String get storyDetailStartedAt => 'Dimulai pada';

  @override
  String get storyDetailCompletedAt => 'Selesai pada';

  @override
  String get landingBadge => 'Alat untuk tim agile';

  @override
  String get landingHeroTitle => 'Bangun produk lebih baik\ndengan Keisen';

  @override
  String get landingHeroSubtitle =>
      'Prioritaskan, estimasi, dan kelola proyek Anda dengan alat kolaboratif. Semuanya di satu tempat, gratis.';

  @override
  String get landingStartFree => 'Mulai Gratis';

  @override
  String get landingEverythingNeed => 'Semua yang Anda butuhkan';

  @override
  String get landingModernTools => 'Alat yang dirancang untuk tim modern';

  @override
  String get landingSmartTodoBadge => 'Produktivitas';

  @override
  String get landingSmartTodoTitle => 'Smart Todo List';

  @override
  String get landingSmartTodoSubtitle =>
      'Manajemen tugas cerdas dan kolaboratif';

  @override
  String get landingSmartTodoCollaborativeTitle => 'Daftar Tugas Kolaboratif';

  @override
  String get landingSmartTodoCollaborativeDesc =>
      'Smart Todo mengubah manajemen tugas harian menjadi proses yang lancar dan kolaboratif. Buat daftar, tugaskan ke anggota tim, dan pantau kemajuan secara real-time.\n\nIdeal untuk tim terdistribusi yang butuh sinkronisasi terus-menerus.';

  @override
  String get landingSmartTodoImportTitle => 'Impor Fleksibel';

  @override
  String get landingSmartTodoImportDesc =>
      'Impor tugas dari sumber eksternal dalam beberapa klik. Mendukung CSV, salin/tempel dari Excel atau teks bebas. Sistem mengenali struktur data secara otomatis.\n\nMigrasi mudah dari alat lain tanpa kehilangan informasi.';

  @override
  String get landingSmartTodoShareTitle => 'Berbagi dan Undangan';

  @override
  String get landingSmartTodoShareDesc =>
      'Undang kolega ke daftar Anda melalui email. Setiap peserta bisa melihat, berkomentar, dan memperbarui status tugas.\n\nSangat cocok untuk mengelola proyek lintas fungsional dengan stakeholder luar.';

  @override
  String get landingSmartTodoFeaturesTitle => 'Fitur Smart Todo';

  @override
  String get landingEisenhowerBadge => 'Prioritas';

  @override
  String get landingEisenhowerSubtitle =>
      'Metode pengambilan keputusan yang digunakan pemimpin';

  @override
  String get landingEisenhowerUrgentImportantTitle => 'Mendesak vs Penting';

  @override
  String get landingEisenhowerUrgentImportantDesc =>
      'Matriks Eisenhower membagi tugas menjadi empat kuadran berdasarkan urgensi dan kepentingan.\n\nFramework ini membantu membedakan apa yang butuh perhatian segera dan apa yang berkontribusi pada tujuan jangka panjang.';

  @override
  String get landingEisenhowerDecisionsTitle => 'Keputusan Lebih Baik';

  @override
  String get landingEisenhowerDecisionsDesc =>
      'Dengan menerapkan matriks, Anda membangun mindset berorientasi hasil. Fokus pada apa yang memberi nilai nyata.\n\nAlat digital kami membuat proses ini instan: geser tugas ke kuadran yang tepat.';

  @override
  String get landingEisenhowerBenefitsTitle =>
      'Mengapa menggunakan Matriks Eisenhower?';

  @override
  String get landingEisenhowerBenefitsDesc =>
      'Studi menunjukkan 80% aktivitas harian masuk kuadran 3 dan 4 (tidak penting). Matriks membantu Anda mengidentifikasi dan membuangnya.';

  @override
  String get landingEisenhowerQuadrants =>
      'Kuadran 1: Mendesak + Penting → Kerjakan sekarang\nKuadran 2: Tidak mendesak + Penting → Rencanakan\nKuadran 3: Mendesak + Tidak penting → Delegasikan\nKuadran 4: Tidak mendesak + Tidak penting → Hapus';

  @override
  String get landingAgileBadge => 'Metodologi';

  @override
  String get landingAgileTitle => 'Agile & Scrum Framework';

  @override
  String get landingAgileSubtitle =>
      'Terapkan praktik terbaik pengembangan perangkat lunak iteratif';

  @override
  String get landingAgileIterativeTitle =>
      'Pengembangan Iteratif dan Inkremental';

  @override
  String get landingAgileIterativeDesc =>
      'Agile membagi pekerjaan menjadi siklus pendek (Sprint). Setiap iterasi menghasilkan inkremen produk yang berfungsi.\n\nDengan Keisen, kelola backlog, rencanakan sprint, dan pantau kecepatan tim.';

  @override
  String get landingAgileScrumTitle => 'Framework Scrum';

  @override
  String get landingAgileScrumDesc =>
      'Scrum menentukan peran (PO, Scrum Master, Tim), acara (Planning, Daily, Review, Retro), dan artefak (Backlog).\n\nKeisen mendukung semua acara Scrum dengan alat khusus.';

  @override
  String get landingAgileKanbanTitle => 'Kanban Board';

  @override
  String get landingAgileKanbanDesc =>
      'Metode Kanban memvisualisasikan alur kerja lewat kolom. Batasi WIP untuk memaksimalkan throughput.\n\nPapan Kanban kami mendukung batas WIP dan metrik alur.';

  @override
  String get landingEstimationBadge => 'Estimasi';

  @override
  String get landingEstimationTitle => 'Teknik Estimasi Kolaboratif';

  @override
  String get landingEstimationSubtitle =>
      'Pilih metode terbaik untuk estimasi akurat';

  @override
  String get landingEstimationFeaturesTitle => 'Fitur Ruang Estimasi';

  @override
  String get landingRetroBadge => 'Retrospektif';

  @override
  String get landingRetroTitle => 'Retrospektif Interaktif';

  @override
  String get landingRetroSubtitle =>
      'Alat kolaborasi real-time: timer, voting anonim, item tindakan, dan laporan AI.';

  @override
  String get landingRetroActionTitle => 'Pelacakan Item Tindakan';

  @override
  String get landingRetroActionDesc =>
      'Setiap retrospektif menghasilkan item tindakan yang bisa dilacak dengan pemilik dan tenggat waktu.';

  @override
  String get landingWorkflowBadge => 'Alur Kerja';

  @override
  String get landingWorkflowTitle => 'Cara Kerja';

  @override
  String get landingWorkflowSubtitle => 'Mulai dalam 3 langkah mudah';

  @override
  String get landingStep1Title => 'Buat proyek';

  @override
  String get landingStep1Desc =>
      'Buat proyek Agile dan undang tim. Atur sprint, backlog, dan papan.';

  @override
  String get landingStep2Title => 'Kolaborasi';

  @override
  String get landingStep2Desc =>
      'Estimasi story bersama, atur sprint, dan pantau kemajuan secara real-time.';

  @override
  String get landingStep3Title => 'Tingkatkan';

  @override
  String get landingStep3Desc =>
      'Analisis metrik, lakukan retrospektif, dan terus tingkatkan proses.';

  @override
  String get landingCtaTitle => 'Siap untuk memulai?';

  @override
  String get landingCtaDesc =>
      'Akses gratis dan mulai berkolaborasi dengan tim Anda.';

  @override
  String get landingFooterBrandDesc =>
      'Alat kolaborasi untuk tim agile.\nRencanakan, estimasi, dan tingkatkan bersama.';

  @override
  String get landingFooterProduct => 'Produk';

  @override
  String get landingFooterResources => 'Sumber Daya';

  @override
  String get landingFooterCompany => 'Perusahaan';

  @override
  String get landingFooterLegal => 'Legal';

  @override
  String get landingCopyright =>
      '© 2026 Keisen. Hak cipta dilindungi undang-undang.';

  @override
  String get featureSmartImportDesc =>
      'Buat tugas cepat dengan deskripsi\nTugaskan ke anggota tim\nAtur prioritas dan tenggat\nNotifikasi penyelesaian';

  @override
  String get featureImportDesc =>
      'Impor file CSV\nSalin/tempel dari Excel\nParsing teks cerdas\nPemetaan bidang otomatis';

  @override
  String get featureShareDesc =>
      'Undangan via email\nIzin yang dapat diatur\nKomentar tugas\nRiwayat perubahan';

  @override
  String get featureSmartTaskCreation => 'Buat tugas cepat';

  @override
  String get featureTeamAssignment => 'Penugasan tim';

  @override
  String get featurePriorityDeadline => 'Prioritas & Tenggat';

  @override
  String get featureCompletionNotifications => 'Notifikasi selesai';

  @override
  String get featureCsvImport => 'Impor CSV';

  @override
  String get featureExcelPaste => 'Tempel Excel';

  @override
  String get featureSmartParsing => 'Parsing Cerdas';

  @override
  String get featureAutoMapping => 'Pemetaan Otomatis';

  @override
  String get featureEmailInvites => 'Undangan Email';

  @override
  String get featurePermissions => 'Izin Kustom';

  @override
  String get featureTaskComments => 'Komentar Tugas';

  @override
  String get featureHistory => 'Riwayat Perubahan';

  @override
  String get featureAdvancedFilters => 'Filter Lanjutan';

  @override
  String get featureFullTextSearch => 'Pencarian Teks';

  @override
  String get featureSorting => 'Urutan';

  @override
  String get featureTagsCategories => 'Tag & Kategori';

  @override
  String get featureArchiving => 'Pengarsipan';

  @override
  String get featureSort => 'Urutan';

  @override
  String get featureDataExport => 'Ekspor Data';

  @override
  String get landingIntroFeatures =>
      'Sprint Planning dengan kapasitas tim\nBacklog prioritas dengan drag & drop\nPelacakan kecepatan & chart burndown\nDaily standup yang difasilitasi';

  @override
  String get landingAgileScrumFeatures =>
      'Product Backlog dengan story points\nSprint Backlog dengan pemecahan tugas\nPapan retrospektif terintegrasi\nMetrik Scrum otomatis';

  @override
  String get landingAgileKanbanFeatures =>
      'Kolom kustom\nBatas WIP per kolom\nDrag & drop intuitif\nLead time dan cycle time';

  @override
  String get landingEstimationPokerDesc =>
      'Metode klasik: tiap anggota pilih kartu. Suara dibuka bersamaan untuk hindari bias.';

  @override
  String get landingEstimationTShirtTitle => 'T-Shirt Size';

  @override
  String get landingEstimationTShirtSubtitle => 'Ukuran relatif';

  @override
  String get landingEstimationTShirtDesc =>
      'Estimasi cepat dengan XS, S, M, L, XL, XXL. Cocok untuk backlog grooming.';

  @override
  String get landingEstimationPertTitle => 'Three-Point (PERT)';

  @override
  String get landingEstimationPertSubtitle => 'Optimis / Mungkin / Pesimis';

  @override
  String get landingEstimationPertDesc =>
      'Teknik statistik: hitung rata-rata tertimbang dari 3 titik estimasi.';

  @override
  String get landingEstimationBucketTitle => 'Bucket System';

  @override
  String get landingEstimationBucketSubtitle => 'Kategorisasi cepat';

  @override
  String get landingEstimationBucketDesc =>
      'Story dimasukkan ke dalam \"ember\" tertentu. Bagus untuk estimasi massal.';

  @override
  String get landingEstimationChipHiddenVote => 'Voting tersembunyi';

  @override
  String get landingEstimationChipTimer => 'Timer kustom';

  @override
  String get landingEstimationChipStats => 'Statistik real-time';

  @override
  String get landingEstimationChipParticipants => 'Hingga 20 peserta';

  @override
  String get landingEstimationChipHistory => 'Riwayat estimasi';

  @override
  String get landingEstimationChipExport => 'Ekspor hasil';

  @override
  String get landingRetroTemplateStartStopTitle => 'Mulai / Berhenti / Lanjut';

  @override
  String get landingRetroTemplateStartStopDesc =>
      'Format klasik: apa yang mulai dilakukan, berhenti, atau dilanjutkan.';

  @override
  String get landingRetroTemplateMadSadTitle => 'Marah / Sedih / Senang';

  @override
  String get landingRetroTemplateMadSadDesc =>
      'Retrospektif emosional: apa yang membuat tim marah, sedih atau senang.';

  @override
  String get landingRetroTemplate4LsTitle => '4L\'s';

  @override
  String get landingRetroTemplate4LsDesc =>
      'Liked, Learned, Lacked, Longed For - analisis sprint lengkap.';

  @override
  String get landingRetroTemplateSailboatTitle => 'Sailboat (Perahu Layar)';

  @override
  String get landingRetroTemplateSailboatDesc =>
      'Metafora visual: angin (bantuan), jangkar (hambatan), batu (risiko), pulau (tujuan).';

  @override
  String get landingRetroTemplateWentWellTitle =>
      'Berjalan Baik / Perlu Ditingkatkan';

  @override
  String get landingRetroTemplateWentWellDesc =>
      'Format langsung: hal positif dan area peningkatan.';

  @override
  String get landingRetroTemplateDakiTitle => 'DAKI';

  @override
  String get landingRetroTemplateDakiDesc =>
      'Drop, Add, Keep, Improve - keputusan nyata untuk sprint depan.';

  @override
  String get landingRetroFeatureTrackingTitle => 'Pelacakan Item Tindakan';

  @override
  String get landingRetroFeatureTrackingDesc =>
      'Tiap retro hasilkan item tindakan dengan pemilik dan tenggat.';

  @override
  String get landingAgileSectionBadge => 'Metodologi';

  @override
  String get landingAgileSectionTitle => 'Agile & Scrum Framework';

  @override
  String get landingAgileSectionSubtitle =>
      'Terapkan praktik pengembangan perangkat lunak iteratif';

  @override
  String get landingSmartTodoCollabTitle => 'Daftar Tugas Kolaboratif';

  @override
  String get landingSmartTodoCollabDesc =>
      'Smart Todo mengubah manajemen aktivitas harian jadi proses lancar. Pantau kemajuan real-time.';

  @override
  String get landingSmartTodoCollabFeatures =>
      'Buat cepat\nPenugasan tim\nPrioritas & Tenggat\nNotifikasi';

  @override
  String get landingSmartTodoImportFeatures =>
      'Impor CSV\nTempel Excel\nParsing Cerdas\nPemetaan Otomatis';

  @override
  String get landingSmartTodoSharingTitle => 'Berbagi & Undangan';

  @override
  String get landingSmartTodoSharingDesc =>
      'Undang kolega, komentar, dan perbarui status tugas bersama.';

  @override
  String get landingSmartTodoSharingFeatures =>
      'Undangan\nIzin Kustom\nKomentar\nRiwayat';

  @override
  String get landingSmartTodoChipFilters => 'Filter lanjutan';

  @override
  String get landingSmartTodoChipSearch => 'Pencarian teks';

  @override
  String get landingSmartTodoChipSort => 'Urutan';

  @override
  String get landingSmartTodoChipTags => 'Tag & Kategori';

  @override
  String get landingSmartTodoChipArchive => 'Pengarsipan';

  @override
  String get landingSmartTodoChipExport => 'Ekspor';

  @override
  String get landingEisenhowerTitle => 'Matriks Eisenhower';

  @override
  String get landingEisenhowerUrgentTitle => 'Mendesak vs Penting';

  @override
  String get landingEisenhowerUrgentDesc =>
      'Membagi tugas jadi 4 kuadran untuk fokus yang lebih baik.';

  @override
  String get landingEisenhowerUrgentFeatures =>
      'Kuadran 1: Mendesak+Penting → Kerjakan\nKuadran 2: Penting+Tidak mendesak → Rencanakan\nKuadran 3: Mendesak+Tidak penting → Delegasi\nKuadran 4: Tidak mendesak+Tidak penting → Hapus';

  @override
  String get landingEisenhowerDecisionsFeatures =>
      'Drag & drop\nKolaborasi real-time\nStatistik distribusi\nEkspor laporan';

  @override
  String get landingEisenhowerUrgentLabel => 'MENDESAK';

  @override
  String get landingEisenhowerNotUrgentLabel => 'TIDAK MENDESAK';

  @override
  String get landingEisenhowerImportantLabel => 'PENTING';

  @override
  String get landingEisenhowerNotImportantLabel => 'TIDAK PENTING';

  @override
  String get landingEisenhowerDoLabel => 'KERJAKAN';

  @override
  String get landingEisenhowerDoDesc => 'Krisis, tenggat, darurat';

  @override
  String get landingEisenhowerPlanLabel => 'RENCANAKAN';

  @override
  String get landingEisenhowerPlanDesc => 'Strategi, pertumbuhan';

  @override
  String get landingEisenhowerDelegateLabel => 'DELEGASIKAN';

  @override
  String get landingEisenhowerDelegateDesc => 'Interupsi, rapat, email';

  @override
  String get landingEisenhowerEliminateLabel => 'HAPUS';

  @override
  String get landingEisenhowerEliminateDesc => 'Gangguan, waktu terbuang';

  @override
  String get landingFooterFeatures => 'Fitur';

  @override
  String get landingFooterPricing => 'Harga';

  @override
  String get landingFooterChangelog => 'Changelog';

  @override
  String get landingFooterRoadmap => 'Roadmap';

  @override
  String get landingFooterDocs => 'Dokumentasi';

  @override
  String jiraConnectedSuccess(String name) {
    return 'Terhubung sebagai $name';
  }

  @override
  String get landingFooterAgileGuides => 'Panduan Agile';

  @override
  String get landingFooterBlog => 'Blog';

  @override
  String get landingFooterCommunity => 'Komunitas';

  @override
  String get landingFooterAbout => 'Tentang Kami';

  @override
  String get landingFooterContact => 'Kontak';

  @override
  String get landingFooterJobs => 'Karir';

  @override
  String get landingFooterPress => 'Press Kit';

  @override
  String get landingFooterPrivacy => 'Kebijakan Privasi';

  @override
  String get landingFooterTerms => 'Ketentuan Layanan';

  @override
  String get landingFooterCookies => 'Kebijakan Cookie';

  @override
  String get landingFooterGdpr => 'GDPR';

  @override
  String get legalCookieTitle => 'Kami menggunakan cookie';

  @override
  String get legalCookieMessage =>
      'Kami menggunakan cookie untuk meningkatkan pengalaman Anda. Dengan melanjutkan, Anda setuju.';

  @override
  String get legalCookieAccept => 'Terima semua';

  @override
  String get legalCookieRefuse => 'Hanya wajib';

  @override
  String get legalCookiePolicy => 'Kebijakan Cookie';

  @override
  String get legalPrivacyPolicy => 'Privasi';

  @override
  String get legalTermsOfService => 'Syarat & Ketentuan';

  @override
  String get legalGDPR => 'GDPR';

  @override
  String get legalLastUpdatedLabel => 'Pembaruan terakhir';

  @override
  String get legalLastUpdatedDate => '18 Januari 2026';

  @override
  String get legalAcceptTerms =>
      'Saya menerima Syarat Layanan dan Kebijakan Privasi';

  @override
  String get legalMustAcceptTerms =>
      'Anda harus menerima ketentuan untuk melanjutkan';

  @override
  String get legalPrivacyContent =>
      '## 1. Pendahuluan\nSelamat datang di **Keisen**. Privasi Anda penting bagi kami. Kebijakan ini menjelaskan cara kami mengelola informasi Anda.\n\n## 2. Data yang Kami Kumpulkan\n### 2.1 Informasi yang Anda Berikan\n- **Data Akun:** Nama, email (via Google Sign-In).\n- **Konten:** Tugas, estimasi, retro, komentar.\n### 2.2 Data Otomatis\n- **Log Sistem:** IP, browser, waktu. Cookie sesi.\n\n## 3. Penggunaan Data\nUntuk operasional, peningkatan platform, pengalaman personal, dan email layanan.\n\n## 4. Berbagi Data\nKami tidak menjual data. Menggunakan **Google Firebase** untuk hosting/autentikasi.\n\n## 5. Keamanan\nStandar industri (enkripsi) diterapkan.\n\n## 6. Hak Anda\nAkses, koreksi, penghapusan (\"Hak untuk dilupakan\"). Kontak: suppkesien@gmail.com.\n\n## 7. Perubahan\nKami memperbarui kebijakan ini secara berkala di halaman ini.';

  @override
  String get legalTermsContent =>
      '## 1. Penerimaan\nDengan menggunakan **Keisen**, Anda menyetujui ketentuan ini.\n\n## 2. Layanan\nPlatform kolaborasi agile. Kami berhak mengubah layanan.\n\n## 3. Akun\nAnda bertanggung jawab atas keamanan akun Anda.\n\n## 4. Perilaku\nDilarang konten ilegal atau akses tidak sah.\n\n## 5. Properti Intelektual\nKeisen milik Leonardo Torella.\n\n## 6. Kewajiban\nLayanan disediakan \"sebagaimana adanya\". Tidak bertanggung jawab atas kerugian tidak langsung.\n\n## 7. Hukum\nDiatur oleh hukum Italia.\n\n## 8. Kontak\nsuppkesien@gmail.com.';

  @override
  String get legalCookiesContent =>
      '## 1. Apa itu Cookie?\nFile teks kecil di perangkat Anda.\n\n## 2. Penggunaan\n### 2.1 Cookie Teknis\nWajib untuk operasional (misal: login).\n### 2.2 Analitik\nData anonim untuk performa situs.\n\n## 3. Manajemen\nKontrol lewat pengaturan browser.\n\n## 4. Pihak Ketiga\nFirebase menggunakan cookie mereka sendiri.';

  @override
  String get legalGdprContent =>
      '## Komitmen GDPR\nKeisen melindungi data pribadi sesuai aturan GDPR Uni Eropa.\n\n## Pengendali Data\n**Keisen Team**\nEmail: suppkesien@gmail.com\n\n## Dasar Hukum\nPersetujuan, pelaksanaan kontrak, atau kepentingan sah.\n\n## Transfer Data\nServer Google Cloud (Firebase) yang aman (patuh SCC).\n\n## Hak Anda\nAkses, koreksi, hapus, pembatasan, portabilitas. Hubungi kami via email. Respon dalam satu bulan.';

  @override
  String get profilePrivacy => 'Privasi';

  @override
  String get profileExportData => 'Ekspor data saya';

  @override
  String get profileDeleteAccountConfirm =>
      'Apakah Anda yakin ingin menghapus akun? Tindakan ini permanen.';

  @override
  String get subscriptionTitle => 'Langganan';

  @override
  String get subscriptionTabPlans => 'Paket';

  @override
  String get subscriptionTabUsage => 'Penggunaan';

  @override
  String get subscriptionTabBilling => 'Tagihan';

  @override
  String subscriptionActiveProjects(int count) {
    return '$count proyek aktif';
  }

  @override
  String subscriptionActiveLists(int count) {
    return '$count daftar Todo';
  }

  @override
  String get subscriptionCurrentPlan => 'Paket saat ini';

  @override
  String subscriptionUpgradeTo(String plan) {
    return 'Upgrade ke $plan';
  }

  @override
  String subscriptionDowngradeTo(String plan) {
    return 'Downgrade ke $plan';
  }

  @override
  String subscriptionChoose(String plan) {
    return 'Pilih $plan';
  }

  @override
  String get subscriptionMonthly => 'Bulanan';

  @override
  String get subscriptionYearly => 'Tahunan (-17%)';

  @override
  String get subscriptionLimitReached => 'Batas tercapai';

  @override
  String get subscriptionLimitProjects =>
      'Batas proyek (5) tercapai. Hubungi kami untuk peningkatan.';

  @override
  String get subscriptionLimitLists =>
      'Batas daftar tercapai. Upgrade ke Premium.';

  @override
  String get subscriptionLimitTasks => 'Batas tugas proyek tercapai.';

  @override
  String get subscriptionLimitInvites => 'Batas undangan tercapai.';

  @override
  String get subscriptionLimitEstimations => 'Batas sesi estimasi tercapai.';

  @override
  String get subscriptionLimitRetrospectives => 'Batas retro tercapai.';

  @override
  String get subscriptionLimitAgileProjects =>
      'Batas proyek agile (5) tercapai.';

  @override
  String get subscriptionLimitDefault => 'Batas paket saat ini tercapai.';

  @override
  String get subscriptionCurrentUsage => 'Penggunaan saat ini';

  @override
  String get subscriptionUpgradeToPremium => 'Jadi Premium';

  @override
  String get subscriptionBenefitProjects => '30 proyek aktif';

  @override
  String get subscriptionBenefitLists => '30 daftar Todo';

  @override
  String get subscriptionBenefitTasks => '100 tugas per proyek';

  @override
  String get subscriptionBenefitNoAds => 'Tanpa iklan';

  @override
  String get subscriptionStartingFrom => 'Hubungi kami untuk info';

  @override
  String get subscriptionLater => 'Nanti';

  @override
  String get subscriptionViewPlans => 'Hubungi pengembang';

  @override
  String get subscriptionContactDeveloper => 'Hubungi pengembang';

  @override
  String get subscriptionOfficialEmail => 'leonardo.torella@gmail.com';

  @override
  String subscriptionCanCreateOne(String entity) {
    return 'Sisa 1 $entity lagi';
  }

  @override
  String subscriptionCanCreateMany(int count, String entity) {
    return 'Sisa $count $entity lagi';
  }

  @override
  String get subscriptionUpgrade => 'UPGRADE';

  @override
  String subscriptionUsed(int count) {
    return 'Terpakai: $count';
  }

  @override
  String get subscriptionUnlimited => 'Tak terbatas';

  @override
  String subscriptionLimit(int count) {
    return 'Batas: $count';
  }

  @override
  String get subscriptionPlanUsage => 'Penggunaan paket';

  @override
  String get subscriptionRefresh => 'Perbarui';

  @override
  String get subscriptionAdsActive => 'Iklan aktif';

  @override
  String get subscriptionRemoveAds => 'Jadi Premium untuk hapus iklan';

  @override
  String get subscriptionNoAds => 'Tanpa iklan';

  @override
  String get subscriptionLoadError => 'Gagal memuat data penggunaan';

  @override
  String get subscriptionAdLabel => 'AD';

  @override
  String get subscriptionAdPlaceholder => 'Ad Placeholder';

  @override
  String get subscriptionDevEnvironment => '(Lingkungan pengembangan)';

  @override
  String get subscriptionRemoveAdsUnlock => 'Hapus iklan & buka fitur pro';

  @override
  String get subscriptionUpgradeButton => 'Upgrade';

  @override
  String subscriptionLoadingError(String error) {
    return 'Kesalahan memuat: $error';
  }

  @override
  String get subscriptionCompletePayment =>
      'Selesaikan pembayaran di jendela baru';

  @override
  String subscriptionError(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get subscriptionConfirmDowngrade => 'Konfirmasi downgrade';

  @override
  String get subscriptionDowngradeMessage =>
      'Apakah Anda yakin ingin pindah ke paket Free?\n\nLangganan Anda akan tetap aktif hingga akhir periode saat ini, setelah itu Anda akan otomatis pindah ke paket Free.\n\nAnda tidak akan kehilangan data, tetapi beberapa fitur mungkin akan dibatasi.';

  @override
  String get subscriptionCancel => 'Batal';

  @override
  String get subscriptionConfirmDowngradeButton => 'Konfirmasi downgrade';

  @override
  String get subscriptionCancelled =>
      'Langganan dibatalkan. Akan tetap aktif hingga akhir periode.';

  @override
  String subscriptionPortalError(String error) {
    return 'Kesalahan membuka portal: $error';
  }

  @override
  String get subscriptionRetry => 'Coba lagi';

  @override
  String get subscriptionChooseRightPlan => 'Pilih paket yang tepat untuk Anda';

  @override
  String get subscriptionStartFree => 'Mulai gratis, upgrade kapan saja';

  @override
  String subscriptionPlan(String plan) {
    return 'Paket $plan';
  }

  @override
  String subscriptionPlanName(String plan) {
    return 'Paket Saat Ini: $plan';
  }

  @override
  String subscriptionTrialUntil(String date) {
    return 'Uji coba hingga $date';
  }

  @override
  String subscriptionRenewal(String date) {
    return 'Perpanjangan: $date';
  }

  @override
  String get subscriptionManage => 'Kelola';

  @override
  String get subscriptionLoginRequired =>
      'Silakan login untuk melihat penggunaan';

  @override
  String get subscriptionSuggestion => 'Saran';

  @override
  String get subscriptionSuggestionText =>
      'Upgrade ke Premium untuk membuka lebih banyak proyek, hapus iklan, dan tingkatkan batas. Coba gratis 7 hari!';

  @override
  String get subscriptionPaymentManagement => 'Manajemen pembayaran';

  @override
  String get subscriptionNoActiveSubscription => 'Tidak ada langganan aktif';

  @override
  String get subscriptionUsingFreePlan => 'Anda menggunakan paket Free';

  @override
  String get subscriptionViewPaidPlans => 'Lihat paket berbayar';

  @override
  String get subscriptionPaymentMethod => 'Metode pembayaran';

  @override
  String get subscriptionEditPaymentMethod =>
      'Ubah kartu atau metode pembayaran';

  @override
  String get subscriptionInvoices => 'Faktur';

  @override
  String get subscriptionViewInvoices => 'Lihat dan unduh faktur';

  @override
  String get subscriptionCancelSubscription => 'Batalkan langganan';

  @override
  String get subscriptionAccessUntilEnd =>
      'Akses akan tetap aktif hingga akhir periode';

  @override
  String get subscriptionPaymentHistory => 'Riwayat pembayaran';

  @override
  String get subscriptionNoPayments => 'Tidak ada pembayaran terdaftar';

  @override
  String get subscriptionCompleted => 'Selesai';

  @override
  String get subscriptionDateNotAvailable => 'Tanggal tidak tersedia';

  @override
  String get subscriptionFaq => 'Pertanyaan yang sering diajukan';

  @override
  String get subscriptionFaqCancel => 'Bisakah saya membatalkan kapan saja?';

  @override
  String get subscriptionFaqCancelAnswer =>
      'Ya, Anda dapat membatalkan langganan kapan saja. Akses tetap aktif hingga akhir periode berbayar.';

  @override
  String get subscriptionFaqTrial => 'Bagaimana cara kerja uji coba gratis?';

  @override
  String get subscriptionFaqTrialAnswer =>
      'Dengan uji coba gratis, Anda mendapatkan akses penuh ke semua fitur. Setelah masa uji coba berakhir, langganan berbayar akan dimulai otomatis.';

  @override
  String get subscriptionFaqChange => 'Bisakah saya ganti paket?';

  @override
  String get subscriptionFaqChangeAnswer =>
      'Anda dapat upgrade atau downgrade kapan saja. Biaya akan dihitung secara proporsional.';

  @override
  String get subscriptionFaqData => 'Apakah data saya aman?';

  @override
  String get subscriptionFaqDataAnswer =>
      'Tentu saja. Anda tidak akan kehilangan data meskipun pindah ke paket yang lebih rendah. Beberapa fitur mungkin dibatasi, tapi data tetap dapat diakses.';

  @override
  String get subscriptionStatusActive => 'Aktif';

  @override
  String get subscriptionStatusTrialing => 'Masa uji coba';

  @override
  String get subscriptionStatusPastDue => 'Pembayaran tertunda';

  @override
  String get subscriptionStatusCancelled => 'Dibatalkan';

  @override
  String get subscriptionStatusExpired => 'Kadaluwarsa';

  @override
  String get subscriptionStatusPaused => 'Ditangguhkan';

  @override
  String get subscriptionStatus => 'Status';

  @override
  String get subscriptionStarted => 'Dimulai';

  @override
  String get subscriptionNextRenewal => 'Perpanjangan berikutnya';

  @override
  String get subscriptionTrialEnd => 'Akhir uji coba';

  @override
  String get toolSectionTitle => 'Alat';

  @override
  String get deadlineTitle => 'Tenggat Waktu';

  @override
  String get deadlineNoUpcoming => 'Tidak ada tenggat waktu dekat';

  @override
  String get deadlineAll => 'Semua';

  @override
  String get deadlineToday => 'Hari ini';

  @override
  String get deadlineTomorrow => 'Besok';

  @override
  String get deadlineSprint => 'Sprint';

  @override
  String get deadlineTask => 'Tugas';

  @override
  String get favTitle => 'Favorit';

  @override
  String get favFilterAll => 'Semua';

  @override
  String get favFilterTodo => 'Daftar Todo';

  @override
  String get favFilterMatrix => 'Matriks';

  @override
  String get favFilterProject => 'Proyek';

  @override
  String get favFilterPoker => 'Estimasi';

  @override
  String get actionRemoveFromFavorites => 'Hapus dari favorit';

  @override
  String get favFilterRetro => 'Retro';

  @override
  String get favNoFavorites => 'Tidak ada favorit ditemukan';

  @override
  String get favTypeTodo => 'Daftar Todo';

  @override
  String get favTypeMatrix => 'Matriks Eisenhower';

  @override
  String get favTypeProject => 'Proyek Agile';

  @override
  String get favTypeRetro => 'Retrospektif';

  @override
  String get favTypePoker => 'Planning Poker';

  @override
  String get favTypeTool => 'Alat';

  @override
  String get deadline2Days => '2 Hari';

  @override
  String get deadline3Days => '3 Hari';

  @override
  String get deadline5Days => '5 Hari';

  @override
  String get deadlineConfigTitle => 'Atur Pintasan';

  @override
  String get deadlineConfigDesc =>
      'Pilih interval waktu yang ingin ditampilkan di header.';

  @override
  String get smartTodoClose => 'Tutup';

  @override
  String get smartTodoDone => 'Selesai';

  @override
  String get smartTodoAdd => 'Tambah';

  @override
  String get smartTodoEmailLabel => 'Email';

  @override
  String get exceptionLoginGoogleRequired =>
      'Butuh login Google untuk mengirim email';

  @override
  String get exceptionUserNotAuthenticated => 'Pengguna tidak terautentikasi';

  @override
  String errorLoginFailed(String error) {
    return 'Gagal login: $error';
  }

  @override
  String retroParticipantsTitle(int count) {
    return 'Peserta ($count)';
  }

  @override
  String get actionReopen => 'Buka Kembali';

  @override
  String get retroWaitingForFacilitator =>
      'Menunggu fasilitator memulai sesi...';

  @override
  String get retroGeneratingSheet => 'Sedang membuat Google Sheet...';

  @override
  String get retroExportSuccess => 'Ekspor selesai!';

  @override
  String get retroExportSuccessMessage =>
      'Retrospektif Anda telah diekspor ke Google Sheets.';

  @override
  String get retroExportError => 'Gagal mengekspor ke Sheets.';

  @override
  String get retroReportCopied =>
      'Laporan disalin! Tempelkan di Excel atau Note.';

  @override
  String get retroReopenTitle => 'Buka Kembali Retrospektif';

  @override
  String get retroReopenConfirm =>
      'Apakah Anda yakin? Sesi akan kembali ke tahap Diskusi.';

  @override
  String get errorAuthRequired => 'Butuh autentikasi';

  @override
  String get errorRetroIdMissing => 'ID Retrospektif tidak ada';

  @override
  String get pokerInviteAccepted =>
      'Undangan diterima! Anda akan dialihkan ke sesi.';

  @override
  String get pokerInviteRefused => 'Undangan ditolak';

  @override
  String get pokerConfirmRefuseTitle => 'Tolak Undangan';

  @override
  String get pokerConfirmRefuseContent =>
      'Apakah Anda yakin ingin menolak undangan ini?';

  @override
  String get pokerVerifyingInvite => 'Memverifikasi undangan...';

  @override
  String get actionBackHome => 'Kembali ke Home';

  @override
  String get actionSignin => 'Masuk';

  @override
  String get exceptionStoryNotFound => 'Story tidak ditemukan';

  @override
  String get exceptionNoTasksInProject => 'Tugas tidak ditemukan di proyek';

  @override
  String get exceptionInvitePending =>
      'Sudah ada undangan tertunda untuk email ini';

  @override
  String get exceptionAlreadyParticipant => 'Pengguna sudah menjadi peserta';

  @override
  String get exceptionInviteInvalid => 'Undangan tidak valid atau kadaluwarsa';

  @override
  String get exceptionInviteCalculated => 'Undangan kadaluwarsa';

  @override
  String get exceptionInviteWrongUser =>
      'Undangan ditujukan untuk pengguna lain';

  @override
  String get todoImportTasks => 'Impor Tugas';

  @override
  String get todoExportSheets => 'Ekspor ke Sheets';

  @override
  String get todoDeleteColumnTitle => 'Hapus Kolom';

  @override
  String get todoDeleteColumnConfirm =>
      'Apakah Anda yakin? Tugas di kolom ini akan hilang.';

  @override
  String get exceptionListNotFound => 'Daftar tidak ditemukan';

  @override
  String get langItalian => 'Italia';

  @override
  String get langEnglish => 'Inggris';

  @override
  String get langFrench => 'Prancis';

  @override
  String get langSpanish => 'Spanyol';

  @override
  String get langPortuguese => 'Portugis';

  @override
  String get langRussian => 'Rusia';

  @override
  String get langGerman => 'Jerman';

  @override
  String get langIndonesian => 'Indonesia';

  @override
  String get jsonExportLabel => 'Unduh salinan JSON data Anda';

  @override
  String errorExporting(String error) {
    return 'Gagal ekspor: $error';
  }

  @override
  String get smartTodoViewKanban => 'Kanban';

  @override
  String get smartTodoViewList => 'Daftar';

  @override
  String get smartTodoViewResource => 'Per Sumber Daya';

  @override
  String get smartTodoViewCalendar => 'Calendario';

  @override
  String get smartTodoInviteTooltip => 'Undang';

  @override
  String get smartTodoOptionsTooltip => 'Opsi Lainnya';

  @override
  String get smartTodoActionImport => 'Impor Tugas';

  @override
  String get smartTodoActionExportSheets => 'Ekspor ke Sheets';

  @override
  String get smartTodoDeleteColumnTitle => 'Hapus Kolom';

  @override
  String get smartTodoDeleteColumnContent =>
      'Yakin? Tugas di kolom ini tidak akan terlihat lagi.';

  @override
  String get smartTodoNewColumn => 'Kolom Baru';

  @override
  String get smartTodoColumnNameHint => 'Nama Kolom';

  @override
  String get smartTodoColorLabel => 'WARNA';

  @override
  String get smartTodoMarkAsDone => 'Tandai sudah selesai';

  @override
  String get smartTodoColumnDoneDescription =>
      'Tugas di kolom ini akan dianggap \'Selesai\' (dicoret).';

  @override
  String get smartTodoListSettingsTitle => 'Pengaturan Daftar';

  @override
  String get smartTodoRenameList => 'Ubah Nama Daftar';

  @override
  String get smartTodoManageTags => 'Kelola Tag';

  @override
  String get smartTodoDeleteList => 'Hapus Daftar';

  @override
  String get smartTodoEditPermissionError =>
      'Anda hanya bisa mengubah tugas yang diberikan kepada Anda';

  @override
  String errorDeletingAccount(String error) {
    return 'Gagal menghapus akun: $error';
  }

  @override
  String get errorRecentLoginRequired =>
      'Harus login baru-baru ini. Silakan keluar dan masuk kembali.';

  @override
  String actionGuide(String framework) {
    return 'Panduan $framework';
  }

  @override
  String get actionExportSheets => 'Ekspor ke Google Sheets';

  @override
  String get actionAuditLog => 'Audit Log';

  @override
  String get actionInviteMember => 'Undang Anggota';

  @override
  String get actionSettings => 'Pengaturan';

  @override
  String get retroSelectIcebreakerTooltip => 'Pilih aktivitas icebreaker';

  @override
  String get retroIcebreakerLabel => 'Aktivitas awal';

  @override
  String get retroTimePhasesOptional => 'Timer Tahap (Opsional)';

  @override
  String get retroTimePhasesDesc => 'Atur durasi per menit untuk setiap tahap:';

  @override
  String get retroIcebreakerSectionTitle => 'Icebreaker';

  @override
  String get retroBoardTitle => 'Papan Retrospektif';

  @override
  String get searchPlaceholder => 'Cari di mana saja...';

  @override
  String get searchResultsTitle => 'Hasil Pencarian';

  @override
  String searchNoResults(Object query) {
    return 'Tidak ada hasil untuk \'$query\'';
  }

  @override
  String get searchResultTypeProject => 'Proyek';

  @override
  String get searchResultTypeTodo => 'Daftar ToDo';

  @override
  String get searchResultTypeRetro => 'Retrospektif';

  @override
  String get searchResultTypeEisenhower => 'Matriks Eisenhower';

  @override
  String get searchResultTypeEstimation => 'Ruang Estimasi';

  @override
  String get searchBackToDashboard => 'Kembali ke Dashboard';

  @override
  String get smartTodoAddItem => 'Tambah item';

  @override
  String get smartTodoAddImageUrl => 'Tambah Gambar (URL)';

  @override
  String get smartTodoNone => 'Tidak ada';

  @override
  String get smartTodoPointsHint => 'Poin (misal: 5)';

  @override
  String get smartTodoNewItem => 'Item baru';

  @override
  String get smartTodoDeleteComment => 'Hapus';

  @override
  String get priorityHigh => 'TINGGI';

  @override
  String get priorityMedium => 'SEDANG';

  @override
  String get priorityLow => 'RENDAH';

  @override
  String get exportToEstimation => 'Kirim ke Estimasi';

  @override
  String get exportToEstimationDesc => 'Buat sesi estimasi dengan tugas ini';

  @override
  String get exportToEisenhower => 'Kirim ke Eisenhower';

  @override
  String get exportToEisenhowerDesc =>
      'Buat matriks Eisenhower dengan tugas ini';

  @override
  String get selectTasksToExport => 'Pilih Tugas';

  @override
  String get selectTasksToExportDesc => 'Pilih tugas yang ingin disertakan';

  @override
  String get noTasksSelected => 'Tidak ada tugas terpilih';

  @override
  String get selectAtLeastOne => 'Pilih minimal satu tugas';

  @override
  String get createEstimationSession => 'Buat Sesi Estimasi';

  @override
  String tasksSelectedCount(int count) {
    return '$count tugas terpilih';
  }

  @override
  String get exportSuccess => 'Berhasil diekspor';

  @override
  String get exportFromEstimation => 'Ekspor ke Daftar';

  @override
  String get exportFromEstimationDesc =>
      'Ekspor story terestimasi ke daftar Smart Todo';

  @override
  String get selectDestinationList => 'Pilih daftar tujuan';

  @override
  String get createNewList => 'Buat daftar baru';

  @override
  String get existingList => 'Daftar yang ada';

  @override
  String get listName => 'Nama daftar';

  @override
  String get listNameHint => 'Masukkan nama untuk daftar baru';

  @override
  String get selectList => 'Pilih daftar';

  @override
  String get selectListHint => 'Pilih satu daftar';

  @override
  String get noListsAvailable =>
      'Daftar tidak tersedia. Akan dibuat daftar baru.';

  @override
  String storiesSelectedCount(int count) {
    return '$count story terpilih';
  }

  @override
  String get selectAll => 'Pilih semua';

  @override
  String get deselectAll => 'Batalkan pilihan semua';

  @override
  String get importStories => 'Impor Story';

  @override
  String storiesImportedCount(int count) {
    return '$count story diimpor';
  }

  @override
  String get noEstimatedStories =>
      'Tidak ada story dengan estimasi untuk diimpor';

  @override
  String get selectDestinationMatrix => 'Pilih Matriks Tujuan';

  @override
  String get existingMatrix => 'Matriks yang Ada';

  @override
  String get createNewMatrix => 'Buat Matriks Baru';

  @override
  String get matrixName => 'Nama Matriks';

  @override
  String get matrixNameHint => 'Masukkan nama untuk matriks baru';

  @override
  String get selectMatrix => 'Pilih Matriks';

  @override
  String get selectMatrixHint => 'Pilih matriks tujuan';

  @override
  String get noMatricesAvailable =>
      'Tidak ada matriks tersedia. Buat yang baru.';

  @override
  String activitiesCreated(int count) {
    return '$count aktivitas dibuat';
  }

  @override
  String get importFromEisenhower => 'Impor dari Eisenhower';

  @override
  String get importFromEisenhowerDesc =>
      'Tambahkan tugas yang diprioritaskan ke daftar ini';

  @override
  String get quadrantQ1 => 'Mendesak & Penting';

  @override
  String get quadrantQ2 => 'Tidak Mendesak & Penting';

  @override
  String get quadrantQ3 => 'Mendesak & Tidak Penting';

  @override
  String get quadrantQ4 => 'Tidak Mendesak & Tidak Penting';

  @override
  String get warningQ4Tasks =>
      'Tugas Q4 biasanya tidak sebanding dengan usahanya. Anda yakin?';

  @override
  String get priorityMappingInfo =>
      'Pemetaan prioritas: Q1=Tinggi, Q2=Sedang, Q3/Q4=Rendah';

  @override
  String get selectColumns => 'Pilih Kolom';

  @override
  String get allTasks => 'Semua Tugas';

  @override
  String get filterByColumn => 'Filter berdasarkan kolom';

  @override
  String get exportFromEisenhower => 'Kirim ke daftar Todo';

  @override
  String get exportFromEisenhowerDesc =>
      'Pilih aktivitas untuk diekspor ke Smart Todo';

  @override
  String get filterByQuadrant => 'Filter berdasarkan kuadran:';

  @override
  String get allActivities => 'Semua';

  @override
  String activitiesSelectedCount(int count) {
    return '$count aktivitas terpilih';
  }

  @override
  String get noActivitiesSelected => 'Tidak ada aktivitas di filter ini';

  @override
  String get unvoted => 'BELUM DIVOTING';

  @override
  String tasksCreated(int count) {
    return '$count tugas dibuat';
  }

  @override
  String get exportToUserStories => 'Kirim ke proyek Agile';

  @override
  String get exportToUserStoriesDesc =>
      'Kirim user stories ke sebuah proyek Agile';

  @override
  String get selectDestinationProject => 'Pilih Proyek Tujuan';

  @override
  String get existingProject => 'Proyek yang Ada';

  @override
  String get createNewProject => 'Buat Proyek Baru';

  @override
  String get projectName => 'Nama Proyek';

  @override
  String get projectNameHint => 'Masukkan nama untuk proyek baru';

  @override
  String get selectProject => 'Pilih Proyek';

  @override
  String get selectProjectHint => 'Tentukan proyek tujuan';

  @override
  String get noProjectsAvailable =>
      'Tidak ada proyek tersedia. Buat yang baru.';

  @override
  String get userStoryFieldMappingInfo =>
      'Pemetaan: Judul → Judul story, Deskripsi → Deskripsi, Effort → Story points, Prioritas → Business value';

  @override
  String storiesCreated(int count) {
    return '$count story dibuat';
  }

  @override
  String get configureNewProject => 'Konfigurasi Proyek Baru';

  @override
  String get exportToAgileSprint => 'Kirim ke Sprint';

  @override
  String get actionSend => 'Kirim';

  @override
  String get exportToAgileSprintDesc =>
      'Tambahkan story terestimasi ke proyek Agile';

  @override
  String get selectSprint => 'Pilih Sprint';

  @override
  String get selectSprintHint => 'Pilih sprint tujuan';

  @override
  String get noSprintsAvailable =>
      'Tidak ada sprint tersedia. Buat sprint terlebih dahulu di perencanaan.';

  @override
  String get sprintExportFieldMappingInfo =>
      'Pemetaan: Judul → Judul story, Deskripsi → Deskripsi, Estimasi → Story points';

  @override
  String get exportToSprint => 'Ekspor ke Proyek Agile';

  @override
  String totalStoryPoints(int count) {
    return 'Total $count story points';
  }

  @override
  String storiesAddedToSprint(int count, String sprintName) {
    return '$count story ditambahkan ke $sprintName';
  }

  @override
  String storiesAddedToProject(int count, String projectName) {
    return '$count story ditambahkan ke proyek $projectName';
  }

  @override
  String get exportEisenhowerToSprintDesc =>
      'Ubah aktivitas Eisenhower menjadi User Stories di proyek Agile';

  @override
  String get exportEisenhowerToEstimationDesc =>
      'Buat sesi estimasi dari aktivitas';

  @override
  String get selectedActivities => 'aktivitas terpilih';

  @override
  String get noActivitiesToExport => 'Tidak ada aktivitas untuk diekspor';

  @override
  String get hiddenQ4Activities => 'Tersembunyi';

  @override
  String get q4Activities => 'aktivitas Q4 (Eliminasi)';

  @override
  String get showQ4 => 'Tampilkan Q4';

  @override
  String get hideQ4 => 'Sembunyikan Q4';

  @override
  String get showingAllActivities => 'Menampilkan semua aktivitas';

  @override
  String get eisenhowerMappingInfo =>
      'Q1→Must, Q2→Should, Q3→Could, Q4→Won\'t. Penting → Business Value.';

  @override
  String get estimationExportInfo =>
      'Aktivitas akan ditambahkan sebagai story yang akan diestimasi. Aktivitas Q4 tidak akan dipindahkan.';

  @override
  String get createSession => 'Buat Sesi';

  @override
  String get estimationType => 'Tipe estimasi';

  @override
  String activitiesAddedToSprint(int count, String sprintName) {
    return '$count aktivitas ditambahkan ke $sprintName';
  }

  @override
  String activitiesAddedToProject(int count, String projectName) {
    return '$count aktivitas ditambahkan ke proyek $projectName';
  }

  @override
  String estimationSessionCreated(int count) {
    return 'Sesi estimasi dibuat dengan $count aktivitas';
  }

  @override
  String activitiesExportedToSprint(int count, String sprintName) {
    return '$count aktivitas diekspor ke sprint $sprintName';
  }

  @override
  String activitiesExportedToEstimation(int count, String sessionName) {
    return '$count aktivitas diekspor ke sesi estimasi $sessionName';
  }

  @override
  String get archiveAction => 'Arsipkan';

  @override
  String get archiveRestoreAction => 'Pulihkan';

  @override
  String get archiveShowArchived => 'Tampilkan yang Diarsipkan';

  @override
  String get archiveHideArchived => 'Sembunyikan yang Diarsipkan';

  @override
  String archiveConfirmTitle(String itemType) {
    return 'Arsipkan $itemType';
  }

  @override
  String get archiveConfirmMessage =>
      'Apakah Anda yakin ingin mengarsipkan item ini? Ini dapat dipulihkan nanti.';

  @override
  String archiveRestoreConfirmTitle(String itemType) {
    return 'Pulihkan $itemType';
  }

  @override
  String get archiveRestoreConfirmMessage =>
      'Apakah Anda ingin memulihkan item ini dari arsip?';

  @override
  String get archiveSuccessMessage => 'Proyek diarsipkan';

  @override
  String get archiveRestoreSuccessMessage => 'Proyek dipulihkan';

  @override
  String get archiveErrorMessage => 'Gagal mengarsipkan proyek';

  @override
  String get archiveRestoreErrorMessage => 'Gagal memulihkan proyek';

  @override
  String get archiveFilterLabel => 'Arsip';

  @override
  String get archiveFilterActive => 'Aktif';

  @override
  String get archiveFilterArchived => 'Diarsipkan';

  @override
  String get archiveFilterAll => 'Semua';

  @override
  String get archiveBadge => 'ARSIP';

  @override
  String get archiveEmptyMessage => 'Tidak ada item yang diarsipkan';

  @override
  String get completeAction => 'Selesaikan';

  @override
  String get reopenAction => 'Buka Kembali';

  @override
  String completeConfirmTitle(String itemType) {
    return 'Selesaikan $itemType';
  }

  @override
  String get completeConfirmMessage =>
      'Apakah Anda yakin ingin menyelesaikan item ini?';

  @override
  String get completeSuccessMessage => 'Item berhasil diselesaikan';

  @override
  String get reopenSuccessMessage => 'Item berhasil dibuka kembali';

  @override
  String get completedBadge => 'Selesai';

  @override
  String get inviteNewInvite => 'UNDANGAN BARU';

  @override
  String get inviteRole => 'Peran:';

  @override
  String get inviteSendEmailNotification => 'Kirim notifikasi email';

  @override
  String get inviteSendInvite => 'Kirim Undangan';

  @override
  String get inviteLink => 'Link undangan:';

  @override
  String get inviteList => 'UNDANGAN';

  @override
  String get inviteResend => 'Kirim ulang';

  @override
  String get inviteRevokeMessage => 'Undangan tidak akan berlaku lagi.';

  @override
  String get inviteResent => 'Undangan dikirim ulang';

  @override
  String inviteSentByEmail(String email) {
    return 'Undangan dikirim via email ke $email';
  }

  @override
  String get inviteStatusPending => 'Tertunda';

  @override
  String get inviteStatusAccepted => 'Diterima';

  @override
  String get inviteStatusDeclined => 'Ditolak';

  @override
  String get inviteStatusExpired => 'Kadaluwarsa';

  @override
  String get inviteStatusRevoked => 'Dicabut';

  @override
  String get inviteGmailAuthTitle => 'Otorisasi Gmail';

  @override
  String get inviteGmailAuthMessage =>
      'Untuk mengirim email undangan, Anda perlu autentikasi ulang dengan Google.\n\nLanjutkan?';

  @override
  String get inviteGmailAuthNo => 'Tidak, link saja';

  @override
  String get inviteGmailAuthYes => 'Otorisasi';

  @override
  String get inviteGmailNotAvailable =>
      'Otorisasi Gmail tidak tersedia. Coba logout dan login kembali.';

  @override
  String get inviteGmailNoPermission => 'Izin Gmail tidak diberikan.';

  @override
  String get inviteEnterEmail => 'Masukkan email';

  @override
  String get inviteInvalidEmail => 'Email tidak valid';

  @override
  String get pendingInvites => 'Undangan Tertunda';

  @override
  String get noPendingInvites => 'Tidak ada undangan tertunda';

  @override
  String invitedBy(String name) {
    return 'Diundang oleh $name';
  }

  @override
  String get inviteOpenInstance => 'Buka';

  @override
  String get inviteAcceptFirst => 'Terima undangan untuk membuka';

  @override
  String get inviteAccept => 'Terima';

  @override
  String get inviteDecline => 'Tolak';

  @override
  String get inviteAcceptedSuccess => 'Undangan berhasil diterima!';

  @override
  String get inviteAcceptedError => 'Gagal menerima undangan';

  @override
  String get inviteDeclinedSuccess => 'Undangan ditolak';

  @override
  String get inviteDeclinedError => 'Gagal menolak undangan';

  @override
  String get inviteDeclineTitle => 'Tolak undangan?';

  @override
  String get inviteDeclineMessage =>
      'Apakah Anda yakin ingin menolak undangan ini?';

  @override
  String expiresInHours(int hours) {
    return 'Kadaluwarsa dalam ${hours}j';
  }

  @override
  String expiresInDays(int days) {
    return 'Kadaluwarsa dalam ${days}h';
  }

  @override
  String get close => 'Tutup';

  @override
  String get cancel => 'Batal';

  @override
  String get raciTitle => 'Matriks RACI';

  @override
  String get raciNoActivities => 'Tidak ada aktivitas tersedia';

  @override
  String get raciAddActivity => 'Tambah Aktivitas';

  @override
  String get raciAddColumn => 'Tambah Kolom';

  @override
  String get raciActivities => 'AKTIVITAS';

  @override
  String get raciAssignRole => 'Berikan peran';

  @override
  String get raciNone => 'Tidak ada';

  @override
  String get raciSaving => 'Menyimpan...';

  @override
  String get raciSaveChanges => 'Simpan Perubahan';

  @override
  String get raciSavedSuccessfully => 'Perubahan berhasil disimpan';

  @override
  String get raciErrorSaving => 'Gagal menyimpan';

  @override
  String get raciMissingAccountable => 'Accountable (A) tidak ada';

  @override
  String get raciOnlyOneAccountable => 'Hanya satu Accountable per aktivitas';

  @override
  String get raciDuplicateRoles => 'Peran duplikat';

  @override
  String get raciNoResponsible => 'Tidak ada Responsible (R) yang ditugaskan';

  @override
  String get raciTooManyInformed =>
      'Terlalu banyak Informed (I): pertimbangkan untuk melirik kembali';

  @override
  String get raciNewColumn => 'Kolom Baru';

  @override
  String get raciRemoveColumn => 'Hapus kolom';

  @override
  String raciRemoveColumnConfirm(String name) {
    return 'Hapus kolom \"$name\"? Semua penugasan peran untuk kolom ini akan dihapus.';
  }

  @override
  String get votingDialogTitle => 'Voting';

  @override
  String votingDialogVoteOf(String participant) {
    return 'Voting $participant';
  }

  @override
  String get votingDialogUrgency => 'URGENSI';

  @override
  String get votingDialogImportance => 'PENTINGNYA';

  @override
  String get votingDialogNotUrgent => 'Tidak mendesak';

  @override
  String get votingDialogVeryUrgent => 'Sangat mendesak';

  @override
  String get votingDialogNotImportant => 'Tidak penting';

  @override
  String get votingDialogVeryImportant => 'Sangat penting';

  @override
  String get votingDialogConfirmVote => 'Konfirmasi Voting';

  @override
  String get votingDialogQuadrant => 'Kuadran:';

  @override
  String get voteCollectionTitle => 'Kumpulkan Voting';

  @override
  String get voteCollectionParticipants => 'peserta';

  @override
  String get voteCollectionResult => 'Hasil:';

  @override
  String get voteCollectionAverage => 'Rata-rata:';

  @override
  String get voteCollectionSaveVotes => 'Simpan Voting';

  @override
  String get scatterChartTitle => 'Distribusi Aktivitas';

  @override
  String get scatterChartNoActivities => 'Tidak ada aktivitas yang divoting';

  @override
  String get scatterChartVoteToShow =>
      'Voting aktivitas untuk melihatnya di grafik';

  @override
  String get scatterChartUrgencyLabel => 'Urgensi:';

  @override
  String get scatterChartImportanceLabel => 'Pentingnya:';

  @override
  String get scatterChartAxisUrgency => 'URGENSI';

  @override
  String get scatterChartAxisImportance => 'PENTINGNYA';

  @override
  String get scatterChartQ1Label => 'Q1 - LAKUKAN';

  @override
  String get scatterChartQ2Label => 'Q2 - RENCANAKAN';

  @override
  String get scatterChartQ3Label => 'Q3 - DELEGASIKAN';

  @override
  String get scatterChartQ4Label => 'Q4 - ELIMINASI';

  @override
  String get scatterChartCardTitle => 'Grafik Distribusi';

  @override
  String get votingStatusYou => 'Anda';

  @override
  String get votingStatusReset => 'Reset';

  @override
  String get estimationDecimalHintPlaceholder => 'Misal: 2.5';

  @override
  String get estimationDecimalSuffixDays => 'hari';

  @override
  String get estimationDecimalVote => 'Voting';

  @override
  String estimationDecimalVoteValue(String value) {
    return 'Voting: $value hari';
  }

  @override
  String get estimationDecimalQuickSelect => 'Pilih cepat:';

  @override
  String get estimationDecimalEnterValue => 'Masukkan nilai';

  @override
  String get estimationDecimalInvalidValue => 'Nilai tidak valid';

  @override
  String estimationDecimalMinValue(String value) {
    return 'Min: $value';
  }

  @override
  String estimationDecimalMaxValue(String value) {
    return 'Max: $value';
  }

  @override
  String get estimationThreePointTitle => 'Estimasi Tiga Titik (PERT)';

  @override
  String get estimationThreePointOptimistic => 'Optimis (O)';

  @override
  String get estimationThreePointRealistic => 'Realistis (M)';

  @override
  String get estimationThreePointPessimistic => 'Pesimis (P)';

  @override
  String get estimationThreePointBestCase => 'Kasus terbaik';

  @override
  String get estimationThreePointMostLikely => 'Paling mungkin';

  @override
  String get estimationThreePointWorstCase => 'Kasus terburuk';

  @override
  String get estimationThreePointAllFieldsRequired =>
      'Semua bidang wajib diisi';

  @override
  String get estimationThreePointInvalidValues => 'Nilai tidak valid';

  @override
  String get estimationThreePointOptMustBeLteReal =>
      'Optimis harus <= Realistis';

  @override
  String get estimationThreePointRealMustBeLtePess =>
      'Realistis harus <= Pesimis';

  @override
  String get estimationThreePointOptMustBeLtePess => 'Optimis harus <= Pesimis';

  @override
  String get estimationThreePointGuide => 'Panduan:';

  @override
  String get estimationThreePointGuideO =>
      'O: Estimasi dalam kasus terbaik (semua lancar)';

  @override
  String get estimationThreePointGuideM =>
      'M: Estimasi paling mungkin (kondisi normal)';

  @override
  String get estimationThreePointGuideP =>
      'P: Estimasi dalam kasus terburuk (hal tak terduga)';

  @override
  String get estimationThreePointStdDev => 'Dev. Std';

  @override
  String get estimationThreePointDaysSuffix => 'hari';

  @override
  String get storyFormNewStory => 'Story Baru';

  @override
  String get storyFormEnterTitle => 'Masukkan judul';

  @override
  String get sessionSearchHint => 'Cari sesi...';

  @override
  String get sessionSearchFilters => 'Filter';

  @override
  String get sessionSearchFiltersTooltip => 'Filter';

  @override
  String get sessionSearchStatusLabel => 'Status: ';

  @override
  String get sessionSearchStatusAll => 'Semua';

  @override
  String get sessionSearchStatusDraft => 'Draf';

  @override
  String get sessionSearchStatusActive => 'Aktif';

  @override
  String get sessionSearchStatusCompleted => 'Selesai';

  @override
  String get sessionSearchModeLabel => 'Mode: ';

  @override
  String get sessionSearchModeAll => 'Semua';

  @override
  String get sessionSearchRemoveFilters => 'Hapus filter';

  @override
  String get sessionSearchActiveFilters => 'Filter aktif:';

  @override
  String get sessionSearchRemoveAllFilters => 'Hapus semua';

  @override
  String participantsTitle(int count) {
    return 'Peserta ($count)';
  }

  @override
  String get participantRoleFacilitator => 'Fasilitator';

  @override
  String get participantRoleVoters => 'Pemilih';

  @override
  String get participantRoleObservers => 'Pengamat';

  @override
  String get votingBoardVotesRevealed => 'Hasil Voting Dibuka';

  @override
  String get votingBoardVotingInProgress => 'Voting Sedang Berlangsung';

  @override
  String votingBoardVotesCount(int voted, int total) {
    return '$voted/$total voting';
  }

  @override
  String get estimationSelectYourEstimate => 'Pilih estimasi Anda';

  @override
  String estimationVoteSelected(String value) {
    return 'Voting terpilih: $value';
  }

  @override
  String get estimationDotVotingTitle => 'Dot Voting';

  @override
  String get estimationDotVotingDesc =>
      'Mode voting dengan alokasi poin.\nSegera hadir...';

  @override
  String get estimationBucketSystemTitle => 'Bucket System';

  @override
  String get estimationBucketSystemDesc =>
      'Estimasi berdasarkan afinitas dengan pengelompokan.\nSegera hadir...';

  @override
  String get estimationModeTitle => 'Mode Estimasi';

  @override
  String get statisticsTitle => 'Statistik Voting';

  @override
  String get statisticsAverage => 'Rata-rata';

  @override
  String get statisticsMedian => 'Median';

  @override
  String get statisticsMode => 'Modus';

  @override
  String get statisticsVoters => 'Pemilih';

  @override
  String get statisticsPertStats => 'Statistik PERT';

  @override
  String get statisticsPertAvg => 'Rata-rata PERT';

  @override
  String get statisticsStdDev => 'Dev. Std';

  @override
  String get statisticsVariance => 'Varians';

  @override
  String get statisticsRange => 'Rentang:';

  @override
  String get statisticsConsensusReached => 'Konsensus tercapai!';

  @override
  String get retroGuideTooltip => 'Panduan Retrospektif';

  @override
  String get retroSearchPlaceholder => 'Cari retrospektif...';

  @override
  String get retroNoSearchResults => 'Tidak ada hasil pencarian';

  @override
  String get retroNewRetro => 'Retrospektif Baru';

  @override
  String get retroNoProjectsFound => 'Tidak ada proyek ditemukan.';

  @override
  String retroDeleteMessage(String retroName) {
    return 'Apakah Anda yakin ingin menghapus permanen retrospektif \"$retroName\"?\n\nTindakan ini tidak dapat dibatalkan dan akan menghapus semua data terkait (kartu, voting, item tindakan).';
  }

  @override
  String get retroDeletePermanently => 'Hapus permanen';

  @override
  String get retroDeletedSuccess => 'Retrospektif berhasil dihapus';

  @override
  String retroDeleteActionItemsWarning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ini juga akan menghapus $count item tindakan terkait.',
      one: 'Ini juga akan menghapus 1 item tindakan terkait.',
    );
    return '$_temp0';
  }

  @override
  String get actionIrreversible => 'Tindakan ini tidak dapat dibatalkan.';

  @override
  String get lessonsLearnedSearchPlaceholder => 'Cari pelajaran...';

  @override
  String errorPrefix(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get loaderProjectIdMissing => 'ID proyek tidak ada';

  @override
  String get loaderProjectNotFound => 'Proyek tidak ditemukan';

  @override
  String get loaderLoadError => 'Gagal memuat';

  @override
  String get loaderError => 'Kesalahan';

  @override
  String get loaderUnknownError => 'Kesalahan tidak diketahui';

  @override
  String get actionGoBack => 'Kembali';

  @override
  String get authRequired => 'Butuh autentikasi';

  @override
  String get retroIdMissing => 'ID retrospektif tidak ada';

  @override
  String get pokerInviteStatusAccepted => 'sudah diterima';

  @override
  String get pokerInviteStatusDeclined => 'telah ditolak';

  @override
  String get pokerInviteStatusExpired => 'telah kadaluwarsa';

  @override
  String get pokerInviteStatusRevoked => 'telah dicabut';

  @override
  String get pokerInviteStatusPending => 'sedang menunggu';

  @override
  String get pokerInviteYouAreInvited => 'Anda Diundang!';

  @override
  String pokerInviteInvitedBy(String name) {
    return '$name mengundang Anda untuk berpartisipasi';
  }

  @override
  String get pokerInviteSessionLabel => 'Sesi';

  @override
  String get pokerInviteProjectLabel => 'Proyek';

  @override
  String get pokerInviteRoleLabel => 'Peran Ditugaskan';

  @override
  String get pokerInviteExpiryLabel => 'Kadaluwarsa Undangan';

  @override
  String pokerInviteExpiryDays(int days) {
    return 'Dalam $days hari';
  }

  @override
  String get pokerInviteDecline => 'Tolak';

  @override
  String get pokerInviteAccept => 'Terima Undangan';

  @override
  String loadingMatrixError(String error) {
    return 'Gagal memuat matriks: $error';
  }

  @override
  String loadingDataError(String error) {
    return 'Gagal memuat data: $error';
  }

  @override
  String loadingActivitiesError(String error) {
    return 'Gagal memuat aktivitas: $error';
  }

  @override
  String smartTodoSprintDays(int days) {
    return '$days hari/sprint';
  }

  @override
  String smartTodoHoursPerDay(int hours) {
    return '${hours}j/hari';
  }

  @override
  String get smartTodoImageFromClipboardFound =>
      'Gambar ditemukan di clipboard';

  @override
  String get smartTodoAddImageFromClipboard => 'Tambah gambar dari clipboard';

  @override
  String get smartTodoInviteCreatedAndSent => 'Undangan dibuat dan dikirim';

  @override
  String get retroColumnDropDesc =>
      'Apa yang tidak memberi nilai dan harus dihapus?';

  @override
  String get retroColumnAddDesc =>
      'Praktik baru apa yang harus kita perkenalkan?';

  @override
  String get retroColumnKeepDesc =>
      'Apa yang berjalan baik dan harus dipertahankan?';

  @override
  String get retroColumnImproveDesc => 'Apa yang bisa kita lakukan lebih baik?';

  @override
  String get retroColumnStart => 'Mulai';

  @override
  String get retroColumnStartDesc =>
      'Aktivitas atau proses baru apa yang harus kita mulai untuk meningkat?';

  @override
  String get retroColumnStop => 'Berhenti';

  @override
  String get retroColumnStopDesc =>
      'Apa yang tidak memberi nilai dan harus kita hentikan?';

  @override
  String get retroColumnContinue => 'Lanjutkan';

  @override
  String get retroColumnContinueDesc =>
      'Apa yang berjalan baik dan harus terus kita lakukan?';

  @override
  String get retroColumnLongedFor => 'Diinginkan';

  @override
  String get retroColumnLikedDesc => 'Apa yang Anda sukai dari sprint ini?';

  @override
  String get retroColumnLearnedDesc => 'Apa hal baru yang Anda pelajari?';

  @override
  String get retroColumnLackedDesc => 'Apa yang kurang dalam sprint ini?';

  @override
  String get retroColumnLongedForDesc =>
      'Apa yang Anda harapkan di masa depan?';

  @override
  String get retroColumnMadDesc =>
      'Apa yang membuat Anda marah atau frustrasi?';

  @override
  String get retroColumnSadDesc => 'Apa yang membuat Anda kecewa atau sedih?';

  @override
  String get retroColumnGladDesc => 'Apa yang membuat Anda senang atau puas?';

  @override
  String get retroColumnWindDesc =>
      'Apa yang mendorong kita maju? Kekuatan dan dukungan.';

  @override
  String get retroColumnAnchorDesc =>
      'Apa yang memperlambat kita? Hambatan dan blokade.';

  @override
  String get retroColumnRockDesc =>
      'Risiko masa depan apa yang kita lihat di cakrawala?';

  @override
  String get retroColumnGoalDesc => 'Apa tujuan ideal kita?';

  @override
  String get retroColumnMoreDesc => 'Apa yang harus kita lakukan lebih banyak?';

  @override
  String get retroColumnLessDesc =>
      'Apa yang harus kita lakukan lebih sedikit?';

  @override
  String get actionTypeMaintain => 'Pertahankan';

  @override
  String get actionTypeStop => 'Hentikan';

  @override
  String get actionTypeBegin => 'Mulai';

  @override
  String get actionTypeIncrease => 'Tingkatkan';

  @override
  String get actionTypeDecrease => 'Kurangi';

  @override
  String get actionTypePrevent => 'Cegah';

  @override
  String get actionTypeCelebrate => 'Rayakan';

  @override
  String get actionTypeReplicate => 'Duplikasi';

  @override
  String get actionTypeShare => 'Bagikan';

  @override
  String get actionTypeProvide => 'Sediakan';

  @override
  String get actionTypePlan => 'Rencanakan';

  @override
  String get actionTypeLeverage => 'Manfaatkan';

  @override
  String get actionTypeRemove => 'Hapus';

  @override
  String get actionTypeMitigate => 'Mitigasi';

  @override
  String get actionTypeAlign => 'Selaraskan';

  @override
  String get actionTypeEliminate => 'Eliminasi';

  @override
  String get actionTypeImplement => 'Implementasikan';

  @override
  String get actionTypeEnhance => 'Tingkatkan';

  @override
  String get actionItemStatus => 'Status';

  @override
  String get actionStatusOpen => 'Terbuka';

  @override
  String get actionStatusInProgress => 'Dalam Proses';

  @override
  String get actionStatusCompleted => 'Selesai';

  @override
  String get actionStatusDeferred => 'Ditunda';

  @override
  String get retroSectionActive => 'Aktif';

  @override
  String get retroSectionHistory => 'Riwayat';

  @override
  String get retroSectionActionTracker => 'Item Tindakan';

  @override
  String get retroSectionLessonsLearned => 'Pelajaran Terpetik';

  @override
  String get retroNoActiveRetro => 'Tidak ada retrospektif aktif';

  @override
  String get retroStartNew => 'Retrospektif Baru';

  @override
  String get retroHistoryEmpty => 'Tidak ada retrospektif yang selesai';

  @override
  String get retroViewSummary => 'Lihat Ringkasan';

  @override
  String get retroSummaryTitle => 'Ringkasan Retrospektif';

  @override
  String retroSummaryCards(Object count) {
    return 'Kartu ($count)';
  }

  @override
  String retroSummaryActions(Object count) {
    return 'Item Tindakan ($count)';
  }

  @override
  String get retroSummarySentiment => 'Sentimen Tim';

  @override
  String get actionTrackerTitle => 'Pelacak Item Tindakan';

  @override
  String get actionTrackerEmpty => 'Tidak ada item tindakan di retrospektif';

  @override
  String get actionTrackerFilterByAssignee =>
      'Filter berdasarkan penerima tugas';

  @override
  String get actionTrackerFilterByStatus => 'Filter berdasarkan status';

  @override
  String get actionTrackerFilterByRetro => 'Filter berdasarkan retrospektif';

  @override
  String get actionTrackerCompletionRate => 'Tingkat Penyelesaian';

  @override
  String get actionTrackerCarryForward => 'Teruskan';

  @override
  String get actionTrackerCarryForwardDesc =>
      'Item tindakan dari retrospektif sebelumnya ini masih terbuka:';

  @override
  String get actionTrackerCarryForwardConfirm => 'Teruskan item terpilih';

  @override
  String get lessonsLearnedTitle => 'Daftar Pelajaran Terpetik';

  @override
  String get lessonsLearnedEmpty =>
      'Tidak ada pelajaran terpetik yang tercatat';

  @override
  String get lessonsLearnedCreate => 'Tambah Pelajaran Terpetik';

  @override
  String get lessonsLearnedEdit => 'Ubah Pelajaran Terpetik';

  @override
  String get lessonsLearnedDelete => 'Hapus Pelajaran Terpetik';

  @override
  String get lessonsLearnedDeleteConfirm =>
      'Yakin ingin menghapus pelajaran ini?';

  @override
  String get lessonCategoryProcess => 'Proses';

  @override
  String get lessonCategoryTechnical => 'Teknis';

  @override
  String get lessonCategoryTeam => 'Tim';

  @override
  String get lessonCategoryCommunication => 'Komunikasi';

  @override
  String get lessonCategoryTools => 'Alat';

  @override
  String get lessonCategoryQuality => 'Kualitas';

  @override
  String get lessonCategoryEstimation => 'Estimasi';

  @override
  String get lessonTypeStrength => 'Kekuatan';

  @override
  String get lessonTypeWeakness => 'Kelemahan';

  @override
  String get lessonTypeRecommendation => 'Rekomendasi';

  @override
  String get lessonFieldTitle => 'Judul';

  @override
  String get lessonFieldDescription => 'Deskripsi';

  @override
  String get lessonFieldRootCause => 'Penyebab Utama';

  @override
  String get lessonFieldRecommendation => 'Rekomendasi';

  @override
  String get lessonFieldTags => 'Tag';

  @override
  String get lessonIsRecurring => 'Pola Berulang';

  @override
  String lessonOccurrenceCount(Object count) {
    return 'Muncul: $count';
  }

  @override
  String get lessonIsResolved => 'Terselesaikan';

  @override
  String get generateLessonsTitle => 'Hasilkan Pelajaran Terpetik';

  @override
  String get generateLessonsDesc =>
      'Tinjau wawasan dari retrospektif ini dan simpan sebagai pelajaran terpetik.';

  @override
  String get generateLessonsFromCards => 'Disarankan dari kartu';

  @override
  String get generateLessonsFromActions => 'Disarankan dari item tindakan';

  @override
  String get generateLessonsSelectToSave => 'Pilih item yang ingin disimpan';

  @override
  String get generateLessonsSave => 'Simpan Pelajaran Terpilih';

  @override
  String get retroTrendTitle => 'Tren Peningkatan Tim';

  @override
  String get retroTrendSentiment => 'Sentimen Seiring Waktu';

  @override
  String get retroTrendActionCompletion => 'Tingkat Penyelesaian Tindakan';

  @override
  String get retroTrendImproving => 'Tim sedang meningkat!';

  @override
  String get retroTrendStable => 'Performa stabil';

  @override
  String get retroTrendDeclining => 'Perlu perhatian';

  @override
  String get crossProjectImport => 'Impor dari Proyek Lain';

  @override
  String get crossProjectImportActions => 'Impor Item Tindakan';

  @override
  String get crossProjectImportLessons => 'Impor Pelajaran Terpetik';

  @override
  String get crossProjectSelectProject => 'Pilih Proyek';

  @override
  String get crossProjectNoProjects => 'Tidak ada proyek lain ditemukan';

  @override
  String crossProjectImportSuccess(Object count) {
    return '$count item berhasil diimpor';
  }

  @override
  String get crossProjectAggregatedView => 'Pelajaran Lintas Proyek';

  @override
  String get tooltipTrackerStatusClick => 'Klik untuk ubah status';

  @override
  String get tooltipTrackerFilterStatus =>
      'Filter tindakan berdasarkan status saat ini';

  @override
  String get tooltipTrackerFilterAssignee =>
      'Filter berdasarkan orang yang ditugaskan';

  @override
  String get tooltipTrackerFilterRetro =>
      'Filter berdasarkan retrospektif asal';

  @override
  String get tooltipTrackerCompletionRate =>
      'Persentase semua tindakan yang selesai';

  @override
  String get tooltipTrackerOverdue =>
      'Tindakan ini telah melewati tenggat waktu';

  @override
  String get tooltipPriorityCritical => 'Kritis: Segera tangani';

  @override
  String get tooltipPriorityHigh => 'Tinggi: Selesaikan dalam sprint ini';

  @override
  String get tooltipPriorityMedium =>
      'Sedang: Rencanakan untuk sprint berikutnya';

  @override
  String get tooltipPriorityLow => 'Rendah: Tangani jika memungkinkan';

  @override
  String get tooltipLessonCategoryFilter =>
      'Filter pelajaran berdasarkan area dampak';

  @override
  String get tooltipLessonTypeFilter =>
      'Filter berdasarkan tipe: kekuatan, kelemahan, atau rekomendasi';

  @override
  String get tooltipLessonResolvedFilter =>
      'Tampilkan semua, hanya yang belum selesai, atau hanya yang selesai';

  @override
  String get tooltipLessonRecurring => 'Pola Berulang';

  @override
  String get tooltipLessonResolved =>
      'Pelajaran ini telah ditangani dan diselesaikan';

  @override
  String get tooltipLessonImport =>
      'Impor pelajaran terpetik dari proyek lain di mana Anda adalah owner';

  @override
  String get tooltipLessonAdd =>
      'Catat pelajaran terpetik baru untuk proyek ini';

  @override
  String get tooltipLessonLongPressDelete =>
      'Tahan pada pelajaran untuk menghapus';

  @override
  String get tooltipCarryForwardDesc =>
      'Teruskan tindakan yang belum selesai dari retrospektif sebelumnya ke yang baru';

  @override
  String get tooltipCarryForwardSelectAll =>
      'Pilih atau batalkan pilihan semua tindakan tertunda';

  @override
  String get tooltipCrossProjectImportDesc =>
      'Pelajaran akan disalin ke proyek saat ini dengan referensi ke sumbernya';

  @override
  String get tooltipTrendSentiment =>
      'Skor rata-rata sentimen tim (1-5) seiring waktu';

  @override
  String get tooltipTrendCompletion =>
      'Persentase tindakan yang selesai per retrospektif seiring waktu';

  @override
  String get tooltipTrendImproving => 'Metrik tim sedang meningkat';

  @override
  String get tooltipTrendDeclining =>
      'Metrik tim menurun - pertimbangkan untuk menangani penyebabnya';

  @override
  String get tooltipTrendStable =>
      'Metrik tim stabil dalam retrospektif terbaru';

  @override
  String get tooltipHistoryRetroCard =>
      'Klik untuk melihat ringkasan lengkap retrospektif';

  @override
  String get tooltipHistorySentiment =>
      'Sentimen rata-rata tim untuk retrospektif ini';

  @override
  String get tooltipHistoryActionCount =>
      'Tindakan selesai vs total untuk retrospektif ini';

  @override
  String get tooltipFormRootCause =>
      'Jelaskan penyebab mendasar yang menyebabkan observasi ini';

  @override
  String get tooltipFormRecommendation =>
      'Sarankan tindakan konkret untuk menangani atau menduplikasi temuan ini';

  @override
  String get tooltipFormTags =>
      'Tambah tag dipisahkan koma untuk kategorisasi dan pencarian';

  @override
  String get tooltipFormRecurring =>
      'Aktifkan jika pelajaran ini muncul di lebih dari satu retrospektif';

  @override
  String get tooltipFormResolved =>
      'Tandai sebagai selesai ketika tim telah menangani pelajaran ini';

  @override
  String get guideActionTrackingTitle => 'Best Practice untuk Tindakan';

  @override
  String get guideActionTrackingDesc =>
      'Gunakan kriteria SMART: Spesifik, Terukur, Dapat Dicapai, Relevan, Terikat Waktu. Tugaskan satu penanggung jawab dan periksa kemajuan.';

  @override
  String get guideLessonsLearnedTitle => 'Framework Pelajaran Terpetik';

  @override
  String get guideLessonsLearnedDesc =>
      'Tangkap kekuatan dan kelemahan. Dokumentasikan penyebab utama dan rekomendasi. Gunakan tag untuk penggunaan lintas proyek.';

  @override
  String get guideContinuousImprovementTitle =>
      'Siklus Peningkatan Berkelanjutan';

  @override
  String get guideContinuousImprovementDesc =>
      'Pantau tren dalam retrospektif. Teruskan tindakan yang belum selesai. Impor wawasan. Fokus pada perubahan sistemik.';

  @override
  String get guideCarryForwardTitle => 'Proses Carry Forward';

  @override
  String get guideCarryForwardDesc =>
      'Saat membuat retrospektif baru, tinjau tindakan terbuka. Teruskan item yang masih relevan dan prioritaskan kembali.';

  @override
  String retroFromSprint(Object name) {
    return 'Dari: Sprint $name';
  }

  @override
  String actionItemsCompleted(Object completed, Object total) {
    return '$completed/$total selesai';
  }

  @override
  String get coachTipSSCWriting =>
      'Fokus pada perilaku nyata yang dapat diamati. Setiap item harus bisa langsung ditindaklanjuti oleh tim. Hindari pernyataan samar.';

  @override
  String get coachTipSSCVoting =>
      'Voting berdasarkan dampak dan kelayakan. Item dengan suara terbanyak menjadi komitmen sprint Anda.';

  @override
  String get coachTipSSCDiscuss =>
      'Untuk setiap item terpilih, tentukan SIAPA melakukan APA kapan. Ubah wawasan menjadi tindakan nyata.';

  @override
  String get coachTipMSGWriting =>
      'Ciptakan ruang aman untuk emosi. Semua perasaan valid. Fokus pada situasi, bukan orang. Gunakan \'Saya merasa...\'.';

  @override
  String get coachTipMSGVoting =>
      'Voting untuk mengidentifikasi pengalaman bersama. Pola emosi mengungkap dinamika tim yang perlu diperhatikan.';

  @override
  String get coachTipMSGDiscuss =>
      'Akui emosi prima memecahkan masalah. Tanya \'Apa yang bisa membantu?\' daripada langsung ke solusi. Dengarkan aktif.';

  @override
  String get coachTip4LsWriting =>
      'Refleksikan pembelajaran, bukan sekadar kejadian. Pikirkan wawasan apa yang akan dibawa ke depan.';

  @override
  String get coachTip4LsVoting =>
      'Prioritaskan pembelajaran yang dapat meningkatkan sprint mendatang. Fokus pada pengetahuan yang dapat ditransfer.';

  @override
  String get coachTip4LsDiscuss =>
      'Ubah pembelajaran menjadi dokumentasi atau perubahan proses. Tanya \'Bagaimana kita bisa berbagi ini?\'.';

  @override
  String get coachTipSailboatWriting =>
      'Gunakan metafora: Angin mendorong (pendorong), Jangkar memperlambat (penghambat), Karang adalah risiko, Pulau adalah tujuan.';

  @override
  String get coachTipSailboatVoting =>
      'Prioritaskan berdasarkan dampak risiko dan potensi pendorong. Seimbangkan blokade dengan kekuatan.';

  @override
  String get coachTipSailboatDiscuss =>
      'Buat daftar risiko untuk karang. Tentukan strategi mitigasi. Gunakan angin untuk mengatasi jangkar.';

  @override
  String get coachTipDAKIWriting =>
      'Tentukan: Hapus pemborosan, Tambah yang kurang, Pertahankan yang berhasil, Tingkatkan yang bisa lebih baik.';

  @override
  String get coachTipDAKIVoting =>
      'Voting secara pragmatis. Fokus pada perubahan yang memiliki dampak langsung dan terukur.';

  @override
  String get coachTipDAKIDiscuss =>
      'Buat keputusan tim yang jelas. Untuk setiap item, buat komitmen tindakan khusus.';

  @override
  String get coachTipStarfishWriting =>
      'Gunakan tingkatan: Pertahankan, Lebih Banyak, Lebih Sedikit, Berhenti, Mulai. Memungkinkan umpan balik yang nuansa.';

  @override
  String get coachTipStarfishVoting =>
      'Pertimbangkan usaha vs dampak. Item \'Lebih Banyak\' mungkin lebih mudah dibanding \'Mulai\'.';

  @override
  String get coachTipStarfishDiscuss =>
      'Tentukan metrik khusus per item. Bagaimana kita mengukurnya? Tetapkan target kalibrasi yang jelas.';

  @override
  String get discussPromptSSCStart =>
      'Praktik baru apa yang harus kita mulai? Pikirkan celah proses yang bisa diisi kebiasaan baru.';

  @override
  String get discussPromptSSCStop =>
      'Apa yang membuang waktu atau energi? Pertimbangkan aktivitas yang tidak memberikan nilai sebanding.';

  @override
  String get discussPromptSSCContinue =>
      'Apa yang berjalan baik? Kenali dan perkuat praktik yang efektif.';

  @override
  String get discussPromptMSGMad =>
      'Apa yang membuat frustrasi? Kita bahas situasi, bukan menyalahkan individu.';

  @override
  String get discussPromptMSGSad =>
      'Apa yang mengecewakan? Ekspektasi apa yang tidak terpenuhi?';

  @override
  String get discussPromptMSGGlad =>
      'Apa yang membuat senang? Momen apa yang memuaskan di sprint ini?';

  @override
  String get discussPrompt4LsLiked =>
      'Apa yang Anda nikmati? Apa yang membuat pekerjaan menyenangkan?';

  @override
  String get discussPrompt4LsLearned =>
      'Keahlian, wawasan, atau pengetahuan baru apa yang Anda dapatkan?';

  @override
  String get discussPrompt4LsLacked =>
      'Apa yang kurang? Sumber daya, dukungan, atau kejelasan apa yang membantu?';

  @override
  String get discussPrompt4LsLonged =>
      'Apa yang Anda harapkan? Apa yang akan membuat sprint mendatang lebih baik?';

  @override
  String get discussPromptSailboatWind =>
      'Apa yang mendorong maju? Apa kekuatan dan dukungan eksternal kita?';

  @override
  String get discussPromptSailboatAnchor =>
      'Apa yang memperlambat kita? Hambatan internal atau eksternal apa yang ada?';

  @override
  String get discussPromptSailboatRock =>
      'Risiko apa di depan? Apa yang bisa menggagalkan kita jika tidak diatasi?';

  @override
  String get discussPromptSailboatGoal =>
      'Mana tujuan kita? Apakah kita selaras ke arah mana kita menuju?';

  @override
  String get discussPromptDAKIDrop =>
      'Apa yang harus dieliminasi? Apa yang tidak memberi nilai?';

  @override
  String get discussPromptDAKIAdd =>
      'Apa yang harus diperkenalkan? Apa yang kurang dari kit kita?';

  @override
  String get discussPromptDAKIKeep =>
      'Apa yang harus dipertahankan? Apa yang esensial bagi kesuksesan kita?';

  @override
  String get discussPromptDAKIImprove =>
      'Apa yang bisa lebih baik? Di mana kita bisa naik level?';

  @override
  String get discussPromptStarfishKeep =>
      'Apa yang harus kita pertahankan tepat seperti aslinya?';

  @override
  String get discussPromptStarfishMore =>
      'Apa yang harus kita tingkatkan? Lakukan lebih banyak?';

  @override
  String get discussPromptStarfishLess =>
      'Apa yang harus kita kurangi? Lakukan lebih sedikit?';

  @override
  String get discussPromptStarfishStop =>
      'Apa yang harus kita eliminasi sepenuhnya?';

  @override
  String get discussPromptStarfishStart =>
      'Hal baru apa yang harus kita mulai?';

  @override
  String get discussPromptGeneric =>
      'Wawasan apa yang muncul dari kolom ini? Pola apa yang Anda lihat?';

  @override
  String get smartPromptSSCStartQuestion =>
      'Praktik baru apa yang akan Anda mulai, e bagaimana Anda mengukurnya?';

  @override
  String get smartPromptSSCStartExample =>
      'misal: \'Mulai standup harian 15 menit jam 09:30, lacak selama 2 minggu\'';

  @override
  String get smartPromptSSCStartPlaceholder =>
      'Kami akan mulai [praktik] pada [tanggal], diukur dengan [metrik]';

  @override
  String get smartPromptSSCStopQuestion =>
      'Apa yang akan Anda berhenti lakukan, dan apa yang akan Anda lakukan sebagai gantinya?';

  @override
  String get smartPromptSSCStopExample =>
      'misal, \'Berhenti kirim pembaruan status via email, gunakan saluran Slack #updates sebagai gantinya\'';

  @override
  String get smartPromptSSCStopPlaceholder =>
      'Kami akan berhenti melakukan [praktik] dan sebagai gantinya [alternatif]';

  @override
  String get smartPromptSSCContinueQuestion =>
      'Praktik mana yang akan Anda lanjutkan, dan bagaimana Anda memastikan itu tidak memudar?';

  @override
  String get smartPromptSSCContinueExample =>
      'misal, \'Lanjutkan tinjauan kode dalam 4 jam, tambahkan ke Definition of Done\'';

  @override
  String get smartPromptSSCContinuePlaceholder =>
      'Kami akan melanjutkan [praktik], diperkuat oleh [mekanisme]';

  @override
  String get smartPromptMSGMadQuestion =>
      'Tindakan apa yang akan menangani frustrasi ini dan siapa yang akan memimpinnya?';

  @override
  String get smartPromptMSGMadExample =>
      'misal, \'Jadwalkan pertemuan dengan PM untuk memperjelas proses persyaratan - Maria sebelum Jumat\'';

  @override
  String get smartPromptMSGMadPlaceholder =>
      '[Tindakan untuk menangani frustrasi], penanggung jawab: [nama], paling lambat: [tanggal]';

  @override
  String get smartPromptMSGSadQuestion =>
      'Perubahan apa yang akan mencegah kekecewaan ini terulang kembali?';

  @override
  String get smartPromptMSGSadExample =>
      'misal, \'Buat checklist komunikasi untuk pembaruan stakeholder - tinjauan mingguan\'';

  @override
  String get smartPromptMSGSadPlaceholder =>
      '[Tindakan pencegahan], dilacak melalui [metode]';

  @override
  String get smartPromptMSGGladQuestion =>
      'Bagaimana kita bisa menduplikasi atau memperkuat apa yang membuat kita bahagia?';

  @override
  String get smartPromptMSGGladExample =>
      'misal, \'Dokumentasikan format sesi pairing dan bagikan dengan tim lain sebelum akhir minggu\'';

  @override
  String get smartPromptMSGGladPlaceholder =>
      '[Tindakan untuk menduplikasi/memperkuat], bagikan dengan [audiens]';

  @override
  String get smartPrompt4LsLikedQuestion =>
      'Bagaimana kita memastikan pengalaman positif ini berlanjut?';

  @override
  String get smartPrompt4LsLikedExample =>
      'misal, \'Jadikan sesi mob programming sebagai acara mingguan di kalender\'';

  @override
  String get smartPrompt4LsLikedPlaceholder =>
      '[Tindakan untuk mempertahankan pengalaman positif]';

  @override
  String get smartPrompt4LsLearnedQuestion =>
      'Bagaimana Anda akan mendokumentasikan dan membagikan pembelajaran ini?';

  @override
  String get smartPrompt4LsLearnedExample =>
      'misal, \'Tulis artikel wiki tentang pendekatan pengujian baru, presentasikan dalam sesi tech talk bulan depan\'';

  @override
  String get smartPrompt4LsLearnedPlaceholder =>
      'Dokumentasikan di [lokasi], bagikan melalui [metode] paling lambat [tanggal]';

  @override
  String get smartPrompt4LsLackedQuestion =>
      'Sumber daya atau dukungan spesifik apa yang Anda perlukan dan kepada siapa?';

  @override
  String get smartPrompt4LsLackedExample =>
      'misal, \'Minta anggaran pelatihan CI/CD ke manajer - kirim sebelum planning berikutnya\'';

  @override
  String get smartPrompt4LsLackedPlaceholder =>
      'Minta [sumber daya] dari [orang/tim], tenggat waktu: [tanggal]';

  @override
  String get smartPrompt4LsLongedQuestion =>
      'Langkah nyata pertama apa yang akan membawa Anda lebih dekat ke keinginan ini?';

  @override
  String get smartPrompt4LsLongedExample =>
      'misal, \'Buat draf proposal untuk 20% waktu proyek sampingan - bagikan dengan team lead hari Senin\'';

  @override
  String get smartPrompt4LsLongedPlaceholder =>
      'Langkah pertama menuju [keinginan]: [tindakan] paling lambat [tanggal]';

  @override
  String get smartPromptSailboatWindQuestion =>
      'Bagaimana Anda akan memanfaatkan pendorong ini untuk mempercepat kemajuan?';

  @override
  String get smartPromptSailboatWindExample =>
      'misal, \'Gunakan keahlian QA yang kuat untuk membimbing junior - jadwalkan sesi pertama minggu ini\'';

  @override
  String get smartPromptSailboatWindPlaceholder =>
      'Manfaatkan [pendorong] dengan [tindakan spesifik]';

  @override
  String get smartPromptSailboatAnchorQuestion =>
      'Tindakan spesifik apa yang akan menghapus atau mengurangi penghambat ini?';

  @override
  String get smartPromptSailboatAnchorExample =>
      'misal, \'Eskalasi masalah infrastruktur ke CTO - siapkan laporan singkat sebelum Rabu\'';

  @override
  String get smartPromptSailboatAnchorPlaceholder =>
      'Hapus [penghambat] dengan [tindakan], eskalasi ke [orang] jika perlu';

  @override
  String get smartPromptSailboatRockQuestion =>
      'Strategi mitigasi apa yang akan Anda terapkan untuk risiko ini?';

  @override
  String get smartPromptSailboatRockExample =>
      'misal, \'Tambah rencana cadangan untuk ketergantungan vendor - dokumentasikan alternatif sebelum akhir sprint\'';

  @override
  String get smartPromptSailboatRockPlaceholder =>
      'Mitigasi [risiko] dengan [strategi], pemicu: [kondisi]';

  @override
  String get smartPromptSailboatGoalQuestion =>
      'Tonggak pencapaian apa yang akan mengonfirmasi kemajuan menuju tujuan ini?';

  @override
  String get smartPromptSailboatGoalExample =>
      'misal, \'Demo MVP kepada stakeholder sebelum 15 Feb, kumpulkan umpan balik via survei\'';

  @override
  String get smartPromptSailboatGoalPlaceholder =>
      'Tonggak pencapaian menuju [tujuan]: [hasil] paling lambat [tanggal]';

  @override
  String get smartPromptDAKIDropQuestion =>
      'Apa yang akan Anda hapus dan bagaimana Anda memastikan itu tidak kembali?';

  @override
  String get smartPromptDAKIDropExample =>
      'misal, \'Hapus langkah deployment manual - otomatisasi sebelum akhir sprint\'';

  @override
  String get smartPromptDAKIDropPlaceholder =>
      'Hapus [praktik], cegah kembali dengan [mekanisme]';

  @override
  String get smartPromptDAKIAddQuestion =>
      'Praktik baru apa yang akan Anda perkenalkan dan bagaimana Anda memvalidasi bahwa itu berhasil?';

  @override
  String get smartPromptDAKIAddExample =>
      'misal, \'Tambah sistem feature flag - coba pada 2 fitur, tinjau hasil dalam 2 minggu\'';

  @override
  String get smartPromptDAKIAddPlaceholder =>
      'Tambah [praktik], validasi keberhasilan melalui [metrik]';

  @override
  String get smartPromptDAKIKeepQuestion =>
      'Bagaimana Anda akan melindungi praktik ini agar tidak diprioritaskan?';

  @override
  String get smartPromptDAKIKeepExample =>
      'misal, \'Pertahankan standar tinjauan kode - tambahkan ke team charter, audit bulanan\'';

  @override
  String get smartPromptDAKIKeepPlaceholder =>
      'Lindungi [praktik] dengan [mekanisme]';

  @override
  String get smartPromptDAKIImproveQuestion =>
      'Peningkatan spesifik apa yang akan Anda lakukan dan bagaimana Anda akan mengukur peningkatannya?';

  @override
  String get smartPromptDAKIImproveExample =>
      'misal, \'Tingkatkan cakupan pengujian dari 60% ke 80% - fokus pada modul pembayaran terlebih dahulu\'';

  @override
  String get smartPromptDAKIImprovePlaceholder =>
      'Tingkatkan [praktik] dari [saat ini] ke [target] paling lambat [tanggal]';

  @override
  String get smartPromptStarfishKeepQuestion =>
      'Praktik mana yang akan Anda pertahankan dan siapa penanggung jawab untuk memastikan konsistensi?';

  @override
  String get smartPromptStarfishKeepExample =>
      'misal, \'Pertahankan demo hari Jumat - Tom memastikan ruang dipesan, agenda dibagikan sebelum Kamis\'';

  @override
  String get smartPromptStarfishKeepPlaceholder =>
      'Pertahankan [praktik], penanggung jawab: [nama]';

  @override
  String get smartPromptStarfishMoreQuestion =>
      'Apa yang akan Anda tingkatkan dan seberapa banyak?';

  @override
  String get smartPromptStarfishMoreExample =>
      'misal, \'Tingkatkan pair programming dari 2 jam menjadi 6 jam per minggu per pengembang\'';

  @override
  String get smartPromptStarfishMorePlaceholder =>
      'Tingkatkan [praktik] dari [level saat ini] ke [level target]';

  @override
  String get smartPromptStarfishLessQuestion =>
      'Apa yang akan Anda kurangi dan seberapa banyak?';

  @override
  String get smartPromptStarfishLessExample =>
      'misal, \'Kurangi rapat dari 10 jam menjadi 6 jam per minggu - batalkan tinjauan rutin\'';

  @override
  String get smartPromptStarfishLessPlaceholder =>
      'Kurangi [praktik] dari [level saat ini] ke [level target]';

  @override
  String get smartPromptStarfishStopQuestion =>
      'Apa yang akan Anda berhenti lakukan sepenuhnya dan apa yang menggantikannya (jika ada)?';

  @override
  String get smartPromptStarfishStopExample =>
      'misal, \'Berhenti pelacakan waktu mendetail pada tugas - estimasi berdasarkan kepercayaan sebagai gantinya\'';

  @override
  String get smartPromptStarfishStopPlaceholder =>
      'Berhenti [praktik], ganti dengan [alternatif] atau tidak sama sekali';

  @override
  String get smartPromptStarfishStartQuestion =>
      'Praktik baru apa yang akan Anda mulai dan kapan kemunculan pertamanya?';

  @override
  String get smartPromptStarfishStartExample =>
      'misal, \'Mulai tech debt Tuesday - sesi pertama minggu depan, 2 jam waktu khusus\'';

  @override
  String get smartPromptStarfishStartPlaceholder =>
      'Mulai [praktik], kemunculan pertama: [tanggal/waktu]';

  @override
  String get smartPromptGenericQuestion =>
      'Tindakan spesifik apa yang akan menangani item ini?';

  @override
  String get smartPromptGenericExample =>
      'misal, \'Tentukan tindakan spesifik dengan penanggung jawab, tenggat waktu, dan kriteria keberhasilan\'';

  @override
  String get smartPromptGenericPlaceholder =>
      '[Tindakan], penanggung jawab: [nama], paling lambat: [tanggal]';

  @override
  String get methodologyFocusAction =>
      'Berorientasi tindakan: fokus pada perubahan perilaku yang konkret';

  @override
  String get methodologyFocusEmotion =>
      'Fokus pada emosi: mengeksplorasi perasaan tim untuk membangun keamanan psikologis';

  @override
  String get methodologyFocusLearning =>
      'Reflektif pada pembelajaran: menekankan penangkapan dan berbagi pengetahuan';

  @override
  String get methodologyFocusRisk =>
      'Risiko dan Tujuan: keseimbangan pendorong, penghambat, risiko, dan tujuan';

  @override
  String get methodologyFocusCalibration =>
      'Kalibrasi: menggunakan tingkatan (lebih banyak/lebih sedikit) untuk penyesuaian nuansa';

  @override
  String get methodologyFocusDecision =>
      'Keputusan: memandu keputusan tim yang jelas tentang praktik';

  @override
  String get exportSheetOverview => 'Ikhtisar';

  @override
  String get exportSheetActionItems => 'Tindakan';

  @override
  String get exportSheetBoardItems => 'Item Board';

  @override
  String get exportSheetTeamHealth => 'Kesehatan Tim';

  @override
  String get exportSheetLessonsLearned => 'Pelajaran Terpetik';

  @override
  String get exportSheetRiskRegister => 'Pendaftaran Risiko';

  @override
  String get exportSheetCalibrationMatrix => 'Matriks Kalibrasi';

  @override
  String get exportSheetDecisionLog => 'Log Keputusan';

  @override
  String get exportHeaderRetrospectiveReport => 'LAPORAN RETROSPEKTIF';

  @override
  String get exportHeaderTitle => 'Judul:';

  @override
  String get exportHeaderDate => 'Tanggal:';

  @override
  String get exportHeaderTemplate => 'Template:';

  @override
  String get exportHeaderMethodology => 'Fokus Metodologi:';

  @override
  String get exportHeaderSentiments => 'Sentimen (Rata-rata):';

  @override
  String get exportHeaderParticipants => 'PARTISIPAN';

  @override
  String get exportHeaderSummary => 'RINGKASAN';

  @override
  String get exportHeaderTotalItems => 'Total Item:';

  @override
  String get exportHeaderActionItems => 'Tindakan:';

  @override
  String get exportHeaderSuggestedFollowUp => 'Tindak Lanjut yang Disarankan:';

  @override
  String get exportTeamHealthTitle => 'ANALISIS KESEHATAN TIM';

  @override
  String get exportTeamHealthEmotionalDistribution => 'Distribusi Emosional';

  @override
  String get exportTeamHealthMadCount => 'Item Mad:';

  @override
  String get exportTeamHealthSadCount => 'Item Sad:';

  @override
  String get exportTeamHealthGladCount => 'Item Glad:';

  @override
  String get exportTeamHealthMadItems => 'FRUSTRASI (Mad)';

  @override
  String get exportTeamHealthSadItems => 'KEKECEWAAN (Sad)';

  @override
  String get exportTeamHealthGladItems => 'PERAYAAN (Glad)';

  @override
  String get exportTeamHealthRecommendation => 'Rekomendasi Kesehatan Tim:';

  @override
  String get exportTeamHealthHighFrustration =>
      'Tingkat frustrasi tinggi terdeteksi. Pertimbangkan untuk memfasilitasi sesi fokus penyelesaian masalah.';

  @override
  String get exportTeamHealthBalanced =>
      'Keadaan emosional seimbang. Tim menunjukkan kemampuan refleksi yang sehat.';

  @override
  String get exportTeamHealthPositive =>
      'Moral tim positif. Manfaatkan energi ini untuk peningkatan yang menantang.';

  @override
  String get exportLessonsLearnedTitle => 'DAFTAR PELAJARAN TERPETIK';

  @override
  String get exportLessonsLearnedWhatWorked => 'APA YANG BERHASIL (Liked)';

  @override
  String get exportLessonsLearnedNewSkills =>
      'KETERAMPILAN DAN WAWASAN BARU (Learned)';

  @override
  String get exportLessonsLearnedGaps => 'CELAH DAN ITEM YANG KURANG (Lacked)';

  @override
  String get exportLessonsLearnedWishes => 'ASPIRASI MASA DEPAN (Longed For)';

  @override
  String get exportLessonsLearnedKnowledgeActions =>
      'Tindakan Berbagi Pengetahuan';

  @override
  String get exportLessonsLearnedDocumentationNeeded =>
      'Dokumentasi yang Diperlukan:';

  @override
  String get exportLessonsLearnedTrainingNeeded =>
      'Pelatihan/Berbagi yang Diperlukan:';

  @override
  String get exportRiskRegisterTitle => 'DAFTAR RISIKO DAN PENDORONG';

  @override
  String get exportRiskRegisterEnablers => 'PENDORONG (Angin)';

  @override
  String get exportRiskRegisterBlockers => 'PENGHAMBAT (Jangkar)';

  @override
  String get exportRiskRegisterRisks => 'RISIKO (Batu Karang)';

  @override
  String get exportRiskRegisterGoals => 'TUJUAN (Pulau)';

  @override
  String get exportRiskRegisterRiskItem => 'Risiko';

  @override
  String get exportRiskRegisterImpact => 'Dampak Potensial';

  @override
  String get exportRiskRegisterMitigation => 'Tindakan Mitigasi';

  @override
  String get exportRiskRegisterStatus => 'Status';

  @override
  String get exportRiskRegisterGoalAlignment =>
      'Verifikasi Penyelarasan Tujuan:';

  @override
  String get exportRiskRegisterGoalAlignmentNote =>
      'Verifikasi apakah tindakan saat ini selaras dengan tujuan yang dinyatakan.';

  @override
  String get exportCalibrationTitle => 'MATRIKS KALIBRASI';

  @override
  String get exportCalibrationKeepDoing => 'TERUS LAKUKAN';

  @override
  String get exportCalibrationDoMore => 'LAKUKAN LEBIH BANYAK';

  @override
  String get exportCalibrationDoLess => 'LAKUKAN LEBIH SEDIKIT';

  @override
  String get exportCalibrationStopDoing => 'BERHENTI LAKUKAN';

  @override
  String get exportCalibrationStartDoing => 'MULAI LAKUKAN';

  @override
  String get exportCalibrationPractice => 'Praktik';

  @override
  String get exportCalibrationCurrentState => 'Keadaan Saat Ini';

  @override
  String get exportCalibrationTargetState => 'Keadaan Target';

  @override
  String get exportCalibrationAdjustment => 'Penyesuaian';

  @override
  String get exportCalibrationNote =>
      'Kalibrasi berfokus pada penyempurnaan praktik yang ada daripada perubahan radikal.';

  @override
  String get exportDecisionLogTitle => 'LOG KEPUTUSAN';

  @override
  String get exportDecisionLogDrop => 'KEPUTUSAN UNTUK DITINGGALKAN';

  @override
  String get exportDecisionLogAdd => 'KEPUTUSAN UNTUK DITAMBAHKAN';

  @override
  String get exportDecisionLogKeep => 'KEPUTUSAN UNTUK DIPERTAHANKAN';

  @override
  String get exportDecisionLogImprove => 'KEPUTUSAN UNTUK DITINGKATKAN';

  @override
  String get exportDecisionLogDecision => 'Keputusan';

  @override
  String get exportDecisionLogRationale => 'Alasan';

  @override
  String get exportDecisionLogOwner => 'Penanggung Jawab';

  @override
  String get exportDecisionLogDeadline => 'Tenggat Waktu';

  @override
  String get exportDecisionLogPrioritizationNote => 'Rekomendasi Prioritas:';

  @override
  String get exportDecisionLogPrioritizationHint =>
      'Fokus pada keputusan DROP terlebih dahulu untuk membebaskan kapasitas, kemudian tambah praktik baru.';

  @override
  String get exportNoItems => 'Tidak ada item yang tercatat';

  @override
  String get exportNoActionItems => 'Tidak ada tindakan';

  @override
  String get exportNotApplicable => 'N/A';

  @override
  String get facilitatorGuideTitle => 'Panduan Pengumpulan Tindakan';

  @override
  String get facilitatorGuideCoverage => 'Cakupan';

  @override
  String get facilitatorGuideComplete => 'Lengkap';

  @override
  String get facilitatorGuideIncomplete => 'Tidak Lengkap';

  @override
  String get facilitatorGuideSuggestedOrder => 'Urutan yang Disarankan:';

  @override
  String get facilitatorGuideMissingRequired => 'Tindakan wajib yang hilang';

  @override
  String get facilitatorGuideColumnHasAction => 'Memiliki tindakan';

  @override
  String get facilitatorGuideColumnNoAction => 'Tidak ada tindakan';

  @override
  String get facilitatorGuideRequired => 'Wajib';

  @override
  String get facilitatorGuideOptional => 'Opsional';

  @override
  String get agileEdit => 'Ubah';

  @override
  String get agileSettings => 'Pengaturan';

  @override
  String get agileDelete => 'Hapus';

  @override
  String get agileDeleteProjectTitle => 'Hapus Proyek';

  @override
  String agileDeleteProjectConfirm(String projectName) {
    return 'Yakin ingin menghapus \"$projectName\"?';
  }

  @override
  String get agileDeleteProjectWarning =>
      'Tindakan ini akan menghapus secara permanen:';

  @override
  String agileDeleteWarningUserStories(int count) {
    return '$count user stories';
  }

  @override
  String agileDeleteWarningSprints(int count) {
    return '$count sprint';
  }

  @override
  String get agileDeleteProjectData => 'Semua data proyek';

  @override
  String get agileProjectSettingsTitle => 'Pengaturan Proyek';

  @override
  String get agileKeyRoles => 'Peran Utama';

  @override
  String get agileKeyRolesSubtitle => 'Tugaskan peran utama tim Scrum';

  @override
  String get agileRoleProductOwner => 'Product Owner';

  @override
  String get agileRoleProductOwnerDesc =>
      'Mengelola backlog dan menentukan prioritas produk';

  @override
  String get agileRoleScrumMaster => 'Scrum Master';

  @override
  String get agileRoleScrumMasterDesc =>
      'Memfasilitasi proses Scrum dan menghapus hambatan';

  @override
  String get agileRoleDevTeam => 'Development Team';

  @override
  String get agileNoDevTeamMembers =>
      'Tidak ada anggota tim. Klik + untuk menambah.';

  @override
  String get agileRolesInfo =>
      'Peran akan ditampilkan dengan ikon khusus. Anda dapat menambah partisipan lain dari Tim proyek.';

  @override
  String agileAssignedTo(String name) {
    return 'Ditugaskan kepada $name';
  }

  @override
  String get agileUnassigned => 'Belum ditugaskan';

  @override
  String get agileAssignableLater => 'Dapat ditugaskan setelah pembuatan';

  @override
  String get agileAddToTeam => 'Tambah ke Tim';

  @override
  String get agileAllMembersAssigned =>
      'Semua anggota yang tersedia sudah ditugaskan';

  @override
  String get agileClose => 'Tutup';

  @override
  String get agileProjectNameLabel => 'Nama Proyek *';

  @override
  String get agileProjectNameHint => 'Mis: Fashion PMO v2';

  @override
  String get agileEnterProjectName => 'Masukkan nama proyek';

  @override
  String get agileProjectDescLabel => 'Deskripsi';

  @override
  String get agileProjectDescHint => 'Deskripsi opsional proyek';

  @override
  String get agileFrameworkLabel => 'Framework Agile';

  @override
  String get agileDiscoverDifferences => 'Temukan perbedaan';

  @override
  String get agileSprintConfig => 'Konfigurasi Sprint';

  @override
  String get agileSprintDuration => 'Durasi Sprint (hari)';

  @override
  String get agileHoursPerDay => 'Jam/Hari';

  @override
  String get agileCreateProjectTitle => 'Proyek Agile Baru';

  @override
  String get agileEditProjectTitle => 'Ubah Proyek';

  @override
  String get agileSelectParticipant => 'Pilih partisipan';

  @override
  String get agileAssignRolesHint =>
      'Tugaskan peran utama.\nAnda dapat mengubahnya nanti dari pengaturan.';

  @override
  String get agileArchiveAction => 'Arsipkan';

  @override
  String get agileRestoreAction => 'Pulihkan';

  @override
  String get agileSetupTitle => 'Setup Proyek';

  @override
  String agileStepComplete(int completed, int total) {
    return '$completed dari $total langkah selesai';
  }

  @override
  String get agileSetupCompleteTitle => 'Setup Selesai!';

  @override
  String get agileSetupCompleteMessage => 'Proyek Anda siap untuk dimulai.';

  @override
  String get agileChecklistAddMembers => 'Tambah anggota tim';

  @override
  String get agileChecklistAddMembersDesc =>
      'Undang anggota tim untuk berkolaborasi';

  @override
  String get agileChecklistInvite => 'Undang';

  @override
  String agileChecklistCreateStories(String itemType) {
    return 'Buat $itemType pertama';
  }

  @override
  String get agileChecklistAddItems => 'Tambah minimal 3 item ke backlog';

  @override
  String get agileChecklistAdd => 'Tambah';

  @override
  String get agileChecklistWipLimits => 'Konfigurasi WIP limits';

  @override
  String get agileChecklistWipLimitsDesc =>
      'Atur batas untuk setiap kolom Kanban';

  @override
  String get agileChecklistConfigure => 'Konfigurasi';

  @override
  String agileChecklistEstimate(String itemType) {
    return 'Estimasi $itemType';
  }

  @override
  String get agileChecklistEstimateDesc =>
      'Tugaskan Story Points untuk perencanaan yang lebih baik';

  @override
  String get agileChecklistCreateSprint => 'Buat Sprint pertama';

  @override
  String get agileChecklistSprintDesc => 'Pilih cerita dan mulai bekerja';

  @override
  String get agileChecklistCreateSprintAction => 'Buat Sprint';

  @override
  String get agileChecklistStartWork => 'Mulai bekerja';

  @override
  String get agileChecklistStartWorkDesc =>
      'Pindahkan item ke sedang dikerjakan';

  @override
  String get agileTipStartSprintTitle => 'Siap untuk Sprint?';

  @override
  String get agileTipStartSprintMessage =>
      'Anda memiliki cukup cerita di backlog. Pertimbangkan untuk merencanakan Sprint pertama.';

  @override
  String get agileTipWipTitle => 'Konfigurasi WIP Limits';

  @override
  String get agileTipWipMessage =>
      'WIP limits sangat penting dalam Kanban. Batasi pekerjaan yang sedang berjalan untuk meningkatkan alur.';

  @override
  String get agileTipHybridTitle => 'Konfigurasi Scrumban Anda';

  @override
  String get agileTipHybridMessage =>
      'Anda dapat menggunakan Sprint untuk irama atau WIP limits untuk alur berkelanjutan. Bereksperimenlah!';

  @override
  String get agileTipDiscover => 'Temukan';

  @override
  String get agileTipClose => 'Tutup';

  @override
  String get agileNextStepInviteTitle => 'Undang Tim';

  @override
  String get agileNextStepInviteDesc =>
      'Tambah anggota untuk berkolaborasi dalam proyek.';

  @override
  String get agileNextStepBacklogTitle => 'Buat Backlog';

  @override
  String agileNextStepBacklogDesc(String itemType) {
    return 'Tambah $itemType pertama ke backlog.';
  }

  @override
  String get agileNextStepSprintTitle => 'Rencanakan Sprint';

  @override
  String agileNextStepSprintDesc(int count) {
    return 'Anda memiliki $count item siap. Buat Sprint pertama!';
  }

  @override
  String get agileNextStepWipTitle => 'Konfigurasi WIP Limits';

  @override
  String get agileNextStepWipDesc =>
      'Batasi pekerjaan yang sedang berjalan untuk meningkatkan alur.';

  @override
  String get agileNextStepWorkTitle => 'Mulai Bekerja';

  @override
  String get agileNextStepWorkDesc =>
      'Pindahkan item ke \"In Progress\" untuk memulai.';

  @override
  String get agileNextStepAddToSprintDesc =>
      'Pindahkan elemen ke \"To Do\" untuk menambah cerita ke sprint.';

  @override
  String get agileNextStepGoToKanban => 'Ke Kanban';

  @override
  String get agileActionNewStory => 'Story Baru';

  @override
  String get agileBacklogTitle => 'Product Backlog';

  @override
  String get agileBacklogArchiveTitle => 'Arsip Selesai';

  @override
  String get agileBacklogToggleActive => 'Tampilkan Backlog aktif';

  @override
  String agileBacklogToggleArchive(int count) {
    return 'Tampilkan Arsip ($count selesai)';
  }

  @override
  String agileBacklogArchiveBadge(int count) {
    return 'Arsip ($count)';
  }

  @override
  String get agileBacklogSearchHint =>
      'Cari berdasarkan judul, deskripsi, atau ID...';

  @override
  String agileBacklogStatsStories(int count) {
    return '$count cerita';
  }

  @override
  String agileBacklogStatsPoints(int points) {
    return '$points pt';
  }

  @override
  String agileBacklogStatsEstimated(int count) {
    return '$count diestimasi';
  }

  @override
  String get agileFiltersStatus => 'Status:';

  @override
  String get agileFiltersPriority => 'Prioritas:';

  @override
  String get agileFiltersTags => 'Tag:';

  @override
  String get agileFiltersAll => 'Semua';

  @override
  String get agileFiltersClear => 'Hapus filter';

  @override
  String get agileEmptyBacklogMatch => 'Tidak ada cerita ditemukan';

  @override
  String get agileEmptyBacklog => 'Backlog kosong';

  @override
  String get agileEmptyBacklogHint => 'Tambah User Story pertama';

  @override
  String get agileEstTitle => 'Estimasi Story';

  @override
  String get agileEstMethod => 'Metode estimasi';

  @override
  String get agileEstSelectValue => 'Pilih nilai';

  @override
  String get agileEstSubmit => 'Konfirmasi Estimasi';

  @override
  String get agileEstCancel => 'Batal';

  @override
  String get agileEstPokerTitle => 'Planning Poker (Fibonacci)';

  @override
  String get agileEstPokerDesc =>
      'Pilih kompleksitas cerita dalam story points';

  @override
  String get agileEstTShirtTitle => 'T-Shirt Sizing';

  @override
  String get agileEstTShirtDesc => 'Pilih ukuran relatif cerita';

  @override
  String get agileEstThreePointTitle => 'Estimasi Tiga Titik (PERT)';

  @override
  String get agileEstThreePointDesc =>
      'Masukkan tiga nilai untuk menghitung estimasi PERT';

  @override
  String get agileEstBucketTitle => 'Bucket System';

  @override
  String get agileEstBucketDesc => 'Tempatkan cerita pada bucket yang sesuai';

  @override
  String get agileEstBucketHint =>
      'Bucket yang lebih besar menunjukkan cerita yang lebih kompleks';

  @override
  String get agileEstReference => 'Referensi:';

  @override
  String get agileEstRefXS => 'XS = Beberapa jam';

  @override
  String get agileEstRefS => 'S = ~1 hari';

  @override
  String get agileEstRefM => 'M = ~2-3 hari';

  @override
  String get agileEstRefL => 'L = ~1 minggu';

  @override
  String get agileEstRefXL => 'XL = ~2 minggu';

  @override
  String get agileEstRefXXL => 'XXL = Terlalu besar, bagi';

  @override
  String get agileEstOptimistic => 'Optimis (O)';

  @override
  String get agileEstOptimisticHint => 'Kasus terbaik';

  @override
  String get agileEstMostLikely => 'Paling Mungkin (M)';

  @override
  String get agileEstMostLikelyHint => 'Kasus rata-rata';

  @override
  String get agileEstPessimistic => 'Pesimis (P)';

  @override
  String get agileEstPessimisticHint => 'Kasus terburuk';

  @override
  String get agileEstPointsSuffix => 'pt';

  @override
  String get agileEstFormula => 'Formula PERT: (O + 4M + P) / 6';

  @override
  String agileEstResult(String value) {
    return 'Estimasi: $value poin';
  }

  @override
  String get agileEstErrorThreePoint => 'Masukkan semua ketiga nilai';

  @override
  String get agileEstErrorSelect => 'Pilih nilai';

  @override
  String agileEstExisting(int count) {
    return 'Estimasi yang ada ($count)';
  }

  @override
  String get agileEstYou => 'Anda';

  @override
  String get scrumPermBacklogTitle => 'Izin Backlog';

  @override
  String get scrumPermBacklogDesc =>
      'Hanya Product Owner yang dapat membuat, mengubah, menghapus, dan memprioritaskan cerita';

  @override
  String get scrumPermSprintTitle => 'Izin Sprint';

  @override
  String get scrumPermSprintDesc =>
      'Hanya Scrum Master yang dapat membuat, memulai, dan menyelesaikan sprint';

  @override
  String get scrumPermEstimateTitle => 'Izin Estimasi';

  @override
  String get scrumPermEstimateDesc =>
      'Hanya Development Team yang dapat mengestimasi cerita';

  @override
  String get scrumPermKanbanTitle => 'Izin Kanban';

  @override
  String get scrumPermKanbanDesc =>
      'Development Team dapat memindahkan cerita mereka, PO dan SM dapat memindahkan cerita apa pun';

  @override
  String get scrumPermTeamTitle => 'Izin Tim';

  @override
  String get scrumPermTeamDesc =>
      'PO dan SM dapat mengundang anggota, hanya PO yang dapat mengubah peran';

  @override
  String get scrumPermDeniedBacklogCreate =>
      'Hanya Product Owner yang dapat membuat cerita baru';

  @override
  String get scrumPermDeniedBacklogEdit =>
      'Hanya Product Owner yang dapat mengubah cerita';

  @override
  String get scrumPermDeniedBacklogDelete =>
      'Hanya Product Owner yang dapat menghapus cerita';

  @override
  String get scrumPermDeniedBacklogPrioritize =>
      'Hanya Product Owner yang dapat mengatur ulang backlog';

  @override
  String get scrumPermDeniedSprintCreate =>
      'Hanya Scrum Master yang dapat membuat sprint baru';

  @override
  String get scrumPermDeniedSprintStart =>
      'Hanya Scrum Master yang dapat memulai sprint';

  @override
  String get scrumPermDeniedSprintComplete =>
      'Hanya Scrum Master yang dapat menyelesaikan sprint';

  @override
  String get scrumPermDeniedEstimate =>
      'Hanya Development Team yang dapat mengestimasi cerita';

  @override
  String get scrumPermDeniedInvite =>
      'Hanya PO dan SM yang dapat mengundang anggota baru';

  @override
  String get scrumPermDeniedRoleChange =>
      'Hanya Product Owner yang dapat mengubah peran tim';

  @override
  String get scrumPermDeniedWipConfig =>
      'Hanya Scrum Master yang dapat mengonfigurasi batas WIP';

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
  String get scrumMatrixTitle => 'Matriks Izin Scrum';

  @override
  String get scrumMatrixSubtitle =>
      'Siapa dapat melakukan apa menurut Scrum Guide 2020';

  @override
  String get scrumMatrixLegend => 'Legenda';

  @override
  String get scrumMatrixLegendFull => 'Mengelola';

  @override
  String get scrumMatrixLegendPartial => 'Parsial';

  @override
  String get scrumMatrixLegendView => 'Lihat';

  @override
  String get scrumMatrixLegendNone => 'Tidak ada';

  @override
  String get scrumMatrixCategoryBacklog => 'BACKLOG';

  @override
  String get scrumMatrixCategorySprint => 'SPRINT';

  @override
  String get scrumMatrixCategoryEstimation => 'ESTIMASI';

  @override
  String get scrumMatrixCategoryKanban => 'KANBAN';

  @override
  String get scrumMatrixCategoryTeam => 'TIM';

  @override
  String get scrumMatrixCategoryRetro => 'RETROSPEKTIF';

  @override
  String get scrumMatrixActionCreateStory => 'Membuat Story';

  @override
  String get scrumMatrixActionEditStory => 'Mengubah Story';

  @override
  String get scrumMatrixActionDeleteStory => 'Menghapus Story';

  @override
  String get scrumMatrixActionPrioritize => 'Memprioritaskan Backlog';

  @override
  String get scrumMatrixActionAddAcceptance => 'Menentukan Kriteria Penerimaan';

  @override
  String get scrumMatrixActionCreateSprint => 'Membuat Sprint';

  @override
  String get scrumMatrixActionStartSprint => 'Memulai Sprint';

  @override
  String get scrumMatrixActionCompleteSprint => 'Menyelesaikan Sprint';

  @override
  String get scrumMatrixActionConfigWip => 'Mengonfigurasi Batas WIP';

  @override
  String get scrumMatrixActionEstimate => 'Mengestimasi Story Points';

  @override
  String get scrumMatrixActionFinalEstimate => 'Menentukan Estimasi Akhir';

  @override
  String get scrumMatrixActionMoveOwn => 'Memindahkan Story sendiri';

  @override
  String get scrumMatrixActionMoveAny => 'Memindahkan Story apa pun';

  @override
  String get scrumMatrixActionSelfAssign => 'Menugaskan diri sendiri';

  @override
  String get scrumMatrixActionAssignOthers => 'Menugaskan orang lain';

  @override
  String get scrumMatrixActionChangeStatus => 'Mengubah status Story';

  @override
  String get scrumMatrixActionInvite => 'Mengundang anggota';

  @override
  String get scrumMatrixActionRemove => 'Menghapus anggota';

  @override
  String get scrumMatrixActionChangeRole => 'Mengubah peran';

  @override
  String get scrumMatrixActionFacilitateRetro => 'Memfasilitasi Retrospektif';

  @override
  String get scrumMatrixActionParticipateRetro =>
      'Berpartisipasi dalam Retrospektif';

  @override
  String get scrumMatrixActionAddRetroItem => 'Menambah item Retro';

  @override
  String get scrumMatrixActionVoteRetro => 'Memberikan suara pada item';

  @override
  String get scrumMatrixColPO => 'PO';

  @override
  String get scrumMatrixColSM => 'SM';

  @override
  String get scrumMatrixColDev => 'Dev';

  @override
  String get scrumMatrixColStake => 'Stake';

  @override
  String get agileInviteTitle => 'Undang ke Tim';

  @override
  String get agileInviteNew => 'UNDANGAN BARU';

  @override
  String get agileInviteEmailLabel => 'Email';

  @override
  String get agileInviteEmailHint => 'nama@contoh.com';

  @override
  String get agileInviteEnterEmail => 'Masukkan email';

  @override
  String get agileInviteInvalidEmail => 'Email tidak valid';

  @override
  String get agileInviteProjectRole => 'Peran Proyek';

  @override
  String get agileInviteTeamRole => 'Peran Tim';

  @override
  String get agileInviteSendEmail => 'Kirim notifikasi email';

  @override
  String get agileInviteSendBtn => 'Kirim Undangan';

  @override
  String get agileInviteLink => 'Link undangan:';

  @override
  String get agileInviteLinkCopied => 'Link disalin!';

  @override
  String get agileInviteListTitle => 'UNDANGAN';

  @override
  String get agileInviteClose => 'Tutup';

  @override
  String get agileInviteGmailAuthTitle => 'Otorisasi Gmail';

  @override
  String get agileInviteGmailAuthContent =>
      'Untuk mengirim email undangan, diperlukan otorisasi ulang dengan Google.\n\nLanjutkan?';

  @override
  String get agileInviteGmailAuthNo => 'Tidak, hanya link';

  @override
  String get agileInviteGmailAuthYes => 'Otorisasi';

  @override
  String agileInviteSentEmail(String email) {
    return 'Undangan dikirim melalui email ke $email';
  }

  @override
  String agileInviteCreated(String email) {
    return 'Undangan dibuat untuk $email';
  }

  @override
  String get agileInviteRevokeTitle => 'Cabut undangan?';

  @override
  String get agileInviteRevokeContent => 'Undangan tidak akan berlaku lagi.';

  @override
  String get agileInviteRevokeBtn => 'Cabut';

  @override
  String get agileInviteResend => 'Kirim ulang';

  @override
  String get agileInviteResent => 'Undangan dikirim ulang';

  @override
  String get agileInviteStatusPending => 'Menunggu';

  @override
  String get agileInviteStatusAccepted => 'Diterima';

  @override
  String get agileInviteStatusDeclined => 'Ditolak';

  @override
  String get agileInviteStatusExpired => 'Kadaluwarsa';

  @override
  String get agileInviteStatusRevoked => 'Dicabut';

  @override
  String get agileRoleMember => 'Anggota';

  @override
  String get agileRoleAdmin => 'Admin';

  @override
  String get agileRoleViewer => 'Pengamat';

  @override
  String get agileRoleOwner => 'Pemilik';

  @override
  String get agileEditStory => 'Ubah Story';

  @override
  String get agileNewStory => 'User Story Baru';

  @override
  String get agileDetailsTab => 'Detail';

  @override
  String get agileAcceptanceCriteriaTab => 'Kriteria Penerimaan';

  @override
  String get agileOtherTab => 'Lainnya';

  @override
  String get agileTitleLabel => 'Judul';

  @override
  String get agileTitleHint => 'Deskripsi singkat fungsionalitas';

  @override
  String get agileUseStoryTemplate => 'Gunakan template User Story';

  @override
  String get agileStoryTemplateSubtitle => 'Sebagai... saya ingin... agar...';

  @override
  String get agileAsA => 'Sebagai...';

  @override
  String get agileAsAHint => 'pengguna, admin, pelanggan...';

  @override
  String get agileIWant => 'Saya ingin...';

  @override
  String get agileIWantHint => 'bisa melakukan sesuatu...';

  @override
  String get agileSoThat => 'Agar...';

  @override
  String get agileSoThatHint => 'mendapatkan manfaat...';

  @override
  String get agileDescriptionLabel => 'Deskripsi';

  @override
  String get agileDescriptionHint => 'Deskripsi bebas dari cerita';

  @override
  String get agilePreview => 'Pratinjau:';

  @override
  String get agileEmptyDescription => '(deskripsi kosong)';

  @override
  String get agileDefineComplete => 'Tentukan kapan cerita dianggap selesai';

  @override
  String get agileAddCriterionHint => 'Tambah kriteria penerimaan...';

  @override
  String get agileNoCriteria => 'Tidak ada kriteria ditentukan';

  @override
  String get agileSuggestions => 'Saran:';

  @override
  String get agilePriorityMoscow => 'Prioritas (MoSCoW)';

  @override
  String get agileBusinessValueLow => 'Nilai bisnis rendah';

  @override
  String get agileBusinessValueMedium => 'Nilai menengah';

  @override
  String get agileBusinessValueHigh => 'Nilai bisnis tinggi';

  @override
  String get agileEstimatedStoryPoints => 'Diestimasi dalam Story Points';

  @override
  String get agileStoryPointsTooltip =>
      'Story Points mewakili kompleksitas relatif pekerjaan.\nGunakan seri Fibonacci: 1 (sederhana) -> 21 (sangat kompleks).';

  @override
  String get agileNoPoints => 'Tidak ada';

  @override
  String get agileAddTagHint => 'Tambah tag...';

  @override
  String get agileExistingTags => 'Tag yang ada:';

  @override
  String get agileAssignTo => 'Tugaskan ke';

  @override
  String get agileSelectMemberHint => 'Pilih anggota tim';

  @override
  String get agilePointsComplexityVeryLow => 'Tugas cepat dan sederhana';

  @override
  String get agilePointsComplexityLow => 'Tugas dengan kompleksitas menengah';

  @override
  String get agilePointsComplexityMedium => 'Tugas kompleks, butuh analisis';

  @override
  String get agilePointsComplexityHigh =>
      'Sangat kompleks, pertimbangkan membagi cerita';

  @override
  String agileDurationDays(Object days) {
    return 'Durasi: $days hari';
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
  String get agileSelectedPoints => 'Poin Terpilih';

  @override
  String get agileSuggestedPoints => 'Poin Disarankan';

  @override
  String agileDaysRemaining(Object days) {
    return '$days hari tersisa';
  }

  @override
  String get agileSelectAtLeastOne => 'Pilih minimal satu cerita';

  @override
  String agileConfirmStories(String count) {
    return 'Konfirmasi $count cerita';
  }

  @override
  String get kanbanPoliciesDescription =>
      'Kebijakan eksplisit menentukan aturan untuk kolom ini (Praktik Kanban #4)';

  @override
  String get kanbanPoliciesEmpty => 'Tidak ada kebijakan ditentukan';

  @override
  String get kanbanPoliciesAdd => 'Tambah kebijakan';

  @override
  String get kanbanPoliciesHint => 'Mis: Maks 24 jam di kolom ini';

  @override
  String kanbanPoliciesIndicator(int count) {
    return 'Kebijakan aktif: $count';
  }

  @override
  String get sprintReviewTitle => 'Sprint Review';

  @override
  String get sprintReviewSubtitle =>
      'Tinjauan pekerjaan selesai bersama stakeholder';

  @override
  String get sprintReviewConductBy => 'Dipandu oleh';

  @override
  String get sprintReviewDate => 'Tanggal Review';

  @override
  String get sprintReviewAttendees => 'Peserta';

  @override
  String get sprintReviewSelectAttendees => 'Pilih peserta';

  @override
  String get sprintReviewDemoNotes => 'Catatan Demo';

  @override
  String get sprintReviewDemoNotesHint =>
      'Deskripsikan fungsionalitas yang didemonstrasikan';

  @override
  String get sprintReviewFeedback => 'Umpan Balik Diterima';

  @override
  String get sprintReviewFeedbackHint => 'Umpan balik dari stakeholder';

  @override
  String get sprintReviewBacklogUpdates => 'Pembaruan Backlog';

  @override
  String get sprintReviewBacklogUpdatesHint =>
      'Perubahan backlog yang didiskusikan';

  @override
  String get sprintReviewNextFocus => 'Fokus Sprint Berikutnya';

  @override
  String get sprintReviewNextFocusHint => 'Prioritas untuk sprint berikutnya';

  @override
  String get sprintReviewMarketNotes => 'Catatan Pasar/Anggaran';

  @override
  String get sprintReviewMarketNotesHint => 'Kondisi pasar, timeline, anggaran';

  @override
  String get sprintReviewStoriesCompleted => 'Cerita Selesai';

  @override
  String get sprintReviewStoriesNotCompleted => 'Cerita Tidak Selesai';

  @override
  String get sprintReviewPointsCompleted => 'Poin Selesai';

  @override
  String get sprintReviewSave => 'Simpan Review';

  @override
  String get sprintReviewWarning => 'Peringatan: Sprint Review';

  @override
  String get sprintReviewWarningMessage =>
      'Sprint Review belum dilakukan. Menurut Scrum Guide 2020, Sprint Review adalah acara wajib sebelum menyelesaikan sprint.';

  @override
  String get sprintReviewCompleteAnyway => 'Tetap Selesaikan';

  @override
  String get sprintReviewDoReview => 'Lakukan Review';

  @override
  String get sprintReviewCompleted => 'Sprint Review selesai';

  @override
  String get swimlaneTitle => 'Swimlanes';

  @override
  String get swimlaneDescription => 'Kelompokkan kartu berdasarkan atribut';

  @override
  String get swimlaneTypeNone => 'Tidak ada';

  @override
  String get swimlaneTypeNoneDesc => 'Tampilan standar tanpa pengelompokan';

  @override
  String get swimlaneTypeClassOfService => 'Kelas Layanan';

  @override
  String get swimlaneTypeClassOfServiceDesc =>
      'Kelompokkan berdasarkan prioritas/urgensi';

  @override
  String get swimlaneTypeAssignee => 'Penerima Tugas';

  @override
  String get swimlaneTypeAssigneeDesc => 'Kelompokkan berdasarkan anggota tim';

  @override
  String get swimlaneTypePriority => 'Prioritas';

  @override
  String get swimlaneTypePriorityDesc =>
      'Kelompokkan berdasarkan tingkat prioritas';

  @override
  String get swimlaneTypeTag => 'Tag';

  @override
  String get swimlaneTypeTagDesc => 'Kelompokkan berdasarkan tag cerita';

  @override
  String get swimlaneUnassigned => 'Belum Ditugaskan';

  @override
  String get swimlaneNoTag => 'Tanpa Tag';

  @override
  String get agileMetricsVelocityTitle => 'Velocity';

  @override
  String get agileMetricsVelocityDesc =>
      'Mengukur jumlah story points yang diselesaikan per sprint. Membantu memprediksi kapasitas tim.';

  @override
  String get agileMetricsLeadTimeDesc =>
      'Total waktu dari pembuatan hingga selesai. Termasuk waktu tunggu di backlog.';

  @override
  String get agileMetricsCycleTimeDesc =>
      'Formula: Waktu yang dihabiskan dalam status aktif (Sedang Dikerjakan / Review). Tidak termasuk waktu tunggu di backlog.';

  @override
  String get agileMetricsThroughputDesc =>
      'Jumlah item yang selesai per unit waktu. Menunjukkan produktivitas.';

  @override
  String get agileMetricsDistributionDesc =>
      'Visualisasikan distribusi berdasarkan status. Membantu identifikasi hambatan.';

  @override
  String get agilePredictability => 'Prediktabilitas';

  @override
  String agilePredictabilityDesc(int days) {
    return '85% item selesai dalam ≤$days hari';
  }

  @override
  String agileThroughputWeekly(int weeks) {
    return 'Item selesai/minggu ($weeks minggu terakhir)';
  }

  @override
  String get agileNoDataVelocity => 'Tidak ada data velocity';

  @override
  String get agileNoDataLeadTime => 'Tidak ada data lead time';

  @override
  String get agileNoDataCycleTime => 'Tidak ada data cycle time';

  @override
  String get agileNoDataThroughput => 'Tidak ada data throughput';

  @override
  String get agileNoDataAccuracy => 'Tidak ada data akurasi';

  @override
  String get agileStartFinishOneItem =>
      'Selesaikan minimal satu item untuk menghitung';

  @override
  String get timeDays => 'hari';

  @override
  String get auditLogTitle => 'Log Audit';

  @override
  String auditLogEventCount(int count) {
    return '$count kejadian';
  }

  @override
  String get actionRefresh => 'Segarkan';

  @override
  String get auditLogFilterEntityType => 'Tipe';

  @override
  String get auditLogFilterAction => 'Tindakan';

  @override
  String get auditLogFilterFromDate => 'Dari';

  @override
  String get actionDetails => 'Detail';

  @override
  String get auditLogDetailsTitle => 'Detail Perubahan';

  @override
  String get auditLogPreviousValue => 'Nilai sebelumnya:';

  @override
  String get auditLogNewValue => 'Nilai baru:';

  @override
  String get auditLogNoEvents => 'Tidak ada kejadian tercatat';

  @override
  String get auditLogNoEventsDesc =>
      'Aktivitas pada proyek akan dicatat di sini';

  @override
  String get recentActivityTitle => 'Aktivitas Terbaru';

  @override
  String get actionViewAll => 'Lihat semua';

  @override
  String get recentActivityNone => 'Tidak ada aktivitas terbaru';

  @override
  String get burndownChartTitle => 'Burndown Chart';

  @override
  String get agileIdeal => 'Ideal';

  @override
  String get agileActual => 'Aktual';

  @override
  String get agileRemaining => 'Tersisa';

  @override
  String get agileBurndownNoDataDesc => 'Data akan muncul saat sprint aktif';

  @override
  String get agileCompleteActiveFirst =>
      'Selesaikan sprint aktif sebelum memulai yang lain';

  @override
  String get kanbanSwimlanes => 'Swimlanes:';

  @override
  String get kanbanSwimlaneLabel => 'Swimlane';

  @override
  String get agileNoTags => 'Tanpa tag';

  @override
  String get kanbanWipExceededBanner =>
      'Batas WIP terlampaui! Selesaikan beberapa item sebelum memulai yang baru.';

  @override
  String get kanbanConfigWip => 'Konfigurasi WIP';

  @override
  String get kanbanPoliciesDesc =>
      'Kebijakan eksplisit membantu tim memahami aturan kolom ini.';

  @override
  String get kanbanNewPolicyHint => 'Kebijakan baru...';

  @override
  String kanbanWipLimitOf(int count, int limit) {
    return 'WIP: $count dari maks $limit';
  }

  @override
  String get kanbanWipExplanationDesc =>
      'WIP (Work In Progress) Limits adalah batas pada jumlah item yang bisa berada dalam satu kolom secara bersamaan.';

  @override
  String get kanbanUnderstand => 'Saya mengerti';

  @override
  String get agileHours => 'Jam';

  @override
  String get agileStoriesPerSprint => 'Story / Sprint';

  @override
  String get agileSprints => 'Sprint';

  @override
  String get agileTeamComposition => 'Komposisi Tim';

  @override
  String get agileHoursNote =>
      'Jam adalah referensi internal. Untuk perencanaan Scrum, gunakan tampilan Story Points.';

  @override
  String agileWorkloadBalanceTooltip(String avg, String min, String max) {
    return 'Rata-rata Tim: $avg SP\nRentang Seimbang: $min - $max SP\nStatus didasarkan pada deviasi dari rata-rata.';
  }

  @override
  String get agileHealthTimeTooltip =>
      'Hari berlalu / Total hari (berdasarkan tanggal Mulai/Selesai).';

  @override
  String get agileHealthWorkTooltip =>
      'Story Points selesai dibandingkan yang direncanakan.';

  @override
  String get agileHealthProgressTooltip =>
      'Jumlah cerita yang saat ini sedang dikerjakan.';

  @override
  String get agileHealthDoneTooltip =>
      'Cerita selesai dibandingkan total cerita dalam sprint.';

  @override
  String get agileHealthCommitmentTooltip =>
      'Keandalan (Selesai / Terencana) berdasarkan sprint masa lalu.';

  @override
  String get agileHealthVelocityTooltip =>
      'Rata-rata harian Story Points yang diselesaikan dalam sprint ini.';

  @override
  String get agileSprintScopeTooltip =>
      'Pantau perubahan cakupan sprint. \'Original\' adalah poin saat mulai, \'Current\' adalah poin saat ini.';

  @override
  String get agileEstimationAccuracyTooltip =>
      'Formula: (Poin Selesai / Poin Terencana) x 100. Menunjukkan keandalan tim.';

  @override
  String get agileCommitmentTrendTooltip =>
      'Tampilkan tren keandalan tim membandingkan Poin Terencana vs Selesai.';

  @override
  String get agileNoTeamMembers => 'Tidak ada anggota tim';

  @override
  String get agileGmailAuthError =>
      'Otorisasi Gmail tidak tersedia. Coba logout dan login kembali.';

  @override
  String get agileGmailPermissionDenied => 'Izin Gmail ditolak.';

  @override
  String get agileResend => 'Kirim ulang';

  @override
  String get agileRevoke => 'Cabut';

  @override
  String get agileVelocityUnits => 'Story Points / Sprint';

  @override
  String get agileFiltersTitle => 'Filter';

  @override
  String get agilePlanned => 'Terencana';

  @override
  String get archiveDeleteSuccess => 'Berhasil diarsipkan/dihapus';

  @override
  String get agileNoItems => 'Tidak ada item untuk ditampilkan';

  @override
  String agileItemsOfTotal(int completed, int total) {
    return '$completed dari $total';
  }

  @override
  String get agileItemsCompletedLabel => 'Item Selesai';

  @override
  String get agileDaysRemainingSuffix => 'hari tersisa';

  @override
  String get agileItemsMore => 'item lainnya';

  @override
  String get wipAgeTitle => 'Usia Item Pekerjaan';

  @override
  String get wipAgeEmpty => 'Tidak ada item sedang dikerjakan';

  @override
  String wipAgeDays(int count) {
    return '$count hari';
  }

  @override
  String get wipAgeWarning =>
      'Beberapa item sudah terlalu lama dikerjakan. Mungkin ada hambatan.';

  @override
  String get agilePerWeekSuffix => '/minggu';

  @override
  String get average => 'Rata-rata';

  @override
  String get agileAvgVelocitySprint => 'Velocity (Sprint)';

  @override
  String get agileAvgVelocityWeekly => 'Velocity (Mingguan)';

  @override
  String get agileAvgVelocitySprintTooltip =>
      'Rata-rata poin selesai per sprint.';

  @override
  String get agileAvgVelocityWeeklyTooltip =>
      'Rata-rata poin selesai per minggu.';

  @override
  String get agileFiltersDoneTooltip =>
      'Cerita selesai diarsipkan secara default. Pilih filter ini untuk melihat.';

  @override
  String agileBacklogDoneBadge(Object count) {
    return '($count) Done';
  }

  @override
  String get agileBacklogDoneBadgeTooltip =>
      'Cerita ini disembunyikan secara default. Pilih status \'Done\' di filter.';

  @override
  String get agileFlowEfficiencyTooltip =>
      'Formula: (Total Waktu Aktif / Total Waktu dalam Sistem) x 100. Kalkulasi real-time.';

  @override
  String get getAgileFlowCycleTimeTooltip =>
      'Waktu rata-rata dalam status aktif. Item yang menunggu (Ready) menurunkan rata-rata.';

  @override
  String get agileFlowLeadTimeTooltip =>
      'Waktu rata-rata total dalam sistem (dari pembuatan hingga hari ini/selesai).';

  @override
  String get agileFlowWipTooltip =>
      'Work In Progress: jumlah cerita yang saat ini sedang dikerjakan.';

  @override
  String get agileBlockedItemsTooltip =>
      'Cerita yang memiliki dependensi belum terpenuhi.';

  @override
  String agileItemsCount(int count) {
    return '$count item';
  }

  @override
  String get agileDaysLeft => 'Hari Tersisa';

  @override
  String get all => 'Semua';

  @override
  String get kanbanGuidePoliciesTitle => 'Kebijakan Eksplisit';

  @override
  String get agileDaysLabel => 'Hari';

  @override
  String get agileStatRemaining => 'tersisa';

  @override
  String get agileStatsCompletedLabel => 'Selesai';

  @override
  String get agileStatsPlannedLabel => 'Terencana';

  @override
  String get agileProgressLabel => 'Kemajuan';

  @override
  String get agileDurationLabel => 'Durata';

  @override
  String get agileVelocityLabel => 'Velocity';

  @override
  String get agileStoriesLabel => 'Cerita';

  @override
  String get agileSprintSummary => 'Ringkasan Sprint';

  @override
  String get agileStoriesTotal => 'Total cerita';

  @override
  String get agileStoriesCompleted => 'Cerita selesai';

  @override
  String get agilePointsCompletedLabel => 'Story Points selesai';

  @override
  String get agileStoriesIncomplete => 'Cerita tidak lengkap';

  @override
  String get agileIncompleteReturnToBacklog => '(akan kembali ke backlog)';

  @override
  String get agilePointsLabel => 'Story Points';

  @override
  String get agileRecordReview => 'Lakukan Sprint Review';

  @override
  String get agileCompleteSprintAction => 'Selesaikan Sprint';

  @override
  String get agileMissingReview => 'Sprint Review belum dilakukan';

  @override
  String get agileSprintReviewCompleted => 'Sprint Review selesai';

  @override
  String get agileReviewNotesLabel => 'Catatan Review';

  @override
  String get agileReviewFeedbackLabel => 'Umpan Balik Stakeholder';

  @override
  String get agileReviewNextFocus => 'Fokus Sprint Berikutnya';

  @override
  String get agileBacklogUpdatesLabel => 'Perubahan Backlog';

  @override
  String get agileSaveReview => 'Simpan Review';

  @override
  String get agileConductedBy => 'Dipandu oleh';

  @override
  String get agileReviewDate => 'Tanggal Review';

  @override
  String get agileReviewOutcome => 'Hasil Review';

  @override
  String get agileStoriesRejected => 'Cerita ditolak';

  @override
  String get agileRejectedWarning =>
      'Cerita tidak lengkap atau ditolak akan otomatis kembali ke Backlog.';

  @override
  String get agileReviewDemoHint => 'Apa yang didemonstrasikan?';

  @override
  String get agileReviewFeedbackHint => 'Umpan balik diterima dari stakeholder';

  @override
  String get agileReviewBacklogHint => 'Perubahan backlog baru...';

  @override
  String get agileReviewNextFocusHint => 'Apa yang harus menjadi fokus tim?';

  @override
  String get agileReviewScrumGuide =>
      'Scrum Guide 2020 merekomendasikan Sprint Review sebelum menyelesaikan sprint.';

  @override
  String agileSprintCompleteConfirm(String name) {
    return 'Yakin ingin menyelesaikan \"$name\"?';
  }

  @override
  String agileSprintCompleteSuccess(String velocity) {
    return 'Sprint selesai! Velocity: $velocity pts/minggu';
  }

  @override
  String get agileSprintReviewSaveSuccess => 'Sprint Review disimpan';

  @override
  String get agileEstimationAccuracy => 'Keandalan Perencanaan';

  @override
  String get agileCompleteOneSprintFirst => 'Selesaikan minimal satu sprint';

  @override
  String get agileNoDataAccuracyFix => 'Tidak ada data akurasi';

  @override
  String get agileScrumGuideRecommends =>
      'Scrum Guide merekomendasikan perencanaan berdasarkan Velocity historis, bukan jam.';

  @override
  String get agileNoSkillsDefined => 'Tidak ada kompetensi ditentukan';

  @override
  String get agileAddSkillsToMembers => 'Tambah kompetensi ke anggota tim';

  @override
  String get retroNoSprintWarningTitle => 'Tidak Ada Sprint Selesai';

  @override
  String get retroNoSprintWarningMessage =>
      'Untuk membuat retrospektif Scrum, Anda harus menyelesaikan minimal satu sprint. Retrospektif terhubung ke sprint untuk melacak peningkatan antar iterasi.';

  @override
  String get agileGoToSprints => 'Ke Sprint';

  @override
  String get agileSprintReviewHistory => 'Riwayat Sprint Review';

  @override
  String get agileNoSprintReviews => 'Tidak ada Sprint Review';

  @override
  String get agileNoSprintReviewsHint =>
      'Selesaikan sprint dan lakukan review untuk melihatnya di sini';

  @override
  String get agileAttendees => 'Peserta';

  @override
  String get agileStoryEvaluations => 'Evaluasi Cerita';

  @override
  String get agileDecisions => 'Keputusan';

  @override
  String get agileDemoNotes => 'Catatan Demo';

  @override
  String get agileFeedback => 'Umpan Balik';

  @override
  String get agileStoryApproved => 'Disetujui';

  @override
  String get agileStoryNeedsRefinement => 'Perlu Pemurnian';

  @override
  String get agileStoryRejected => 'Ditolak';

  @override
  String get agileAddAttendee => 'Tambah Peserta';

  @override
  String get agileAddDecision => 'Tambah Keputusan';

  @override
  String get agileNoDecisions => 'Tidak ada keputusan ditambahkan';

  @override
  String get agileTooltipApproved => 'Disetujui';

  @override
  String get agileTooltipRefinement => 'Perlu pemurnian';

  @override
  String get agileTooltipRejected => 'Ditolak';

  @override
  String get agileReviewGuidance =>
      'Pilih hasil. \'Perlu pemurnian\' dan \'Ditolak\' akan mengembalikan cerita ke Backlog.';

  @override
  String get agileEvaluateStories => 'Evaluasi Cerita';

  @override
  String get agileSelectRole => 'Pilih Peran';

  @override
  String get agileStatsNotCompleted => 'Tidak Selesai';

  @override
  String get agileFramework => 'Framework';

  @override
  String get teamMembers => 'Anggota Tim';

  @override
  String get eisenhowerImportCsv => 'Impor CSV';

  @override
  String get eisenhowerImportPreview => 'Pratinjau Aktivitas';

  @override
  String get eisenhowerImportSelectFile => 'Pilih file CSV untuk diimpor';

  @override
  String get eisenhowerImportFormatHint =>
      'Format yang diharapkan: Aktivitas, Deskripsi, Kuadran, Urgensi, Kepentingan';

  @override
  String get eisenhowerImportClickToSelect => 'Klik untuk memilih file';

  @override
  String get eisenhowerImportSupportedFormats =>
      'Format yang didukung: .csv (UTF-8 atau Latin-1)';

  @override
  String get eisenhowerImportNoActivities =>
      'Tidak ada aktivitas ditemukan dalam file';

  @override
  String get eisenhowerImportMarkRevealed => 'Tandai sebagai sudah divoting';

  @override
  String get eisenhowerImportMarkRevealedHint =>
      'Aktivitas akan muncul langsung di kuadran yang dikalkulasi';

  @override
  String eisenhowerImportSuccess(int count) {
    return 'Berhasil mengimpor $count aktivitas';
  }

  @override
  String get actionSelectAll => 'Pilih Semua';

  @override
  String get actionDeselectAll => 'Batal Pilih Semua';

  @override
  String get actionImport => 'Impor';

  @override
  String get eisenhowerImportShowInstructions =>
      'Tampilkan/sembunyikan instruksi';

  @override
  String get eisenhowerImportInstructionsTitle => 'Format CSV yang Diperlukan';

  @override
  String get eisenhowerImportInstructionsBody =>
      'File CSV harus berisi minimal kolom \'Aktivitas\' atau \'Title\'. Kolom opsional: Deskripsi, Urgensi (1-10), Kepentingan (1-10). Baris pertama harus berupa header.';

  @override
  String get eisenhowerImportExampleFormat =>
      'Aktivitas,Deskripsi,Urgensi,Kepentingan\n\"Nama aktivitas\",\"Deskripsi opsional\",8.5,7.2';

  @override
  String get eisenhowerImportChangeFile => 'Ubah file';

  @override
  String eisenhowerImportSkippedRows(int count) {
    return '$count baris dilewati karena kesalahan';
  }

  @override
  String eisenhowerImportAndMore(int count) {
    return '...dan $count baris lainnya';
  }

  @override
  String eisenhowerImportFoundActivities(int valid, int total) {
    return 'Ditemukan $valid aktivitas valid dari $total baris';
  }

  @override
  String eisenhowerImportErrorEmptyTitle(int row) {
    return 'Baris $row: judul kosong';
  }

  @override
  String eisenhowerImportErrorInvalidRow(int row) {
    return 'Baris $row: format tidak valid';
  }

  @override
  String get eisenhowerImportErrorMissingColumn =>
      'Kolom \'Aktivitas\' atau \'Title\' tidak ditemukan di header';

  @override
  String get eisenhowerImportErrorEmptyFile => 'File kosong';

  @override
  String get eisenhowerImportErrorNoHeader =>
      'Header tidak ditemukan di baris pertama';

  @override
  String eisenhowerImportErrorRow(int row) {
    return 'Baris $row';
  }

  @override
  String get eisenhowerImportErrorReadFile => 'Gagal membaca file';

  @override
  String get agileSprintHealthTitle => 'Sprint Health';

  @override
  String get agileSprintHealthNoSprint => 'Tidak ada sprint aktif';

  @override
  String get agileSprintHealthNoSprintDesc =>
      'Mulai sprint untuk melihat metrik kesehatan';

  @override
  String get agileSprintHealthGoal => 'Sprint Goal';

  @override
  String get agileSprintHealthOnTrack => 'Sesuai Jalur';

  @override
  String get agileSprintHealthAtRisk => 'Berisiko';

  @override
  String get agileSprintHealthOffTrack => 'Terlambat';

  @override
  String get agileSprintHealthTime => 'Waktu';

  @override
  String get agileSprintHealthWork => 'Pekerjaan';

  @override
  String get agileSprintHealthDaysLeft => 'hari tersisa';

  @override
  String get agileSprintHealthSpRemaining => 'SP tersisa';

  @override
  String get agileSprintHealthStoriesInProgress => 'Sedang Jalan';

  @override
  String get agileSprintHealthStoriesDone => 'Cerita Selesai';

  @override
  String get agileSprintHealthCommitment => 'Keandalan';

  @override
  String get agileSprintHealthDailyVelocity => 'Vel. Harian';

  @override
  String get agileSprintHealthPrediction => 'Prediksi';

  @override
  String get agileSprintHealthOnTime => 'Tepat waktu';

  @override
  String get agileSprintHealthStoriesBreakdown => 'Distribusi Cerita';

  @override
  String get agileSprintBurndownTitle => 'Sprint Burndown';

  @override
  String get agileSprintBurndownNoData => 'Tidak ada data burndown';

  @override
  String get agileSprintBurndownNoDataDesc =>
      'Assegna stories allo sprint per vedere il burndown';

  @override
  String get agileWorkloadTitle => 'Beban Tim';

  @override
  String get agileWorkloadBalanced => 'Seimbang';

  @override
  String get agileWorkloadUnbalanced => 'Tidak Seimbang';

  @override
  String get agileWorkloadTotalStories => 'Total Cerita';

  @override
  String get agileWorkloadAssigned => 'Ditugaskan';

  @override
  String get agileWorkloadAvgSp => 'Rata-rata SP/Orang';

  @override
  String get agileWorkloadStories => 'cerita';

  @override
  String get agileWorkloadInProgress => 'sedang jalan';

  @override
  String get agileWorkloadUnassigned => 'Belum ditugaskan';

  @override
  String get agileWorkloadUnassignedWarning => 'cerita tanpa penerima tugas';

  @override
  String get agileWorkloadNoStories => 'Tidak ada cerita untuk dianalisis';

  @override
  String get agileWorkloadNoStoriesDesc =>
      'Buat cerita dan tugaskan ke anggota tim';

  @override
  String get agileWorkloadOverloaded => 'Kelebihan Beban';

  @override
  String get agileCommitmentTrendTitle => 'Tren Keandalan Komitmen';

  @override
  String get agileCommitmentTrendNoData => 'Tidak ada data tersedia';

  @override
  String get agileCommitmentTrendNoDataDesc =>
      'Selesaikan minimal satu sprint untuk melihat tren';

  @override
  String get agileCommitmentTrendPlanned => 'Terencana';

  @override
  String get agileCommitmentTrendCompleted => 'Selesai';

  @override
  String get agileCommitmentTrendAvg => 'Rata-rata';

  @override
  String get agileFlowEfficiencyTitle => 'Efisiensi Alur & WIP';

  @override
  String get agileFlowEfficiencyNoData => 'Tidak ada data tersedia';

  @override
  String get agileFlowEfficiencyNoDataDesc =>
      'Tambah cerita untuk melihat analisis alur';

  @override
  String get agileFlowEfficiency => 'Efisiensi Alur';

  @override
  String get agileFlowCycleTime => 'Cycle Time';

  @override
  String get agileFlowLeadTime => 'Lead Time';

  @override
  String get agileFlowDays => 'hari';

  @override
  String get agileFlowWipByStatus => 'WIP per Status';

  @override
  String get agileFlowAvg => 'rata-rata';

  @override
  String get agileBlockedItemsTitle => 'Item Terhambat';

  @override
  String get agileBlockedItemsNone => 'Tidak ada item terhambat';

  @override
  String get agileBlockedItemsNoneDesc => 'Semua dependensi terpenuhi';

  @override
  String agileBlockedItemsCount(Object count) {
    return '$count terhambat';
  }

  @override
  String get agileBlockedItemsSp => 'SP terhambat';

  @override
  String get agileBlockedItemsBlockedBy => 'Terhambat oleh';

  @override
  String get agileBlockedItemsDependency => 'dependensi';

  @override
  String get agileBlockedItemsDependencies => 'dependensi';

  @override
  String get agileSprintScopeTitle => 'Scope Sprint';

  @override
  String get agileSprintScopeNoSprint => 'Tidak ada sprint aktif';

  @override
  String get agileSprintScopeNoSprintDesc =>
      'Mulai sprint untuk memantau variasi scope';

  @override
  String get agileSprintScopeOriginal => 'Asli';

  @override
  String get agileSprintScopeCurrent => 'Saat Ini';

  @override
  String get agileSprintScopeDelta => 'Delta';

  @override
  String get agileSprintScopeCreep => 'Scope Creep';

  @override
  String get agileSprintScopeReduction => 'Pengurangan Scope';

  @override
  String get agileSprintScopeStable => 'Stabil';

  @override
  String get agileSprintScopeSp => 'SP';

  @override
  String get landingIntegrationBadge => 'Integrasi';

  @override
  String get landingIntegrationTitle => 'Ekosistem yang Terhubung';

  @override
  String get landingIntegrationSubtitle =>
      'Alat Anda bekerja bersama. Beralih dari ide ke delivery tanpa gangguan.';

  @override
  String get landingIntegrationFlowTitle =>
      'Dari daftar ke pengiriman, dalam satu alur';

  @override
  String get landingIntegrationStep1 => 'Kumpulkan';

  @override
  String get landingIntegrationStep1Desc => 'Smart Todo';

  @override
  String get landingIntegrationStep2 => 'Prioritaskan';

  @override
  String get landingIntegrationStep2Desc => 'Eisenhower';

  @override
  String get landingIntegrationStep3 => 'Estimasi';

  @override
  String get landingIntegrationStep3Desc => 'Estimation Room';

  @override
  String get landingIntegrationStep4 => 'Eksekusi';

  @override
  String get landingIntegrationStep4Desc => 'Agile Process';

  @override
  String get landingIntegrationStep5 => 'Tingkatkan';

  @override
  String get landingIntegrationStep5Desc => 'Retrospektif';

  @override
  String get landingIntegrationExport0Title =>
      'Smart Todo → Eisenhower / Estimasi / Sprint';

  @override
  String get landingIntegrationExport0Desc =>
      'Ubah tugas Anda menjadi aktivitas yang diprioritaskan, story estimasi, atau item backlog sprint.';

  @override
  String get landingIntegrationExport1Title =>
      'Eisenhower → Todo / Estimasi / Sprint';

  @override
  String get landingIntegrationExport1Desc =>
      'Ekspor aktivitas yang diprioritaskan ke tugas, story estimasi, atau user stories sprint.';

  @override
  String get landingIntegrationExport2Title =>
      'Estimation Room → Todo / Sprint';

  @override
  String get landingIntegrationExport2Desc =>
      'Setelah estimasi, kirim story dengan poin ke daftar Anda atau ke backlog sprint.';

  @override
  String get landingIntegrationExport3Title => 'Agile Process → Retrospektif';

  @override
  String get landingIntegrationExport3Desc =>
      'Hubungkan retrospektif ke sprint dengan metrik yang tersedia saat diskusi.';

  @override
  String get landingIntegrationDashboardTitle => 'Dashboard Terpadu';

  @override
  String get landingIntegrationDashboardDesc =>
      'Favorit, tenggat waktu, dan undangan tertunda dari setiap alat di satu tempat.';

  @override
  String jiraTransitionTitle(Object transitionName) {
    return 'Selesaikan Transisi: $transitionName';
  }

  @override
  String get jiraTransitionInfo =>
      'Jira memerlukan informasi tambahan untuk transisi ini.';

  @override
  String get jiraTransitionConfirm => 'Konfirmasi';

  @override
  String get jiraTransitionCancel => 'Batal';

  @override
  String get jiraFieldRequired => 'Bidang wajib diisi';

  @override
  String jiraSyncSuccess(Object transitionName) {
    return 'Jira: $transitionName selesai';
  }

  @override
  String jiraSyncedTo(Object statusName) {
    return 'Jira: Sinkron ke $statusName';
  }

  @override
  String jiraSyncFromSuccess(Object issueKey) {
    return 'Sinkron dari Jira: $issueKey';
  }

  @override
  String jiraSyncFailed(Object error) {
    return 'Sinkronisasi gagal: $error';
  }

  @override
  String jiraSyncWarning(Object warning) {
    return 'Peringatan Sync Jira: $warning';
  }

  @override
  String get actionSyncJira => 'Sinkronkan dengan Jira';

  @override
  String get validationRequired => 'Wajib';

  @override
  String get jiraInvalidDomain => 'Domain tidak valid';

  @override
  String get jiraInvalidEmail => 'Email tidak valid';

  @override
  String get jiraCreateTokenLink => 'Buat Token API >';

  @override
  String get agileHelpTitle => 'Panduan Cepat';

  @override
  String get agileHelpStep1Title => 'Isi Backlog';

  @override
  String get agileHelpStep1Desc =>
      'Buat User Stories di tab Backlog untuk menentukan pekerjaan yang akan dilakukan.';

  @override
  String get agileHelpStep2Title => 'Rencanakan Sprint';

  @override
  String get agileHelpStep2Desc =>
      'Buka tab Sprint, buat sprint baru dan pilih cerita dari backlog.';

  @override
  String get agileHelpStep3Title => 'Bekerja di Board';

  @override
  String get agileHelpStep3Desc =>
      'Gunakan tab Board untuk melihat kemajuan. Seret kartu untuk memperbarui status.';

  @override
  String get agileHelpStep4Title => 'Sinkron dan Tutup';

  @override
  String get agileHelpStep4Desc =>
      'Jika Jira terhubung, status diperbarui otomatis. Gunakan \'Selesaikan Sprint\' untuk mengakhiri.';

  @override
  String get actionNext => 'Lanjut';

  @override
  String get actionBack => 'Kembali';

  @override
  String get actionFinish => 'Selesai';

  @override
  String get agileStartSprintHint => 'Mulai Sprint untuk melihat cerita aktif';

  @override
  String get workflowTitle => 'Alur Kerja';

  @override
  String get workflowShowButton => 'Tampilkan Alur';

  @override
  String get workflowDiagramTitle => 'Diagram Alur Status';

  @override
  String get workflowLegend => 'Legenda';

  @override
  String get workflowScrumDesc =>
      'Dalam Scrum, story mengalir melalui Sprint Planning, Pengembangan, Review, dan Done. Alur bersifat iteratif dengan sprint berbatas waktu.';

  @override
  String get workflowKanbanDesc =>
      'Dalam Kanban, pekerjaan mengalir terus menerus. Story ditarik (pull) ke sistem berdasarkan batas WIP dan kapasitas.';

  @override
  String get workflowHybridDesc =>
      'Hibrida menggabungkan sprint Scrum con alur Kanban. Story dapat ditarik terus menerus atau direncanakan dalam sprint.';

  @override
  String get workflowFromAny => 'Dari Mana Saja';

  @override
  String get workflowFromAnyDesc => 'Dapat beralih dari status mana saja';

  @override
  String get workflowCycleLabel => 'Rework';

  @override
  String get workflowCycleDesc => 'Transisi dua arah (siklus)';

  @override
  String get workflowOptionalDesc => 'Langkah opsional (bisa dilewati)';

  @override
  String get kanbanPoliciesActive => 'Kebijakan Aktif (Kontrol Otomatis)';

  @override
  String get kanbanPoliciesExplicit =>
      'Kebijakan Eksplisit (Catatan untuk tim)';

  @override
  String get agileTeam => 'Tim';

  @override
  String get agileRoleDevelopmentTeam => 'Development Team';

  @override
  String get agileRoleDevelopmentTeamDesc => 'Anggota yang melakukan pekerjaan';

  @override
  String get feedbackTitle => 'Come ti trovi con Keisen?';

  @override
  String get feedbackSubtitle => 'La tua opinione ci aiuta a migliorare';

  @override
  String get feedbackCommentHint => 'Lascia un commento (opzionale)';

  @override
  String get feedbackSubmit => 'Invia';

  @override
  String get feedbackDismiss => 'Non ora';

  @override
  String get feedbackThankYou => 'Grazie per il tuo feedback!';
}
