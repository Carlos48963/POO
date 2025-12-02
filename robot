# Clase base Robot
class Robot:
    def __init__(self, nombre):
        # Nombre del robot y valores iniciales
        self.nombre = nombre
        self.bateria = 100
        self.x = 0

    def saludar(self):
        """Devuelve un saludo con el nombre del robot."""
        return f"Hola, soy {self.nombre}"

    def mover(self, distancia):
        """Mueve al robot en el eje x y reduce la batería."""
        self.x += distancia
        self.bateria -= abs(distancia)  # Se resta batería según la distancia

    def status(self):
        """Muestra el estado del robot en tierra."""
        return f"batería={self.bateria}, x={self.x}"


# Clase derivada RobotVolador
class RobotVolador(Robot):
    def __init__(self, nombre):
        # Hereda inicialización de Robot
        super().__init__(nombre)
        self.z = 0  # Altura inicial

    def volar(self, altura):
        """Cambia la altura z y reduce batería según el esfuerzo."""
        self.z += altura
        self.bateria -= abs(altura) * 2  # Volar consume el doble

    def status(self):
        """Muestra estado incluyendo altura."""
        return f"batería={self.bateria}, x={self.x}, z={self.z}"


# --- Simulación obligatoria ---
r = RobotVolador("Atlas")
print(r.saludar())
r.mover(10)      # Avanza 10 → x=10, batería=90
r.volar(5)       # Sube 5 → z=5, batería=80
print(r.status())
r.volar(-3)      # Baja 3 → z=2, batería=74
print(r.status())
