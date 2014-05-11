//
//  TextureGenerator.m
//  Triversi
//
//  Created by Luda on 5/10/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "TextureStore.h"

@implementation TextureStore

+ (TextureStore *)sharedInstance {
    static TextureStore *sharedGenerator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGenerator = [[self alloc] init];
    });
    
    return sharedGenerator;
}

+ (SKShapeNode *)createPieceWithPieceType:(kTRTrianglePieceType)pieceType
                            withDirection:(kTRTriangleDirection)direction {
    SKShapeNode *newPiece = [SKShapeNode node];
    
    ////// Path Creation //////
    
    // Set the piece's color based on the pieceType enum.
    switch (pieceType) {
        case kTRTrianglePieceTypeNeutral:
            newPiece.fillColor = [SKColor lightGrayColor];
            break;
            
        case kTRTrianglePieceTypeRed:
            newPiece.fillColor = [SKColor colorWithHexString:@"bd3b3b"];
            break;
            
        case kTRTrianglePieceTypeBlue:
            newPiece.fillColor = [SKColor colorWithHexString:@"395c78"];
            break;
    }
    
    newPiece.path = [[TextureStore bezierPathForDirection:direction] CGPath];
    newPiece.antialiased = YES;
    
    return newPiece;
}

+ (UIBezierPath *)bezierPathForDirection:(kTRTriangleDirection)direction {
    ////// Path Creation //////
    
    // Set the size of the piece depending on what device the user is on.
    CGFloat sideLength;
    if ([UIDevice iPhone]) {
        sideLength = 320.0f / 5.8181f;
    }
    
    if ([UIDevice iPad]) {
        sideLength = 768.0f / 6.8181f;
    }
    
    CGFloat height = sideLength * (sqrtf(3) / 2.0);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // Set the direction of the piece depending on the up/down enum.
    switch (direction) {
        case kTRTriangleDirectionDown:
            [path moveToPoint:CGPointMake(0, -height / 2.0)];
            [path addLineToPoint:CGPointMake(-sideLength / 2.0, height / 2.0)];
            [path addLineToPoint:CGPointMake(sideLength / 2.0, height / 2.0)];
            [path addLineToPoint:CGPointMake(0, -height / 2.0)];
            break;
            
        case kTRTriangleDirectionUp:
            [path moveToPoint:CGPointMake(0, height / 2.0)];
            [path addLineToPoint:CGPointMake(-sideLength / 2.0, -height / 2.0)];
            [path addLineToPoint:CGPointMake(sideLength / 2.0, -height / 2.0)];
            [path addLineToPoint:CGPointMake(0, height / 2.0)];
            break;
    }
    
    return path;
}

- (SKTexture *)textureFromPieceType:(kTRTrianglePieceType)pieceType andDirection:(kTRTriangleDirection)direction {
    SKShapeNode *triangle = [TextureStore createPieceWithPieceType:pieceType withDirection:direction];
    
    NSString *playerString;
    NSString *directionString;
    
    NSDictionary *playerStringDict = @{
                                       @(kTRTrianglePieceTypeRed):     @"player1",
                                       @(kTRTrianglePieceTypeBlue):    @"player2",
                                       @(kTRTrianglePieceTypeNeutral): @"player3"
                                       };
    
    NSDictionary *direcitonDict = @{
                                    @(kTRTriangleDirectionUp):   @"up",
                                    @(kTRTriangleDirectionDown): @"down"
                                    };
    
    return [self.view textureFromNode:triangle];
}

@end























