import 'dart:math';

class Position {

  double x;
  double y;
  Point point;

  Position(this.x, this.y) {
    this.point = new Point(this.x, this.y);
  }

  // Un constructeur nommé, avec une liste d'initialisation.
  Position.origin() : x = 0, y = 0;
  
  // Définition d'une méthode.
  num distanceTo(Position other) {
      var dx = x - other.x;
      var dy = y - other.y;
      return sqrt(dx * dx + dy * dy);
  }

  

}

