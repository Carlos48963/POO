import RPi.GPIO as GPIO
import time
import adafruit_dht
import board

# === CONFIGURACIÓN GENERAL ===
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

PIN_LED = 18
PIN_BOTON = 25

GPIO.setup(PIN_LED, GPIO.OUT)
GPIO.setup(PIN_BOTON, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

LOG_FILE = "data_log.txt"     # Archivo donde se guardan los datos


# === FUNCIÓN GENERAL DE LOG ===
def escribir_log(texto):
    with open(LOG_FILE, "a") as f:
        f.write(texto + "\n")


# === CLASE PADRE ===
class Robot:
    def __init__(self, nombre):
        self.nombre = nombre

    def contar_uso(self):
        escribir_log(f"[USO] Robot {self.nombre} llamado - {time.ctime()}")


# === ROBOT CONSTRUCTOR ===
class RobotConstructor(Robot):
    def __init__(self, nombre):
        super().__init__(nombre)

    def encender(self):
        self.contar_uso()
        GPIO.output(PIN_LED, True)
        return "🤖 Constructor encendido (LED ON)"

    def apagar(self):
        self.contar_uso()
        GPIO.output(PIN_LED, False)
        return "🤖 Constructor apagado (LED OFF)"
    # En modelo.py (por ejemplo, dentro de RobotConstructor o una clase base)


    # ... (Tus métodos existentes: encender, apagar, etc.) ...
    
    # Archivo donde se guardarán las cuentas
    LOG_FILE = "registro_acciones.txt"

    def __cargar_logs(self):
        """Método privado para leer el archivo de logs y devolver un diccionario."""
        counts = {}
        try:
            with open(self.LOG_FILE, "r") as f:
                for line in f:
                    if ":" in line:
                        key, value = line.split(":", 1)
                        # Convertir el valor a entero
                        counts[key.strip()] = int(value.strip())
        except FileNotFoundError:
            # Si el archivo no existe, simplemente devolvemos un diccionario vacío
            pass
        return counts

    def __guardar_logs(self, counts):
        """Método privado para escribir el diccionario de logs de vuelta al archivo."""
        with open(self.LOG_FILE, "w") as f:
            for key, value in counts.items():
                f.write(f"{key}: {value}\n")

    def registrar_accion(self, action_key):
        """Incrementa el contador para una acción específica y guarda el archivo."""
        counts = self.__cargar_logs()
        counts[action_key] = counts.get(action_key, 0) + 1
        self.__guardar_logs(counts)
        return counts[action_key] # Devuelve el nuevo total

    def obtener_logs_formato(self):
        """Obtiene todos los logs y los formatea para la respuesta de Telegram."""
        counts = self.__cargar_logs()
        if not counts:
            return "El registro de acciones está vacío."
        
        # Formatear el diccionario para que se vea bien en Telegram
        output = "📊 **Resumen de Acciones Registradas:**\n\n"
        for key, value in counts.items():
            # Reemplazar '_' por espacios para mejor legibilidad
            nombre_accion = key.replace('_', ' ').capitalize()
            output += f"- {nombre_accion}: **{value}** veces\n"
        return output


# === ROBOT MEDICO ===
class RobotMedico(Robot):
    def __init__(self, nombre):
        super().__init__(nombre)
        self.sensor = adafruit_dht.DHT11(board.D4)

    def medir_temperatura(self):
        self.contar_uso()
        try:
            time.sleep(2)
            t = self.sensor.temperature
            escribir_log(f"[DHT] Temperatura: {t}°C - {time.ctime()}")
            return f"🌡️ Temperatura: {t}°C"
        except:
            return "⚠️ Error al leer temperatura."

    def medir_humedad(self):
        self.contar_uso()
        try:
            time.sleep(2)
            h = self.sensor.humidity
            escribir_log(f"[DHT] Humedad: {h}% - {time.ctime()}")
            return f"💧 Humedad: {h}%"
        except:
            return "⚠️ Error al leer humedad."


# === ROBOT EXPLORADOR ===
class RobotExplorador(Robot):
    def __init__(self, nombre):
        super().__init__(nombre)

    def explorar(self):
        self.contar_uso()

        # Esperar a presionar
        while GPIO.input(PIN_BOTON) == GPIO.HIGH:
            time.sleep(0.01)

        GPIO.output(PIN_LED, True)
        escribir_log("[EXPLORACION] Inicio de exploración")

        # Mientras esté presionado
        while GPIO.input(PIN_BOTON) == GPIO.LOW:
            print("Explorando...")
            time.sleep(0.2)

        # Soltado
        GPIO.output(PIN_LED, False)
        escribir_log("[EXPLORACION] Fin de exploración")

        return "🛑 Robot explorador ha dejado de explorar"



    # ... (métodos existentes) ...

    def leer_archivo_devices(self):
        """Lee el contenido de devices.txt y lo devuelve como una sola cadena."""
        # Usa 'with open' para asegurar que el archivo se cierre
        with open("devices.txt", "r") as file:
            # Lee todas las líneas y las une en una cadena
            contenido = "".join(file.readlines())
        
        return contenido
    
    
