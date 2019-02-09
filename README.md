# max9744-spin 
---------------

This is a P8X32A/Propeller driver object for the Maxim Semi. I2C MAX9744 Audio AMP IC

## Salient Features

* Volume up
* Volume down
* Set specific volume
* Mute
* Classic PWM or Filterless modulation

## Requirements

* 1 additional core/cog for PASM I2C driver

## Limitations

* None known

## TODO

- [ ] Create variant that uses a SPIN-based I2C driver, so as to be more compact, and not require an additional core, since the driver is so simple and resource-light anyway.
