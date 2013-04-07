//
//  ViewController.h
//  FlickerEater
//
//  Created by Gonzalo Erro on 4/5/13.
//  Copyright (c) 2013 Gonzalo Erro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickerParser.h"

@interface MainListViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, FlickerParserDelegate>

@property(nonatomic, assign)IBOutlet UICollectionView *imagesCollection;

@end
