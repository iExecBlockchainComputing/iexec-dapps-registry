# sudokuCLI

This Dapp provides a CLI sudoku solver.

## Usage:
The application takes a single argument: a sudoku grid formated
as an ascii string. Any caractere other than 1~9 can be used to
represent free cells (ex: '0', '.', '#' ...)

## Example:

> python3 apps/sudokuCLI 53..7....6..195....98....6.8...6...34..8.3..17...2...6.6....28....419..5....8..79
> 534678912672195348198342567859761423426853791713924856961537284287419635345286179

## Dependencies:
* python3
* argparse (python module)