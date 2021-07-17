#!/bin/bash

adb reverse tcp:5000 tcp:3333 && clear && flutter run
