{
    --------------------------------------------
    Filename: MAX9744-Demo.spin
    Author: Jesse Burt
    Description: Simple serial terminal-based demo of the MAX9744
        audio amp driver.
    Copyright (c) 2020
    Started Jul 7, 2018
    Updated Mar 5, 2020
    See end of file for terms of use.
    --------------------------------------------
}

CON

    _clkmode    = cfg#_clkmode
    _xinfreq    = cfg#_xinfreq

    LED         = cfg#LED1
    SER_RX      = 31
    SER_TX      = 30
    SER_BAUD    = 115_200

    I2C_SCL     = 28
    I2C_SDA     = 29
    I2C_HZ      = 400_000                                               ' I2C clock used only with PASM driver
    SHDN_PIN    = 18

OBJ

    cfg     : "core.con.boardcfg.flip"
    ser     : "com.serial.terminal.ansi"
    io      : "io"
    time    : "time"
    amp     : "signal.audio.amp.max9744.i2c"                            ' PASM driver
'    amp     : "tiny.signal.audio.amp.max9744.i2c"                      ' SPIN-only driver

PUB Main | i, level

    Setup
    level := 31
    ser.Clear

    repeat
        ser.Position (0, 0)
        ser.Str (string("Volume: "))
        ser.Dec (level)
        ser.NewLine
        ser.Str (string("Press [ or ] for Volume Down or Up, respectively", ser#CR, ser#LF))
        i := ser.CharIn
            case i
                "[":
                    level := 0 #> (level - 1)
                    amp.VolDown
                "]":
                    level := (level + 1) <# 63
                    amp.VolUp
                "f":
                    ser.Str (string("Modulation mode: Filterless ", ser#CR, ser#LF))
                    amp.ModulationMode (0)
                "m":
                    ser.Str (string("MUTE", ser#CR, ser#LF))
                    amp.Mute
                "p":
                    ser.Str (string("Modulation mode: Classic PWM", ser#CR, ser#LF))
                    amp.ModulationMode (1)
                OTHER:

PUB Setup

    repeat until ser.StartRXTX (SER_RX, SER_TX, 0, SER_BAUD)
    time.MSleep(30)
    ser.Clear
    ser.Str (string("Serial terminal started", ser#CR, ser#LF))
    if amp.Startx (I2C_SCL, I2C_SDA, I2C_HZ, SHDN_PIN)                  ' PASM driver
'    if amp.Startx (I2C_SCL, I2C_SDA, SHDN_PIN)                         ' SPIN-only driver
        ser.Str (string("MAX9744 driver started", ser#CR, ser#LF))
    else
        ser.Str (string("MAX9744 driver failed to start - halting", ser#CR, ser#LF))
        amp.Stop
        time.MSleep (500)
        ser.Stop
        FlashLED(LED, 500)

#include "lib.utility.spin"

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
