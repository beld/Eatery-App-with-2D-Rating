import UIKit
import AMTagListView
import SCLAlertView

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    // MARK: Properties
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var tagListView: AMTagListView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageRatingView: ImageRatingView!
    @IBOutlet weak var vertiLabel: UILabel!
    @IBOutlet weak var rateHealthTasteButton: UIButton!
    @IBOutlet weak var rateFatCarbButton: UIButton!
    @IBOutlet weak var rateSugarVitaminButton: UIButton!
    @IBOutlet weak var rateDifficultyTimeButton: UIButton!
    @IBOutlet weak var rateCaloryEnergyButton: UIButton!
    
    @IBOutlet weak var healthCircle: UIView!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var tasteCircle: UIView!
    @IBOutlet weak var tasteLabel: UILabel!
    @IBOutlet weak var fatCircle: UIView!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbCircle: UIView!
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var sugarCircle: UIView!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var vitaminCircle: UIView!
    @IBOutlet weak var vitaminLabel: UILabel!
    @IBOutlet weak var difficultyCircle: UIView!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var timeCircle: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var caloryCircle: UIView!
    @IBOutlet weak var caloryLabel: UILabel!
    @IBOutlet weak var energyDensityCircle: UIView!
    @IBOutlet weak var energyDensityLabel: UILabel!
    
    var meal: Meal?
    var horiRating: CGFloat = 0.0
    var vertiRating: CGFloat = 0.0
    var horiLabel: UILabel!
    
    @IBAction func rateHealthTasteButtion(sender: AnyObject) {
        horiLabel.text = "hoch          Gesundheit        niedrig"
        vertiLabel.text = "niedrig          Geschmack         hoch"
        if rateHealthTasteButton.currentTitle == "Bewerte den Geschmack und Gesundheit" {
            rateHealthTasteButton.setTitle("Klicken Sie einfach", forState: .Normal)
        } else {
            initCicle(healthCircle)
            (horiRating, vertiRating) = imageRatingView.getRatingScale()
            addCircleView(healthCircle, isForeground: true, duration: 1.5, fromValue: 0.0, toValue: horiRating)
            healthLabel.text = String(format: ("%d%%"), lroundf(Float(horiRating) * 100))
            healthLabel.layer.zPosition = 1
            
            initCicle(tasteCircle)
            addCircleView(tasteCircle, isForeground: true, duration: 1.5, fromValue: 0.0, toValue: vertiRating)
            tasteLabel.text = String(format: ("%d%%"), lroundf(Float(vertiRating) * 100))
            tasteLabel.layer.zPosition = 1
            
            rateHealthTasteButton.setTitle("Bewerte den Geschmack und Gesundheit", forState: .Normal)
            meal!.healthRating = Float(horiRating)
            meal!.tasteRating = Float(vertiRating)
        }
    }
    
    @IBAction func rateFatCarbButton(sender: AnyObject) {
        horiLabel.text = "hoch          Fett          niedrig"
        vertiLabel.text = "niedrig      Kohlenhydrate         hoch"
        if rateFatCarbButton.currentTitle == "Bewerte den Fett und Kohlenhydrat" {
            rateFatCarbButton.setTitle("Klicken Sie einfach", forState: .Normal)
        } else {
            initCicle(fatCircle)
            (horiRating, vertiRating) = imageRatingView.getRatingScale()
            addCircleView(fatCircle, isForeground: true, duration: 1.5, fromValue: 0.0, toValue: horiRating)
            fatLabel.text = String(format: ("%d%%"), lroundf(Float(horiRating) * 100))
            fatLabel.layer.zPosition = 1
            initCicle(carbCircle)
            addCircleView(carbCircle, isForeground: true, duration: 1.5, fromValue: 0.0, toValue: vertiRating)
            carbLabel.text = String(format: ("%d%%"), lroundf(Float(vertiRating) * 100))
            carbLabel.layer.zPosition = 1
            rateFatCarbButton.setTitle("Bewerte den Fett und Kohlenhydrat", forState: .Normal)
            meal!.fatRating = Float(horiRating)
            meal!.carbRating = Float(vertiRating)
        }
    }
    
    @IBAction func rateSugarVitaminButton(sender: AnyObject) {
        horiLabel.text = "hoch          Zucker        niedrig"
        vertiLabel.text = "niedrig          Vitamine          hoch"
        if rateSugarVitaminButton.currentTitle == "Bewerte den Zucker und Vitamine" {
            rateSugarVitaminButton.setTitle("Klicken Sie einfach", forState: .Normal)
        } else {
            initCicle(sugarCircle)
            (horiRating, vertiRating) = imageRatingView.getRatingScale()
            addCircleView(sugarCircle, isForeground: true, duration: 1.5, fromValue: 0.0, toValue: horiRating)
            sugarLabel.text = String(format: ("%d%%"), lroundf(Float(horiRating) * 100))
            sugarLabel.layer.zPosition = 1
            initCicle(vitaminCircle)
            addCircleView(vitaminCircle, isForeground: true, duration: 1.5, fromValue: 0.0, toValue: vertiRating)
            vitaminLabel.text = String(format: ("%d%%"), lroundf(Float(vertiRating) * 100))
            vitaminLabel.layer.zPosition = 1
            rateSugarVitaminButton.setTitle("Bewerte den Zucker und Vitamine", forState: .Normal)
            meal!.sugarRating = Float(horiRating)
            meal!.vitaminRating = Float(vertiRating)
        }
    }
    @IBAction func rateCaloryEnergyButton(sender: AnyObject) {
        horiLabel.text = "hoch          Kalorien          niedrig"
        vertiLabel.text = "niedrig      Energiedichte         hoch"
        if rateCaloryEnergyButton.currentTitle == "Bewerte den Kalorien und Energiedichte" {
            rateCaloryEnergyButton.setTitle("Klicken Sie einfach", forState: .Normal)
        } else {
            initCicle(caloryCircle)
            (horiRating, vertiRating) = imageRatingView.getRatingScale()
            addCircleView(caloryCircle, isForeground: true, duration: 1.5, fromValue: 0.0, toValue: horiRating)
            caloryLabel.text = String(format: ("%d%%"), lroundf(Float(horiRating) * 100))
            caloryLabel.layer.zPosition = 1
            initCicle(energyDensityCircle)
            addCircleView(energyDensityCircle, isForeground: true, duration: 1.5, fromValue: 0.0, toValue: vertiRating)
            energyDensityLabel.text = String(format: ("%d%%"), lroundf(Float(vertiRating) * 100))
            energyDensityLabel.layer.zPosition = 1
            rateCaloryEnergyButton.setTitle("Bewerte den Kalorien und Energiedichte", forState: .Normal)
            meal!.caloryRating = Float(horiRating)
            meal!.energyDensityRating = Float(vertiRating)
        }
    }
 
    @IBAction func rateDifficultyTimeButton(sender: AnyObject) {
        horiLabel.text = "hoch      Schwierigkeit         niedrig"
        vertiLabel.text = "niedrig          Zeit            hoch"
        if rateDifficultyTimeButton.currentTitle == "Bewerte die Schwierigkeit und die Zeit" {
            rateDifficultyTimeButton.setTitle("Klicken Sie einfach", forState: .Normal)
        } else {
            initCicle(difficultyCircle)
            (horiRating, vertiRating) = imageRatingView.getRatingScale()
            addCircleView(difficultyCircle, isForeground: true, duration: 1.5, fromValue: 0.0, toValue: horiRating)
            difficultyLabel.text = String(format: ("%d%%"), lroundf(Float(horiRating) * 100))
            difficultyLabel.layer.zPosition = 1
            initCicle(timeCircle)
            addCircleView(timeCircle, isForeground: true, duration: 1.5, fromValue: 0.0, toValue: vertiRating)
            timeLabel.text = String(format: ("%d%%"), lroundf(Float(vertiRating) * 100))
            timeLabel.layer.zPosition = 1
            rateDifficultyTimeButton.setTitle("Bewerte die Schwierigkeit und die Zeit", forState: .Normal)
            meal!.difficultyRating = Float(horiRating)
            meal!.timeRating = Float(vertiRating)
        }
    }
    
    
    @IBAction func addTag(sender: AnyObject) {
        let tag = ["delicious", "healthy", "easy", "unhealthy"]
        RRTagController.displayTagController(self, tagsString: tag, blockFinish: { (selectedTags, unSelectedTags) -> () in
            // the user finished the selection and returns the separated list Selected and not selected.
            for tag in selectedTags {
                self.tagListView.addTag(tag.textContent)
            }
        }) { () -> () in
            // here the user cancel the selection, nothing is returned.
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor(red: 1/255.0, green: 131/255.0, blue: 209/255.0, alpha: 1))
        
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.titleTextAttributes =
            ([NSFontAttributeName: UIFont(name: "BradleyHandITCTT-Bold", size: 15)!,
                NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        horiLabel = UILabel(frame: CGRectMake(0, 0, 320, 21))
        horiLabel.textAlignment = NSTextAlignment.Center
        horiLabel.font = UIFont(name: "ChalkboardSE-regular", size: 18)
        horiLabel.textColor = UIColor.darkGrayColor()
        vertiLabel.textColor = UIColor.darkGrayColor()
        self.contentView.addSubview(horiLabel)
        horiLabel.layer.anchorPoint = CGPointMake(0.0, 0.0)
        horiLabel.transform = CGAffineTransformMakeRotation( CGFloat(M_PI) / 2 )
        horiLabel.frame = CGRectMake(28, 10.5, 21, 320)

        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // set up views if editing an existing meal
        if let existingMeal = meal {
            navigationItem.title = existingMeal.name
            nameTextField.text = existingMeal.name
            photoImageView.image = existingMeal.photo
            
            tasteLabel.text = String(Int(meal!.tasteRating * 100)) + "%"
            let tasteToValue : CGFloat = (CGFloat(meal!.tasteRating)) as CGFloat
            initCicle(tasteCircle)
            addCircleView(tasteCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: tasteToValue)
            
            healthLabel.text = String(Int(meal!.healthRating * 100)) + "%"
            let healthToValue : CGFloat = (CGFloat(meal!.healthRating)) as CGFloat
            initCicle(healthCircle)
            addCircleView(healthCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: healthToValue)
            
            fatLabel.text = String(Int(meal!.fatRating * 100)) + "%"
            let fatToValue : CGFloat = (CGFloat(meal!.fatRating)) as CGFloat
            initCicle(fatCircle)
            addCircleView(fatCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: fatToValue)
            
            carbLabel.text = String(Int(meal!.carbRating * 100)) + "%"
            let carbToValue : CGFloat = (CGFloat(meal!.carbRating)) as CGFloat
            initCicle(carbCircle)
            addCircleView(carbCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: carbToValue)
            
            difficultyLabel.text = String(Int(meal!.difficultyRating * 100)) + "%"
            let difficultyToValue : CGFloat = (CGFloat(meal!.difficultyRating)) as CGFloat
            initCicle(difficultyCircle)
            addCircleView(difficultyCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: difficultyToValue)
            
            timeLabel.text = String(Int(meal!.timeRating * 100)) + "%"
            let timeToValue : CGFloat = (CGFloat(meal!.timeRating)) as CGFloat
            initCicle(timeCircle)
            addCircleView(timeCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: timeToValue)
            
            sugarLabel.text = String(Int(meal!.sugarRating * 100)) + "%"
            let sugarToValue : CGFloat = (CGFloat(meal!.sugarRating)) as CGFloat
            initCicle(sugarCircle)
            addCircleView(sugarCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: sugarToValue)
            
            vitaminLabel.text = String(Int(meal!.vitaminRating * 100)) + "%"
            let vitaminToValue : CGFloat = (CGFloat(meal!.vitaminRating)) as CGFloat
            initCicle(vitaminCircle)
            addCircleView(vitaminCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: vitaminToValue)
            
            caloryLabel.text = String(Int(meal!.caloryRating * 100)) + "%"
            let caloryToValue : CGFloat = (CGFloat(meal!.caloryRating)) as CGFloat
            initCicle(caloryCircle)
            addCircleView(caloryCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: caloryToValue)
            
            energyDensityLabel.text = String(Int(meal!.energyDensityRating * 100)) + "%"
            let energyDensityToValue : CGFloat = (CGFloat(meal!.energyDensityRating)) as CGFloat
            initCicle(energyDensityCircle)
            addCircleView(energyDensityCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: energyDensityToValue)
    
            descriptionTextView.text = existingMeal.cookingDescription
        }
        
        descriptionTextView.sizeToFit()
        
        // enable save button only if text field has valid name
        checkValidMealName()
        
        AMTagView.appearance().tagLength = 10
        AMTagView.appearance().textFont = UIFont(name: "Futura", size: 14)
        AMTagView.appearance().tagColor = UIColor(red:0.12, green:0.55, blue:0.84, alpha:1)
        tagListView.addTag("Gericht")
    }
    
    @IBAction func tasteButton(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.showInfo("Geschmack", subTitle: "Bitte den Geschmack diese Gericht nach Ihren Gunsten bewerten, von 0 bis 100")
    }
    
    @IBAction func healthButton(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.showInfo("Gesundheit", subTitle: "Wie gesund ist diese Gericht in Ihrer Meinung, von 0 bis 100")
    }
    
    @IBAction func fatButton(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.showInfo("Fett", subTitle: "blah blah blah")
    }
    
    @IBAction func carbButton(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.showInfo("Kohlenhydrate", subTitle: "blah blah blah")
    }
    
    @IBAction func caloryButton(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.showInfo("Kalorien", subTitle: "blah blah blah")
    }
    
    @IBAction func energyDensityButton(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.showInfo("Energiedichte", subTitle: "blah blah blah")
    }
    
    @IBAction func difficultyButton(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.showInfo("Schwierigkeit", subTitle: "Schwierigkeit misst, wie schwierig, wenn Sie Ihre Gericht vorbereiten")
    }
    
    @IBAction func timeButton(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.showInfo("Zeit", subTitle: "blah blah blah")
    }
    
    @IBAction func sugarButton(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.showInfo("Zucker", subTitle: "blah blah blah")
    }
    @IBAction func vitaminButton(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.showInfo("Vitamine", subTitle: "blah blah blah")
    }

    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable save button while editing
        saveButton.enabled = false
    }
    
    func checkValidMealName() {
        // disable the save button if text field is empty
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
    }
    
//    // MARK: UIImagePickerControllerDelegate
//    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//        // Dismiss the picker if the user canceled.
//        dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        // The info dictionary contains multiple representations of the image, and this uses the original.
//        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        
//        // Set photoImageView to display the selected image.
//        photoImageView.image = selectedImage
//        
//        // Dismiss the picker.
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        // depending on style of presentation (modal or push), this view
        // controller needs to be dismissed in 2 different ways
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // configure a view controller before it's passed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
        }
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
//        nameTextField.resignFirstResponder()
//        
//        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
//        let imagePickerController = UIImagePickerController()
//        
//        // Only allow photos to be picked, not taken.
//        imagePickerController.sourceType = .PhotoLibrary
//        
//        // Make sure ViewController is notified when the user picks an image.
//        imagePickerController.delegate = self
//        
//        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func initCicle(myView : UIView) {
        addCircleView(myView, isForeground: false, duration: 0.0, fromValue: 0.0, toValue: 1.0)
    }
    
    //MARK: Add Circle
    func addCircleView(myView : UIView, isForeground : Bool, duration : NSTimeInterval, fromValue: CGFloat, toValue : CGFloat) {
        let circleWidth = CGFloat(120)
        let circleHeight = circleWidth
        
        // Create a new CircleView
        let circleView = CircleView(frame: CGRectMake(0, 0, circleWidth, circleHeight))
        
        //Setting the color.
        if (isForeground == true) {
            circleView.circleLayer.strokeColor = UIColor(red: 0.5, green: 0.5, blue: 1, alpha: 1).CGColor
        } else {
            circleView.circleLayer.strokeColor = UIColor.whiteColor().CGColor
        }
        
        myView.addSubview(circleView)
        
        circleView.layer.shadowColor = UIColor.cyanColor().CGColor
        circleView.layer.shadowOpacity = 0.2
        circleView.layer.shadowRadius = 2
        
        //Rotate the circle so it starts from the top.
        circleView.transform = CGAffineTransformMakeRotation(-1.57)
        
        // Animate the drawing of the circle
        circleView.animateCircleTo(duration, fromValue: fromValue, toValue: toValue)
    }
}
