//
//  GameScene.h
//  SLQTSOR
//
//  Created by Mike Daley on 29/08/2009.
//  Copyright 2009 Michael Daley. All rights reserved.
//

#import "AbstractScene.h"
@class StaticObject;
@class Image;
@class ImageRenderManager;
@class Player;


@interface GameScene : AbstractScene {
	float transY;
	CGPoint touchLocation;

    //Menu
    StaticObject *insertBombe;
    StaticObject *Menu;
    
    //DynamicObject * player;
	ImageRenderManager *sharedImageRenderManager;
    
    //gameover
    StaticObject *finishGame;
}


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView;
+(NSMutableArray *)getBombes;

+(NSMutableArray *)getIAplayers;
+(Player *)getplayer;
+(void)setGameOver:(bool)over;
@end
