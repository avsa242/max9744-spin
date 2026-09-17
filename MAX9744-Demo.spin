{
---------------------------------------------------------------------------------------------------
    Filename:       MAX9744-Demo.spin
    Description:    Simple serial terminal-based demo of the MAX9744 audio amp driver.
    Author:         Jesse Burt
    Started:        Jul 7, 2018
    Updated:        Sep 17, 2026
    Copyright (c) 2026 - See end of file for terms of use.
---------------------------------------------------------------------------------------------------
}
' Uncomment the two lines below to use the bytecode-based I2C engine
'#define MAX9744_I2C_BC
'#pragma exportdef(MAX9744_I2C_BC)

CON

    _clkmode    = xtal1+pll16x
    _xinfreq    = 5_000_000


OBJ

    ser:    "com.serial.terminal.ansi" | SER_BAUD=115_200
    amp:    "audio.amp.max9744" | SCL=28, SDA=29, I2C_FREQ=400_000, SHDN=24
    time:   "time"


PUB {++opt(0)}main() | i

    setup()
    amp.set_volume(31)                          ' set starting volume (midpoint)
    ser.clear()

    repeat
        ser.pos_xy(0, 0)
        ser.strln(@"Help:")
        ser.strln(@"[: Volume down")
        ser.strln(@"]: Volume up")
        ser.strln(@"f: Filterless modulation")
        ser.strln(@"m: Mute")
        ser.strln(@"p: Classic PWM modulation")
        ser.printf(@"\n\r\n\rVolume: %d \n\r", amp.volume() )

        i := ser.getchar()
        case i
            "[":
                amp.vol_down()
            "]":
                amp.vol_up()
            "f":
                ser.strln(@"Modulation mode: Filterless ")
                amp.set_modulation(amp.NONE)
            "m":
                amp.mute()
            "p":
                ser.strln(@"Modulation mode: Classic PWM")
                amp.set_modulation(amp.PWM)


PUB setup()

    ser.start()
    time.msleep(30)
    ser.clear()
    ser.strln(@"Serial terminal started")

    if ( amp.start() )
        ser.strln(@"MAX9744 driver started")
    else
        ser.strln(@"MAX9744 driver failed to start - halting")
        repeat


DAT
{
Copyright 2026 Jesse Burt

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT
OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
}

