//
//  Triangle.h
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TrianglePiece : SKShapeNode

@property (nonatomic) UIBezierPath *touchableArea;
@property (nonatomic) kTRTrianglePieceType type;
@property (nonatomic) int row;
@property (nonatomic) int column;

+ (TrianglePiece *)createTriangleAtPosition:(CGPoint)position withPieceType:(kTRTrianglePieceType)pieceType upSideDown:(BOOL)upSideDown;

@end
