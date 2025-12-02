import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)
GPIO.setwarnings(False)
GPIO.setup(18,GPIO.OUT)
GPIO.setup(25,GPIO.IN)

while True:
       if GPIO.input(25):
           GPIO.output(18, False)
       else:
           GPIO.output(18,True)
