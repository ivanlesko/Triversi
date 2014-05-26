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
 *  It's important to note that we should only ever use the 6 texture properties that the TextureStore has.
 *  There should only ever be 6 different triangle textures.  This is to save memory and slightly increase performance.
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

@end
