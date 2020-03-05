{
    --------------------------------------------
    Filename: tiny. signal.audio.amp.max9744.i2c.spin
    Author: Jesse Burt
    Description: Driver for the MAX9744 20W audio amplifier IC (SPIN-only version)
    Copyright (c) 2020
    Started Mar 5, 2020
    Updated Mar 5, 2020
    See end of file for terms of use.
    --------------------------------------------
}

CON

    SLAVE_WR          = core#SLAVE_ADDR
    SLAVE_RD          = core#SLAVE_ADDR|1

    DEF_SCL           = 28
    DEF_SDA           = 29

VAR

    long _shdn
    byte _vol_level, _mod_mode

OBJ

    i2c     : "tiny.com.i2c"
    core    : "core.con.max9744"
    io      : "io"
    time    : "time"

PUB Null
' This is not a top-level object

PUB Start(SHDN_PIN): okay                                       'Default to "standard" Propeller I2C pins and 400kHz
' Simple start method uses default pin and bus freq settings, but still requires
'  SHDN_PIN to be defined
    if lookdown(SHDN_PIN: 0..31)
        okay := Startx (DEF_SCL, DEF_SDA, SHDN_PIN)
    else
        return FALSE

PUB Startx(SCL_PIN, SDA_PIN, SHDN_PIN): okay
' Start with custom settings
'   Returns: Core/cog number+1 of driver
    if lookdown(SCL_PIN: 0..31) and lookdown(SDA_PIN: 0..31)
        i2c.setupx (SCL_PIN, SDA_PIN)                           'I2C Object Started?
        time.MSleep (1)
        if i2c.present (SLAVE_WR)                               'Response from device?
            _shdn := SHDN_PIN
            Powered(TRUE)                                       'Bring SHDN pin high, if it isn't already
            return okay := cogid + 1

    return FALSE                                                'If we got here, something went wrong

PUB Stop

    Mute
    Powered(FALSE)

PUB ModulationMode(mode)
' Set output filter mode
'   Valid values:
'       0: Filterless
'       1: Classic PWM
'   Any other value returns the current setting
    case mode
        0:
            _mod_mode := core#MODULATION_FILTERLESS  'Filterless modulation
        1:
            _mod_mode := core#MODULATION_CLASSICPWM  'Classic PWM
        OTHER:
            return _mod_mode

    Powered (FALSE)
    Powered (TRUE)
  
    writeReg(_mod_mode)

PUB Mute
' Set 0 Volume
    Volume (0)

PUB Powered(enabled)
' Power on or off
'   Valid values:
'       FALSE (0): Power off
'       TRUE (-1 or 1): Power on
'   Any other value returns the current setting
    case ||enabled
        0:
            io.Low (_shdn)
        1:
            io.High (_shdn)
            Volume(_vol_level)
        OTHER:
            return io.State (_shdn)

PUB VolDown
' Decrease volume level
    writeReg(core#CMD_VOL_DN)

PUB Volume(level)
' Set Volume to a specific level
'   Valid values: 0..63
'   Any other value returns the current setting
    case level
        0..63:
            _vol_level := level
        OTHER:
            return _vol_level

    writeReg(_vol_level)

PUB VolUp
' Increase volume level
    writeReg(core#CMD_VOL_UP)

PRI writeReg(reg)

    i2c.Start
    i2c.Write (SLAVE_WR)
    i2c.Write (reg)
    i2c.Stop

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
