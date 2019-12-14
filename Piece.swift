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