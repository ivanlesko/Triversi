//
//  Board.h
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Board : NSObject

/// These are the blank triangles without any peices on them.
@property (nonatomic, strong) SKNode *triangleGrid;

/// An array of the triangle pieces currently on the grid.
@property (nonatomic, strong) NSMutableArray *pieces;



@end
