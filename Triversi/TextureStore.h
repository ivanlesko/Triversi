//
//  TextureGenerator.h
//  Triversi
//
//  Created by Luda on 5/10/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <Foundation/Foundation.h>

/// TextureGenerator is responsible for creating the Triangle piece textures.

/**
 *  The texture store contains all the textures the game will use.
 *  Access the textures by calling @p[[TextureStore sharedInstance] player1Up]@p
 */
@interface TextureStore : NSObject

/// TextureGen needs reference to a view since view's spit out SKTextures.
@property (nonatomic, strong) SKView *view;

@property (nonatomic, strong) SKTexture *player1Up;
@property (nonatomic, strong) SKTexture *player1Down;
@property (nonatomic, strong) SKTexture *player2Up;
@property (nonatomic, strong) SKTexture *player2Down;
@property (nonatomic, strong) SKTexture *neutralUp;
@property (nonatomic, strong) SKTexture *neutralDown;

/**
 *  This method calls the TextureStore singleton.
 *
 *  @return The TextureStore.
 */
+ (TextureStore *)sharedInstance;

/**
 *  Generates a triangle texture from the TextureStore's view.
 *
 *  @param pieceType The piece color.
 *  @param direction The piece direction
 *
 *  @return A red or blue triangle texture.
 */
- (SKTexture *)textureFromPieceType:(kTRTrianglePieceType)pieceType andDirection:(kTRTriangleDirection)direction;

@end
