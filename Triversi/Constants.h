//
//  Constants.h
//  Swing Boxer
//
//  Created by Ivan Lesko on 3/5/14.
//  Copyright (c) 2014 Richard Lichkus, Ivan Lesko, Spencer Fornaciari, Chris Meehan. All rights reserved.
//

#import <Foundation/Foundation.h>

// Glove Side Enum
typedef enum {
    kSBGloveLeft = 0,
    kSBGloveRight
} kSBGloveType;

typedef enum {
    kTRTrianglePieceTypeNeutral = 0,
    kTRTrianglePieceTypeRed,
    kTRTrianglePieceTypeBlue
} kTRTrianglePieceType;

typedef enum {
    kTRPieceColorPlayer1 = 0,
    kTRPieceColorPlayer2
} kTRPieceColor;

typedef enum {
    kTRResultPlayer1Won = 0,
    kTRResultPlayer2Won,
    kTRResultDraw
} kTRResult;

typedef enum {
    kTRTriangleDirectionUp = 0,
    kTRTriangleDirectionDown
} kTRTriangleDirection;

#define ROWS    8
#define COLUMNS 9

// Objects
#define NULL_OBJECT [NSNull null]

/// Leaderboard Identifiers
#define kSBLeaderboardIDEasyWins   = @"easyWins"
#define kSBLeaderboardIDMediumWins = @"mediumWins"
#define kSBLeaderboardIDHardWinw   = @"hardWins"

#define BOARD         @"board"
#define TRIANGLE_GRID @"triangleGrid"
#define EMPTY_SPACE   @"emptySpace"

#pragma mark - Notifications

#define PLACED_NEW_PIECE @"placedNewPiece"

