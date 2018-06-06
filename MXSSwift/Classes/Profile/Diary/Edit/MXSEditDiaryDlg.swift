//
//  MXSEditDiaryDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 22/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSEditDiaryDlg: MXSTableDlg {

	var queryDataSub: MXSDiary?
	
	let title_arr = ["Date", "Weather", "Content", "Think", "Mood"]
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 4
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
        let cell = tableView.dequeueReusableCell(withIdentifier: (cellNames?.first)!, for: indexPath) as! MXSEditDiaryCell
		cell.titleLabel?.text = title_arr[indexPath.row]
		
		if indexPath.row == 0 {
			let date = (queryDataSub?.date_daily)! as Date
			cell.cellData = dateConvertString(date)
		}
		else if indexPath.row == 1 {
			let wea = MXSToolsCmd.shared.transWeather(Int(queryDataSub!.weather))
			cell.cellData = wea
		}
		else if indexPath.row == 2 {
			cell.cellData = queryDataSub?.diary_content
		}
		else if indexPath.row == 3 {
			cell.cellData = queryDataSub?.diary_think
		}
		else {
			cell.cellData = queryDataSub?.mood
		}
		return cell
	}
	
	func dateConvertString(_ date:Date) -> String {
		
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.init(identifier: "UTC")
		formatter.locale = Locale.init(identifier: "zh_CN")
		formatter.dateFormat = "yyyy-MM-dd EEE"
		
		return formatter.string(from: date)
//		return date.components(separatedBy: " ").first!
	}
}
