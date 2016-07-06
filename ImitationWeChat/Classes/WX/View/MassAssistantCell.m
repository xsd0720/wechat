//
//  MassAssistantCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/1.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "MassAssistantCell.h"

@implementation MassAssistantCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _bgButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButtonView.layer.cornerRadius = 5;
        _bgButtonView.clipsToBounds = YES;
        _bgButtonView.layer.borderColor = [RGB(206, 206, 206) CGColor];
        _bgButtonView.layer.borderWidth = 1;
        _bgButtonView.frame = CGRectMake(5, 10, SCREEN_WIDTH-40, 100);
        [self addSubview:_bgButtonView];
        
        
  
        
        _receiveTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(_bgButtonView.bounds), 44)];
        _receiveTitleView.backgroundColor = RGB(246, 246, 246);
        [_bgButtonView addSubview:_receiveTitleView];
        
        
        UIImage *im =[UIImage imageNamed:@"mailapp_arrow"];
        _mailapp_arrow = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_bgButtonView.bounds)-16-6, 18-im.size.height/2, im.size.width, im.size.height)];
        _mailapp_arrow.alpha = 0.7;
        _mailapp_arrow.image = [UIImage imageNamed:@"mailapp_arrow"];
        [_receiveTitleView addSubview:_mailapp_arrow];
        
        _receivePeoplesLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, CGRectGetMaxX(_receiveTitleView.bounds)-16-37, 44)];
        _receivePeoplesLabel.backgroundColor = RGB(246, 246, 246);
        _receivePeoplesLabel.textColor = RGB(118, 118, 118);
        _receivePeoplesLabel.font = [UIFont systemFontOfSize:13];
        _receivePeoplesLabel.numberOfLines = 0;
        [_receiveTitleView addSubview:_receivePeoplesLabel];
        
        
        _reSendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reSendButton setTitle:@"再发一条" forState:UIControlStateNormal];
        _reSendButton.backgroundColor = RGB(245, 245, 245);
        _reSendButton.layer.borderColor = [RGB(234, 233, 234) CGColor];
        _reSendButton.layer.borderWidth = 0.5;
        _reSendButton.layer.cornerRadius = 25/2;
        [_reSendButton setTitleColor:RGB(95, 95, 95) forState:UIControlStateNormal];
        _reSendButton.titleLabel.font = [UIFont systemFontOfSize:11];
        _reSendButton.frame = CGRectMake(CGRectGetMaxX(_bgButtonView.bounds)-65-15, CGRectGetMaxY(_bgButtonView.bounds)-10-25, 65, 25);
        _reSendButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [_bgButtonView addSubview:_reSendButton];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_receiveTitleView.bounds), CGRectGetMaxX(_receiveTitleView.bounds), 1)];
        lineView.backgroundColor = RGB(206, 206, 206);
        lineView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [_receiveTitleView addSubview:lineView];
        
        
        _sendContentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_receiveTitleView.frame), CGRectGetMaxX(_bgButtonView.bounds), 50)];
        [_bgButtonView addSubview:_sendContentView];
        
        _sendContentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(_sendContentView.bounds), 400/2)];
        _sendContentImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_sendContentView addSubview:_sendContentImageView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(receiveTitleViewClick)];
        [_receiveTitleView addGestureRecognizer:tap];
    }
    return self;
}

- (void)receiveTitleViewClick
{
    [LocalManager sharedManager].isopen = ![LocalManager sharedManager].isopen;
    
    UITableView *tabview = (UITableView *)self.superview.superview;
    [tabview reloadData];
    
}

- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    NSString *receivePeoplesStr = @"93位收信人:\n┌溡緔メ籹↘,柒染划破泪浅,___两个人的真情,又帅又能操,稳坐江山,Ghost゜湛蓝,煮茶煮酒煮时光,誰丶是我独家的记忆ゝ,Journey（旅程）,champion,比花还妖艳的笑容,以為`你爱我づ,谁惊艳了岁月,放肆的年华╰╯,﹏冷却の心,江湖浪人,我歌月徘徊,≮复仇★之怒≯,寻遍,ホ€思随颩散﹏.,副歌DI一句-,遥迢流年,仅 缺  份,凝眸处，又添一段新愁,即使我那么爱你-,生命在聆听,祝我万瘦不胖,某人，曾为伱哭泣,″　　兽性打败理性　-/g,甜蜜爱恋。Δ,假情。,冬至心凉。,流年割容颜※,某只小帅比,星星不说话★,…gū唇洧dú,看的见的阳光,恋爱记事簿,我很好比你好,我活得很好,Kiss or hugs,讓愛下地獄,等我变优秀,嘻哈body,咆哮着唱call me baby,宸墨诚星城拾光,外純內騷,小法师的忧伤,放肆的落寞〞,°越是想念，越是依赖,浪游,患得患失的情,瞳話嘟4噓ωёìの,Doctor异乡人。,喂.别犯贱,太平长安。,糟老头孑丶,柠檬仔℃,丶偷心少年丶,┉風彺Ьēīδ欠~`,丑的别致 ㄟ,果酱╰,ゆ我亵读了你的温存て,你不属于我i,柠檬片片,-海单纯洁白°,思念在发烫#,泪水无色,灿泪i,哲学式、演绎,抽煙菂渘情少年,っ心已麻木ン怎会痛゜,只想要你陪,感染你的气息﹌,夜 、唯美,装萌小可爱℡,无谓姑娘";
    
    CGSize size = CGSizeMake(_receivePeoplesLabel.width,2000); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: _receivePeoplesLabel.font};
    CGSize labelsize = [receivePeoplesStr boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    if (![LocalManager sharedManager].isopen) {
        labelsize.height = 15*3;
        _mailapp_arrow.transform = CGAffineTransformIdentity;
    }
    else
    {
        _mailapp_arrow.transform = CGAffineTransformMakeRotation(M_PI/2.0);
    }
    
    
    _receivePeoplesLabel.text = receivePeoplesStr;
    _receiveTitleView.height = labelsize.height+20;
    _receivePeoplesLabel.height = labelsize.height+20;
    
}

- (void)setSendContentImage:(UIImage *)sendContentImage
{
    CGSize resultSize = [sendContentImage limitMaxWidthHeight];
    
    _sendContentImageView.image = sendContentImage;
    _sendContentView.frame = CGRectMake(0, CGRectGetMaxY(_receiveTitleView.frame), CGRectGetMaxX(_bgButtonView.bounds), resultSize.height+40);
    _sendContentImageView.size = resultSize;
    _sendContentImageView.center = CGPointMake(CGRectGetMaxX(_sendContentView.bounds)/2, CGRectGetMaxY(_sendContentView.bounds)/2);
    _bgButtonView.height = _receiveTitleView.height+_sendContentView.height+25+10;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self bringSubviewToFront:_mailapp_arrow];
}
@end
