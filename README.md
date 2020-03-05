# max9744-spin 
---------------

This is a P8X32A/Propeller driver object for the Maxim Semi. I2C MAX9744 Audio AMP IC

## Salient Features

* I2C connection at up to 400kHz
* Set Volume up, down, or to specific level
* Mute
* Classic PWM or Filterless modulation

## Requirements

* 1 additional core/cog for PASM I2C driver
* SPIN-only driver: N/A

## Limitations

* None known

## TODO

- [x] Create variant that uses a SPIN-based I2C driver, so as to be more compact, and not require an additional core, since the driver is so simple and resource-light anyway.
