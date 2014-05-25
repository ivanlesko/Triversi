//
//  TextureGenerator.m
//  Triversi
//
//  Created by Luda on 5/10/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "TextureStore.h"
#import "UIBezierPath+TriversiShapes.h"
#import "AppDelegate.h"

@implementation TextureStore

+ (TextureStore *)sharedInstance {
    static TextureStore *sharedGenerator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGenerator = [[self alloc] init];
    });
    
    return sharedGenerator;
}

- (id)init {
    if (self = [super init]) {
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        self.view = delegate.view;
        
        self.player1Up = [self textureFromPieceType:kTRTrianglePieceTypeRed andDirection:kTRTriangleDirectionUp];
        self.player1Down = [self textureFromPieceType:kTRTrianglePieceTypeRed andDirection:kTRTriangleDirectionDown];
        
        self.player2Up = [self textureFromPieceType:kTRTrianglePieceTypeBlue andDirection:kTRTriangleDirectionUp];
        self.player2Down = [self textureFromPieceType:kTRTrianglePieceTypeBlue andDirection:kTRTriangleDirectionDown];
        
        self.neutralUp = [self textureFromPieceType:kTRTrianglePieceTypeNeutral andDirection:kTRTriangleDirectionUp];
        self.neutralDown = [self textureFromPieceType:kTRTrianglePieceTypeNeutral andDirection:kTRTriangleDirectionDown];
    }
    
    return self;
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
    
    newPiece.path = [[UIBezierPath acuteTriangleForDirection:direction] CGPath];
    newPiece.lineWidth   = 1.0;
    newPiece.antialiased = YES;
    
    return newPiece;
}

- (SKTexture *)textureFromPieceType:(kTRTrianglePieceType)pieceType andDirection:(kTRTriangleDirection)direction {
    SKShapeNode *triangle = [TextureStore createPieceWithPieceType:pieceType withDirection:direction];
    
    return [self.view textureFromNode:triangle];
}

@end























