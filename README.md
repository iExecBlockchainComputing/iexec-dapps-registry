# sudokuCLI

This Dapp provides a sudoku solver with OCR.

## Usage:
python3 apps/sudokuOCR <input> -o <output>
* The input must be the path to an image containing a sudoku grid.
* The (optional) output is the path to the completed grid.
  Default: ./completed.png

## Example:

> python3 apps/sudokuOCR.py ~/Code/Projects/sudokuOCR/imgs/grid.jpg
> Solution: 534678912672195348198342567859761423426853791713924856961537284287419635345286179

## Dependencies:
* python3
	* argparse
	* cv2
	* numpy
	* PIL
	* pytesseract
* [tesseract](https://github.com/tesseract-ocr/tesseract)
