{
    --------------------------------------------
    Filename:
    Author:
    Copyright (c) 20__
    See end of file for terms of use.
    --------------------------------------------
}

CON

  _clkmode = cfg#_clkmode
  _xinfreq = cfg#_xinfreq

OBJ

  cfg   : "core.con.client.propboe"
  ser   : "com.serial.terminal"
  time  : "time"
  amp   : "signal.audio.amp.max9744.i2c"

VAR


PUB Main | cmd, i, level

  Setup
  level := 31
  ser.Clear

  repeat
    ser.Str (string("Volume: "))
    ser.Dec (level)
'    amp.Vol (level)
    ser.NewLine
    ser.Str (string("Press [ or ] for Volume Down or Up, respectively", ser#NL))
    i := ser.CharIn
    case i
      "[":
        level := 0 #> (level - 1)
        amp.VolDown
      "]":
        level := (level + 1) <# 63
        amp.VolUp
      "f":
        ser.Str (string("Modulation mode: Filterless", ser#NL))
        amp.ModulationMode (0)
      "p":
        ser.Str (string("Modulation mode: Classic PWM", ser#NL))
        amp.ModulationMode (1)
      OTHER:

PUB Setup

  repeat until ser.Start (115_200)
  amp.Startx (10, 11, 100_000, 8)

DAT
{
    --------------------------------------------------------------------------------------------------------
    TERMS OF USE: MIT License

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
    associated documentation files (the "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
    following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial
    portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
    LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    --------------------------------------------------------------------------------------------------------
}
