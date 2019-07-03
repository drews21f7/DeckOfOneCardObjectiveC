//
//  DVMCard.m
//  DeckOfOneCardObjectiveC
//
//  Created by Drew Seeholzer on 7/2/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

#import "DVMCard.h"

@implementation DVMCard

-(instancetype)initWithCardName:(NSString *)suit image:(NSString *)image
{
    self = [super init];
    if (self != nil) {
        _suit = suit;
        _image = image;
    }
    return self;
}

@end

@implementation DVMCard (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *suit = dictionary[@"suit"];
    NSString *image = dictionary[@"image"];
    
    return [self initWithCardName:suit image:image];
}

@end
