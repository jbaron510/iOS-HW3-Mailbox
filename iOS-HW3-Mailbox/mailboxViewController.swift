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
    @IBOutlet weak var feedImage: UIImageView!
    
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
    
    @IBOutlet weak var rescheduleViewImage: UIImageView!
    
    @IBOutlet weak var listViewImage: UIImageView!
    
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
        

        
        
        
        print("panning")
        
        if messagePanGestureRecognizer.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            messageInitialCenter = messageImage.center
            archiveIconInitialCenter = archiveIconImage.center
            laterIconInitialCenter = laterIconImage.center
            moveIconsLeft = false
            moveIconsRight = false
            print("message init center.x = \(messageInitialCenter.x)")

        } else if messagePanGestureRecognizer.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point) transX: \(translation.x) velX: \(velocity.x)")
            
            messageImage.center.x = messageInitialCenter.x + translation.x
            
            //if past threshold, start moving icons
            if moveIconsRight == true {
                archiveIconImage.center.x = archiveIconInitialCenter.x + translation.x - 60
                deleteIconImage.center.x = archiveIconInitialCenter.x + translation.x - 60
            }
            
            if moveIconsLeft == true {
                laterIconImage.center.x = laterIconInitialCenter.x + translation.x + 60
                listIconImage.center.x = laterIconInitialCenter.x + translation.x + 60
            }
            
            if 30 <= translation.x && translation.x < 60 {
                
                //make the archive icon opaque
                UIView.animateWithDuration(0.4, animations: {
                    self.archiveIconImage.alpha = 1
                })
                
                
                // if moving from right back towards center, reset the bkgnd to gray, stop moving icons and reset their positions
                if moveIconsRight == true {
                    UIView.animateWithDuration(0.4, animations: {
                        self.messageView.backgroundColor = UIColor.lightGrayColor()
                    })
                    moveIconsRight = false
                    archiveIconImage.center.x = archiveIconInitialCenter.x
                    deleteIconImage.center.x = archiveIconInitialCenter.x
                    laterIconImage.alpha = 0.5
                }
                print("30 to 60: gray with solid stationary archive icon")
                
            } else if -60 < translation.x && translation.x <= -30 {
                //start making later icon opaque
                laterIconImage.alpha = 1
                
                //if moving left to right, reset the bknd color, stop moving the icons, and reset them to their original position
                if moveIconsLeft == true {
                    UIView.animateWithDuration(0.4, animations: {
                        self.messageView.backgroundColor = UIColor.lightGrayColor()
                    })
                    moveIconsLeft = false
                    laterIconImage.center.x = laterIconInitialCenter.x
                    listIconImage.center.x = laterIconInitialCenter.x
                    archiveIconImage.alpha = 0.5
                }
                print("-60 to -30: gray with solid stationary later icon")
                
            } else if 60 <= translation.x && translation.x < 260 {
            
                //set bkgn color to green
                // start moving archive icon
                UIView.animateWithDuration(0.4, animations: {
                    self.messageView.backgroundColor = UIColor.greenColor()
                })
                laterIconImage.alpha = 0
                moveIconsRight = true
                print("move icons right is \(moveIconsRight) \(archiveIconInitialCenter.x + translation.x - 60)")
                if archiveIconImage.alpha == 0 {
                    archiveIconImage.alpha = 1
                    deleteIconImage.alpha = 0
                }
                print ("60 to 260: green with moving archive icon")
            
               
                    
            } else if -260 <= translation.x && translation.x < -60 {
                
                
                //set bkgn color to yellow
                UIView.animateWithDuration(0.4, animations: {
                    self.messageView.backgroundColor = UIColor.yellowColor()
                })
                archiveIconImage.alpha = 0
                //start moving the later icon
                moveIconsLeft = true
                print("move icons left is \(moveIconsLeft) \(laterIconInitialCenter.x + translation.x + 60)")
                if laterIconImage.alpha == 0 {
                    laterIconImage.alpha = 1
                    listIconImage.alpha = 0
                }
                print("-260 to -60: yellow bknd, moving later icon")
                
                
            } else if 260 <= translation.x {
                
                //set bkgnd color to red
                //archive icon changes to delete icon
                UIView.animateWithDuration(0.4, animations: {
                    self.messageView.backgroundColor = UIColor.redColor()
                })
                archiveIconImage.alpha = 0
                deleteIconImage.alpha = 1
                print("> 260: red bknd, moving delete icon")

            } else if translation.x < -260 {
                
                //set bkgnd color to brown
                
                //later icon changes to list icon
                if messageView.backgroundColor != UIColor.brownColor() {
                    UIView.animateWithDuration(0.4, animations: {
                        self.messageView.backgroundColor = UIColor.brownColor()
                    })
                    laterIconImage.alpha = 0
                    listIconImage.alpha = 1
                }
                print("-260: brown bkgd, later icon replaced by list icon")
                
            }
            
      
        } else if messagePanGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            print("Gesture ended at: \(point)")
            
            //if -60<translation<60, return image to original position and color
            if abs(translation.x) < 60  {
                messageImage.center.x = messageInitialCenter.x
                laterIconImage.center.x = laterIconInitialCenter.x
                listIconImage.center.x = laterIconInitialCenter.x
                archiveIconImage.center.x = archiveIconInitialCenter.x
                deleteIconImage.center.x = archiveIconInitialCenter.x
                messageView.backgroundColor = UIColor.lightGrayColor()
                print("message init center.x = \(messageInitialCenter.x)")
                print("message image center.x = \(messageImage.center.x)")
            
            //move the feed up for both archive and delete (slid right more than 60px)
            } else if translation.x >= 60 {
                
//                UIView.animateWithDuration(0.4, animations: {
//                    Bool in
//                    self.feedImage.center.y = self.feedImage.center.y - 65
//                })
                UIView.animateWithDuration(0.4, animations: {() -> Void in
                    self.messageImage.center.x = self.messageInitialCenter.x + 320
                    self.archiveIconImage.center.x = 320 - self.archiveIconInitialCenter.x
                    self.deleteIconImage.center.x = 320 - self.archiveIconInitialCenter.x
                    self.messageView.alpha = 0
                    },
                    completion: {(Bool) -> Void in []
                        UIView.animateWithDuration(0.4, animations: {
                            self.feedImage.center.y = self.feedImage.center.y - 65
                        })
                })
                
            
            //else if -61 -- -261 show the reschedule options, continue to open
            } else if -260 < translation.x && translation.x <= -60 {
                UIView.animateWithDuration(0.4, animations: {() -> Void in
                    self.messageImage.center.x = self.messageInitialCenter.x - 320
                    self.laterIconImage.center.x = 320 - self.laterIconInitialCenter.x
                    self.listIconImage.center.x = 320 - self.laterIconInitialCenter.x
                    },
                    completion: {(Bool) -> Void in []
                        UIView.animateWithDuration(0.4, animations: {
                            self.rescheduleViewImage.alpha = 1
                        })
                })

            
            //else if translation < -260 finish opening and show the list options
            } else if translation.x < -260 {
                UIView.animateWithDuration(0.4, animations: {() -> Void in
                    self.messageImage.center.x = self.messageInitialCenter.x - 320
                    self.laterIconImage.center.x = 320 - self.laterIconInitialCenter.x
                    self.listIconImage.center.x = 320 - self.laterIconInitialCenter.x
                    //                    self.messageView.alpha = 0
                    },
                    completion: {(Bool) -> Void in []
                        UIView.animateWithDuration(0.4, animations: {
                            self.listViewImage.alpha = 1
                        })
                })

            }
            
            
            
        }  //end of panning ended

        
    }  // end of pan gesture fn
    
    
    @IBAction func tapListView(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.4, animations: {
            self.listViewImage.alpha = 0
            self.messageView.alpha = 0
            self.feedImage.center.y = self.feedImage.center.y - 65
        })
    
    }
    
    
    @IBAction func tapRescheduleView(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.4, animations: {
            self.rescheduleViewImage.alpha = 0
            self.messageView.alpha = 0
            self.feedImage.center.y = self.feedImage.center.y - 65
        })

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
