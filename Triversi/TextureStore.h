//
//  TextureGenerator.h
//  Triversi
//
//  Created by Luda on 5/10/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <Foundation/Foundation.h>

/// TextureGenerator is responsible for creating the Triangle piece textures.

@interface TextureStore : NSObject

+ (TextureStore *)sharedInstance;

/// Creates a new piece but does not place it on the board.
/// This method is mostly used to create the textures for the documents directory.
+ (SKShapeNode *)createPieceWithPieceType:(kTRTrianglePieceType)pieceType
                      withDirection:(kTRTriangleDirection)direction;

- (SKTexture *)textureFromPieceType:(kTRTrianglePieceType)pieceType andDirection:(kTRTriangleDirection)direction ;

/// TextureGen needs reference to a view since view's spit out SKTextures.
@property (nonatomic, strong) SKView *view;

@end
