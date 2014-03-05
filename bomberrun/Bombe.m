//
//  Bombe.m
//  CH05_SLQTSOR
//
//  Created by Lion User on 10/01/13.
//
//

#import "Bombe.h"
#import "GameScene.h"
#import "Player.h"

@implementation Bombe

@synthesize dead;

-(id)initWithImage:(NSString*)filename withSize:(CGRect)sizeAndBegin withNumber:(int)nbr withTime:(NSTimeInterval) miliseconds withPuissance:(int)puissanc AtPostion:(CGPoint)postio{
    [super initWithImage:filename withSize:sizeAndBegin withNumber:nbr];
    dead = false;
    nbrcurrent = 0;
    puissance = puissanc;
    postion =postio;
    
    [NSTimer scheduledTimerWithTimeInterval:(miliseconds) target:self selector:@selector(deathBombe) userInfo:nil repeats:false];
    
    return self;
}

-(void)death:(CGRect) begindeath withNumber:(int)nbr{
    begin = begindeath.origin;
    size = begindeath.size;
    dead = true;
    nbrOfImage = nbr;
    nbrcurrent = 0;
    
}


-(void) renderObject{
     if(!dead){
        [self renderStatic];
    } else {
        [self renderDead];
    }
}
-(void) renderObject:(ImageRenderManager *)renderimages{
    if(!dead){
        [self renderStatic];
    } else {
        [self renderDead];
    }
    [current renderCenteredAtPoint:postion];
    [renderimages renderImages];
    
}



-(void)renderStatic{
    if(nbrcurrent == nbrOfImage )
        nbrcurrent =0;
    
    current = [image subImageInRect:CGRectMake(begin.x + (nbrcurrent * size.width), begin.y, size.width, size.height)];
    nbrcurrent ++;
    
}

-(void)renderDead{
    if(nbrcurrent == nbrOfImage){
        NSLog(@"la bombe a expoloser est mort\n");
        [[GameScene getBombes] removeObject:self];
        
    } else {
        if(nbrcurrent == 3){
            current = [image subImageInRect:CGRectMake(67, begin.y, 20, size.height)];
            
        }
        else{
        current = [image subImageInRect:CGRectMake(begin.x+(nbrcurrent * size.width), begin.y, size.width, size.height)];
        }
        current.scale = Scale2fMake(current.scale.x+puissance, current.scale.y+puissance);
        nbrcurrent++;
    }
}

-(void)deathBombe{
    [self death:CGRectMake(0, 156, 22, 20) withNumber:4];
    
    for (int i=0; i<[GameScene getBombes].count; i++) {
        Bombe *b =[[GameScene getBombes] objectAtIndex:i];
        if (!CGPointEqualToPoint(postion, b.postion) && [self colusionWith:b]) {
            if (!b.dead) {
                [b deathBombe];
            }
        }
    }
    for (int i=0; i<[GameScene getIAplayers].count; i++) {
        Player *p =[[GameScene getIAplayers] objectAtIndex:i];
        
        if ([self colusionWith:p]) {
            [p deathPlayer];
        }
    }
    
    if ([self colusionWith:[GameScene getplayer]])  {
        [[GameScene getplayer] deathPlayer];
     }//*/

}

-(Boolean)colusionWith:(AbstractObject *)other{
    CGRect me = CGRectMake(postion.x-size.width/2, postion.y-size.height/2, size.width*puissance, size.height*puissance);
    CGRect oth = CGRectMake(other.postion.x, other.postion.y, other.size.width, size.height);
    return CGRectIntersectsRect(me, oth);
}

@end
