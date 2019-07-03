//
//  ViewController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Drew Seeholzer on 7/2/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

#import "ViewController.h"
#import "DVMCardController.h"
#import "DVMCard.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)updateViews
{
    [DVMCardController fetchCard:^(DVMCard *card, NSError *error) {
        dispatch_async( dispatch_get_main_queue(), ^{
            self.cardLabel.text = card.suit;
            
        });
        [DVMCardController fetchImage:card completion:^(UIImage * image) {
            dispatch_async( dispatch_get_main_queue(), ^{
                
                self.cardImageView.image = image;
            });
            
        }];
    }];
}

- (IBAction)drawCardButtonTapped:(id)sender {
    [self updateViews];
}


@end
