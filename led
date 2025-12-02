import RPi.GPIO as GPIO
import time

class Led():
  def __init__(self,pin_led):
     self.pin_led =pin_led
     GPIO.setwarnings(False)
     GPIO.setmode(GPIO.BCM)
     GPIO.setup(self.pin_led, GPIO.OUT)

  def blink(self,delay = 0.5):
         while True:
            GPIO.output(self.pin_led, True)
            time.sleep(delay)
            GPIO.output(self.pin_led,False)
            time.sleep(delay)

PIN_DEL_LED= 18
blinker=Led(PIN_DEL_LED)
blinker.blink(delay = 0.5)
