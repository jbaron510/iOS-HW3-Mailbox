//
//  mailboxViewController.swift
//  iOS-HW3-Mailbox
//
//  Created by Jon Baron on 10/20/15.
//  Copyright © 2015 Walmart. All rights reserved.
//

import UIKit

class mailboxViewController: UIViewController {

    @IBOutlet weak var mailboxScrollView: UIScrollView!

    
    @IBOutlet var messagePanGestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var messageImage: UIImageView!
    
    var messageInitialCenter: CGPoint!
    var archiveIconInitialCenter: CGPoint!
    var laterIconInitialCenter: CGPoint!
    var moveIconsRight: Bool!
    var moveIconsLeft: Bool!
    
    @IBOutlet weak var laterIconImage: UIImageView!
    @IBOutlet weak var archiveIconImage: UIImageView!
    
    @IBOutlet weak var listIconImage: UIImageView!
    
    @IBOutlet weak var deleteIconImage: UIImageView!
    
    
//    On dragging the message left...
//    Initially, the revealed background color should be gray.
//    As the reschedule icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
//    After 60 pts, the later icon should start moving with the translation and the background should change to yellow.
//    Upon release, the message should continue to reveal the yellow background. When the animation it complete, it should show the reschedule options.
//    After 260 pts, the icon should change to the list icon and the background color should change to brown.
//    Upon release, the message should continue to reveal the brown background. When the animation it complete, it should show the list options.
//    User can tap to dismissing the reschedule or list options. After the reschedule or list options are dismissed, you should see the message finish the hide animation.
//    On dragging the message right...
//    Initially, the revealed background color should be gray.
//    As the archive icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
//    After 60 pts, the archive icon should start moving with the translation and the background should change to green.
//    Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
//    After 260 pts, the icon should change to the delete icon and the background color should change to red.
//    Upon release, the message should continue to reveal the red background. When the animation it complete, it should hide the message.
//    Optional: Panning from the edge should reveal the menu
//    Optional: If the menu is being revealed when the user lifts their finger, it should continue revealing.
//    Optional: If the menu is being hidden when the user lifts their finger, it should continue hiding.
//    Optional: Tapping on compose should animate to reveal the compose view.
//    Optional: Tapping the segmented control in the title should swipe views in from the left or right.
//    Optional: Shake to undo.
    
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        
        
        
        // Absolute (x,y) coordinates in parent view
        var point = messagePanGestureRecognizer.locationInView(view)
        
        
        // Relative change in (x,y) coordinates from where gesture began.
        var translation = messagePanGestureRecognizer.translationInView(view)
        var velocity = messagePanGestureRecognizer.velocityInView(view)
        

        moveIconsLeft = false
        moveIconsRight = false
        
//        var isGreen = false
//        var isYellow = false
//        var isRed = false
//        var isBrown = false
//        var isGray = true
//        var isSolidLeft = false
//        var isSolidRight = false
        
        
        print("panning")
        
        if messagePanGestureRecognizer.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            messageInitialCenter = messageImage.center
            laterIconInitialCenter = laterIconImage.center
            archiveIconInitialCenter = archiveIconImage.center

        } else if messagePanGestureRecognizer.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point) transX: \(translation.x) velX: \(velocity.x)")
            
            messageImage.center.x = messageInitialCenter.x + translation.x
            
            //if past threshold, start moving icons
            if moveIconsRight == true {
                laterIconImage.center.x = laterIconInitialCenter.x + translation.x - 30
                listIconImage.center.x = laterIconInitialCenter.x + translation.x - 30
                
            }
            if moveIconsLeft == true {
                archiveIconImage.center.x = archiveIconInitialCenter.x + translation.x + 30
                deleteIconImage.center.x = archiveIconInitialCenter.x + translation.x + 30
                
            }
            
            if translation.x == 30 {
                
                //make the archive icon opaque when sliding to the right, translucent when goig left
                if velocity.x > 0 {
                    archiveIconImage.alpha = CGFloat(1.0)
                    
                } else if velocity.x < 0 {
                    archiveIconImage.alpha = CGFloat(0.5)
                    
                }
                print("+")
                
            } else if translation.x == -30 {
                //start making later icon opaque
                if velocity.x < 0 {
                    laterIconImage.alpha = CGFloat(1.0)
                    
                } else if velocity.x > 0 {
                    laterIconImage.alpha = CGFloat(0.5)
                   
                }
                
            } else if translation.x == 60 {
                
                if velocity.x > 0 {
                    //set bkgn color to green
                    // start moving archive icon
                    messageView.backgroundColor = UIColor.greenColor()
                    moveIconsRight = true
                } else if velocity.x < 0 {
                    //set bkgn color to gray
                    // stop moving archive icon
                    messageView.backgroundColor = UIColor.lightGrayColor()
                    moveIconsRight = false
                }
                    
            } else if translation.x == -60 {
                print("--")
                if velocity.x < 0 {
                    //set bkgn color to yellow
                    messageView.backgroundColor = UIColor.yellowColor()
                    //start moving the later icon
                    moveIconsLeft = true
                } else if velocity.x > 0 {
                    messageView.backgroundColor = UIColor.lightGrayColor()
                    moveIconsLeft = false
                }
                
                
                
            } else if translation.x == 260 {
                print("++")
                if velocity.x > 0 {
                    //set bkgnd color to red
                    //archive icon changes to delete icon
                    messageView.backgroundColor = UIColor.redColor()
                    archiveIconImage.alpha = 0
                    deleteIconImage.alpha = 1
                } else if velocity.x < 0 {
                    //set to green
                    // delete icon changes to archive icon
                    messageView.backgroundColor = UIColor.greenColor()
                    archiveIconImage.alpha = 1
                    deleteIconImage.alpha = 0
                }
                
            } else if translation.x == -260 {
                if velocity.x < 0 {
                    //set bkgnd color to brown
                    messageView.backgroundColor = UIColor.brownColor()
                    //later icon changes to list icon
                    laterIconImage.alpha = 0
                    listIconImage.alpha = 1
                    print("--")
                } else if velocity.x > 0 {
                    //set background color to <>
                    //change list icon to later icon
                    messageView.backgroundColor = UIColor.yellowColor()
                    //later icon changes to list icon
                    laterIconImage.alpha = 1
                    listIconImage.alpha = 0
                }
                
            }
//            else {
//                //set bknd color back to gray
//                messageView.backgroundColor = UIColor.lightGrayColor()
//                
//                //later icon changes to semi transparent
//                //archive icon turns semi transparent
//                if isSolidRight == true {
//                    archiveIconImage.alpha = CGFloat(0.5)
//                    isSolidRight = false
//                } else if isSolidLeft == true {
//                    laterIconImage.alpha = CGFloat(0.5)
//                    isSolidLeft = false
//            }
            
                
 //           }
            
            
//            if translation.x >= 30 && translation.x <= 60 {
//                
//                //make the archive icon opaque if it isn't already
//                if isSolidRight == false {
//                    archiveIconImage.alpha = CGFloat(1.0)
//                    isSolidRight = true
//                }
//                print("+")
//                
//            } else if translation.x >= -60 && translation.x <=  -30 {
//                //start making later icon opaque
//                laterIconImage.alpha = CGFloat(1.0)
//                
//            } else if translation.x > 60 && translation.x < 260 {
//                //set bkgn color to green
//                // start moving archive icon
//                
//                messageView.backgroundColor = UIColor.greenColor()
//                
//                print("+")
//            
//            } else if translation.x >= 260 {
//                print("++")
//                
//                //set bkgnd color to red
//                //archive icon changes to delete icon
//                 messageView.backgroundColor = UIColor.redColor()
//            
//            } else if translation.x <= -60 && translation.x > -260 {
//                print("--")
//                //set bkgn color to yellow
//                 messageView.backgroundColor = UIColor.yellowColor()
//                //start moving the later icon
//                
//            } else if translation.x <= -260 {
//                //set bkgnd color to brown
//                 messageView.backgroundColor = UIColor.brownColor()
//                //later icon changes to list icon
//                print("--")
//           
//            } else {
//                //set bknd color back to gray
//                 messageView.backgroundColor = UIColor.lightGrayColor()
//                
//                //later icon changes to semi transparent
//                //archive icon turns semi transparent
//                if isSolidRight == true {
//                    archiveIconImage.alpha = CGFloat(0.5)
//                    isSolidRight = false
//                } else if isSolidLeft == true {
//                    laterIconImage.alpha = CGFloat(0.5)
//                    isSolidLeft = false
//                }
//                
//                
//            }
//            
            
            
            
        
        } else if messagePanGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            print("Gesture ended at: \(point)")
            
            //if -60<translation<60, return image to original position
            if translation.x > -60 && translation.x < 60 {
                messageImage.center.x = messageInitialCenter.x
                laterIconImage.center.x = laterIconInitialCenter.x
                listIconImage.center.x = laterIconInitialCenter.x
                archiveIconImage.center.x = archiveIconInitialCenter.x
                deleteIconImage.center.x = archiveIconInitialCenter.x
                messageView.backgroundColor = UIColor.lightGrayColor()
            }
            
            //else if 61<translation< 261 show the reschedule options, continue to open?
            
            //else if translation > 260 finish opening and show the list options
            
            //else if
        }

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        mailboxScrollView.contentSize = CGSize(width: 320, height:1367)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
