//
//  Board.h
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Piece.h"

@interface Board : SKNode

/// These are the blank triangles without any peices on them.
@property (nonatomic, strong) SKNode *triangleGrid;

/// Squares is a loose term for each piece on the triangle grid, similar to a square on a chess board.
@property (nonatomic, strong) NSMutableArray *squares;

/// Played pieces contains the actual pieces on top of the grid.
@property (nonatomic, strong) NSMutableArray *playedPieces;

+ (Board *)createNewBoardAtPosition:(CGPoint)position;

@end
