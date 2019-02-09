{
    --------------------------------------------
    Filename: core.con.max9744.spin
    Author: Jesse Burt
    Description: MAX9744 low-level definitions
    Copyright (c) 2019
    Started Jul 7, 2018
    Updated Feb 9, 2019
    See end of file for terms of use.
    --------------------------------------------
}

CON

    I2C_MAX_FREQ      = 400_000             'Change to your device's maximum bus rate, according to its datasheet
    SLAVE_ADDR        = $4B << 1            'Change to your device's slave address, according to its datasheet

'' Register definitions
    CMD_VOL_UP            = %11_000100
    CMD_VOL_DN            = %11_000101
    MODULATION_FILTERLESS = %01_000000
    MODULATION_CLASSICPWM = %01_000001

PUB Null
'' This is not a top-level object
