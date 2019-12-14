enum Couleur : String {
	case Claire = "Claire"
	case Sombre = "Sombre"
}

enum Forme : String, Equatable {
	case Sphere = "Sphere"
	case Cube = "Cube"
	case Cone = "Cone"
	case Cylindre = "Cylindre"
}

protocol TJoueur {

	associatedtype ATPiece : TPiece

	//créé un joueur de la Couleur indiqué en paramètre
	//initialise une collection de TPiece comportant :
	// - 2 TPiece Sphere de la couleur Couleur
	// - 2 TPiece Cube de la couleur Couleur
	// - 2 TPiece Cylindre de la couleur Couleur
	// - 2 TPiece Cone de la couleur Couleur
	init(couleur : Couleur)

	//couleur() : TJoueur --> Couleur
	//renvoie la Couleur du TJoueur
	func couleur() -> Couleur

	//getPiecesAvailable : TJoueur  --> [TPiece]
	//renvoie la collection des TPiece encore jouables par le TJoueur
	func getPiecesAvailable() -> [ATPiece]

	//isPieceAvailable : TJoueur x TPiece --> Bool
	//renvoie True si le joueur de la couleur de TPiece dispose toujours de la TPiece dans la collection des TPiece encore jouables par ce joueur, False sinon
	func isPieceAvailable(piece :ATPiece) -> Bool

	//piecePlayed : TJoueur x TPiece --> TJoueur 
	//enlève la TPiece dans la collection des TPiece jouables par le TJoueur
	mutating func piecePlayed(piece :ATPiece)
}


// TYPE
class Joueur : TJoueur {

	typealias ATPiece = Piece

	//PROPRIETE
	private var _couleurJ : Couleur
	private var _listePiece : [ATPiece]

	//FONCTION
	init(couleur : Couleur) {

		self._couleurJ = couleur

		let Sp1 = Piece(couleur: self._couleurJ, forme: Forme.Sphere)
		let Sp2 = Piece(couleur: self._couleurJ, forme: Forme.Sphere)

		let Cu1 = Piece(couleur: self._couleurJ, forme: Forme.Cube)
		let Cu2 = Piece(couleur: self._couleurJ, forme: Forme.Cube)

		let Co1 = Piece(couleur: self._couleurJ, forme: Forme.Cone)
		let Co2 = Piece(couleur: self._couleurJ, forme: Forme.Cone)

		let Cy1 = Piece(couleur: self._couleurJ, forme: Forme.Cylindre)
		let Cy2 = Piece(couleur: self._couleurJ, forme: Forme.Cylindre)

		_listePiece = [Sp1,Sp2,Cu1,Cu2,Co1,Co2,Cy1,Cy2]

	}

	func couleur() -> Couleur {
		return self._couleurJ	
	}

	func getPiecesAvailable() -> [ATPiece] {
		return self._listePiece
	}

	func isPieceAvailable(piece :ATPiece) -> Bool {
		return (self._listePiece.contains(piece))
	}

	func piecePlayed(piece :ATPiece){
	var i : Int = 0
	while(_listePiece[i].forme() != piece.forme()){
		i = i + 1
	}
	_listePiece.remove(at: i)
	}
}

// PROTOCOLE
protocol TPiece {
	//init : String x String --> TPiece
	//créé une TPiece avec une Couleur et une Forme
	init(couleur : Couleur, forme : Forme)

	//couleur : Piece --> Couleur
	//renvoie la Couleur de la TPiece
	func couleur() -> Couleur 

	//piece : TPiece --> Forme
	//renvoie la Forme de la Piece
	func forme() -> Forme 
}
//si les pré-conditions ne sont pas validées, faire planter le programme

// TYPE
struct Piece : TPiece {
	
	private var _couleurP : Couleur

	private var _forme : Forme

	init(couleur : Couleur, forme : Forme){
		self._couleurP = couleur
		self._forme = forme 
	}

	func couleur() -> Couleur {
		return self._couleurP
	}
	func forme() -> Forme {
		return self._forme
	}

}
	
extension Piece: Equatable {
    static func == (lhs: Piece, rhs: Piece) -> Bool {
        return
            lhs.forme() == rhs.forme() 
        }
}

protocol TQuantik {

	associatedtype ATPiece : TPiece
	associatedtype ATJoueur : TJoueur

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
	func isAlreadyInRow(piece :ATPiece, row : Int) -> Bool

	//isAlreadyInColumn : TQuantik x TPiece x Int --> Bool
	//renvoie True si une TPiece de meme Forme mais de Couleur différente est déjà placée dans la colonne Int, False sinon
	// 0 <= Int <= 3
	func isAlreadyInColumn(piece :ATPiece, column : Int) -> Bool

	//isAlreadyInRegion : TQuantik x TPiece x Int --> Bool
	//renvoie True si une TPiece de meme Forme mais de Couleur différente est déjà placée dans la région Int, False sinon
	//les régions sont des sous grilles 2 x 2 de la grille du TQuantik
	//la région 1 est située en haut à gauche de la grille du TQuantik (i.e coordonnées (0,0) ; (0,1) ; (1,0) ; (1,1) de la grille du quantik)
	//la région 2 est située en haut à droite de la grille du TQuantik (i.e coordonnées (0,2) ; (0,3) ; (1,2) ; (1,3) de la grille du quantik)
	//la région 3 est située en bas à gauche de la grille du TQuantik (i.e coordonnées (2,0) ; (2,1) ; (3,0) ; (3,1) de la grille du quantik)
	//la région 4 est située en bas à droite de la grille du TQuantik (i.e coordonnées (2,2) ; (2,3) ; (3,2) ; (3,3) de la grille du quantik)
	// 1 <= Int <= 4
	func isAlreadyInRegion(piece :ATPiece, region : Int) -> Bool

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
	func isPlayable(joueur : ATJoueur, piece :ATPiece, row : Int, column : Int) -> Bool

	//playPiece : TQuantik x TPiece x Int x Int --> TQuantik
	//ajoute la TPiece à la grille du quantik en position Int x Int
	// 0 <= Int <= 3 (pour les deux Int en paramètres)
	//le premier Int représente la ligne et le deuxième Int représente la colonne
	mutating func playPiece(piece : ATPiece, row : Int, column : Int)

	//isAbleToPlay : TQuantik x TJoueur --> Bool
	//renvoie True si il existe une TPiece disponible dans la collection du TJoueur pouvant être jouée, False sinon
	//i.e : isPlayable(Q,TJoueur,TPiece,x,y) doit retourner True pour au moins une TPiece et une position x,y donnée
	func isAbleToPlay(joueur : ATJoueur) -> Bool

	//getPieceGrille : TQuantik x Int x Int--> (TPiece | Vide)
	//renvoie la TPiece en position Int x Int de la grille du quantik si elle existe, renvoie Vide sinon
	// 0 <= Int <= 3 (pour les deux Int en paramètres)
	//le premier Int représente la ligne et le deuxième Int représente la colonne 
	func getPieceGrille(row : Int, column : Int) -> TPiece?

	//gameOver : TQuantik x TJoueur x TJoueur--> Int
	//renvoie 1 si il y a 4 TPiece de Forme différentes sur une ligne, une colonne ou une région du TQuantik
	//sinon, renvoie 2 si il n'y a plus de TPiece disponibles à jouer dans les collections des deux TJoueur (i.e les deux collections sont vides)
	//sinon, renvoie 0
	func gameOver(joueur1 : ATJoueur, joueur2 : ATJoueur) -> Int
}

//si les pré-conditions ne sont pas validées, faire planter le programme 

//TYPE
struct Quantik : TQuantik {

	typealias ATPiece = Piece
	typealias ATJoueur = Joueur

	private var _grid : [[Piece?]]

	// _grid[row][column]

	init()
	{
		self._grid = [[Piece?]](repeating:[Piece?](repeating:nil,count:4),count:4)
	}

	func isOccupied(row : Int, column : Int) -> Bool
	{
		return self._grid[row][column] != nil
	}

	func isAlreadyInRow(piece :ATPiece, row : Int) -> Bool
	{
		var columnT : Int = 0
		var res : Bool = false
		if row<0 || row>3 
		{
			fatalError("row en dehors de la grille")
		} else {
			while columnT<4 && !res {
				if let pieceTestee = _grid[row][columnT] {
					res = (pieceTestee.forme() == piece.forme() && !(pieceTestee.couleur() == piece.couleur()))
				}
				columnT += 1
			}
		}
	return res
	}
	

	func isAlreadyInColumn(piece :ATPiece, column : Int) -> Bool
	{
		var rowT : Int = 0
		var res : Bool = false
		if column<0 || column>3 
		{
			fatalError("column en dehors de la grille")
		} else {
			while rowT<4 && !res {
				if let pieceTestee = _grid[rowT][column] {
					res = (pieceTestee.forme() == piece.forme() && !(pieceTestee.couleur() == piece.couleur()))
				}
				rowT += 1
			}
		}
	return res
	}

	func isAlreadyInRegion(piece :ATPiece, region : Int) -> Bool {
		var res : Bool = false 
		if region<1 || region>4 
		{
			fatalError("region en dehors de la grille")
		} else {
			for rowT in 0...3 {
				for columnT in 0...3 {
					if (region == regionFromXY(row : rowT, column : columnT) && !res) {
						if let pieceTestee = _grid[rowT][columnT] {
							res = (pieceTestee.forme() == piece.forme() && !(pieceTestee.couleur() == piece.couleur()))
						}
					}
				}
			}
		}
	return res
	}

	func regionFromXY(row : Int, column : Int) -> Int {
		var region : Int 
		if row-2 < 0 {
			if column-2 < 0 {
				region = 1
			} else {
				region = 2
			}
		} else {
			if column-2 < 0 {
				region = 3
			} else {
				region = 4
			}
		}
		return region
	}

	func isPlayable(joueur : ATJoueur, piece : ATPiece, row : Int, column : Int) -> Bool {
		return (!isOccupied(row: row,column: column) 
			&& !isAlreadyInRow(piece: piece,row: row) 
			&& !isAlreadyInColumn(piece: piece,column: column) 
			&& !isAlreadyInRegion(piece: piece,region: regionFromXY(row: row,column: column)) 
			&& joueur.isPieceAvailable(piece: piece))
	}

	mutating func playPiece(piece : ATPiece, row : Int, column : Int) {
		if row >= 0 && row <= 3 && column >= 0 && column <= 3 {
			//On Place la pièce
			self._grid[row][column] = piece

			//On l'enlève de la collection du Joueur
			joueur.piecePlayed(piece: piece)
		}
		fatalError("Préconditions non respectées : 0 <= row <= 3 et 0 <= column <= 3")
	

	
	func isAbleToPlay(joueur : ATJoueur) -> Bool {
		// On regarde s'il reste au moins 1 pièce dans la collection du joueur
		var liste = joueur.getPiecesAvailable()
		if (liste.isEmpty) {
			return false
		}
		//On prends chacune des pièces une par une et on regarde toutes les positions si elle est jouable
		var e : Int = 0
		var canPlay : Bool = false
		while ((e < liste.count ) && !canPlay ) {
			for i in 0...3 {
				for j in 0...3 {
					if(isPlayable(joueur : joueur, piece : liste[e], row : i, column : j)) {
						canPlay = true 
					}
				}
			}		
			e = e + 1	
		}
		return canPlay
	}


	func getPieceGrille(row : Int, column : Int) -> ATPiece? {
		if row >= 0 && row <= 3 && column >= 0 && column <= 3 {
			return self._grid[row][column]
		}
		fatalError("Préconditions non respectées : 0 <= row <= 3 et 0 <= column <= 3")
	}

	func formeInRow (forme : Forme, row : Int) -> Bool {
		// renvoie vrai lorsqu'on trouve la forme sur le ligne 
		var columnT : Int = 0
		var res : Bool = false
		while columnT<4 && !res {
			if let pieceTestee = _grid[row][columnT] {
				res = (pieceTestee.forme() == forme )
			}
		columnT += 1
		}
		return res
	}


	func formeInColumn (forme : Forme, column : Int) -> Bool {
		// renvoie vrai lorsqu'on trouve la forme sur la colonne
		var rowT : Int = 0
		var res : Bool = false
		while rowT<4 && !res {
			if let pieceTestee = _grid[rowT][column] 
			{
				res = (pieceTestee.forme() == forme )
			}
		rowT += 1
		}
	return res
	}
	

	func formeInRegion (forme : Forme, region : Int) -> Bool {
		// renvoie vrai lorsqu'on trouve la forme dans la region
	var res : Bool = false 
		for rowT in 0...3 {
			for columnT in 0...3 {
				if (region == regionFromXY(row : rowT, column : columnT) && !res) {
					if let pieceTestee = _grid[rowT][columnT] {
						res = (pieceTestee.forme() == forme)
					}
				}
			}
		}
	return res
	}

	func verifGameOver () -> Bool {
		// renvoie vrai si il y a 4 pieces de formes différentes sur une ligne, une colonne ou dans une région
		var res : Bool = false
		var rowT : Int = 0
		var columnT : Int = 0
		var regionT : Int = 0 
		// verification ligne
		while (rowT < 4 && !res){
			res = (formeInRow (forme : Forme.Sphere, row : rowT)
				&& formeInRow (forme : Forme.Cube, row : rowT)
				&& formeInRow (forme : Forme.Cone, row : rowT)
				&& formeInRow (forme : Forme.Cylindre, row : rowT)
				)
			rowT += 1
		}
		// verification colonne
		while (columnT < 4 && !res){
			res = (formeInColumn (forme : Forme.Sphere, column : columnT)
				&& formeInColumn (forme : Forme.Cube, column : columnT)
				&& formeInColumn (forme : Forme.Cone, column : columnT)
				&& formeInColumn (forme : Forme.Cylindre, column : columnT) 
				)
			columnT += 1
		}
		// verification region 
		while (regionT < 4 && !res){
			res = (formeInRegion (forme : Forme.Sphere, region : regionT)
				&& formeInRegion (forme : Forme.Cube, region : regionT)
				&& formeInRegion (forme : Forme.Cone, region : regionT)
				&& formeInRegion (forme : Forme.Cylindre, region : regionT)
				)
			regionT += 1
		}
		return res
	}

	func gameOver(joueur1 : ATJoueur, joueur2 : ATJoueur) -> Int {
		//renvoie 1 si il y a 4 TPiece de Forme différentes sur une ligne, une colonne ou une région du TQuantik
		// A FAIRE MAIS MANQUE AUTRE FONCTION ?
		var res : Int = 0
		if (verifGameOver() == true) {
			res = 1
		}
		//sinon, renvoie 2 si il n'y a plus de TPiece disponibles à jouer dans les collections des deux TJoueur (i.e les deux collections sont vides)
		if (joueur1.getPiecesAvailable().isEmpty && joueur2.getPiecesAvailable().isEmpty){
			res = 2
		} 
		return res
	}
}
}
