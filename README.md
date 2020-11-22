# max9744-spin 
---------------

This is a P8X32A/Propeller driver object for the Maxim Semi. I2C MAX9744 Audio AMP IC

**IMPORTANT**: This software is meant to be used with the [spin-standard-library](https://github.com/avsa242/spin-standard-library) (P8X32A) or [p2-spin-standard-library](https://github.com/avsa242/p2-spin-standard-library) (P2X8C4M64P). Please install the applicable library first before attempting to use this code, otherwise you will be missing several files required to build the project.

## Salient Features

* I2C connection at up to 400kHz
* Set Volume up, down, or to specific level
* Mute
* Classic PWM or Filterless modulation

## Requirements

P1/SPIN1:
* spin-standard-library
* PASM driver: 1 additional core/cog
* SPIN-only driver: N/A

P2/SPIN2:
* p2-spin-standard-library

## Compiler Compatibility

* P1/SPIN1: OpenSpin (tested with 1.00.81)
* P2/SPIN2: FastSpin (tested with 5.0.0)
* ~~BST~~ (incompatible - no preprocessor)
* ~~Propeller Tool~~ (incompatible - no preprocessor)
* ~~PNut~~ (incompatible - no preprocessor)

## Limitations

* None known

## TODO

- [x] Create variant that uses a SPIN-based I2C driver, so as to be more compact, and not require an additional core, since the driver is so simple and resource-light anyway.
- [x] Port to P2/SPIN2
