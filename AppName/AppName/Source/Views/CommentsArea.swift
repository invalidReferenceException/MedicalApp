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
	
	@IBAction func addCommentPressed(_ sender: Any) {
		
		newCommentAvatar.image = UIImage(contentsOfFile:Database.currentUser?.avatarURL ?? "")
		newCommentAvatar.isHidden = false
		
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
		newCommentBody.text = ""
		newCommentBody.becomeFirstResponder()
		
		addCommentButton.isHidden = true
		saveAndCancelButtons.isHidden = false
	}
	
	@IBAction func cancelCommentPressed(_ sender: Any) {
	
		newCommentBody.text = ""
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
		
		Database.currentUser?.associatedTests[Database.currentTestIndex].comments?.append(comment)
		
		newCommentBody.text = ""
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
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if let commentsCount = Database.currentUser?.associatedTests[Database.currentTestIndex].comments?.count {
			return commentsCount
		}
		
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
		
		if let comment =  Database.currentUser?.associatedTests[Database.currentTestIndex].comments?[indexPath.row] {
			
			cell.commentAuthorName.text = comment.authorName
			cell.commentAuthorTagline.text = "Sample Org"
			cell.commentAvatar.image = UIImage(contentsOfFile: comment.thumbnailUrl)
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
