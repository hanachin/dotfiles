#!/bin/bash

jack_control start
jack_control ds alsa
jack_control dps device hw:CODEC
jack_control dps rate 48000
jack_control dps nperiods 3
jack_control dps period 32
sleep 10
# a2jmidid -e &
# sleep 10
qjackctl &

