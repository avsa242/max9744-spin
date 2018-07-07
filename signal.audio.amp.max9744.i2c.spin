{
    --------------------------------------------
    Filename: signal.audio.amp.max9744.i2c.spin
    Author: Jesse Burt
    Description: Driver for the MAX9744 20W audio amplifier IC
    Copyright (c) 2018
    See end of file for terms of use.
    --------------------------------------------
}

CON

  SLAVE_ADDR        = $4B << 1  'Replace with 7bit address, or 8bit and remove the left shift
  SLAVE_ADDR_W      = SLAVE_ADDR
  SLAVE_ADDR_R      = SLAVE_ADDR|1
  
  SCL               = 28
  SDA               = 29
  HZ                = 400_000
  I2C_MAX_BUS_FREQ  = 400_000

VAR

  long  _shdn

OBJ

  i2c     : "jm_i2c_fast"
  max9744 : "core.con.max9744"
  io      : "io"

PUB null
''This is not a top-level object

PUB Start(SHDN): okay                                   'Default to "standard" Propeller I2C pins
' Must provide SHDN (shutdown) pin
  okay := Startx (SCL, SDA, HZ, SHDN)

PUB Startx(SCL_PIN, SDA_PIN, I2C_HZ, SHDN)
' Must provide SHDN (shutdown) pin
  if lookdown(SCL_PIN: 0..31)                           'Validate pins
    if lookdown(SDA_PIN: 0..31)
      if SCL_PIN <> SDA_PIN
        if I2C_HZ =< I2C_MAX_BUS_FREQ
          _shdn := SHDN
          Powered (TRUE)                                'Bring SHDN pin high, if it isn't already
          return i2c.setupx (SCL_PIN, SDA_PIN, I2C_HZ)
        else
          return FALSE
      else
        return FALSE
    else
      return FALSE
  else
    return FALSE

PUB Vol(level) | ack
' Set Volume to a specific level
  level := 0 #> level <# 63
  cmd(level)

PUB VolUp
' Increase volume level
  cmd(max9744#CMD_VOL_UP)

PUB VolDown
' Decrease volume level
  cmd(max9744#CMD_VOL_DN)

PUB ModulationMode(mode)
' Set output filter mode
' NOTE: Verified difference in output on scope, but inaudible (to me)
  case mode
    0:
      mode := max9744#MODULATION_FILTERLESS  'Filterless modulation
    1:
      mode := max9744#MODULATION_CLASSICPWM  'Classic PWM
    OTHER:
      return

  Powered (FALSE)
  Powered (TRUE)
  
  cmd(mode)

PUB Mute
' Set 0 Volume
  Vol (0)

PUB Powered(bool__powered)
' Power on or off
  case bool__powered
    FALSE:
      io.Low (_shdn)
    OTHER:
      io.High (_shdn)

PRI cmd(cmd_byte)

  i2c.start
  i2c.write (SLAVE_ADDR_W)
  i2c.write (cmd_byte)
  i2c.stop

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
