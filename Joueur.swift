// PROTOCOLE
protocol TJoueur {
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
	func getPiecesAvailable() -> [TPiece]

	//isPieceAvailable : TJoueur x TPiece --> Bool
	//renvoie True si le joueur de la couleur de TPiece dispose toujours de la TPiece dans la collection des TPiece encore jouables par ce joueur, False sinon
	func isPieceAvailable(piece :TPiece) -> Bool

	//piecePlayed : TJoueur x TPiece --> TJoueur 
	//enlève la TPiece dans la collection des TPiece jouables par le TJoueur
	mutating func piecePlayed(piece :TPiece)
}


// TYPE
struct Joueur : TJoueur{
	//PROPRIETE
	private var _couleurJ : Couleur
	private var _listePiece : [TPiece]

	//FONCTION
	init(couleur : Couleur) {

		self._couleurJ = couleur

		var Sp1 = Piece(couleur: self._couleurJ, forme: Forme.Sphere)
		var Sp2 = Piece(couleur: self._couleurJ, forme: Forme.Sphere)

		var Cu1 = Piece(couleur: self._couleurJ, forme: Forme.Cube)
		var Cu2 = Piece(couleur: self._couleurJ, forme: Forme.Cube)

		var Co1 = Piece(couleur: self._couleurJ, forme: Forme.Cone)
		var Co2 = Piece(couleur: self._couleurJ, forme: Forme.Cone)

		var Cy1 = Piece(couleur: self._couleurJ, forme: Forme.Cylindre)
		var Cy2 = Piece(couleur: self._couleurJ, forme: Forme.Cylindre)

		_listePiece = [Sp1,Sp2,Cu1,Cu2,Co1,Co2,Cy1,Cy2]

	}

	func couleur() -> Couleur {
		return self._couleurJ	
	}

	func getPiecesAvailable() -> [TPiece] {
		return self._listePiece
	}

	func isPieceAvailable(piece :TPiece) -> Bool {
		return (self._listePiece.contains(piece))
	}

	mutating func piecePlayed(piece :TPiece){

	var i : Int = 0
	while(_listePiece[i].forme() != piece.forme()){
		i = i + 1
	}
	_listePiece.remove(at: i)
	}
}
	
	

