//
//  MMInviteFriendCollectionViewCell.h
//  LooseLeaf
//
//  Created by Adam Wulf on 9/8/14.
//  Copyright (c) 2014 Milestone Made, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMInviteUserButton.h"


@interface MMCloudKitInviteCollectionViewCell : UICollectionViewCell <MMInviteUserButtonDelegate>

@property (nonatomic, weak) NSObject<MMInviteUserButtonDelegate>* delegate;

@end
