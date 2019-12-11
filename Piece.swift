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
/*
	init(couleur : Couleur, forme : Forme){}
	func couleur() -> Couleur {}
	func forme() -> Forme {}
*/
}
	
