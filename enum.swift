enum Couleur : String {
	case Claire = "Claire"
	case Sombre = "Sombre"
}

enum Forme : String, CaseIterable, Equatable {
	case Sphere = "Sphere"
	case Cube = "Cube"
	case Cone = "Cone"
	case Cylindre = "Cylindre"
}
