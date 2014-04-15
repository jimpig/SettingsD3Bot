; -- Created with ISN Form Studio 2 for ISN AutoIt Studio -- ;

#NoTrayIcon

Global $MainForm = GUICreate("Settings Arreat Core",617,541,-1,-1,-1,-1)

;;On cr�� la Tab Options
TabOptions()
GUISetIcon(@ScriptDir & "\lib\ico\icon.ico")

;;Menu
$OutilsMenu = GUICtrlCreateMenu("Outils")
$LogsItem = GUICtrlCreateMenuItem("Afficher les logs", $OutilsMenu)
$StatsItem = GUICtrlCreateMenuItem("Afficher les stats", $OutilsMenu)
$GrablistsItem = GUICtrlCreateMenuItem("Afficher les grablists", $OutilsMenu)
$BuildsItem = GUICtrlCreateMenuItem("Afficher les builds", $OutilsMenu)
$OptionsMenu = GUICtrlCreateMenu("Options")
$VersionItem = GUICtrlCreateMenuItem("Version modifi�e", $OptionsMenu)
GUICtrlCreateMenuitem("", $OptionsMenu)
$EnreD3PrefsItem = GUICtrlCreateMenuItem("Enregistrer le D3Prefs.txt", $OptionsMenu)
$CpuGpuItem = GUICtrlCreateMenuItem("Cpu/gpu pour Bot", $OptionsMenu)
GUICtrlCreateMenuitem("", $OptionsMenu)
$DebugItem = GUICtrlCreateMenuItem("Debug (logs)", $OptionsMenu)
$DevmodeItem = GUICtrlCreateMenuItem("Devmode", $OptionsMenu)
$HelpMenu = GUICtrlCreateMenu("?")
$InfoItem = GUICtrlCreateMenuItem("Aide", $HelpMenu)
$AproposItem = GUICtrlCreateMenuItem("A propos", $HelpMenu)
;;Fin Menu

;;Groupe Profils
GUICtrlCreateGroup("Profils",5,5,441,272,-1,-1)
GUICtrlSetResizing(-1,  $GUI_DOCKALL)
GUICtrlSetBkColor(-1,"0xF0F0F0")
Global $AddProfil = GUICtrlCreateButton("Ajouter Profil",10,250,100,22,-1,-1)
GUICtrlSetResizing(-1,  $GUI_DOCKALL)
Global $EditProfil = GUICtrlCreateButton("Editer Profil",110,250,100,22,-1,-1)
GUICtrlSetResizing(-1,  $GUI_DOCKALL)
Global $DeleteProfil = GUICtrlCreateButton("Effacer Profil",210,250,100,22,-1,-1)
GUICtrlSetResizing(-1,  $GUI_DOCKALL)
Global $ChargerProfil = GUICtrlCreateButton("Charger Profil",340,250,100,22,-1,-1)
GUICtrlSetResizing(-1,  $GUI_DOCKALL)
Global $ListviewProfils = GUICtrlCreatelistview("",10,20,430,225,-1,512)
GUICtrlSetResizing(-1,  $GUI_DOCKALL)
Global $ImageLogo = GUICtrlCreatePic(@ScriptDir & "\lib\images\logo.jpg",455,10,156,156,-1,-1)
GUICtrlSetResizing(-1,  $GUI_DOCKALL)
Global $CheckBoxModeAvance = GUICtrlCreateCheckbox("Mode avanc�",460,180,150,20,-1,-1)
GUICtrlSetResizing(-1,  $GUI_DOCKALL)
_GUICtrlListView_InsertColumn($ListviewProfils, 0, "Profil", 100)
_GUICtrlListView_InsertColumn($ListviewProfils, 1, "Nom du perso", 100)
_GUICtrlListView_InsertColumn($ListviewProfils, 2, "Build", 226)
;; Fin Groupe Profils

Func TabOptions()
	Global $tab = GUICtrlCreatetab(10,300,600,211,-1,-1)
	GuiCtrlSetState(-1,2048)
	GUICtrlCreateTabItem("Options")
	GUICtrlCreateTabItem("")
	GUICtrlCreateTabItem("Logs")
	GUICtrlCreateInput("Texte",20,329,478,172,-1,512)
	GUICtrlCreateButton("Effacer",502,471,100,22,-1,-1)
	GUICtrlCreateButton("Exporter",502,438,100,22,-1,-1)
	GUICtrlCreateTabItem("")

	;On cache le TabItem
	GUICtrlSetState($tab, $GUI_HIDE)
EndFunc

Func ChoixVersion()

	Global $ChoixVersion = GUICreate("Choix de la version utilis�e",326,102,-1,-1,$WS_POPUP+$WS_BORDER,$WS_EX_TOPMOST)
	Global $RadioArreatCoreOriginal = GUICtrlCreateRadio("Arreat Core + Field",15,33,124,20,-1,-1)
	Global $RadioArreatCoreModif = GUICtrlCreateRadio("Arreat Core + Field modifi�",164,33,150,20,-1,-1)
	GUICtrlCreateLabel("Veuillez choisir la version que vous utilis� :",15,5,299,25,-1,-1)
	GUICtrlSetFont(-1,10,700,4,"MS Sans Serif")
	GUICtrlSetBkColor(-1,"-2")
	Global $ButtonValiderChoixVersion = GUICtrlCreateButton("Valider",15,68,292,27,-1,-1)
	GUISetState(@SW_SHOW,$ChoixVersion)

	AjoutLog("Ouverture de la fen�tre : Choix de la version")
	GUICtrlSetState($RadioArreatCoreOriginal, $GUI_CHECKED);on selectionne la version originale par d�faut

	While 1

		$nMsg = GUIGetMsg()

		Switch $nMsg

			Case $ButtonValiderChoixVersion

				If IsChecked($RadioArreatCoreOriginal) Then
					$VersionUtilisee = "Originale"
					GUICtrlSetState($BuildsItem, $GUI_DISABLE)
					GUICtrlSetState($ListviewProfils, $GUI_DISABLE)
					GUICtrlSetState($DeleteProfil, $GUI_DISABLE)
					GUICtrlSetState($ChargerProfil, $GUI_DISABLE)
					GUICtrlSetState($AddProfil, $GUI_DISABLE)
					$EditProfil = GUICtrlCreateButton("Editer Settings",110,250,100,22,-1,-1)
				Else
					$VersionUtilisee = "Modif"
				EndIf

				;on enregistre la version utilis�e dans SettingsArreatCore.ini
				iniwrite($OptionsIni, "Infos","VersionUtilisee",$VersionUtilisee)

				GUIDelete($ChoixVersion)
				AjoutLog("Fermeture de la fen�tre : Choix de la version")
				GUISetState(@SW_SHOW, $MainForm)
				ExitLoop

		EndSwitch
	WEnd
EndFunc;==>ChoixVersion

Func Builds()

	Global $Builds = GUICreate("Builds",377,302,-1,-1,-1,$WS_EX_TOPMOST)
	GUISetIcon(@scriptdir & "\lib\ico\icon.ico", -1)
	Global $ListBuilds = GUICtrlCreatelist("",15,25,144,227,-1,512)
	Global $ListsBuildsProfils = GUICtrlCreatelist("",215,25,144,227,-1,512)
	GUICtrlCreateGroup("Builds",10,5,157,258,-1,-1)
	GUICtrlSetBkColor(-1,"0xF0F0F0")
	GUICtrlCreateGroup("Profils",210,5,156,258,-1,-1)
	GUICtrlSetBkColor(-1,"0xF0F0F0")
	Global $ButtonBuildsImporter = GUICtrlCreateButton("Importer",5,270,80,25,-1,-1)
	Global $ButtonBuildsSupprimer = GUICtrlCreateButton("Supprimer",90,270,80,25,-1,-1)
	Global $ButtonBuildsCharger = GUICtrlCreateButton("Charger",285,270,80,25,-1,-1)
	GUICtrlCreateLabel(">>",175,120,20,23,-1,-1)
	GUICtrlSetFont(-1,12,700,0,"MS Sans Serif")
	GUICtrlSetBkColor(-1,"-2")
	Global $ButtonBuildsFermer = GUICtrlCreateButton("Fermer",200,270,80,25,-1,-1)
	GUISetState(@SW_SHOW,$Builds)

	AjoutLog("Ouverture de la fen�tre Builds")
	ListFichier($DossierBuilds,2) ; on list les builds
	ListFichier($DossierProfils,3) ; On list les profils

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg

			Case $GUI_EVENT_CLOSE
				GUIDelete($Builds)
				AjoutLog("Fermeture de la fen�tre Builds")
				ExitLoop

			Case $ButtonBuildsFermer
				GUIDelete($Builds)
				AjoutLog("Fermeture de la fen�tre Builds")
				ExitLoop

			Case $ButtonBuildsCharger
				$BuildSel = $DossierBuilds & GUICtrlRead($ListBuilds)
				$ProfilBuildSel = $DossierProfilsSettings & "settingshero_" & GUICtrlRead($ListsBuildsProfils)
				FileCopy($BuildSel, $ProfilBuildSel, 9)
				AjoutLog("Chargement du build : " & $BuildSel & "dans le profil : " & $ProfilBuildSel)

			Case $ButtonBuildsSupprimer
				$SuppBuild = GUICtrlRead($ListBuilds)
				If $SuppBuild = "" Then
					MsgBox( 48 + 262144, "", "Aucun build s�lectionn� !!", 3)
				Else
					FileDelete($DossierBuilds & $SuppBuild)
					AjoutLog("Suppression du build : " & $SuppBuild)
					ListFichier($DossierBuilds,2)
				EndIf

			Case $ButtonBuildsImporter
				Local Const $sMessage = "S�lectionner le build � importer."
				Local $sFile = FileOpenDialog($sMessage, @WindowsDir & "\", "Settings (*.ini;)")
				If @error Then
					MsgBox( 48 + 262144, "", "Aucun fichier s�lectionn� !!", 3)
				Else
					$fName = StringRegExpReplace($sFile, "^.*\\", "")
					FileCopy($sFile, $DossierBuilds & $fName)
					AjoutLog("Importation Build : " & $fName)
					ListFichier($DossierBuilds,2)
				EndIf
		EndSwitch
	WEnd
EndFunc;==>Builds

Func Apropos()

	$Apropos = GUICreate("A Propos",350,166,-1,-1,-1,$WS_EX_TOPMOST)
	GUISetIcon(@ScriptDir & "\lib\ico\icon.ico")
	$ButtonFermerApropos = GUICtrlCreateButton("Quitter",266,140,79,20,-1,-1)
	$ImageApropos = GUICtrlCreatePic(@ScriptDir & "\lib\images\logo.jpg",5,5,156,156,-1,-1)
	GUICtrlCreateLabel("Settings Arreat Core",185,10,143,15,-1,-1)
	GUICtrlSetFont(-1,10,700,0,"MS Sans Serif")
	GUICtrlSetBkColor(-1,"-2")
	$LabelVersionApropos = GUICtrlCreateLabel("Version 1.3d",225,30,67,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Pour plus d'information :",170,100,118,15,-1,-1)
	GUICtrlSetFont(-1,8,400,4,"MS Sans Serif")
	GUICtrlSetBkColor(-1,"-2")
	$LabelLienForum = GuiCtrlCreateHyperlink("http://forum.gmstemple.com/",175,120,166,15,0x0000ff,"Cliquer pour acc�der au site !")
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("D�velopper par Sebo.",175,56,127,15,-1,-1)
	GUICtrlSetColor(-1,"0x008000")
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Remerciement � Jiisan.",175,75,153,15,-1,-1)
	GUICtrlSetColor(-1,"0x008000")
	GUICtrlSetBkColor(-1,"-2")
	GUISetState(@SW_SHOW,$Apropos)

	AjoutLog("Affichage de la fen�tre A Propos")
	GUICtrlSetData($LabelVersionApropos, "Version " & $Version)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($Apropos)
				AjoutLog("Fermeture de la fen�tre A Propos")
				ExitLoop

			Case $ButtonFermerApropos
				GUIDelete($Apropos)
				AjoutLog("Fermeture de la fen�tre A Propos")
				ExitLoop

			Case $LabelLienForum
				ShellExecute("http://forum.gmstemple.com/")

		EndSwitch
	WEnd

EndFunc;==>Apropos

Func CreerBuild()

	Global $CreerBuild = GUICreate("Nom du build",260,80,-1,-1,-1,$WS_EX_TOPMOST)
	GUISetIcon(@ScriptDir & "\lib\ico\icon.ico")
	GUICtrlCreateLabel("Nom du build :",15,15,74,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputCreerBuild = GUICtrlCreateInput("",95,10,150,20,-1,512)
	Global $ButtonCreerBuild = GUICtrlCreateButton("Cr�er",145,40,100,30,-1,-1)
	Global $ButtonAnnulerCreerBuild = GUICtrlCreateButton("Annuler",15,40,100,30,-1,-1)
	GUISetState(@SW_SHOW,$CreerBuild)

	AjoutLog("Ouverture de la fen�tre 'Cr�er un build'")

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($CreerBuild)
				AjoutLog("Fermeture de la fen�tre 'Cr�er un build'")
				ExitLoop

			Case $ButtonCreerBuild
				$NomBuild = GUICtrlRead($InputCreerBuild) & ".ini"
				If FileExists($DossierBuilds & $NomBuild) Then
					MsgBox( 48 + 262144, "", "Build d�j� �xistant", 3)
					ContinueLoop
				Else
					FileCopy($FichierSettingsHeroDefaut, $DossierBuilds & $NomBuild)
					AjoutLog("Cr�ation d'un nouveau build :" & $NomBuild)
				EndIf
				GUIDelete($CreerBuild)
				AjoutLog("Fermeture de la fen�tre 'Cr�er un build'")
				ExitLoop

			Case $ButtonAnnulerCreerBuild
				GUIDelete($CreerBuild)
				AjoutLog("Annulation de la cr�ation d'un build")
				ExitLoop

		EndSwitch
	WEnd

EndFunc;==>CreerBuild

Func Logs()

 	Global $MainLogs = GUICreate("Logs",536,535,-1,-1,-1,-1)
	GUISetIcon(@scriptdir & "\lib\ico\icon.ico", -1)
	Global $EditLogs = GUICtrlCreateEdit("",5,5,525,495,3145728,-1)
	Global $ButtonExporterLogs = GUICtrlCreateButton("Exporter",430,505,100,25,-1,-1)
	Global $ButtonEffacerLogs = GUICtrlCreateButton("Effacer",220,505,100,25,-1,-1)
	Global $ButtonFermerLogs = GUICtrlCreateButton("Fermer",325,505,100,25,-1,-1)
	GUISetState(@SW_SHOW,$MainLogs)

	AjoutLog("Ouverture de la fen�tre Logs")
	GUICtrlSetData($EditLogs,$Logs)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($MainLogs)
				AjoutLog("Fermeture de la fen�tre Logs")
				ExitLoop

			Case $ButtonFermerLogs
				GUIDelete($MainLogs)
				AjoutLog("Fermeture de la fen�tre Logs")
				ExitLoop

			Case $ButtonEffacerLogs
				GUICtrlSetData($EditLogs,"")

			Case $ButtonExporterLogs
				CreerFichierLogs ()
				GUICtrlSetData($EditLogs,$Logs)

		EndSwitch
	WEnd

EndFunc;==>Logs

Func Grablists()

	Global $Grablist = GUICreate("Grablists",668,420,-1,-1,-1,-1)
	GUISetIcon(@ScriptDir & "\lib\ico\icon.ico")
	Global $EditGrablists = GUICtrlCreateEdit("",5,40,659,376,-1,-1)
	Global $ComboLectureGrablist = GUICtrlCreateCombo("",80,10,150,21,-1,-1)
	If $VersionUtilisee = "Originale" Then
		GUICtrlSetData(-1,"grablist_file.txt")
	Else
		GUICtrlSetData(-1,"grabListTourment.txt|grabListTourmentXp.txt|grabListTourmentRecycle.txt|grablistNormal.txt|grablistDifficile.txt|grablistExpert.txt|grablistCalvaire.txt")
	EndIf
	GUICtrlCreateLabel("Grablists :",15,15,50,15,-1,-1)
	GUICtrlSetFont(-1,8,400,4,"MS Sans Serif")
	GUICtrlSetBkColor(-1,"-2")
	Global $ButtonEnregistrerModif = GUICtrlCreateButton("Enregistrer les modifications",501,10,155,25,-1,-1)
	Global $ButtonFermerGrablist = GUICtrlCreateButton("Fermer",415,10,83,25,-1,-1)
	GUISetState(@SW_SHOW,$Grablist)

	AjoutLog("Ouverture de la fen�tre Grablist")

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($Grablist)
				AjoutLog("Fermeture de la fen�tre Grablist")
				ExitLoop

			Case $ButtonFermerGrablist
				GUIDelete($Grablist)
				AjoutLog("Fermeture de la fen�tre Grablist")
				ExitLoop

			Case $ButtonEnregistrerModif
				CreerFichier()


			Case $ComboLectureGrablist
				LectureGrablist()


		EndSwitch
	WEnd

EndFunc ;==>Grablists

Func Stats()

	Global $Stats = GUICreate("Stats",646,401,-1,-1,-1,-1)
	GUISetIcon(@scriptdir & "\lib\ico\icon.ico", -1)
	Global $EditStats = GUICtrlCreateEdit("",225,5,404,390,-1,-1)
	Global $ListStats = GUICtrlCreatelist("",15,52,200,266,-1,512)
	GUICtrlCreateLabel("Stats du :",15,10,50,15,-1,-1)
	GUICtrlSetFont(-1,8,400,4,"MS Sans Serif")
	GUICtrlSetBkColor(-1,"-2")
	Global $ButtonEffacerStats = GUICtrlCreateButton("Tout effacer",15,320,200,25,-1,-1)
	Global $ButtonCopierStats = GUICtrlCreateButton("Copier dans le presse-papier",15,370,200,25,-1,-1)
	Global $LabelDateStats = GUICtrlCreateLabel("",15,30,195,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $ButtonFermerStats = GUICtrlCreateButton("Fermer",15,345,200,25,-1,-1)
	GUISetState(@SW_SHOW,$Stats)

	AjoutLog("Ouverture de la fen�tre Stats")
	if FileExists($DossierStats) = 0 Then DirCreate($DossierStats)

	ListFichier($DossierStats,1)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($Stats)
				AjoutLog("Fermeture de la fen�tre Stats")
				ExitLoop

			Case $ButtonFermerStats
				GUIDelete($Stats)
				AjoutLog("Fermeture de la fen�tre Stats")
				ExitLoop

			Case $ButtonEffacerStats

				DirRemove($DossierStats, 1)
				DirCreate($DossierStats)
				ListFichier($DossierStats,1)
				GUICtrlSetData($EditStats,"")
				AjoutLog("Effacement des stats")

			Case $ButtonCopierStats
				Local $StatsCopier = GUICtrlRead($EditStats)
				ClipPut($StatsCopier)
				AjoutLog("Copie des stats dans le presse-papier")

			Case $ListStats

				GUICtrlSetData($EditStats,"")
				If GUICtrlRead($ListStats) = "" or GUICtrlRead($ListStats) = "Aucune stat" Then
					GUICtrlSetData($EditStats,"Aucune stat de dispo")
				Else
					Local $FichierLu = $DossierStats & GUICtrlRead($ListStats)
					ParseFichierStats(GUICtrlRead($ListStats))
					AfficheStats($FichierLu)
				EndIf

		EndSwitch
	WEnd

EndFunc;==>Stats

Func EditSettings($ProfilSel)

	Global $settings = GUICreate("Modification des fichiers settings.ini",731,368,-1,-1,-1,-1)
	Global $tab = GUICtrlCreatetab(11,10,712,313,-1,-1)
	GuiCtrlSetState(-1,2048)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateTabItem("Settings")
	GUICtrlCreateTabItem("Runs")
	GUICtrlCreateTabItem("S�quences")
	GUICtrlCreateTabItem("S�quences Boss")
	GUICtrlCreateTabItem("Routines")
	GUICtrlCreateTabItem("Spells")
	GUICtrlCreateTabItem("")
	_GUICtrlTab_SetCurFocus($tab,-1)
	GUISwitch($settings,_GUICtrlTab_SetCurFocus($tab,0)&GUICtrlRead ($tab, 1))
	GUICtrlCreateLabel("Pass D3 :",18,44,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputPassD3 = GUICtrlCreateInput("",68,39,150,20,-1,512)
	Global $RadioBotSeul = GUICtrlCreateRadio("Bot seul",235,39,60,20,-1,-1)
	GUICtrlCreateGroup("Gestion Raccourcis",18,68,182,242,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $RadioBotTeam = GUICtrlCreateRadio("Bot en team",304,39,80,20,-1,-1)
	GUICtrlCreateLabel("CoseWindows :",25,88,75,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputCloseWindows = GUICtrlCreateInput("",104,83,88,20,1,512)
	GUICtrlCreateLabel("Inventaire :",25,138,66,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputMouseMove = GUICtrlCreateInput("",104,108,88,20,1,512)
	Global $InputInventory = GUICtrlCreateInput("",104,133,32,20,1,512)
	GUICtrlCreateLabel("MouseMove :",25,113,66,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputPotions = GUICtrlCreateInput("",104,158,32,20,1,512)
	Global $InputPortal = GUICtrlCreateInput("",104,183,32,20,1,512)
	GUICtrlCreateLabel("Potions :",25,163,66,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Portal :",25,188,66,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $Inputkey1 = GUICtrlCreateInput("",104,208,32,20,1,512)
	Global $Inputkey2 = GUICtrlCreateInput("",104,233,32,20,1,512)
	Global $Inputkey3 = GUICtrlCreateInput("",104,258,32,20,1,512)
	Global $Inputkey4 = GUICtrlCreateInput("",104,283,32,20,1,512)
	GUICtrlCreateLabel("Key1 :",25,213,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Key2 :",25,238,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Key4 :",25,288,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Key3 :",25,263,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateGroup("Gestion Pauses",210,68,174,95,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateGroup("Gestion Loots",210,165,174,145,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $CheckboxPause = GUICtrlCreateCheckbox("Pause",217,83,114,20,-1,-1)
	Global $InputApresXparties = GUICtrlCreateInput("",342,108,34,20,1,512)
	Global $InputTempsPause = GUICtrlCreateInput("",342,133,34,20,1,512)
	GUICtrlCreateLabel("Pause apr�s X parties :",216,113,114,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Temps de Pause :",217,138,92,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlSetTip(-1,"Temps de pause en seconde ==> 6 min x 60 s = 360 s")
	GUICtrlCreateLabel("Objets stock�s :",216,185,88,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Objets recycl�s :",217,210,87,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Objets vendus :",217,235,87,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputQualiteItemKeep = GUICtrlCreateInput("",307,180,69,20,1,512)
	Global $InputQualiteItemSalvage = GUICtrlCreateInput("",307,205,69,20,1,512)
	Global $InputQualiteItemSell = GUICtrlCreateInput("",307,230,69,20,1,512)
	Global $CheckboxFiltreNoID = GUICtrlCreateCheckbox("Non Identifi�",216,280,150,20,-1,-1)
	Global $ComboUnknownItemAction = GUICtrlCreateCombo("",307,255,69,21,-1,-1)
	GUICtrlSetData(-1,"Vendre|Recycler")
	GUICtrlCreateLabel("Trash Sac :",216,258,77,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateGroup("Gestion Games",392,68,192,145,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $ComboTypeBot = GUICtrlCreateCombo("",476,82,100,21,-1,-1)
	GUICtrlSetData(-1,"Semi-Manuel|Auto|Manuel")
	GUICtrlCreateLabel("Type de Bot :",400,88,72,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $ComboPM = GUICtrlCreateCombo("",476,133,99,21,-1,-1)
	GUICtrlSetData(-1,"Tourment1|Tourment2|Tourment3|Tourment4|Tourment5|Tourment6")
	Global $ComboDifficulte = GUICtrlCreateCombo("",476,108,99,21,-1,-1)
	GUICtrlSetData(-1,"Normal|Difficile|Expert|Calvaire|Tourment")
	GUICtrlCreateLabel("Difficult� :",400,113,72,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("P. Monstres :",400,138,69,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Grablist :",400,163,69,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $ComboGrablist = GUICtrlCreateCombo("",476,157,99,21,-1,-1)
	GUICtrlSetData(-1,"Tourment|TourmentXp")
	Global $CheckboxFollower = GUICtrlCreateCheckbox("Follower",400,185,150,20,-1,-1)
	GUICtrlCreateTabItem("")
	Global $ButtonEnregistrerSettings = GUICtrlCreateButton("Enregistrer les modifications",562,330,161,30,-1,-1)
	Global $ButtonParDefautSettings = GUICtrlCreateButton("Valeurs par d�faut",447,330,111,30,-1,-1)
	GUISwitch($settings,_GUICtrlTab_SetCurFocus($tab,0)&GUICtrlRead ($tab, 1))
	Global $CheckboxChaseElite = GUICtrlCreateCheckbox("ChaseElite",597,82,89,21,-1,-1)
	Global $CheckboxWaitForLoot = GUICtrlCreateCheckbox("WaitForLoot",597,108,89,20,-1,-1)
	GUISwitch($settings,_GUICtrlTab_SetCurFocus($tab,1)&GUICtrlRead ($tab, 1))
	Global $ComboChoixRun = GUICtrlCreateCombo("",106,40,272,20,-1,-1)
	GUICtrlSetData(-1,"Mode Bounty|Mode aventure|Mode Campagne : Acte Al�atoire (Act1,Act2,Act3)|Mode Campagne : S�quence par d�faut/Test/etc|Mode Campagne : Act 1|Mode Campagne : Act 2|Mode Campagne : Act 3|Mode Campagne : Lt Vachem et Tuer Maghda|Mode Campagne : Tuer Maghda|Mode Campagne : Tuer Zoltun Kulle|Mode Campagne : Tuer Belial|Mode Campagne : Tuer Ghom|Mode Campagne : Tuer le Briseur de Si�ge|Mode Campagne : Tuer Asmodan|Mode Campagne : Tuer Asmodan, Iskatu et Rakanoth|Mode Campagne : Tuer Iskatu et Rakanoth|Mode Campagne : Tuer Diablo")
	GUICtrlCreateLabel("Chois du Run :",22,45,78,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateGroup("S�quence Al�atoire",385,37,327,98,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $CheckboxSequencesAlea = GUICtrlCreateCheckbox("Activ�",398,53,150,20,-1,-1)
	GUICtrlCreateLabel("Changement Acte :",395,81,99,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputChangementAct = GUICtrlCreateInput("",515,76,33,21,1,512)
	GUICtrlCreateLabel("Changement Run :",395,109,99,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputChangementRun = GUICtrlCreateInput("",515,103,33,21,1,512)
	GUICtrlCreateLabel("Act1 (min-max) :",561,57,77,13,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputAct1Max = GUICtrlCreateInput("",677,51,25,20,1,512)
	Global $InputAct1Min = GUICtrlCreateInput("",644,51,25,20,1,512)
	Global $InputAct2Min = GUICtrlCreateInput("",644,77,25,20,1,512)
	Global $InputAct2Max = GUICtrlCreateInput("",677,77,25,20,1,512)
	Global $InputAct3Max = GUICtrlCreateInput("",677,103,25,20,1,512)
	Global $InputAct3Min = GUICtrlCreateInput("",644,103,25,20,1,512)
	GUICtrlCreateLabel("Act2 (min-max) :",561,84,77,13,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Act3 (min-max) :",561,110,77,13,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("BountyAct :",22,75,73,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputBountyAct = GUICtrlCreateInput("",104,68,88,20,1,512)
	Global $InputRackList = GUICtrlCreateInput("",149,290,532,20,-1,512)
	GUICtrlCreateLabel("List des Racks :",22,295,135,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Liste des Coffres :",22,270,98,13,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Liste du Decor :",22,247,78,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputChestList = GUICtrlCreateInput("",149,266,532,20,-1,512)
	Global $InputDecorList = GUICtrlCreateInput("",149,242,532,20,-1,512)
	GUICtrlCreateLabel("Liste Monstres Sp�ciaux :",22,222,145,13,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Liste Monstres :",22,198,102,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Priorit� Monstres :",22,176,108,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputSpecialmonterList = GUICtrlCreateInput("",149,218,532,20,-1,512)
	Global $InputPriorityMonsterList = GUICtrlCreateInput("",149,170,532,20,-1,512)
	Global $InputMonsterList = GUICtrlCreateInput("",149,194,532,20,-1,512)
	GUISwitch($settings,_GUICtrlTab_SetCurFocus($tab,2)&GUICtrlRead ($tab, 1))
	Global $InputSequenceAct2 = GUICtrlCreateInput("",129,59,552,18,-1,512)
	Global $InputSequenceAct1 = GUICtrlCreateInput("",129,37,552,18,-1,512)
	Global $InputSequenceAct3 = GUICtrlCreateInput("",129,81,552,18,-1,512)
	Global $InputSequenceAct3Pt = GUICtrlCreateInput("",129,103,552,18,-1,512)
	Global $InputSequenceTest = GUICtrlCreateInput("",129,158,552,18,-1,512)
	Global $InputSequenceAventure = GUICtrlCreateInput("",129,180,552,18,-1,512)
	GUICtrlCreateLabel("S�quence Acte 1 :",18,40,102,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("S�quence Acte 2 :",18,62,102,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("S�quence Acte 3 :",18,84,102,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("S�quence Acte 3 PT :",18,107,128,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("S�quence Test :",18,161,102,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("S�quence Aventure :",18,183,102,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $ButtonResetSequenceAventure = GUICtrlCreateButton("R",686,178,21,20,-1,-1)
	Global $ButtonResetSequenceTest = GUICtrlCreateButton("R",686,156,21,20,-1,-1)
	Global $ButtonResetAct3PT = GUICtrlCreateButton("R",686,102,21,20,-1,-1)
	Global $ButtonResetAct3 = GUICtrlCreateButton("R",686,80,21,20,-1,-1)
	Global $ButtonResetAct1 = GUICtrlCreateButton("R",686,36,21,20,-1,-1)
	Global $ButtonResetAct2 = GUICtrlCreateButton("R",686,58,21,20,-1,-1)
	GUISwitch($settings,_GUICtrlTab_SetCurFocus($tab,1)&GUICtrlRead ($tab, 1))
	Global $ButtonResetPrioMonstre = GUICtrlCreateButton("R",687,170,21,20,-1,-1)
	Global $ButtonResetListeMonstres = GUICtrlCreateButton("R",687,194,21,20,-1,-1)
	Global $ButtonResetListeMonstreSpe = GUICtrlCreateButton("R",687,218,21,20,-1,-1)
	Global $ButtonResetListeDecor = GUICtrlCreateButton("R",687,241,21,20,-1,-1)
	Global $ButtonResetListeCoffre = GUICtrlCreateButton("R",687,266,21,20,-1,-1)
	Global $ButtonResetListeRack = GUICtrlCreateButton("R",687,290,21,20,-1,-1)
	GUISwitch($settings,_GUICtrlTab_SetCurFocus($tab,3)&GUICtrlRead ($tab, 1))
	Global $ButtonResetSequence222 = GUICtrlCreateButton("R",688,43,21,20,-1,-1)
	Global $InputSequenceAct222 = GUICtrlCreateInput("",129,44,552,18,-1,512)
	Global $InputSequenceAct232 = GUICtrlCreateInput("",129,66,552,18,-1,512)
	Global $InputSequenceAct283 = GUICtrlCreateInput("",129,88,552,18,-1,512)
	Global $InputSequenceAct299 = GUICtrlCreateInput("",129,110,552,18,-1,512)
	Global $InputSequenceAct333 = GUICtrlCreateInput("",129,132,552,18,-1,512)
	Global $InputSequenceAct362 = GUICtrlCreateInput("",130,154,552,18,-1,512)
	Global $InputSequenceAct374 = GUICtrlCreateInput("",129,176,552,18,-1,512)
	Global $InputSequenceAct373 = GUICtrlCreateInput("",129,198,552,18,-1,512)
	Global $InputSequenceAct411 = GUICtrlCreateInput("",129,220,552,18,-1,512)
	Global $InputSequenceAct442 = GUICtrlCreateInput("",129,242,552,18,-1,512)
	Global $ButtonResetSequence232 = GUICtrlCreateButton("R",688,65,21,20,-1,-1)
	Global $ButtonResetSequence283 = GUICtrlCreateButton("R",688,87,21,20,-1,-1)
	Global $ButtonResetSequence299 = GUICtrlCreateButton("R",688,109,21,20,-1,-1)
	Global $ButtonResetSequence333 = GUICtrlCreateButton("R",688,131,21,20,-1,-1)
	Global $ButtonResetSequence362 = GUICtrlCreateButton("R",688,152,21,20,-1,-1)
	Global $ButtonResetSequence374 = GUICtrlCreateButton("R",688,174,21,20,-1,-1)
	Global $ButtonResetSequence373 = GUICtrlCreateButton("R",688,196,21,20,-1,-1)
	Global $ButtonResetSequence411 = GUICtrlCreateButton("R",688,219,21,20,-1,-1)
	Global $ButtonResetSequence442 = GUICtrlCreateButton("R",688,241,21,20,-1,-1)
	GUICtrlCreateLabel("Lt Vachem / Maghda :",15,47,107,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Maghda :",15,69,107,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Zoltun Kulle :",15,92,107,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Belial :",15,114,107,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Ghom :",15,136,107,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Briseur de Si�ge :",15,158,107,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Asmo/Iskatu/Raka  :",15,180,107,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Asmodan :",15,202,107,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Iskatu / Rakanoth :",15,224,107,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Diablo :",15,244,107,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUISwitch($settings,_GUICtrlTab_SetCurFocus($tab,4)&GUICtrlRead ($tab, 1))
	GUICtrlCreateGroup("Gestion Vie",17,36,259,70,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputPotionStock = GUICtrlCreateInput("",117,51,29,20,1,512)
	Global $InputLifeForPotion = GUICtrlCreateInput("",238,51,29,20,1,512)
	Global $InputVieGlobes = GUICtrlCreateInput("",238,78,29,20,1,512)
	Global $InputNbPotionBuy = GUICtrlCreateInput("",117,78,29,20,1,512)
	GUICtrlCreateGroup("R�surrection",608,36,102,70,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $CheckboxResActivated = GUICtrlCreateCheckbox("Activ�e",619,56,65,20,-1,-1)
	GUICtrlCreateLabel("Nombre :",621,85,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputResLife = GUICtrlCreateInput("",671,80,28,20,1,512)
	GUICtrlCreateGroup("Pause HC",609,108,102,70,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $CheckboxSecuHC = GUICtrlCreateCheckbox("Activ�e",618,128,65,20,-1,-1)
	GUICtrlCreateLabel("Vie mini :",620,158,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputViemini = GUICtrlCreateInput("",668,153,28,20,1,512)
	GUICtrlCreateLabel("Stock Potions :",27,57,75,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Potions achet�e :",27,83,88,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Vie pour Potions :",153,56,88,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Vie pour Globes :",153,83,88,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateGroup("Gestion Affixes",18,109,259,196,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $CheckboxUsePath = GUICtrlCreateCheckbox("UsePath",621,187,63,23,-1,-1)
	Global $InputLifeArcane = GUICtrlCreateInput("",116,127,29,20,1,512)
	Global $InputLifePeste = GUICtrlCreateInput("",239,127,29,20,1,512)
	Global $InputLifeProj = GUICtrlCreateInput("",116,155,29,20,1,512)
	Global $InputLifeLave = GUICtrlCreateInput("",116,183,29,20,1,512)
	Global $InputLifeMine = GUICtrlCreateInput("",116,211,29,20,1,512)
	Global $InputLifeSpore = GUICtrlCreateInput("",116,240,29,20,1,512)
	Global $InputLifeArm = GUICtrlCreateInput("",116,269,29,20,-1,512)
	Global $InputLifeProfa = GUICtrlCreateInput("",239,155,29,20,1,512)
	Global $InputLifeIce = GUICtrlCreateInput("",239,183,29,20,1,512)
	Global $InputLifePoison = GUICtrlCreateInput("",239,211,29,20,1,512)
	Global $InputLifeExplo = GUICtrlCreateInput("",239,240,29,20,1,512)
	Global $InputLifeLightning = GUICtrlCreateInput("",239,269,29,20,1,512)
	GUICtrlCreateLabel("Arcane (%vie) :",27,131,79,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Proj (%vie) :",27,159,79,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Lave (%vie) :",27,187,79,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Mine (%vie) :",27,215,79,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Arm (%vie) :",27,273,79,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Spore (%vie) :",27,244,79,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Profa (%vie) :",154,159,79,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Peste (%vie) :",154,129,79,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Glace (%vie) :",154,187,79,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Poison (%vie) :",154,214,79,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Explo (%vie) :",154,242,79,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Elec (%vie) :",154,273,79,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateGroup("",282,36,160,130,-1,-1)
	GUICtrlSetBkColor(-1,"0xF0F0F0")
	GUICtrlCreateGroup("",448,36,155,130,-1,-1)
	GUICtrlSetBkColor(-1,"0xF0F0F0")
	Global $Inputattacktimeout = GUICtrlCreateInput("",386,51,45,20,1,512)
	Global $Inputgrabtimeout = GUICtrlCreateInput("",386,78,45,20,1,512)
	GUICtrlCreateLabel("Tempo. Attaque :",295,56,92,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Dist Attaque :",295,110,112,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Tempo. Collecte :",295,83,96,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Dist Collecte :",295,138,101,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputattackRange = GUICtrlCreateInput("",386,106,45,20,1,512)
	Global $InputgrabRange = GUICtrlCreateInput("",386,134,45,20,1,512)
	GUICtrlCreateGroup("",282,170,182,135,-1,-1)
	GUICtrlSetBkColor(-1,"0xF0F0F0")
	GUICtrlCreateGroup("",470,170,133,135,-1,-1)
	GUICtrlSetBkColor(-1,"0xF0F0F0")
	Global $CheckboxItemRefresh = GUICtrlCreateCheckbox("V�rif. si Objet",479,180,118,20,-1,-1)
	Global $CheckboxInventoryCheck = GUICtrlCreateCheckbox("V�rif. Inventaire",479,205,118,20,-1,-1)
	Global $CheckboxMonsterPriority = GUICtrlCreateCheckbox("Priorit� Monstres",479,230,118,20,-1,-1)
	Global $CheckboxMonsterTri = GUICtrlCreateCheckbox("Tri des Monstres",479,255,118,20,-1,-1)
	Global $CheckboxMonsterRefresh = GUICtrlCreateCheckbox("V�rif. si Monstres",479,280,118,20,-1,-1)
	Global $CheckboxGestionaffixe = GUICtrlCreateCheckbox("Gestion des Affixes",291,180,150,20,-1,-1)
	Global $CheckboxGestionaffixeloot = GUICtrlCreateCheckbox("Gestion Affixes Loot",291,205,150,20,-1,-1)
	Global $CheckboxGestaffixeByClass = GUICtrlCreateCheckbox("Gestion Affixes Classe",291,230,150,20,-1,-1)
	Global $InputBanAffixList = GUICtrlCreateInput("",289,281,169,19,-1,512)
	GUICtrlCreateLabel("Bannir Affixes :",291,258,163,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Temps Max / Parties :",461,51,115,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $Inputmaxgamelength = GUICtrlCreateInput("",458,78,106,20,1,512)
	Global $CheckboxTakeShrines = GUICtrlCreateCheckbox("Prendre Sanctuaires",461,133,123,22,-1,-1)
	GUICtrlCreateLabel("Reparation (Partie) :",461,110,106,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $Inputrepairafterxxgames = GUICtrlCreateInput("",567,106,28,20,1,512)
	GUISwitch($settings,_GUICtrlTab_SetCurFocus($tab,5)&GUICtrlRead ($tab, 1))
	GUICtrlCreateGroup("Souris Gauche",18,31,696,52,-1,-1)
	GUICtrlSetBkColor(-1,"0xF0F0F0")
	Global $CheckboxSpellOnLeft = GUICtrlCreateCheckbox("Activ�e",24,52,55,21,-1,-1)
	GUICtrlCreateLabel("D�lai :",90,57,35,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputSpellDelayLeft = GUICtrlCreateInput("",127,52,47,19,1,512)
	GUICtrlCreateLabel("Type :",191,55,32,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputSpellTypeLeft = GUICtrlCreateInput("",230,51,112,20,-1,512)
	GUICtrlCreateLabel("Energie :",360,58,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputSpellEnergyNeedsLeft = GUICtrlCreateInput("",411,54,37,20,1,512)
	GUICtrlCreateLabel("Vie :",465,58,28,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputSpellLifeLeft = GUICtrlCreateInput("",495,54,37,20,1,512)
	Global $InputSpellDistanceLeft = GUICtrlCreateInput("",609,54,37,20,1,512)
	GUICtrlCreateLabel("Distance :",548,57,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateGroup("Souris Droite",18,86,696,52,-1,-1)
	GUICtrlSetBkColor(-1,"0xF0F0F0")
	Global $InputSpellEnergyNeedsRight = GUICtrlCreateInput("",411,106,37,20,1,512)
	Global $InputSpellLifeRight = GUICtrlCreateInput("",495,106,37,20,1,512)
	Global $InputSpellDistanceRight = GUICtrlCreateInput("",609,106,37,20,1,512)
	Global $InputSpellTypeRight = GUICtrlCreateInput("",230,106,112,20,-1,512)
	Global $InputSpellDelayRight = GUICtrlCreateInput("",127,106,47,19,1,512)
	Global $CheckboxSpellOnRight = GUICtrlCreateCheckbox("Activ�e",24,106,55,21,-1,-1)
	GUICtrlCreateLabel("D�lai :",90,110,35,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Type :",191,110,32,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Energie :",360,110,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Vie :",465,111,28,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Distance :",548,111,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateGroup("Spells Secondaires",18,142,696,153,-1,-1)
	GUICtrlSetBkColor(-1,"0xF0F0F0")
	Global $RadioTouche1 = GUICtrlCreateRadio("Premier Spell (1)",27,163,100,21,-1,-1)
	Global $RadioTouche2 = GUICtrlCreateRadio("Deuxi�me Spell (2)",141,163,107,21,-1,-1)
	Global $RadioTouche3 = GUICtrlCreateRadio("Troisi�me Spell (3)",265,163,116,21,-1,-1)
	Global $RadioTouche4 = GUICtrlCreateRadio("Quatri�me Spell (4)",391,163,109,21,-1,-1)
	Global $CheckboxTouche = GUICtrlCreateCheckbox("Activ�e",27,190,55,21,-1,-1)
	GUICtrlCreateLabel("D�lai :",90,195,35,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputSpellDelay = GUICtrlCreateInput("",127,192,47,19,1,512)
	GUICtrlCreateGroup("Pr�buff",27,222,178,53,-1,-1)
	GUICtrlSetBkColor(-1,"0xF0F0F0")
	Global $CheckboxPrebuff = GUICtrlCreateCheckbox("Activ�e",38,243,55,21,-1,-1)
	GUICtrlCreateLabel("D�lai :",106,248,35,16,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputPrebuffDelay = GUICtrlCreateInput("",146,244,47,19,1,512)
	GUICtrlCreateLabel("Type :",191,197,32,14,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputSpellType = GUICtrlCreateInput("",230,192,112,20,-1,512)
	GUICtrlCreateLabel("Energie :",360,197,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputSpellEnergyNeeds = GUICtrlCreateInput("",411,192,37,20,1,512)
	Global $InputSpellLife = GUICtrlCreateInput("",495,192,37,20,1,512)
	Global $InputSpellDistance = GUICtrlCreateInput("",609,191,37,20,1,512)
	GUICtrlCreateLabel("Vie :",465,197,28,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Distance :",548,196,50,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUISwitch($settings,_GUICtrlTab_SetCurFocus($tab,1)&GUICtrlRead ($tab, 1))
	Global $CheckboxNoAdventure = GUICtrlCreateCheckbox("Pas de Prime : S�quence Aventure",22,95,201,20,-1,-1)
	_GUICtrlTab_SetCurFocus($tab,0)
	GUISetState(@SW_SHOW,$settings)

AjoutLog("Ouverture de la fen�tre 'Edition de profil'")

RemplirSettings()
EtatGriser()

	;$NPerso = IniRead($DossierProfils & $ProfilSel, "Info", "NomPerso", "")
	;GUICtrlSetData($LabelSettingsProfil,$ProfilSel & "  -- Pseudo : " & $NPerso)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg

			Case $GUI_EVENT_CLOSE
				GUIDelete($settings)
				AjoutLog("Fermeture de la fen�tre 'Edition de profil'")
				ExitLoop

			Case $CheckboxPause

				If GUICtrlRead($CheckboxPause) = $GUI_CHECKED Then
					GUICtrlSetState($InputApresXparties, $GUI_ENABLE)
					GUICtrlSetState($InputTempsPause, $GUI_ENABLE)
					AjoutLog("On d�grise la pause")
				Else
					GUICtrlSetState($InputApresXparties, $GUI_DISABLE)
					GUICtrlSetState($InputTempsPause, $GUI_DISABLE)
					AjoutLog("On grise la pause")
				EndIf

			Case $ComboChoixRun

				If GUICtrlRead($ComboChoixRun) = "Acte Al�atoire (Act1,Act2,Act3)" Then
					GUICtrlSetState($CheckboxSequencesAlea, $GUI_ENABLE)
					GUICtrlSetState($InputChangementAct, $GUI_ENABLE)
					GUICtrlSetState($InputChangementRun, $GUI_ENABLE)
					GUICtrlSetState($InputAct1min, $GUI_ENABLE)
					GUICtrlSetState($InputAct1max, $GUI_ENABLE)
					GUICtrlSetState($InputAct2min, $GUI_ENABLE)
					GUICtrlSetState($InputAct2max, $GUI_ENABLE)
					GUICtrlSetState($InputAct3min, $GUI_ENABLE)
					GUICtrlSetState($InputAct3max, $GUI_ENABLE)
					AjoutLog("On d�grise les s�quences al�atoires")
				Else
					GUICtrlSetState($CheckboxSequencesAlea, $GUI_DISABLE)
					GUICtrlSetState($CheckboxSequencesAlea, $GUI_UNCHECKED)
					GUICtrlSetState($InputChangementAct, $GUI_DISABLE)
					GUICtrlSetState($InputChangementRun, $GUI_DISABLE)
					GUICtrlSetState($InputAct1min, $GUI_DISABLE)
					GUICtrlSetState($InputAct1max, $GUI_DISABLE)
					GUICtrlSetState($InputAct2min, $GUI_DISABLE)
					GUICtrlSetState($InputAct2max, $GUI_DISABLE)
					GUICtrlSetState($InputAct3min, $GUI_DISABLE)
					GUICtrlSetState($InputAct3max, $GUI_DISABLE)
					AjoutLog("On grise les s�quences al�atoires")
				EndIf

			Case $ButtonParDefautSettings

				ValeurDefaut()
				RemplirSettings()
				MsgBox( 0, "", "Valeurs par d�faut charg�es !", 3)

			Case $ButtonEnregistrerSettings

				RecupDonneesSettings()
				EnregistProfil($ProfilSel)
				GUIDelete($settings)
				AjoutLog("Fermeture de la fen�tre 'Edition de profil'")
				MsgBox( 0, "", "Profil modifi� !", 3)
				ExitLoop

;########################################################
;#Boutons Reset
;########################################################

			Case $ButtonResetPrioMonstre



			Case $ButtonResetListeMonstres



			Case $ButtonResetListeMonstreSpe



			Case $ButtonResetListeDecor



			Case $ButtonResetListeCoffre



			Case $ButtonResetListeRack



			Case $ButtonResetAct1

				$SequenceFileAct1 = "act1-manoir_[1-8]|act1-Val_[1-8]|act1-putride_[1-6]|act1-champs_[1-8]"
				GUICtrlSetData($InputSequenceAct1,$SequenceFileAct1)
				AjoutLog("S�quence Act1 par d�faut")

			Case $ButtonResetAct2

				$SequenceFileAct2 = "act2-alcarnus_[1-8]|act2-gorge_noire_[1-6]|act2-dalgur_[1-2]"
				GUICtrlSetData($InputSequenceAct2,$SequenceFileAct2)
				AjoutLog("S�quence Act2 par d�faut")

			Case $ButtonResetAct3

				$SequenceFileAct3 = "[CMD]safeportstart()|act3_core_start_[1-5]|act3_tower_[1-5]|act3_field_[1-2]|[CMD]TakeWP=0,0,3,4"
				GUICtrlSetData($InputSequenceAct3,$SequenceFileAct3)
				AjoutLog("S�quence Act3 par d�faut")

			Case $ButtonResetAct3PT

				$SequenceFileAct3PtSauve = "act3_pt_save_le_coeur_darreat_[1-5]|act3_tower_[1-5]|act3_field_[1-2]|[CMD]TakeWP=0,0,3,4"
				GUICtrlSetData($InputSequenceAct3Pt,$SequenceFileAct3PtSauve)
				AjoutLog("S�quence Act3PT par d�faut")

			Case $ButtonResetSequenceTest

				$SequenceFile = "act3_ADV-core_start_[1-5]|act3_ADV-tower_[1-5]|act3_ADV-field_[1-4]|[CMD]TakeWPAdv=26"
				GUICtrlSetData($InputSequenceTest,$SequenceFile)
				AjoutLog("S�quence Test par d�faut")

			Case $ButtonResetSequenceAventure

				$SequenceFileAdventure = "act3_ADV-core_start_[1-5]|act3_ADV-tower_[1-5]|act3_ADV-field_[1-4]|[CMD]TakeWPAdv=26"
				GUICtrlSetData($InputSequenceAventure,$SequenceFileAdventure)
				AjoutLog("S�quence Aventure par d�faut")

			Case $ButtonResetSequence222

				$SequenceFileAct222 = "act2-Lieutenant_Vachem|act2-Tuer_Maghda_1"
				GUICtrlSetData($InputSequenceAct222,$SequenceFileAct222)
				AjoutLog("S�quence Act222 par d�faut")

			Case $ButtonResetSequence232

				$SequenceFileAct232 = "act2-gorge_noire_[1-6]|act2-Tuer_Maghda"
				GUICtrlSetData($InputSequenceAct232,$SequenceFileAct232)
				AjoutLog("S�quence Act232 par d�faut")

			Case $ButtonResetSequence222

				$SequenceFileAct283 = "act2-gorge_noire_[1-6]|act2-Tuer_ZoltunKulle"
				GUICtrlSetData($InputSequenceAct283,$SequenceFileAct283)
				AjoutLog("S�quence Act283 par d�faut")

			Case $ButtonResetSequence299

				$SequenceFileAct299 = "act2-Tuer_Belial"
				GUICtrlSetData($InputSequenceAct299,$SequenceFileAct299)
				AjoutLog("S�quence Act299 par d�faut")

			Case $ButtonResetSequence333

				$SequenceFileAct333 = "act3_rempart_[1-4]|act3-Tuer_Ghom"
				GUICtrlSetData($InputSequenceAct333,$SequenceFileAct333)
				AjoutLog("S�quence Act333 par d�faut")

			Case $ButtonResetSequence362

				$SequenceFileAct362 = "act3_rempart_[1-4]|act3_field_[1-4]|act3-Tuer_Siegebreaker"
				GUICtrlSetData($InputSequenceAct362,$SequenceFileAct362)
				AjoutLog("S�quence Act362 par d�faut")

			Case $ButtonResetSequence373

				$SequenceFileAct373 = "act3_tower_[1-5]|act3_field_[1-4]|act3-Tuer_Azmodan"
				GUICtrlSetData($InputSequenceAct373,$SequenceFileAct373)
				AjoutLog("S�quence Act373 par d�faut")

			Case $ButtonResetSequence373

				$SequenceFileAct374 = "act3-Tuer_Azmodan_1|act4-Tuer_Iskatu_1|act4-Tuer_Rakanoth"
				GUICtrlSetData($InputSequenceAct374,$SequenceFileAct374)
				AjoutLog("S�quence Act374 par d�faut")

			Case $ButtonResetSequence373

				$SequenceFileAct411 = "act4-Tuer_Iskatu|act4-Tuer_Rakano"
				GUICtrlSetData($InputSequenceAct411,$SequenceFileAct411)
				AjoutLog("S�quence Act411 par d�faut")

			Case $ButtonResetSequence442

				$SequenceFileAct442 = "act3_tower_[1-5]|act3_field_[1-4]|act3-Tuer_Azmodan"
				GUICtrlSetData($InputSequenceAct442,$SequenceFileAct442)
				AjoutLog("S�quence Act373 par d�faut")

		EndSwitch
	WEnd

EndFunc;==>EditSettings

Func CreerProfil()

	Global $CreationProfil = GUICreate("Cr�er un profil",262,117,-1,-1,-1,$WS_EX_TOPMOST,$MainForm)
	GUISetIcon(@scriptdir & "\lib\ico\icon.ico", -1)
	Global $CreerProfil = GUICtrlCreateButton("Cr�er",170,85,82,25,-1,-1)
	Global $AnnulerProfil = GUICtrlCreateButton("Annuler",80,85,82,24,-1,-1)
	GUICtrlCreateLabel("Nom du profil :",15,10,74,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	Global $InputProfil = GUICtrlCreateInput("",100,5,150,20,-1,512)
	Global $InputNomPerso = GUICtrlCreateInput("",100,30,150,20,-1,512)
	Global $InputBuild = GUICtrlCreateInput("",100,55,150,20,-1,512)
	GUICtrlCreateLabel("Personnage :",15,35,76,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUICtrlCreateLabel("Build :",15,60,74,15,-1,-1)
	GUICtrlSetBkColor(-1,"-2")
	GUISetState(@SW_SHOW,$CreationProfil)

	AjoutLog("Ouverture de la fen�tre 'Cr�er un profil'")

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg

			Case $GUI_EVENT_CLOSE

				GUIDelete($CreationProfil)
				AjoutLog("Fermeture de la fen�tre 'Cr�er un profil'")
				ExitLoop

			Case $AnnulerProfil

				GUIDelete($CreationProfil)
				AjoutLog("Fermeture de la fen�tre 'Cr�er un profil'")
				ExitLoop

			Case $CreerProfil
				Switch $VersionUtilisee
					Case "Modif"
						CreationProfil($DossierProfilsModif)
					Case "Originale"
						CreationProfil($DossierProfilsOriginale)
				EndSwitch
				GUIDelete($CreationProfil)
				AjoutLog("Fermeture de la fen�tre 'Cr�er un profil'")
				ExitLoop

		EndSwitch
	WEnd
EndFunc;==>CreerProfil