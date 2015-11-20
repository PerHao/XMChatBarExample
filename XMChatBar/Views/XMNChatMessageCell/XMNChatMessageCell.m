//
//  XMNChatMessageCell.m
//  XMNChatExample
//
//  Created by shscce on 15/11/13.
//  Copyright © 2015年 xmfraker. All rights reserved.
//

#import "XMNChatMessageCell.h"

#import "XMNChatTextMessageCell.h"
#import "XMNChatImageMessageCell.h"
#import "XMNChatVoiceMessageCell.h"
#import "XMNChatSystemMessageCell.h"
#import "XMNChatLocationMessageCell.h"

#import "Masonry.h"

#import "UIImageView+XMWebImage.h"


@interface XMNChatMessageCell ()

@property (nonatomic, strong) UIMenuController *menuController;

@end

@implementation XMNChatMessageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

#pragma mark - Override Methods


- (void)updateConstraints {
    [super updateConstraints];
    if (self.messageOwner == XMNMessageOwnerSystem || self.messageOwner == XMNMessageOwnerUnknown) {
        return;
    }
    if (self.messageOwner == XMNMessageOwnerSelf) {
        [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).with.offset(-16);
            make.top.equalTo(self.contentView.mas_top).with.offset(16);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
        }];
        
        [self.nicknameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headIV.mas_top);
            make.right.equalTo(self.headIV.mas_left).with.offset(-16);
            make.width.mas_lessThanOrEqualTo(@120);
            make.height.equalTo(self.messageChatType == XMNMessageChatGroup ? @16 : @0);
        }];
        
        [self.messageContentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headIV.mas_left).with.offset(-16);
            make.top.equalTo(self.nicknameL.mas_bottom).with.offset(4);
            make.width.lessThanOrEqualTo(@([UIApplication sharedApplication].keyWindow.frame.size.width/5*3)).priorityHigh();
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-16).priorityLow();
        }];
        
        [self.messageSendStateIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.messageContentV.mas_left).with.offset(-8);
            make.centerY.equalTo(self.messageContentV.mas_centerY);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        [self.messageReadStateIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.messageContentV.mas_left).with.offset(-8);
            make.centerY.equalTo(self.messageContentV.mas_centerY);
            make.width.equalTo(@10);
            make.height.equalTo(@10);
        }];
    }else if (self.messageOwner == XMNMessageOwnerOther){
        [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(16);
            make.top.equalTo(self.contentView.mas_top).with.offset(16);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
        }];
        
        [self.nicknameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headIV.mas_top);
            make.left.equalTo(self.headIV.mas_right).with.offset(16);
            make.width.mas_lessThanOrEqualTo(@120);
            make.height.equalTo(self.messageChatType == XMNMessageChatGroup ? @16 : @0);
        }];
        
        [self.messageContentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headIV.mas_right).with.offset(16);
            make.top.equalTo(self.nicknameL.mas_bottom).with.offset(4);
            make.width.lessThanOrEqualTo(@([UIApplication sharedApplication].keyWindow.frame.size.width/5*3)).priorityHigh();
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-16).priorityLow();
        }];
        
        [self.messageSendStateIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.messageContentV.mas_right).with.offset(8);
            make.centerY.equalTo(self.messageContentV.mas_centerY);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        [self.messageReadStateIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.messageContentV.mas_right).with.offset(8);
            make.centerY.equalTo(self.messageContentV.mas_centerY);
            make.width.equalTo(@10);
            make.height.equalTo(@10);
        }];
    }
    [self.messageContentBackgroundIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.messageContentV);
    }];
    
    if (self.messageChatType == XMNMessageChatSingle) {
        [self.nicknameL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint touchPoint = [[touches anyObject] locationInView:self.contentView];
    if (CGRectContainsPoint(self.messageContentV.frame, touchPoint)) {
        self.messageContentBackgroundIV.highlighted = YES;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.messageContentBackgroundIV.highlighted = NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.messageContentBackgroundIV.highlighted = NO;
}


#pragma mark - Private Methods

- (void)setup {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.headIV];
    [self.contentView addSubview:self.nicknameL];
    [self.contentView addSubview:self.messageContentV];
    [self.contentView addSubview:self.messageReadStateIV];
    [self.contentView addSubview:self.messageSendStateIV];
    
    self.messageSendStateIV.hidden = YES;
    self.messageReadStateIV.hidden = YES;
    
    if (self.messageOwner == XMNMessageOwnerSelf) {
        [self.messageContentBackgroundIV setImage:[[UIImage imageNamed:@"message_sender_background_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24) resizingMode:UIImageResizingModeStretch]];
        [self.messageContentBackgroundIV setHighlightedImage:[[UIImage imageNamed:@"message_sender_background_highlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24) resizingMode:UIImageResizingModeStretch]];
    }else if (self.messageOwner == XMNMessageOwnerOther){
        [self.messageContentBackgroundIV setImage:[[UIImage imageNamed:@"message_receiver_background_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24) resizingMode:UIImageResizingModeStretch]];
        [self.messageContentBackgroundIV setHighlightedImage:[[UIImage imageNamed:@"message_receiver_background_highlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24) resizingMode:UIImageResizingModeStretch]];
    }
    
    self.messageContentV.layer.mask.contents = (__bridge id _Nullable)(self.messageContentBackgroundIV.image.CGImage);
    [self.contentView insertSubview:self.messageContentBackgroundIV belowSubview:self.messageContentV];
    
    [self updateConstraintsIfNeeded];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.contentView addGestureRecognizer:tap];

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.numberOfTouchesRequired = 1;
    longPress.minimumPressDuration = 1.f;
    [self.contentView addGestureRecognizer:longPress];
    
}

#pragma mark - Public Methods

- (void)configureCellWithData:(id)data {
    self.nicknameL.text = data[kXMNMessageConfigurationNicknameKey];
    [self.headIV setImageWithUrlString:data[kXMNMessageConfigurationAvatarKey]];
    
    if (self.messageOwner == XMNMessageOwnerSelf) {
        self.messageReadStateIV.hidden = YES;
        if (data[kXMNMessageConfigurationSendStateKey] && [data[kXMNMessageConfigurationSendStateKey] integerValue] == XMNMessageSendFail) {
            self.messageSendStateIV.hidden = NO;
        }else {
            self.messageSendStateIV.hidden = YES;
        }
    }else if (self.messageOwner == XMNMessageOwnerOther) {
        self.messageSendStateIV.hidden = YES;
        if (self.messageType == XMNMessageTypeVoice) {
            if (data[kXMNMessageConfigurationReadStateKey]  && [data[kXMNMessageConfigurationReadStateKey] integerValue] == XMNMessageReaded) {
                self.messageReadStateIV.hidden = YES;
            }else {
                self.messageReadStateIV.hidden = NO;
            }
        }else {
            self.messageReadStateIV.hidden = YES;
        }
    }
}

#pragma mark - Private Methods


//以下两个方法必须有
/*
 *  让UIView成为第一responser
 */
- (BOOL)canBecomeFirstResponder{
    return YES;
}

/*
 *  根据action,判断UIMenuController是否显示对应aciton的title
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(menuRelayAction) || action == @selector(menuCopyAction)) {
        return YES;
    }
    return NO;
}


- (void)handleTap:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateEnded) {
        CGPoint tapPoint = [tap locationInView:self.contentView];
        if (CGRectContainsPoint(self.messageContentV.frame, tapPoint)) {
            NSLog(@"tap message");
            [self.delegate messageCellTappedMessage:self];
        }else if (CGRectContainsPoint(self.headIV.frame, tapPoint)) {
            NSLog(@"tap head");
            [self.delegate messageCellTappedHead:self];
        }else {
            NSLog(@"tap blank");
            [self.delegate messageCellTappedBlank:self];
        }
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPressGes {
    if (longPressGes.state == UIGestureRecognizerStateBegan) {
        //首先自己成为第一responser
        [self becomeFirstResponder];
        //!!!此处使用self.superview.superview 获得到cell所在的tableView,不是很严谨,有哪位知道更加好的方法请告知
        [self.menuController setTargetRect:self.messageContentV.frame inView:self.superview.superview];
        [self.menuController setMenuVisible:YES animated:YES];
    }
}


- (void)menuCopyAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCell:withActionType:)]) {
        [self.delegate messageCell:self withActionType: XMNChatMessageCellMenuActionTypeCopy];
    }
}

- (void)menuRelayAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCell:withActionType:)]) {
        [self.delegate messageCell:self withActionType: XMNChatMessageCellMenuActionTypeRelay];
    }
}


#pragma mark - Getters

- (UIImageView *)headIV {
    if (!_headIV) {
        _headIV = [[UIImageView alloc] init];
        _headIV.layer.cornerRadius = 25.0f;
        _headIV.layer.masksToBounds = YES;
        _headIV.backgroundColor = [UIColor redColor];
    }
    return _headIV;
}

- (UILabel *)nicknameL {
    if (!_nicknameL) {
        _nicknameL = [[UILabel alloc] init];
        _nicknameL.font = [UIFont systemFontOfSize:12.0f];
        _nicknameL.textColor = [UIColor blackColor];
        _nicknameL.text = @"nickname";
    }
    return _nicknameL;
}

- (XMNContentView *)messageContentV {
    if (!_messageContentV) {
        _messageContentV = [[XMNContentView alloc] init];
    }
    return _messageContentV;
}

- (UIImageView *)messageReadStateIV {
    if (!_messageReadStateIV) {
        _messageReadStateIV = [[UIImageView alloc] init];
        _messageReadStateIV.backgroundColor = [UIColor redColor];
    }
    return _messageReadStateIV;
}

- (UIImageView *)messageSendStateIV {
    if (!_messageSendStateIV) {
        _messageSendStateIV = [[UIImageView alloc] init];
        _messageSendStateIV.backgroundColor = [UIColor greenColor];
    }
    return _messageSendStateIV;
}

- (UIImageView *)messageContentBackgroundIV {
    if (!_messageContentBackgroundIV) {
        _messageContentBackgroundIV = [[UIImageView alloc] init];
    }
    return _messageContentBackgroundIV;
}

- (XMNMessageType)messageType {
    if ([self isKindOfClass:[XMNChatTextMessageCell class]]) {
        return XMNMessageTypeText;
    }else if ([self isKindOfClass:[XMNChatImageMessageCell class]]) {
        return XMNMessageTypeImage;
    }else if ([self isKindOfClass:[XMNChatVoiceMessageCell class]]) {
        return XMNMessageTypeVoice;
    }else if ([self isKindOfClass:[XMNChatLocationMessageCell class]]) {
        return XMNMessageTypeLocation;
    }else if ([self isKindOfClass:[XMNChatSystemMessageCell class]]) {
        return XMNMessageTypeSystem;
    }
    return XMNMessageTypeUnknow;
}

- (XMNMessageChat)messageChatType {
    if ([self.reuseIdentifier containsString:@"GroupCell"]) {
        return XMNMessageChatGroup;
    } {
        return XMNMessageChatSingle;
    }
}

- (XMNMessageOwner)messageOwner {
    if ([self.reuseIdentifier containsString:@"OwnerSelf"]) {
        return XMNMessageOwnerSelf;
    }else if ([self.reuseIdentifier containsString:@"OwnerOther"]) {
        return XMNMessageOwnerOther;
    }else if ([self.reuseIdentifier containsString:@"OwnerSystem"]) {
        return XMNMessageOwnerSystem;
    }
    return XMNMessageOwnerUnknown;
}


- (UIMenuController *)menuController{
    if (!_menuController) {
        _menuController = [UIMenuController sharedMenuController];
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(menuCopyAction)];
        UIMenuItem *shareItem = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(menuRelayAction)];
        if (self.messageType == XMNMessageTypeText) {
            [_menuController setMenuItems:@[copyItem,shareItem]];
        }else{
            [_menuController setMenuItems:@[shareItem]];
        }
        [_menuController setArrowDirection:UIMenuControllerArrowDown];
    }
    return _menuController;
}


#pragma mark - Class Methods

+ (NSString *)cellIdentifierForMessageConfiguration:(NSDictionary *)messageConfiguration {
    XMNMessageType messageType = [messageConfiguration[kXMNMessageConfigurationTypeKey] integerValue];
    XMNMessageOwner messageOwner = [messageConfiguration[kXMNMessageConfigurationOwnerKey] integerValue];
    XMNMessageChat messageChat = [messageConfiguration[kXMNMessageConfigurationGroupKey] integerValue];
    NSString *identifierKey = @"XMNChatMessageCell";
    NSString *ownerKey;
    NSString *typeKey;
    NSString *groupKey;
    switch (messageOwner) {
        case XMNMessageOwnerSystem:
            ownerKey = @"OwnerSystem";
            break;
        case XMNMessageOwnerOther:
            ownerKey = @"OwnerOther";
            break;
        case XMNMessageOwnerSelf:
            ownerKey = @"OwnerSelf";
            break;
        default:
            NSAssert(NO, @"Message Owner Unknow");
            break;
    }
    switch (messageType) {
        case XMNMessageTypeVoice:
            typeKey = @"VoiceMessage";
            break;
        case XMNMessageTypeImage:
            typeKey = @"ImageMessage";
            break;
        case XMNMessageTypeLocation:
            typeKey = @"LocationMessage";
            break;
        case XMNMessageTypeSystem:
            typeKey = @"SystemMessage";
            break;
        case XMNMessageTypeText:
            typeKey = @"TextMessage";
            break;
        default:
            NSAssert(NO, @"Message Type Unknow");
            break;
    }
    switch (messageChat) {
        case XMNMessageChatGroup:
            groupKey = @"GroupCell";
            break;
        case XMNMessageChatSingle:
            groupKey = @"SingleCell";
            break;
        default:
            groupKey = @"";
            break;
    }
    
    return [NSString stringWithFormat:@"%@_%@_%@_%@",identifierKey,ownerKey,typeKey,groupKey];
}


+ (void)registerCellClassForTableView:(UITableView *)tableView {
    
    [tableView registerClass:[XMNChatImageMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerSelf_ImageMessage_GroupCell"];
    [tableView registerClass:[XMNChatImageMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerSelf_ImageMessage_SingleCell"];
    [tableView registerClass:[XMNChatImageMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerOther_ImageMessage_GroupCell"];
    [tableView registerClass:[XMNChatImageMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerOther_ImageMessage_SingleCell"];
    
    [tableView registerClass:[XMNChatLocationMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerSelf_LocationMessage_GroupCell"];
    [tableView registerClass:[XMNChatLocationMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerSelf_LocationMessage_SingleCell"];
    [tableView registerClass:[XMNChatLocationMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerOther_LocationMessage_GroupCell"];
    [tableView registerClass:[XMNChatLocationMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerOther_LocationMessage_SingleCell"];
    
    [tableView registerClass:[XMNChatVoiceMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerSelf_VoiceMessage_GroupCell"];
    [tableView registerClass:[XMNChatVoiceMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerSelf_VoiceMessage_SingleCell"];
    [tableView registerClass:[XMNChatVoiceMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerOther_VoiceMessage_GroupCell"];
    [tableView registerClass:[XMNChatVoiceMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerOther_VoiceMessage_SingleCell"];
    
    [tableView registerClass:[XMNChatTextMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerSelf_TextMessage_GroupCell"];
    [tableView registerClass:[XMNChatTextMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerSelf_TextMessage_SingleCell"];
    [tableView registerClass:[XMNChatTextMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerOther_TextMessage_GroupCell"];
    [tableView registerClass:[XMNChatTextMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerOther_TextMessage_SingleCell"];

    [tableView registerClass:[XMNChatSystemMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerSystem_SystemMessage_"];
    [tableView registerClass:[XMNChatSystemMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerSystem_SystemMessage_SingleCell"];
    [tableView registerClass:[XMNChatSystemMessageCell class] forCellReuseIdentifier:@"XMNChatMessageCell_OwnerSystem_SystemMessage_GroupCell"];

}
@end
