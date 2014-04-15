//
//  GameScene.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "GameScene.h"
#import "Piece.h"

@implementation GameScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.board = [Board createNewBoardAtPosition:CGPointMake(size.width / 2.0, size.height / 2.0)];
        [self addChild:self.board];
        
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInNode:self];
    NSArray *nodes = [self nodesAtPoint:position];
    for (Piece *piece in nodes) {
        if ([piece isKindOfClass:[Piece class]]) {
            position = [touch locationInNode:piece];
            if ([piece.touchableArea containsPoint:position]) {
                Piece *newPiece = [Piece placePieceAtRow:piece.row
                                               andColumn:piece.column
                                              atPosition:piece.position
                                           withPieceType:kTRTrianglePieceTypeBlue
                                           withDirection:piece.direction];
                NSLog(@"direction : %d", piece.direction);
                [self.board.triangleGrid addChild:newPiece];
            }
        }
    }
}

@end

















