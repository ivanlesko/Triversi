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

@property (nonatomic, strong) NSMutableArray *emptyPieces;

/// Pieces node is a node that contains all of the pieces that have been played.
/// We need this to be a separate layer from the triangle grid.
/// The pieces played are their own layer in the node tree.
@property (nonatomic, strong) SKNode *piecesNode;

/// Played pieces contains the actual pieces on top of the grid.
@property (nonatomic, strong) NSMutableArray *playedPieces;

@property (nonatomic, strong) NSNumber *player1pieces;
@property (nonatomic, strong) NSNumber *player2pieces;

+ (Board *)createNewBoardAtPosition:(CGPoint)position;

- (void)placeInitialPieces;

@end
