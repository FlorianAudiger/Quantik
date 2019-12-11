//pour implémenter l'ensemble des types demandé, il vous sera nécessaire d'importer ce fichier

enum Couleur : String {
	case Claire = "Claire"
	case Sombre	= "Sombre"
}

enum Forme : String, CaseIterable {
	case Sphere = "Sphere"
	case Cube = "Cube"
	case Cone = "Cone"
	case Cylindre = "Cylindre"
}