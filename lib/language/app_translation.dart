import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS, // English translations
        'de_DE': deDE, // German translations
        'fr_FR': frFR, // French translations
      };
}

final Map<String, String> enUS = {
  'appName': 'Task Tracker',
  'task': 'Task',
  'typeComment': 'Type Comment...',
  'createdAt': 'Created At',
  'selectLanguage': 'Select Language', // English translation
  'settings': 'Settings',
  'changeTheme': 'Change - Theme',
  'board': 'Board',
  'noboard': 'No boards found.',
  'toDo': 'To-Do',
  'inProgress': 'In-Progress',
  'done': 'Done',
  'createBoard': 'Create Board',
  'createTask': 'Create Task',
  'title': 'Title',
  'create': 'Create',
  'boardName': 'Board Name',
  'description': 'Description',
  'enterBoardName': 'Please enter board name',
  'enterDescription': 'Please enter description',
  'enterTitle': 'Please enter title',
  'taskBoardApp': 'Task board app',
  'new': 'New',
  'pagination': 'Pagination (infinite scroll)'
};

final Map<String, String> deDE = {
  'appName': 'Task Tracker',
  'selectLanguage': 'Sprache auswählen', // German translation
  'typeComment': 'Kommentar eingeben...',

  'task': 'Aufgabe',
  'createdAt': 'Hergestellt in',
  'settings': 'Einstellungen',
  'changeTheme': 'Thema - ändern',
  'board': 'Board',
  'noboard': 'Keine Boards gefunden.',
  'toDo': 'Zu erledigen',
  'inProgress': 'In Bearbeitung',
  'done': 'Fertig',
  'createBoard': 'Board erstellen',
  'createTask': 'Aufgabe erstellen',
  'title': 'Titel',
  'create': 'Erstellen',
  'boardName': 'Board-Name',
  'description': 'Beschreibung',
  'enterBoardName': 'Bitte geben Sie den Board-Namen ein',
  'enterDescription': 'Bitte geben Sie eine Beschreibung ein',
  'enterTitle': 'Bitte geben Sie einen Titel ein',
  'taskBoardApp': 'Aufgaben-Board-App',
  'new': 'Neu',
  'pagination': 'Seitenverwaltung (unendliches Scrollen)'
};

final Map<String, String> frFR = {
  'appName': 'Task Tracker',
  'task': 'Tâche',
  'selectLanguage': 'Sélectionner la langue', // French translation
  'createdAt': 'Créé à',
  'typeComment': 'Tapez un commentaire...',

  'settings': 'Paramètres',
  'changeTheme': 'Changer - de - thème',
  'board': 'Tableau',
  'noboard': 'Aucun tableau trouvé.',
  'toDo': 'À faire',
  'inProgress': 'En cours',
  'done': 'Terminé',
  'createBoard': 'Créer un tableau',
  'createTask': 'Créer une tâche',
  'title': 'Titre',
  'create': 'Créer',
  'boardName': 'Nom du tableau',
  'description': 'Description',
  'enterBoardName': 'Veuillez saisir le nom du tableau',
  'enterDescription': 'Veuillez saisir une description',
  'enterTitle': 'Veuillez saisir un titre',
  'taskBoardApp': 'Application de tableau de tâches',
  'new': 'Nouveau',
  'pagination': 'Pagination (défilement infini)'
};
