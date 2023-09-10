# flutter_cours_en_ligne_v2

# ENTÊTE
   
    Projet: 	Projet Final Flutter, Application de Cours en Ligne
    Codeurs:	Mathieu Hatin (2296939)
    Cours: 		Apps multi (420-324-AH)
	Date:		15 septembre 2023

# LANCER L'APPLICATION

    flutter run à la racine du projet.

# ÉNONCÉ/DESCRIPTION
    
    PROJET FINAL FLUTTER
     
        Application de Cours en Ligne
        Remise vendredi 15 septembre.
        (Remplace le dernier examen)
        Travail à 1 ou 2 maximum.

    OBJECTIF

        Créer une application en utilisant Flutter qui affiche une liste de cours en ligne.
        
        100% 
        Chaque cours sera représenté par une image et un titre.
        
        75% la page de détail est présentée dans un tab via un tab controller alors l'Effet Hero n'ai pas possible dans 
            ce contexte. Voir avec le prof si c'est ok?
        Lorsqu'un cours est sélectionné, une transition en utilisant le widget Hero montrera l'image du cours en plein écran avec le titre et la description du cours en dessous. Un bouton permettant de démarrer le cours cela lancera une transition vers un vidéo du cours. (Vous n’avez pas à intégrer le vidéo)
       
        L'application comportera également
            • un écran de profil étudiant
            • un écran de splash screen
            • un écran de login
            • un écran de création d'utilisateur
        
        75% Ça fonctionne ainsi mais toute les fonctionnalité ne sont pas encore donc 75% pour l'instant
        Pour faire la transition entre les différents états de l’application vous utiliserez une barre de navigation au bas de l’écran qui comportera un icône représentatif de chaque
    
    TÂCHES :
        
        ÉTAPE 1 : CRÉATION DE L'ÉCRAN SPLASH (10%) (100% fait)

            100% 1. Créez un écran de splash screen simple avec le titre de l'application ou un icône significatif            
            100% 2. Assurez-vous que l'écran de splash s'affiche au démarrage de l'application pendant 2 secondes avant de passer à l'écran suivant.
            
            Pistes :

            Vous pouvez créer votre splash screen comme étant StatelessWidget de la propriété home de votre materialApp et créer un Future.delayed dans la fonction « initState() » de votre splash, cependant vous pouvez aussi explorer l’ajout de la dépendance « animated_splash_screen » dans votre fichier yalm et définir le splash de cette façon, si vous prennez cette avenue, je veux avoir comme splashTransition : SplashTransition.scaleTransition.

        ÉTAPE 2 : CRÉATION DE L'ÉCRAN DE LISTE DE COURS (10%) (100% fait)

            100% 1. Créez une liste de cours fictifs en utilisant une classe `Cours` avec les attributs : titre, description et chemin d'accès à l'image.

            100% 2. Affichez ces cours dans un écran de liste en utilisant un `ListView.

            100% 3. Chaque élément de la liste (row) doit afficher le titre du cours et l'image associée. Assurez-vous d’avoir un listbuilder qui prend les cours en compte. Trouver comment afficher une image.
        
        ÉTAPE 3 : MISE EN PLACE DE LA TRANSITION AVEC HERO

            1. Lorsqu'un cours est sélectionné dans la liste, utilisez le widget `Hero` pour créer une transition fluide vers l'écran de détail du cours.

            2. Créez un nouvel écran appelé `EcranDetailCours` qui affiche l'image du cours en grand en utilisant le widget `Hero`, suivi du titre et de la description du cours.
        
        ÉTAPE 4 : AJOUT DE L'ÉCRAN DE PROFIL ÉTUDIANT

            1. Créez un écran de profil étudiant qui affiche des informations du profil utilisateur telles que le nom, prénom, numéro de dossier, nom de l’institution, l'adresse e-mail et la photo de profil de l'étudiant. Ces informations peuvent être ajoutés et sauvegardées si elles sont manquantes.

            2. Accédez à cet écran à partir d'un bouton ou d'une icône sur l'écran principal. Ces icônes peuvent être disposés de manière logique soit dans la appBar, soit dans un drawer, soit dans des tabs au bas de l’écran.
        
        ÉTAPE 5 : IMPLÉMENTATION DE L'ÉCRAN DE CRÉATION D'UTILISATEUR

            1. Créez un écran de création d'utilisateur qui permettra aux utilisateurs de saisir leur adresse e-mail et un mot de passe. Si il n’y a pas de session active c’est cet écran qui doit afficher après le splash screen

            2. Ajoutez des champs de saisie et un bouton de soumission avec une validation pour les champs et l’acceptation des conditions d’utilisation.
        
        ÉTAPE 6 : AUTRES TÂCHES.

            1. Implémentez une navigation entre les différents écrans en utilisant un système de routes et de navigation.

            2. Ajoutez des transitions d'écran animées pour une expérience utilisateur plus fluide.

            3. Stockez les informations de l'utilisateur localement et les cours dans des structures de données appropriées (peuvent être statique au début), mais préparer votre code pour ajouter les fonctions de base de données externes alors que nous progressons dans le cours.
            
        CRITÈRES DE RÉUSSITE :

            - L’application est adaptée pour un téléphone Android (instructions à venir) 5%

            100% - L'application doit démarrer par un écran de splash screen. 10%

            - L’application doit automatiquement transitionner vers un login s’il n’y a pas de session ou la liste des cours si une session est active. 5%

            50% - La liste de cours doit afficher les cours avec des images et des titres. (possibilité de charger ces information localement ou d’un serveur distant) 10%

            50% - La transition Hero doit fonctionner correctement et afficher l'image et les détails du cours. 10%

            - L'écran de profil étudiant doit contenir des informations justes et on peut les modifier. Les informations sont persistantes. 15%

            - L'écran de création d'utilisateur doit avoir des champs de saisie fonctionnels. 5%

            50% - L'application doit être bien structurée avec des fichiers séparés pour chaque écran et classe. 15%

            40% - L’application est bien désignée, elle est aussi riche en couleurs en texte et a une apparence dynamique et intéressante. Il y a un thème de couleur qui est respecté partout dans votre application ainsi que de bonne taille et police de texte. Quand c’est possible utiliser des animations et des transitions. 15%

            - Faire une présentation de votre projet au dernier cours. 10%

    SOUMISSION :
        
        Remettre le projet au complet compressé dans Léa.
    
    PERSONNEL CALCUL DE LA NOTE FINALE
        (10pt)    10%x100%      Splashscreen
        (10pt)    10%x100%      écran de liste de cours