// Réunitialise l'affichage de la console
func clear() {
	print("\u{001B}[2J")
}

// Affichage de la grille du jeu
// TQuantik : le jeu quantik
func printGrille(quantik : Quantik) {
	var separator1 : Int = 0
	var a : Int = 0
	print("\u{001B}[0;33m    0 1   2 3")
	print("\u{001B}[0;37m   -----------")
	for i in 0...4 {
		if (i == 2) {
			print("\u{001B}[0;37m  |-----|-----|")
			separator1 = 1
			a = 1
		}
		else {
			var numLigne : String = "\u{001B}[0;33m" + String(i-a)
			numLigne += " "
			print(numLigne , terminator : "")
			print("\u{001B}[0;37m| ", terminator : "")
			var separator2 : Int = 0
			for j in 0...4 {
				if (j == 2) {
					print("\u{001B}[0;37m| ", terminator : "")
					separator2 = 1
				}			
				else {
					if let piece = quantik.getPieceGrille(row : i-separator1, column : j-separator2) {
						let color : String
						if (piece.couleur() == Couleur.Claire) {
							color = "\u{001B}[0;34m"
						}
						else {
							color = "\u{001B}[0;31m"
						}
						if (piece.forme() == Forme.Sphere){
							let show : String = color + "O " 
							print(show, terminator : "")
						}
						else if (piece.forme() == Forme.Cube) {
							let show : String = color + "# " 
							print(show, terminator : "")
						}
						else if (piece.forme() == Forme.Cone) {
							let show : String = color + "A " 
							print(show, terminator : "")
						}
						else {
							let show : String = color + "U " 
							print(show, terminator : "")
						}
					}
					else {
						print("  ", terminator : "")
					}
				}
			}
			print("\u{001B}[0;37m|")
		}
		
	}
	print("\u{001B}[0;37m   -----------")
}

// Création du jeu TQuantik
var quantik : Quantik = Quantik()

// Création de deux joueurs --> joueurClair avec la couleur Couleur.Claire et joueurSombre avec la couleur Couleur.Sombre
var joueurClair : Joueur = Joueur(couleur : Couleur.Claire)
var joueurSombre : Joueur = Joueur(couleur : Couleur.Sombre)

// Création d'une collection de 2 TJoueur
var joueurs : [Joueur] = [joueurClair, joueurSombre]

// Définir aléatoirement le TJoueur qui commence la partie : 0 correspond au joueurClair et 1 au joueurSombre
// dans la collection joueurs
var current : Int = Int.random(in: 0...1)

// défini si le joueur peut jouer la pièce saisie
var warning : Bool = false

// Continue la partie tant que la partie n'est pas fini et que le joueur courant peut jouer
while quantik.gameOver(joueur1: joueurClair, joueur2: joueurSombre) == 0 && quantik.isAbleToPlay(joueur: joueurs[current]) {
	
	// Variable booléenne pour définir si la saisie est bonne(true) ou non(false)
	// pour la saisie de : pièce, ligne et colonne
	var valuesOK : Bool

	// numéro de la pièce saisie
	var pieceToPlay : Int = 0

	// numéro de la ligne saisie
	var row : Int = 0

	//numéro de la colonne saisie
	var column : Int = 0

	// Dictionnaire de Formes
	let forms : [Int : String] = [1 : Forme.Sphere.rawValue, 2 : Forme.Cube.rawValue, 3 : Forme.Cone.rawValue, 4 : Forme.Cylindre.rawValue]

	// Affichage de la demande de saisies et récupération des saisies
	repeat {
		clear()

		printGrille(quantik : quantik)

		// Affichage lié aux informations de saisies du joueur
		print("\u{001B}[0;37mAu tour du joueur : " + joueurs[current].couleur().rawValue)
		print("\u{001B}[0;37m1. Sphere : O")
		print("\u{001B}[0;37m2. Cube : #")
		print("\u{001B}[0;37m3. Cone : A")
		print("\u{001B}[0;37m4. Cylindre : U")

		//
		if warning { print("\u{001B}[0;31mImpossible de jouer cette piece") }

		warning = false

		print("\u{001B}[0;37mJouer pièce n°(1,2,3 ou 4) ? : ", terminator : "")
		
		valuesOK = true

		// Lire la valeur saisie pour la pièce choisie
		let lineRead = readLine()

		// Vérification que le numéro de la pièce saisie est bien compris entre 1 et 4
		if let lineRead = lineRead {
			if let intLR = Int(lineRead) {
				if (intLR > 0 && intLR < 5) {
					pieceToPlay = intLR // la saisie est bien entre 1 et 4 donc on stock le numéro de la pièce
				}
				else { valuesOK = false }
			}
			else { valuesOK = false }
		}
		else { valuesOK = false }

		// si la valeur de la pièce saisie est bonne
		if valuesOK {

			// choisir la ligne
			print("\u{001B}[0;37mA la ligne n°(0,1,2,3) ? : ", terminator : "")
			let x = readLine()

			// choisir la colonne
			print("\u{001B}[0;37mA la colonne n°(0,1,2,3) ? : ", terminator : "")
			let y = readLine()

			// vérifie que la ligne saisie est bien entre 0 et 3
			if let x = x {
				if let intX = Int(x) {
					if intX < 4 && intX >= 0 {
						row = intX	// la saisie est bonne
					}
					else { valuesOK = false }
				}
				else { valuesOK = false }
			}
			else { valuesOK = false }
			
			// vérifie que la colonne saisie est bien entre 0 et 3
			if let y = y {
				if let intY = Int(y) {
					if intY < 4 && intY >= 0 {
						column = intY  // la saisie est bonne
					}
					else { valuesOK = false }
				}
				else { valuesOK = false }
			}
			else { valuesOK = false }


			// Si les valeurs de ligne et colonne sont bonnes
			if valuesOK {

				// vérifie que c'est bien une forme
				var formPiece : Forme
				if let tempForme = forms[pieceToPlay] {
					formPiece = Forme(rawValue:tempForme)!
					// Création de la TPiece avec la Couleur du TJoueur courant et la Forme de la TPiece
					let piece : Piece = Piece(couleur : joueurs[current].couleur(), forme : formPiece)

					// vérification que la piece TPiece peut être jouée à la position ligne : row et à la colonne : column
					// si elle peut être jouée alors on place la pièce (playPiece) et enlève cette pièce de la collection de pièce du joueur courant
					// sinon on affecte la variable warning à true et valuesOK à false afin de recommencer la saisie du TJoueur courant
					if quantik.isPlayable(joueur : joueurs[current], piece : piece, row : row, column : column) {
						quantik.playPiece(piece : piece, row : row, column : column)
						joueurs[current].piecePlayed(piece : piece)
					}	
					else { 
						warning = true
						valuesOK = false
					}
				} 
				else { 
					warning = true
					valuesOK = false
				}
			}
		}
	} while !valuesOK

	// Changement de joueur
	if (current == 1) {
		current = 0
	}
	else {
		current = 1
	}	
} 

clear()

// Défini l'état de la fin de partie
if (quantik.gameOver(joueur1: joueurClair, joueur2: joueurSombre) == 2) {
	print("Match nul !")
}
else if current == 0 {
	print("Le joueur Sombre a gagné !")
}
else {
	print("Le joueur Claire a gagné !")
}
