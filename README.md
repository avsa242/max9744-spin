# max9744-spin 
--------------

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
* 1 additional core/cog for the PASM I2C engine (none if bytecode engine is used)

P2/SPIN2:
* p2-spin-standard-library

## Compiler Compatibility

| Processor | Language | Compiler               | Backend      | Status                |
|-----------|----------|------------------------|--------------|-----------------------|
| P1        | SPIN1    | FlexSpin (6.1.1)       | Bytecode     | OK                    |
| P1        | SPIN1    | FlexSpin (6.1.1)       | Native/PASM  | OK                    |
| P2        | SPIN2    | FlexSpin (6.1.1)       | NuCode       | FTBFS                 |
| P2        | SPIN2    | FlexSpin (6.1.1)       | Native/PASM2 | OK                    |

(other versions or toolchains not listed are not supported, and _may or may not_ work)

## Limitations

* None known

