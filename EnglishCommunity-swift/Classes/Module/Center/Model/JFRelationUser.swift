//
//  JFRelationUser.swift
//  EnglishCommunity-swift
//
//  Created by zhoujianfeng on 16/8/16.
//  Copyright © 2016年 zhoujianfeng. All rights reserved.
//

import UIKit

class JFRelationUser: NSObject {
    
    /// 用户id
    var relationUserId = 0
    
    /// 昵称
    var relationNickname: String?
    
    /// 头像
    var relationAvatar: String?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    /**
     获取朋友关系列表
     
     - parameter relation: 0粉丝 1关注
     - parameter finished: 完成回调
     */
    class func getFriendList(relation: Int, finished: (relationUsers: [JFRelationUser]?) -> ()) {
        
        let parameters: [String : AnyObject] = [
            "user_id" : JFAccountModel.shareAccount()!.id,
            "relation" : relation
        ]
        
        JFNetworkTools.shareNetworkTool.get(GET_FRIEND_LIST, parameters: parameters) { (success, result, error) in
            
            guard let result = result where success == true else {
                return
            }
            
            let data = result["result"].arrayObject as! [[String : AnyObject]]
            var relationUsers = [JFRelationUser]()
            
            for dict in data {
                let relationUser = JFRelationUser(dict: dict)
                relationUsers.append(relationUser)
            }
            
            finished(relationUsers: relationUsers)
            
        }
        
    }

}
