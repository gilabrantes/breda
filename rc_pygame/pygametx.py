import sys, os, pygame, time, struct
import serial

from pygame.locals import *

pygame.init()
screen = pygame.display.set_mode((696, 396))
pygame.display.set_caption('Pygame Caption')
pygame.mouse.set_visible(0)
ser = serial.Serial('/dev/ttyUSB0',9600)

send='0'
up = False
down = False
left =  False
right = False

def input(events):
	global send
	global down
	global left
	global right
	global up
	for event in events:
		print event
		
		if event.type == QUIT:
			sys.exit(0)
		
		if event.type == KEYDOWN:
		  if event.key == K_LEFT:
		    left = True
		  if event.key == K_RIGHT:
		    right = True
		  if event.key == K_UP:
		    up = True
		  if event.key == K_DOWN:
		    down = True
		    
		if event.type == KEYUP:	  
		  if event.key == K_LEFT:
		    left = False
		  if event.key == K_RIGHT:
		    right = False
		  if event.key == K_UP:
		    up = False
		  if event.key == K_DOWN:
		    down = False

while True:
	send='0'
	input( pygame.event.get() )
	if up:
	  send = '1'
	if down:
	  send = '2'
	if left:
	  send = '5'
	if right:
	  send = '6'
	print send
	#ser.write(struct.pack("!h",send))
	ser.write(send)
	#ser.flush()
	
	time.sleep(0.1) #best so far: 0.1

