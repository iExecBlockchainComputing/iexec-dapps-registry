#!/usr/bin/python3

import argparse
import cv2
import numpy as np
import PIL
import pytesseract

# =============================================================================
NUMBERS = [1,2,3,4,5,6,7,8,9]
# =============================================================================

class SudokuSolver:
	def __same_row(i,j):  return i // 9  == j // 9
	def __same_col(i,j):  return i  % 9  == j  % 9
	def __same_blk(i,j):  return i // 27 == j // 27 and i % 9 // 3 == j % 9 // 3
	def __dependent(i,j): return SudokuSolver.__same_row(i,j) or SudokuSolver.__same_col(i,j) or SudokuSolver.__same_blk(i,j)
	def __solve(grid):
		try:
			idx = next(i for i,v in enumerate(grid) if v not in NUMBERS)
		except:
			return grid
		exclude = set()
		for pos in range(81):
			if grid[pos] in NUMBERS:
				if SudokuSolver.__dependent(pos,idx):
					exclude.add(grid[pos])
		for value in NUMBERS:
			if value not in exclude:
				ngrid = SudokuSolver.__solve(grid[:idx]+[value]+grid[idx+1:])
				if ngrid:
					return ngrid
		return None
	def __check(grid):
		if len(grid) != 81:
			raise argparse.ArgumentTypeError('Argument must be a valid sudoku grid (size must be 81)')
		for idx in range(81):
			if grid[idx] in NUMBERS:
				for pos in range(81):
					if idx != pos and grid[idx] == grid[pos] and SudokuSolver.__dependent(pos,idx):
						raise argparse.ArgumentTypeError('Argument must be a valid sudoku grid (positions %d and %d should not have the same value)' % (idx, pos))
	def solve(grid):
		try:
			SudokuSolver.__check(grid)
			solved = SudokuSolver.__solve(grid)
			if solved:
				print("Solution:", "".join(str(i) for i in solved))
				return solved
		except:
			pass
		print("Reconstructed grid has no valid solution")
		exit(1)

# =============================================================================

class SudokuGrid:
	def __init__(self, poly):
		self.poly = np.array(poly).reshape(4,2)
	def coords(self, block):
		dx_min = (block // 9    ) / 9
		dx_max = (block // 9 + 1) / 9
		dy_min = (block  % 9    ) / 9
		dy_max = (block  % 9 + 1) / 9
		p0 = self.poly[0] * (1-dx_min) + self.poly[1] * dx_min
		p1 = self.poly[0] * (1-dx_max) + self.poly[1] * dx_max
		p3 = self.poly[3] * (1-dx_min) + self.poly[2] * dx_min
		p2 = self.poly[3] * (1-dx_max) + self.poly[2] * dx_max
		P0 = p0           * (1-dy_min) + p3           * dy_min
		P1 = p0           * (1-dy_max) + p3           * dy_max
		P3 = p1           * (1-dy_min) + p2           * dy_min
		P2 = p1           * (1-dy_max) + p2           * dy_max
		return P0,P1,P2,P3

# =============================================================================

class SudokuImage:
	def __init__(self, path):
		img    = cv2.imread(path)
		gray   = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
		gray   = cv2.GaussianBlur(gray,(5,5),0)
		thresh = cv2.adaptiveThreshold(gray,255,1,1,11,2)
		_, contours, _ = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
		biggest = (0, None)
		for i,c in enumerate(contours):
			area = cv2.contourArea(c)
			if area > biggest[0]:
				peri = cv2.arcLength(c,True)
				appr = cv2.approxPolyDP(c,0.02*peri,True)
				if len(appr) == 4:
					biggest = (area, appr)
		self.img    = img
		self.thresh = thresh
		self.grid   = SudokuGrid(biggest[1])
    # DEBUG
		# cv2.drawContours(self.img,[biggest[1]],-1,(255,255,0),1)

	def OCR(self):
		grid = []
		for idx in range(81):
			block = self.grid.coords(idx)
			zone  = np.array(block, dtype=np.int)
			zone += np.array([[+1,+1],[-1,+1],[-1,-1],[+1,-1]])*12
			roi   = self.thresh[zone[0,1]:zone[2,1],zone[0,0]:zone[2,0]]
			ocr   = pytesseract.image_to_string(PIL.Image.fromarray(roi), config='-psm 10 outputbase digits')
			# if ocr:
				# print("[{}] {}".format(idx, ocr))
				# DEBUG
				# pos   = tuple((np.array(block).mean(axis=0)+np.array([+10,+10])).astype(int))
				# cv2.putText(self.img, ocr, pos, cv2.FONT_HERSHEY_SCRIPT_COMPLEX, 1, color=(0,0,255), thickness=2)
			try:
				grid.append(int(ocr))
			except:
				grid.append(None)
		return grid

	def complete(self, new):
		size = self.img.shape[1] / 600
		for idx in range(81):
			if new[idx]:
				block = self.grid.coords(idx)
				pos   = tuple((np.array(block).mean(axis=0)+np.array([-10,+10])*size).astype(int))
				cv2.putText(self.img, str(new[idx]), pos, cv2.FONT_HERSHEY_SCRIPT_COMPLEX, size, color=(0,255,0), thickness=2)

# =============================================================================

if __name__ == '__main__':

	parser = argparse.ArgumentParser(description='Sudoku solver')
	parser.add_argument('input',          type=str)
	parser.add_argument('-o', '--output', type=str, default="complete.png")
	args = parser.parse_args()

	SG = SudokuImage(args.input)
	grid   = SG.OCR()
	solved = SudokuSolver.solve(grid)
	delta  = [ s if g not in NUMBERS else None for (g,s) in zip(grid, solved) ]
	SG.complete(delta)
	cv2.imwrite(args.output, SG.img)
