//
//  GameScene.m
//  *¨%£M+/.&é"'(§è!çà)-$^`∞…÷≠@Ù€ô—}øÇ¡«¶{‘“ë•=:;,SLQTSOR
//
//  Created by Mike Daley on 29/08/2009.
//  Copyright 2009 Michael Daley. All rights reserved.
//
#import "GameController.h"
#import "GameScene.h"
#import "Image.h"
#import "ImageRenderManager.h"
#import "StaticObject.h"
#import "Player.h"
#import "Bombe.h"

static bool gameover;
static NSMutableArray  *bombes;
static NSMutableArray  *players;
static Player  *player;

@implementation GameScene

+(NSMutableArray *)getBombes{
    return bombes;
}
+(NSMutableArray *)getIAplayers{
    return players;
}
+(Player *)getplayer{
    return player;
}
+(void)setGameOver:(bool)over{
   gameover = over;
}

- (id) init
{
	self = [super init];
	if (self != nil) {
        if(bombes !=nil){
            [bombes removeAllObjects];
            [bombes release];
            bombes = nil;
        }
        if(players !=nil){
            [players removeAllObjects];
            [players release];
            players = nil;
        }
        
        players = [[NSMutableArray alloc] init];
        bombes = [[NSMutableArray alloc] init];
        gameover = false;
        
        sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
		
        insertBombe = [[StaticObject alloc] initWithImage:@"boom.png" withSize:CGRectMake(0,0, 18, 30)];
        insertBombe.postion = CGPointMake(145, 15);
        
        player = [[Player alloc] initWithImage:@"player.png" withSize:CGRectMake(0, 0, 20, 32) withNumber:9 withImgPerState:3 IA:false];
        
        
        //ajoute des adversaire
        [players addObject: [[Player alloc] initWithImage:@"playerred.png" withSize:CGRectMake(0, 0, 20, 32) withNumber:9 withImgPerState:3 IA:true]];
        
        [players addObject: [[Player alloc] initWithImage:@"playerviolet.png" withSize:CGRectMake(0, 0, 20, 32) withNumber:9 withImgPerState:3 IA:true]];
        [players addObject: [[Player alloc] initWithImage:@"playergris.png" withSize:CGRectMake(0, 0, 20, 32) withNumber:9 withImgPerState:3 IA:true]];
        
        finishGame = [[StaticObject alloc] initWithImage:@"gameover.gif" withSize:CGRectMake(0, 0, 220, 78) ];
        finishGame.postion = CGPointMake(140, 240);
        
    }
	return self;
}



- (void)updateSceneWithDelta:(float)aDelta {
    if (!gameover) {
        [player update];
        for (int i = 0 ; i<players.count ;i++) {
            Player * p =[players objectAtIndex:i];
            [p update];
        }
    }
}

- (void)renderScene{
    if (!gameover) {
        for (int i = 0 ; i<bombes.count ;i++) {
            Bombe *b =[bombes objectAtIndex:i];
            [b renderObject:sharedImageRenderManager];
        }
        
        for (int i = 0 ; i<players.count ;i++) {
            Player * p =[players objectAtIndex:i];
            [p renderObject:sharedImageRenderManager];
        }
        
        [player renderObject:sharedImageRenderManager];
        [insertBombe renderObject:sharedImageRenderManager];
    }else{
        [finishGame renderObject:sharedImageRenderManager];
    }
    
}


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView {
    UITouch *touch = [touches anyObject];
    touchLocation = [touch locationInView:aView];
    touchLocation.y = 480 - touchLocation.y;
    printf("%lf, %lf     ",touchLocation.x,touchLocation.y);
    
    if ([self insertBombeTouch]) {
        [player addBombe];
    } else {
        [player destinationAt:touchLocation];
    }
    if(gameover){
        AbstractScene *inter =[[GameController sharedGameController].gameScenes objectForKey:@"welcome"];
        [[GameController sharedGameController] setCurrentScene:inter ];

    }
}

-(bool)insertBombeTouch{
    return [insertBombe colusionWithPoint:touchLocation];
}


@end
