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
	}

	func couleur() -> Couleur {
	return self._couleur	
	}

	func getPiecesAvailable() -> [TPiece] {
	return self._listePiece
}
/*
	func isPieceAvailable(piece :TPiece) -> Bool {}

	mutating func piecePlayed(piece :TPiece) {}
*/
}
	
	

