# max9744-spin 
--------------

This is a P8X32A/Propeller, P2X8C4M64P/Propeller 2 driver object for the Analog Devices (Maxim) I2C MAX9744 Audio AMP IC

**IMPORTANT**: This software is meant to be used with the [spin-standard-library](https://github.com/avsa242/spin-standard-library) (P8X32A) or [p2-spin-standard-library](https://github.com/avsa242/p2-spin-standard-library) (P2X8C4M64P). Please install the applicable library first before attempting to use this code, otherwise you will be missing several files required to build the project.


## Salient Features

* I2C connection at up to 400kHz
* Set Volume up, down, or to specific level
* Mute
* Classic PWM or Filterless modulation


## Requirements

P1/SPIN1:
* spin-standard-library
* 1 additional core/cog for the PASM I2C engine (none if bytecode engine is used)

P2/SPIN2:
* p2-spin-standard-library


## Compiler Compatibility

| Processor | Language | Compiler               | Backend      | Status                |
|-----------|----------|------------------------|--------------|-----------------------|
| P1        | SPIN1    | FlexSpin (7.7.2beta)   | Bytecode     | OK                    |
| P1        | SPIN1    | FlexSpin (7.7.2beta)   | Native/PASM  | OK                    |
| P2        | SPIN2    | FlexSpin (7.7.2beta)   | NuCode       | OK                    |
| P2        | SPIN2    | FlexSpin (7.7.2beta)   | Native/PASM2 | OK                    |

(other versions or toolchains not listed are not supported, and _may or may not_ work)


## Limitations

* TBD

