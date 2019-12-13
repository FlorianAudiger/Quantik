protocol TQuantik {
	//init : --> TQuantik
	//créé une une grille 4*4 vide représentant la grille du TQuantik (chaque case de la grille peut être vide ou contenir une TPiece au cours de la partie)		
	init()	

	//isOccupied : TQuantik x Int x Int --> Bool 
	//renvoie True si une TPiece est déjà placé à la position Int x Int, False sinon
	// 0 <= Int <= 3 (pour les deux Int en paramètres)
	//le premier Int représente la ligne et le deuxième Int représente la colonne de la grille du quantik
	func isOccupied(row : Int, column : Int) -> Bool

	//isAlreadyInRow : TQuantik x TPiece x Int --> Bool
	//renvoie True si une TPiece de meme Forme mais de Couleur différente est déjà placée dans la ligne Int, False sinon
	// 0 <= Int <= 3
	func isAlreadyInRow(piece :TPiece, row : Int) -> Bool

	//isAlreadyInColumn : TQuantik x TPiece x Int --> Bool
	//renvoie True si une TPiece de meme Forme mais de Couleur différente est déjà placée dans la colonne Int, False sinon
	// 0 <= Int <= 3
	func isAlreadyInColumn(piece :TPiece, column : Int) -> Bool

	//isAlreadyInRegion : TQuantik x TPiece x Int --> Bool
	//renvoie True si une TPiece de meme Forme mais de Couleur différente est déjà placée dans la région Int, False sinon
	//les régions sont des sous grilles 2 x 2 de la grille du TQuantik
	//la région 1 est située en haut à gauche de la grille du TQuantik (i.e coordonnées (0,0) ; (0,1) ; (1,0) ; (1,1) de la grille du quantik)
	//la région 2 est située en haut à droite de la grille du TQuantik (i.e coordonnées (0,2) ; (0,3) ; (1,2) ; (1,3) de la grille du quantik)
	//la région 3 est située en bas à gauche de la grille du TQuantik (i.e coordonnées (2,0) ; (2,1) ; (3,0) ; (3,1) de la grille du quantik)
	//la région 4 est située en bas à droite de la grille du TQuantik (i.e coordonnées (2,2) ; (2,3) ; (3,2) ; (3,3) de la grille du quantik)
	// 1 <= Int <= 4
	func isAlreadyInRegion(piece :TPiece, region : Int) -> Bool

	//regionFromXY : TQuantik x Int x Int --> Int
	//renvoie le numéro de la région (compris entre 1 et 4) dans laquelle se trouve la position Int x Int en paramètre 
	//les régions sont des sous grilles 2 x 2 de la grille du TQuantik
	//la région 1 est située en haut à gauche de la grille du TQuantik (i.e coordonnées (0,0) ; (0,1) ; (1,0) ; (1,1) de la grille du quantik)
	//la région 2 est située en haut à droite de la grille du TQuantik (i.e coordonnées (0,2) ; (0,3) ; (1,2) ; (1,3) de la grille du quantik)
	//la région 3 est située en bas à gauche de la grille du TQuantik (i.e coordonnées (2,0) ; (2,1) ; (3,0) ; (3,1) de la grille du quantik)
	//la région 4 est située en bas à droite de la grille du TQuantik (i.e coordonnées (2,2) ; (2,3) ; (3,2) ; (3,3) de la grille du quantik)
	// 0 <= Int <= 3 (pour les deux Int en paramètres)
	//le premier Int représente la ligne et le deuxième Int représente la colonne de la grille du quantik
	func regionFromXY(row : Int, column : Int) -> Int

	//isPlayable : TQuantik x TJoueur x TPiece x Int x Int --> Bool
	//renvoie True si la TPiece peut être jouée en position Int x Int et quelle est disponible dans la collection du TJoueur
	//isPlayable(Q,TJoueur,TPiece,x,y) => !isOccupied(Q,x,y) et !isAlreadyInRow(Q,TPiece,x) et !isAlreadyInColumn(Q,TPiece,y) et !isAlreadyInRegion(Q,TPiece,refionFromXY(Q,x,y)) et isPieceAvailable(Q,TPiece)
	// 0 <= Int <= 3 (pour les deux Int en paramètres)
	func isPlayable(joueur : TJoueur, piece :TPiece, row : Int, column : Int) -> Bool

	//playPiece : TQuantik x TPiece x Int x Int --> TQuantik
	//ajoute la TPiece à la grille du quantik en position Int x Int
	// 0 <= Int <= 3 (pour les deux Int en paramètres)
	//le premier Int représente la ligne et le deuxième Int représente la colonne
	mutating func playPiece(piece :TPiece, row : Int, column : Int)

	//isAbleToPlay : TQuantik x TJoueur --> Bool
	//renvoie True si il existe une TPiece disponible dans la collection du TJoueur pouvant être jouée, False sinon
	//i.e : isPlayable(Q,TJoueur,TPiece,x,y) doit retourner True pour au moins une TPiece et une position x,y donnée
	func isAbleToPlay(joueur : TJoueur) -> Bool

	//getPieceGrille : TQuantik x Int x Int--> (TPiece | Vide)
	//renvoie la TPiece en position Int x Int de la grille du quantik si elle existe, renvoie Vide sinon
	// 0 <= Int <= 3 (pour les deux Int en paramètres)
	//le premier Int représente la ligne et le deuxième Int représente la colonne 
	func getPieceGrille(row : Int, column : Int) -> TPiece?

	//gameOver : TQuantik x TJoueur x TJoueur--> Int
	//renvoie 1 si il y a 4 TPiece de Forme différentes sur une ligne, une colonne ou une région du TQuantik
	//sinon, renvoie 2 si il n'y a plus de TPiece disponibles à jouer dans les collections des deux TJoueur (i.e les deux collections sont vides)
	//sinon, renvoie 0
	func gameOver(joueur1 : TJoueur, joueur2 : TJoueur) -> Int
}

//si les pré-conditions ne sont pas validées, faire planter le programme 

//TYPE
struct Quantik : TQuantik {

	private var _grid : [[Piece?]]

	// _plateau[row][column]

	init()
	{
		self._grid = [[Piece?]](repeating:[Piece?](repeating:nil,count:4),count:4)
	}

	func isOccupied(row : Int, column : Int) -> Bool
	{
		var res : Bool
		if let piecePres = self._grid[row][column] 
		{
			res = true 
		} else {
			res = false
		}
		return res
	}

	func isAlreadyInRow(piece :TPiece, row : Int) throws -> Bool
	{
		var columnT : Int = 0
		var res : Bool = false
		if row<0 || row>3 
		{
			return fatalError("row en dehors de la grille")
		} else {
			while columnT<4 && !res {
				if let pieceTestee = _grid[row][columnT] {
					res = (pieceTestee.forme() == piece.forme())
				}
			}
		}
	return res
	}

	func isAlreadyInColumn(piece :TPiece, column : Int) -> Bool
	{
		var rowT : Int = 0
		var res : Bool = false
		if column<0 || column>3 
		{
			return fatalError("column en dehors de la grille")
		} else {
			while rowT<4 && !res {
				if let pieceTestee = _grid[rowT][column] {
					res = (pieceTestee.forme() == piece.forme())
				}
			}
		}
	return res
	}

	func isAlreadyInRegion(piece :TPiece, region : Int) -> Bool {
	}

	func regionFromXY(row : Int, column : Int) -> Int {
		var region : Int 
		if 
	}

	func isPlayable(joueur : TJoueur, piece :TPiece, row : Int, column : Int) -> Bool {
	return (!isOccupied(row,column) && !isAlreadyInRow(piece,row) && !isAlreadyInColumn(piece,column) && !isAlreadyInRegion(piece,regionFromXY(row,column)) && joueur.isPieceAvailable(piece))

	mutating func playPiece(piece :TPiece, row : Int, column : Int) {
		if row >= 0 && row <= 3 && column >= 0 && column <= 3 {
			//On Place la pièce
			self.grille[row][column] = piece

			//On l'enlève de la collection du Joueur
			joueur.piecePlayed(piece)
		}
		fatalError("Préconditions non respectées : 0 <= row <= 3 et 0 <= column <= 3")
	

	
	func isAbleToPlay(joueur : TJoueur) -> Bool {
	// On regarde s'il reste au moins 1 pièce dans la collection du joueur
	var liste = joueur.getPiecesAvailable()
	if (liste.isEmpty) {
		return false
	}
	//On prends chacune des pièces une par une et on regarde toutes les positions si elle est jouable
	var e : Int = 0
	var canPlay : Bool = false
	while(e < liste.count ){
	for i in 0...3 {
		for j in 0...3 {
			if(isPlayable(joueur,liste[e],i,j) {
				canPlay = true }
		}
	}		
	e = e + 1	
	}
	return canPlay
	}

}

	func getPieceGrille(row : Int, column : Int) -> TPiece? {
		if row >= 0 && row <= 3 && column >= 0 && column <= 3 {
			return self.grille[row][column]
		}
		fatalError("Préconditions non respectées : 0 <= row <= 3 et 0 <= column <= 3")
	}


	func gameOver(joueur1 : TJoueur, joueur2 : TJoueur) -> Int {
	//renvoie 1 si il y a 4 TPiece de Forme différentes sur une ligne, une colonne ou une région du TQuantik
	// A FAIRE MAIS MANQUE AUTRE FONCTION ?
	if(){
	return 1
	}
	//sinon, renvoie 2 si il n'y a plus de TPiece disponibles à jouer dans les collections des deux TJoueur (i.e les deux collections sont vides)
	else if(joueur1.getPiecesAvailable().isEmpty && joueur2.getPiecesAvailable().isEmpty){
		return 2
	}
	//sinon, renvoie 0
	else
		return 0
	}
}


