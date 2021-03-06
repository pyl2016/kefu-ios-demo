//
//  HDMemberObject.h
//  HRTCDemo
//
//  Created by afanda on 7/26/17.
//  Copyright © 2017 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDCallBackView.h"

@interface HVideoItem : NSObject
@property(nonatomic,strong) HDCallBackView *backView;
@property(nonatomic,assign) HCallViewScaleMode scaleMode;
@property (nonatomic, strong) HDCallRemoteView * normalView;
@property (nonatomic, strong) HDCallRemoteView * deskTopView;
@end

typedef void(^tapBlock)(HVideoItem *videoItem);
@interface HDMemberObject : NSObject
@property(nonatomic,strong) NSString *memberName;
@property(nonatomic,strong) NSString *agentName;
@property(nonatomic,assign) BOOL isFull;
@property (nonatomic, strong) HCallStream * normalStream;
@property (nonatomic, strong) HCallStream * deskTopStream;
@property (nonatomic, strong) HVideoItem * remoteVideoItem;
- (instancetype)initWithMemberName:(NSString *)memberName frame:(CGRect)frame target:(id)target;
- (void)setTapBlock:(tapBlock)tapBlock;
@end
