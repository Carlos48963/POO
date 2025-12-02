import RPi.GPIO as GPIO
import time

def led():
    GPIO.setwarnings(False)
    GPIO.setmode(GPIO.BOARD)
    GPIO.setup(12,GPIO.OUT)
    GPIO.setup(22,GPIO.IN,pull_up_down=GPIO.PUD_UP)
def co_led():
  try:
    while True:
        if GPIO.input(22)==GPIO.LOW:
            GPIO.output(12,False)
        else:
            GPIO.output(12,True)
  except KeyboardInterrupt:
      pass
  finally:
     GPIO.cleanup()
if __name__ == '__main__':
    led()
    co_led()

