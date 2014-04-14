//
//  GameScene.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "GameScene.h"
#import "TrianglePiece.h"

@implementation GameScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        SKNode *grid = [SKNode node];
        grid.name = @"triangleGrid";
        grid.position = CGPointMake(size.width / 2.0, size.height / 2.0);
        
        [self addChild:grid];
        
        int rows = 8;
        int columns = 9;
        
        TrianglePiece *placeholderTri = [TrianglePiece createTriangleAtPosition:CGPointMake(0, 0) withPieceType:kTRTrianglePieceTypeNeutral upSideDown:NO];
        CGFloat spacing = placeholderTri.frame.size.width / 2.0;
        
        [self addChild:placeholderTri];
        CGPoint origin = CGPointMake(-rows / 2.0 * spacing, rows / 2.0 * spacing + placeholderTri.frame.size.height);
        CGPoint newOrigin = origin;
        
        BOOL upSideDown = NO;
        
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < columns; j++) {
                TrianglePiece *newTri;
                if (j % 2 == 0) {
                    // even numbered row
                    newTri = [TrianglePiece createTriangleAtPosition:newOrigin withPieceType:kTRTrianglePieceTypeBlue upSideDown:upSideDown];
                }
                else {
                    // odd number row
                    newTri = [TrianglePiece createTriangleAtPosition:newOrigin withPieceType:kTRTrianglePieceTypeRed upSideDown:upSideDown];
                }
                newTri.name   = [NSString stringWithFormat:@"triangle%d%d", i, j];
                newTri.row    = i;
                newTri.column = j;
                upSideDown = !upSideDown;
                [grid addChild:newTri];
                newOrigin = CGPointMake(newOrigin.x + spacing, newOrigin.y);
            }
            newOrigin = CGPointMake(origin.x, newOrigin.y - placeholderTri.frame.size.height);
        }
        
        [placeholderTri removeFromParent];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInNode:self];
    NSArray *nodes = [self nodesAtPoint:position];
    for (TrianglePiece *triangle in nodes) {
        if ([triangle isKindOfClass:[TrianglePiece class]]) {
            position = [touch locationInNode:triangle];
            if ([triangle.touchableArea containsPoint:position]) {
                NSLog(@"triangle: %@", triangle);
            }
        }
    }
}

@end

















