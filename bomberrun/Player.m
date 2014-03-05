//
//  Player.m
//  CH05_SLQTSOR
//
//  Created by Lion User on 03/01/13.
//
//

#import "Player.h"
#import "GameScene.h"
#import "Bombe.h"

@implementation Player
@synthesize state;

-(id)initWithImage:(NSString*)filename withSize:(CGRect)sizeAndBegin withNumber:(int)nbr withImgPerState:(int)n IA:(Boolean)isIA{
    [super initWithImage:filename withSize:sizeAndBegin withNumber:nbr];
    distination = postion;
    state = BAS;
    nbrImgInEtat = n;
    moving = false;
    dead = false;
    ia = isIA;
    if(isIA){
        [NSTimer scheduledTimerWithTimeInterval:3  target:self selector:@selector(destinationAt) userInfo:nil repeats:FALSE];
        [NSTimer scheduledTimerWithTimeInterval:3  target:self selector:@selector(addBombe) userInfo:nil repeats:FALSE];
    }
    return self;
}



-(void)destinationAt{
    
    int x = arc4random()%250+15;
    int y = arc4random()%400+40;
 
    CGPoint newdes = CGPointMake(x, y);
    
    if (distination.x != newdes.x && distination.y != newdes.y) {
        distination = newdes;
        moving = true;
    }
}

	
-(void)destinationAt:(CGPoint) newdes{
    if (distination.x != newdes.x && distination.y != newdes.y) {
        distination = newdes;
        moving = true;
    }
}

-(void)update{
     if(moving && !vectory){
         if ([GameScene getIAplayers].count ==0) {
             vectory = true;
             [self vectoryPlayer];
         }else if(![self gauche])
         if(![self droite])
          if(![self bas])
           if (![self haut]) {
              moving = false;
               if (ia) {
                   int nextmove = arc4random()%20;
                   [NSTimer scheduledTimerWithTimeInterval:nextmove  target:self selector:@selector(destinationAt) userInfo:nil repeats:FALSE];
               }
           }
    }
}

-(void) renderObject{
    if (moving && !dead) {
        [self renderDeplacement];
    } else if(!dead){
        [self renderStatic];
    } else {
        [self renderDead];
    }
}

-(void) renderObject:(ImageRenderManager*)renderimages{
    if (moving && !dead && !vectory) {
        [self renderDeplacement];
    } else if(!dead && !vectory){
        [self renderStatic];
    } else if(dead){
        [self renderDead];
    } else if(vectory){
        [self renderVectory];
    }
    [current renderCenteredAtPoint:postion];
    [renderimages renderImages];
}


-(void)addBombe{
    if(!dead && !vectory){
        Bombe* b= [[Bombe alloc] initWithImage:@"bom.png" withSize:CGRectMake(0, 106, 21, 20) withNumber:3 withTime:3 withPuissance:3 AtPostion:postion];
        [[GameScene getBombes] addObject: b];
        if(ia ){
            int nextbombe = arc4random()%10;
            [NSTimer scheduledTimerWithTimeInterval:nextbombe  target:self selector:@selector(addBombe) userInfo:nil repeats:FALSE];
            [self destinationAt];

        }//*/
    }

}

////Private function
-(void)renderDeplacement{
    if(nbrcurrent == nbrImgInEtat) nbrcurrent =1;
    if (state == GAUCHE && nbrcurrent == 1) {
        current = [image subImageInRect:CGRectMake(78, begin.y, size.width+2, size.height)];
    }else if(state == DROITE && nbrcurrent ==2){
        current = [image subImageInRect:CGRectMake(160, begin.y, size.width+2, size.height)];
        
    }else{
    current = [image subImageInRect:CGRectMake(begin.x+((nbrcurrent+(state*nbrImgInEtat)) * size.width), begin.y, size.width, size.height)];
    }
    nbrcurrent++;
}



/////////render Static
-(void)renderStatic{
    if (state == HAUT) {
        current = [image subImageInRect:CGRectMake(183, begin.y, size.width-3, size.height)];
    } else {
        current = [image subImageInRect:CGRectMake(begin.x+(state*nbrImgInEtat * size.width), begin.y, size.width, size.height)];
    }
    
}


/////////Render vectory
-(void)renderVectory{
    if(nbrcurrent == nbrOfImage){
        NSLog(@"le joueur a Gagner");
        nbrcurrent =0;
    } else {
        if(nbrcurrent <  3){
            current = [image subImageInRect:CGRectMake(begin.x+(nbrcurrent * size.width), begin.y, size.width, size.height)];
        }else if(nbrcurrent ==  3){
            current = [image subImageInRect:CGRectMake(64, begin.y, 33, size.height)];
        } else if(nbrcurrent ==  4){
            current = [image subImageInRect:CGRectMake(97, begin.y, 42, size.height)];
        }else{
            current = [image subImageInRect:CGRectMake(139, begin.y, size.width, size.height)];
        }
        postion = CGPointMake(160, 240);
        
        nbrcurrent++;
    }
    
}

-(void)renderDead{
    if(nbrcurrent == nbrOfImage){
        NSLog(@"le joueur est mort\n");
        if (ia) {
            [[GameScene getIAplayers] removeObject:self];
        } else {
            [GameScene setGameOver:true];
        }
    } else {
        current = [image subImageInRect:CGRectMake(begin.x+(nbrcurrent * size.width), begin.y, size.width, size.height)];
        nbrcurrent++;
    }
    
}

-(void)death:(CGRect)begindeath withNumber:(int)nbr{
    begin = begindeath.origin;
    size = begindeath.size;
    dead = true;
    nbrOfImage = nbr;
    nbrcurrent = 0;
}

-(void)deathPlayer{
    [self death:CGRectMake(0, 73, 22, 32) withNumber:7];
    
}
-(void)vectory:(CGRect)begindeath withNumber:(int)nbr{
    begin = begindeath.origin;
    size = begindeath.size;
    vectory = true;
    nbrOfImage = nbr;
    nbrcurrent = 0;
}

-(void)vectoryPlayer{
    [self vectory:CGRectMake(0, 37, 21, 30) withNumber:5];
}

-(void)dealloc{
    [super dealloc];
}


//Moving functions

-(bool)gauche{
    if(postion.x > distination.x){
        state = GAUCHE;
        postion.x = postion.x -1;
        return true;
    } else return false;
}
-(bool)droite{
    if(postion.x < distination.x){
        state = DROITE;
        postion.x = postion.x + 1;
        return true;
    } else return false;
}
-(bool)haut{
    if(postion.y < distination.y){
        state = HAUT;
        postion.y = postion.y + 1;
        return true;
    } else {
        return  false;
    }
}
-(bool)bas{
    if(postion.y > distination.y){
        state = BAS;
        postion.y = postion.y -1;
        return true;
    } else return false;
}
@end
