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
* PASM driver: 1 additional core/cog for the PASM I2C engine
* SPIN-only driver: N/A

P2/SPIN2:
* p2-spin-standard-library

## Compiler Compatibility

* P1/SPIN1 FlexSpin (bytecode): OK, tested with 5.9.10-beta
* P1/SPIN1 FlexSpin (native): OK, tested with 5.9.10-beta
* P2/SPIN2 FlexSpin (nu-code): Untested
* P2/SPIN2 FlexSpin (native): OK, tested with 5.9.10-beta
* P1/SPIN1 OpenSpin (bytecode): Untested (deprecated)
* ~~BST~~ (incompatible - no preprocessor)
* ~~Propeller Tool~~ (incompatible - no preprocessor)
* ~~PNut~~ (incompatible - no preprocessor)

## Limitations

* None known

