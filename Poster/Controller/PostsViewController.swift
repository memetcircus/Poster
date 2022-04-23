//
//  ViewController.swift
//  Poster
//
//  Created by Akif Acar on 21.04.2022.
//

import UIKit
import DropDown

class PostsViewController: UIViewController {
    
    @IBOutlet var postTableView: UITableView!
    @IBOutlet var dropDownView: UIView!
    @IBOutlet var titleLabelForDropDownView: UILabel!
    @IBOutlet var createPostButton: UIButton!
    
    //initialize DropDown
    let usersDropDown = DropDown()
    
    //store the index of selected user in the users array of the UsersData struct after the client select the user from the dropdownmenu.
    var selectedUserIndex: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        
        setNavigationBar()
        
        postTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDropDownView()
        
        configureTableView()
        
        //createPost button is activated once user chosen from dropdown menu
        createPostButton.isHidden = true
        
        postTableView.dataSource = self
        
        //need to register customcell to tableview to use cell in the tableview.
        postTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifer)
        
    }
    
    /**
    This method is used to change the color of navigationbar to the background color of the postViewcontroller since if tableview scrolled up the color of the navigation bar turned to gray and the color turned to white unexpectedly when returning from createpostViewController
    */
    func setNavigationBar(){
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor  = UIColor(named: "BackgroundDark")
        UINavigationBar.appearance().barTintColor = UIColor(named: "BackgroundDark")
    }
    
    /**
    This method is used to configure row height of the postTableview as postCell content view will not fit in the row and the rows will be overlapped if not configured. K.postTableViewRowHeight constant set to specific number to avoid overlapping.
    */
    func configureTableView() {
        postTableView.rowHeight = K.postTableViewRowHeight
    }
    
    @IBAction func createPostButtonTouched(_ sender: Any) {
        self.performSegue(withIdentifier: "goToCreatePostViewController", sender: self)
    }
    
    /**
    This method is used to pass selected user's username to postviewcontroller in order to set a Post's sender property via User struct.
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCreatePostViewController" {
            let destinationVC = segue.destination as! CreatePostsViewController
            destinationVC.selectedUser = UsersData().users[selectedUserIndex!]
        }
    }
}

// MARK: DropDownView Methods

extension PostsViewController {
    
    @IBAction func btnTouchedinDropDownMenu(_ sender: UIButton) {
        usersDropDown.show()
    }
    
    func setDropDownView(){
        
        //set placeholder text
        titleLabelForDropDownView.text = K.placeholdertextTitleLabelOfDropDownViewText
        
        usersDropDown.anchorView = dropDownView
        
        //used to populate the dropdown menu with usernames
        usersDropDown.dataSource = UsersData().getUserNames()
        
        //drowndownmenu UX configuration
        usersDropDown.cornerRadius = K.cornerRadiusOfDropDownMenu
        usersDropDown.backgroundColor = UIColor(named: "BackgroundLighter")
        usersDropDown.textColor = UIColor(named: "textColor")!
        usersDropDown.textFont = UIFont(name: K.fontTypeBodyLabel, size: K.fontSizeBodyLabel)!
        
        //In order to avoid overlapping titleLabel with collapsed dropdown menu, the collapsed menu is moved down.
        usersDropDown.bottomOffset = CGPoint(x: 0, y:(usersDropDown.anchorView?.plainView.bounds.height)!)
        usersDropDown.topOffset = CGPoint(x: 0, y:-(usersDropDown.anchorView?.plainView.bounds.height)!)
        
        //Here we set selectedUser after the username selected from the dropdown menu
        usersDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.titleLabelForDropDownView.text = UsersData().getUserNames()[index]
            selectedUserIndex = index
            createPostButton.isHidden = false
        }
    }
}

//MARK: PostTableView datasource methods

extension PostsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostData.sharedInstance.posts.count
    }
    
    /**
    This method is used to populate post's data to the UX components and it configures the textColor and the font of the tableviewCell.
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifer, for: indexPath) as! PostCell
        
        let user = UsersData().getUser(userName: PostData.sharedInstance.posts[indexPath.row].senderUserName)
        
        cell.nameLabel.text = user.name
        cell.userNameLabel.text = user.userName
        cell.profileImage.image = UIImage(imageLiteralResourceName: user.profileImageName)
        cell.bodyLabel.text = PostData.sharedInstance.posts[indexPath.row].body
        cell.postImage.image = PostData.sharedInstance.posts[indexPath.row].postImage
        
        //set fontColor and fontType since these operations fails if it is done through Storyboard or inside PostCell controller
        cell.bodyLabel.textColor = UIColor(named: "textColor")!
        cell.bodyLabel.font = UIFont(name: K.fontTypeDropDownMenu, size: K.fontSizeDropDownMenu)
        
        return cell
    }
}

