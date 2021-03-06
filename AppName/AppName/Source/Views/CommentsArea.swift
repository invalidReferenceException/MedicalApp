//
//  CommentsArea.swift
//  AppName
//
//  Created by Aglaia on 7/12/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class CommentsArea: UIView, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet var newCommentAvatar: UIImageView!
	@IBOutlet var newCommentAuthorName: UILabel!
	@IBOutlet var newCommentAuthorTagline: UILabel!
	@IBOutlet var newCommentBody: UITextView!
	@IBOutlet var newCommentDate: UILabel!
	
	@IBOutlet var addCommentButton: UIButton!
	@IBOutlet var saveAndCancelButtons: UIStackView!
	
	@IBOutlet var tableView: UITableView!
	@IBAction func addCommentPressed(_ sender: Any) {
		
		newCommentAvatar.image = #imageLiteral(resourceName: "font-awesome_4-7-0_user-circle_50_0_ffffff_none.png")
	
		newCommentAvatar.isHidden = false
		newCommentAvatar.backgroundColor = .lightGray
		
		newCommentAuthorName.text = (Database.currentUser?.firstName ?? "") + " " + (Database.currentUser?.lastName ?? "")
		newCommentAuthorName.isHidden = false
		
		newCommentAuthorTagline.text = "Sample Org"
		newCommentAuthorTagline.isHidden = false
		
		let today = Date()
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		let date = formatter.string(from: today)
		
		newCommentDate.text = date
		newCommentDate.isHidden = false
		
		newCommentBody.isHidden = false
		newCommentBody.isEditable = true
		//newCommentBody.text = ""
		newCommentBody.becomeFirstResponder()
		
		addCommentButton.isHidden = true
		saveAndCancelButtons.isHidden = false
	}
	
	@IBAction func cancelCommentPressed(_ sender: Any) {
	
		//newCommentBody.text = ""
		newCommentBody.isEditable = false
		newCommentBody.resignFirstResponder()
		
		saveAndCancelButtons.isHidden = true
		addCommentButton.isHidden = false
		
		newCommentAvatar.isHidden = true
		newCommentAuthorName.isHidden = true
		newCommentAuthorTagline.isHidden = true
		newCommentDate.isHidden = true
		newCommentBody.isHidden = true
	}
	
	@IBAction func saveCommentPressed(_ sender: Any) {
		
		let thumbnailUrl = Database.currentUser?.avatarURL ?? ""
		let comment = Database.PatientTest.Comment(authorName: newCommentAuthorName.text!, text: newCommentBody.text, date: newCommentDate.text!, thumbnailUrl: thumbnailUrl)
		
		Database.currentUser?.associatedTests[Database.currentTestIndex].comments.append(comment)
		
		newCommentBody.text = "New Comment Here..."
		newCommentBody.isEditable = false
		newCommentBody.resignFirstResponder()
		
		
		
		
		
		saveAndCancelButtons.isHidden = true
		addCommentButton.isHidden = false
		
		newCommentAvatar.isHidden = true
		newCommentAuthorName.isHidden = true
		newCommentAuthorTagline.isHidden = true
		newCommentDate.isHidden = true
		newCommentBody.isHidden = true
		
		self.setNeedsDisplay()
		tableView.reloadData()
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		print("Lovely tableView count: " + String( Database.currentUser?.associatedTests[Database.currentTestIndex].comments.count ?? 0))
		if let commentsCount = Database.currentUser?.associatedTests[Database.currentTestIndex].comments.count {
			return commentsCount
		}
		
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
		
		if let comment =  Database.currentUser?.associatedTests[Database.currentTestIndex].comments[indexPath.row] {
			
			cell.commentAuthorName.text = comment.authorName
			cell.commentAuthorTagline.text = "Sample Org"
			cell.commentAvatar.backgroundColor = .lightGray
            cell.commentAvatar.image = #imageLiteral(resourceName: "font-awesome_4-7-0_user-circle_50_0_ffffff_none.png")
			cell.commentBody.text = comment.text
		}
		
		return cell
	}
	
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
	
}
