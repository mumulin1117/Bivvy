//A模版 path

enum TOWINKLIopVibeRoute: String {

    case TOWINKLIopSparkAI = "pages/AIexpert/index?”    //AI香薰专家  
    case TOWINKLIopVibeVault = "pages/repository/index?current=“ // 香薰知识库  顺序(0-2) (可不传)
    case TOWINKLIopAromaDetail = "pages/AromatherapyDetails/index?dynamicId=“  // 香薰详情  动态ID
    case TOWINKLIopMomentDetail = "pages/DynamicDetails/index?dynamicId=“ // 动态详情  动态ID
   
    case TOWINKLIopPostArticle = "pages/issue/index?"// 发布动态
    case TOWINKLIopPostVisual = "pages/postVideos/index?"// 发布视频
    case TOWINKLIopUserCore = "pages/homepage/index?userId=“ // 他人主页  用户ID
    case TOWINKLIopReportNode = "pages/report/index?”  // 用户举报  
    case TOWINKLIopAuthVerify = "pages/information/index?”  // 消息列表  
    case TOWINKLIopProfileModify = "pages/EditData/index?” // 编辑资料  
    
    case TOWINKLIopFollowGroup = "pages/attentionList/index?type=“ // 关注/粉丝列表  1关注 2 粉丝
    case TOWINKLIopFanGroup = "pages/wallet/index?” // 充值页面  
    case TOWINKLIopBalanceVault = "pages/SetUp/index?” // 设置  
    case TOWINKLIopMasterConfig = "pages/Agreement/index?type=1?"//用户协议
    case TOWINKLIopLegalTerms = "pages/Agreement/index?type=2"//隐私政策
    case TOWINKLIopPrivacyPolicy = "pages/privateChat/index?userId=“ //私聊 用户ID (拨打视频时增加参数 CallVideo=1 )
    case TOWINKLIopVoidChannel = ""
    
    
  
    func TOWINKLIopConstructFinalPath(TOWINKLIopQuery: String) -> String {
        let TOWINKLIopBaseGateway = "http://modernlifestylehub99globalmarket.shop/#"
        
        if self != .TOWINKLIopVoidChannel {
            let TOWINKLIopAuthToken = Network.TOWINKLIopSessionToken ?? ""
            let TOWINKLIopUniqueAppId = "81266843"
            
            let TOWINKLIopMergedPath = String(
                format: "%@%@%@&token=%@&appID=%@",
                TOWINKLIopBaseGateway,
                self.rawValue,
                TOWINKLIopQuery,
                TOWINKLIopAuthToken,
                TOWINKLIopUniqueAppId
            )
            
            return TOWINKLIopMergedPath
        }
        
        return TOWINKLIopBaseGateway
    }
   

}
