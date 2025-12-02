import RPi.GPIO as GPIO
import time

def ledbort():
    GPIO.setwarnings(False)
    GPIO.setmode(GPIO.BOARD)
    GPIO.setup(12,GPIO.OUT)
def con_led():
    try:
       while True:
           GPIO.output(12,True)
           time.sleep(1)
           GPIO.output(12,False)
           time.sleep(1)
    except KeyboardInterrupt:
        pass
    finally:
        GPIO.cleanup()
if __name__ == '__main__':
  ledbort()
  con_led()
