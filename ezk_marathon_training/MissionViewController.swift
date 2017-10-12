//
//  MissionViewController.swift
//  ezk_marathon_training
//
//  Created by 山本和夫 on 2017/10/02.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import UIKit
import PagingMenuController

class MissionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let options = MissionPagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

private struct MissionPagingMenuOptions: PagingMenuControllerCustomizable {
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [UIViewController] {
        let vc1 = DailyMissionViewController()
        let vc2 = WeeklyMissionViewController()
        let vc3 = MainMissionViewController()
        return [vc1, vc2, vc3]
    }
    
    fileprivate struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        
        var itemWidthMode: MenuItemWidthMode {
            return .fixed(width: 50.0)
        }
        
        var itemsOptions: [MenuItemViewCustomizable] {
            return [DailyMission(), WeeklyMission(), MainMission()]
        }
        
        var focusMode: MenuFocusMode {
            return .underline(height: 4.0, color: UIColor.black, horizontalPadding: 0.0, verticalPadding: 0.0)
        }
    }
    
    fileprivate struct DailyMission: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "デイリー"))
        }
    }
    fileprivate struct WeeklyMission: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "ウィークリー"))
        }
    }
    fileprivate struct MainMission: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "メイン"))
        }
    }
}
