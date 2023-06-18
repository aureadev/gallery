import 'dart:mirrors';

mixin SerializableMixin {
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    final instanceMirror = reflect(this);
    final classMirror = instanceMirror.type;
    classMirror.declarations.forEach((symbol, declarationMirror) {
      if (declarationMirror is VariableMirror && !declarationMirror.isPrivate) {
        final key = MirrorSystem.getName(symbol);
        final value = instanceMirror.getField(symbol).reflectee;
        json[key] = value;
      }
    });
    return json;
  }
}

class Persona with SerializableMixin {
  String nombre;
  int edad;
  String profesion;

  Persona(this.nombre, this.edad, this.profesion);
}

class Perro with SerializableMixin {
  String raza;
  String color;

  Perro(this.raza, this.color);
}

void main() {
  final persona = Persona('Juan', 25, 'Ingeniero');
  print(persona.toJson());

  final perro = Perro('Salchica', 'Café');
  print(perro.toJson());
}
