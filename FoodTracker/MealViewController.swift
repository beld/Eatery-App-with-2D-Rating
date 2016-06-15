import UIKit
import AMTagListView
import SCLAlertView

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, Delegate {
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var tagListView: AMTagListView!
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
    let ratingContents = ["rateTasteHealth", "rateFatCarb", "rateSugarVitamin", "rateCaloryEnergy", "rateDifficultyTime"]
    var currentVertiRatingValue: Float!
    var currentHoriRatingValue: Float!
    var currentRatingContent: String = ""
    var vertiLabel: String = ""
    var horiLabel: String = ""
    var currentTitle: String = ""
    var cookingDescription: String = ""
    let appearance = SCLAlertView.SCLAppearance(
        kTitleFont: UIFont(name: "HelveticaNeue", size: 22)!,
        kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
        kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
        kWindowWidth: CGFloat(300),
        showCloseButton: true
    )
    
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

    @IBAction func showRecipe(sender: AnyObject) {
        let alert = SCLAlertView(appearance: appearance)
        alert.showInfo(nameTextField.text!, subTitle: cookingDescription, closeButtonTitle: "Bestätigen")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.lt_setBackgroundColor(UIColor(red: 1/255.0, green: 131/255.0, blue: 209/255.0, alpha: 1))
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.titleTextAttributes =
            ([NSFontAttributeName: UIFont(name: "ChalkboardSE-Bold", size: 17)!,
                NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // set up views if editing an existing meal
        if let existingMeal = meal {
            navigationItem.title = existingMeal.name
            nameTextField.text = existingMeal.name
            photoImageView.image = existingMeal.photo
            
            tasteLabel.text = String(format: ("%.0f %%"), meal!.tasteRating * 100)
            let tasteToValue : CGFloat = (CGFloat(meal!.tasteRating)) as CGFloat
            initCicle(tasteCircle)
            addCircleView(tasteCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: tasteToValue)
            tasteLabel.layer.zPosition = 1
            
            healthLabel.text = String(format: ("%.0f %%"), meal!.healthRating * 100)
            let healthToValue : CGFloat = (CGFloat(meal!.healthRating)) as CGFloat
            initCicle(healthCircle)
            addCircleView(healthCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: healthToValue)
            healthLabel.layer.zPosition = 1
            
            fatLabel.text = String(format: ("%.0f %%"), meal!.fatRating * 100)
            let fatToValue : CGFloat = (CGFloat(meal!.fatRating)) as CGFloat
            initCicle(fatCircle)
            addCircleView(fatCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: fatToValue)
            fatLabel.layer.zPosition = 1
            
            carbLabel.text = String(format: ("%.0f %%"), meal!.carbRating * 100)
            let carbToValue : CGFloat = (CGFloat(meal!.carbRating)) as CGFloat
            initCicle(carbCircle)
            addCircleView(carbCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: carbToValue)
            carbLabel.layer.zPosition = 1
            
            difficultyLabel.text = String(format: ("%.0f %%"), meal!.difficultyRating * 100)
            let difficultyToValue : CGFloat = (CGFloat(meal!.difficultyRating)) as CGFloat
            initCicle(difficultyCircle)
            addCircleView(difficultyCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: difficultyToValue)
            difficultyLabel.layer.zPosition = 1
            
            timeLabel.text = String(format: ("%.0f %%"), meal!.timeRating * 100)
            let timeToValue : CGFloat = (CGFloat(meal!.timeRating)) as CGFloat
            initCicle(timeCircle)
            addCircleView(timeCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: timeToValue)
            timeLabel.layer.zPosition = 1
            
            sugarLabel.text = String(format: ("%.0f %%"), meal!.sugarRating * 100)
            let sugarToValue : CGFloat = (CGFloat(meal!.sugarRating)) as CGFloat
            initCicle(sugarCircle)
            addCircleView(sugarCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: sugarToValue)
            sugarLabel.layer.zPosition = 1
            
            vitaminLabel.text = String(format: ("%.0f %%"), meal!.vitaminRating * 100)
            let vitaminToValue : CGFloat = (CGFloat(meal!.vitaminRating)) as CGFloat
            initCicle(vitaminCircle)
            addCircleView(vitaminCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: vitaminToValue)
            vitaminLabel.layer.zPosition = 1
            
            caloryLabel.text = String(format: ("%.0f %%"), meal!.caloryRating * 100)
            let caloryToValue : CGFloat = (CGFloat(meal!.caloryRating)) as CGFloat
            initCicle(caloryCircle)
            addCircleView(caloryCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: caloryToValue)
            caloryLabel.layer.zPosition = 1
            
            energyDensityLabel.text = String(format: ("%.0f %%"), meal!.energyDensityRating * 100)
            let energyDensityToValue : CGFloat = (CGFloat(meal!.energyDensityRating)) as CGFloat
            initCicle(energyDensityCircle)
            addCircleView(energyDensityCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: energyDensityToValue)
            energyDensityLabel.layer.zPosition = 1
    
            cookingDescription = existingMeal.cookingDescription
        }
        
        // enable save button only if text field has valid name
        checkValidMealName()
        
        AMTagView.appearance().tagLength = 10
        AMTagView.appearance().textFont = UIFont(name: "Futura", size: 14)
        AMTagView.appearance().tagColor = UIColor(red:0.12, green:0.55, blue:0.84, alpha:1)
        tagListView.addTag("Gericht")
    }
    
    @IBAction func tasteButton(sender: AnyObject) {
        let tasteAlert = SCLAlertView(appearance: appearance)
        tasteAlert.showInfo("Geschmack", subTitle: "Bitte den Geschmack diese Gericht nach Ihren Gunsten bewerten, von 0 bis 100", closeButtonTitle: "Bestätigen")
    }
    
    @IBAction func healthButton(sender: AnyObject) {
        let healthAlert = SCLAlertView(appearance: appearance)
        healthAlert.showInfo("Gesundheit", subTitle: "Wie gesund ist diese Gericht in Ihrer Meinung, von 0 bis 100", closeButtonTitle: "Bestätigen")
    }
    
    @IBAction func fatButton(sender: AnyObject) {
        let alert = SCLAlertView(appearance: appearance)
        alert.showInfo("Fett", subTitle: "blah blah blah", closeButtonTitle: "Bestätigen")
    }
    
    @IBAction func carbButton(sender: AnyObject) {
        let alert = SCLAlertView(appearance: appearance)
        alert.showInfo("Kohlenhydrate", subTitle: "blah blah blah", closeButtonTitle: "Bestätigen")
    }
    
    @IBAction func caloryButton(sender: AnyObject) {
        let alert = SCLAlertView(appearance: appearance)
        alert.showInfo("Kalorien", subTitle: "blah blah blah", closeButtonTitle: "Bestätigen")
    }
    
    @IBAction func energyDensityButton(sender: AnyObject) {
        let alert = SCLAlertView(appearance: appearance)
        alert.showInfo("Energiedichte", subTitle: "blah blah blah", closeButtonTitle: "Bestätigen")
    }
    
    @IBAction func difficultyButton(sender: AnyObject) {
        let alert = SCLAlertView(appearance: appearance)
        alert.showInfo("Schwierigkeit", subTitle: "Schwierigkeit misst, wie schwierig, wenn Sie Ihre Gericht vorbereiten", closeButtonTitle: "Bestätigen")
    }
    
    @IBAction func timeButton(sender: AnyObject) {
        let alert = SCLAlertView(appearance: appearance)
        alert.showInfo("Zeit", subTitle: "blah blah blah", closeButtonTitle: "Bestätigen")
    }
    
    @IBAction func sugarButton(sender: AnyObject) {
        let alert = SCLAlertView(appearance: appearance)
        alert.showInfo("Zucker", subTitle: "blah blah blah", closeButtonTitle: "Bestätigen")
    }
    @IBAction func vitaminButton(sender: AnyObject) {
        let alert = SCLAlertView(appearance: appearance)
        alert.showInfo("Vitamine", subTitle: "blah blah blah", closeButtonTitle: "Bestätigen")
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

    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        // depending on style of presentation (modal or push), this view
        // controller needs to be dismissed in 2 different ways
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // configure a view controller before it's passed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
        }
        for content in ratingContents {
            if(segue.identifier == content) {
                let destinationViewController = segue.destinationViewController as! RatingViewController
                destinationViewController.ratingContent = content
                destinationViewController.delegate = self
                self.currentRatingContent = content
                setCurrentValue(content)
                destinationViewController.navigationItem.title = currentTitle
                destinationViewController.image = self.photoImageView.image
                destinationViewController.vertiRating = CGFloat(currentVertiRatingValue)
                destinationViewController.horiRating = CGFloat(currentHoriRatingValue)
                destinationViewController.horiContent = horiLabel
                destinationViewController.vertiContent = vertiLabel
            }
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
    
    func setCurrentValue(content: String) {
        switch content {
            case "rateTasteHealth":
                currentVertiRatingValue = meal!.tasteRating
                currentHoriRatingValue =  meal!.healthRating
                currentTitle = "Bewerte Geschmack und Gesundheit"
                vertiLabel = "hoch          Geschmack         niedrig"
                horiLabel = "niedrig          Gesundheit        hoch"
            case "rateCaloryEnergy":
                currentVertiRatingValue = meal!.caloryRating
                currentHoriRatingValue = meal!.energyDensityRating
                currentTitle = "Bewerte Kalorien und Energiedichte"
                vertiLabel = "hoch          Kalorien          niedrig"
                horiLabel = "niedrig      Energiedichte         hoch"
            case "rateFatCarb":
                currentVertiRatingValue = meal!.fatRating
                currentHoriRatingValue =  meal!.carbRating
                currentTitle = "Bewerte Fett und Kohlenhydrate"
                vertiLabel = "hoch          Fett          niedrig"
                horiLabel = "niedrig      Kohlenhydrate         hoch"
            case "rateDifficultyTime":
                currentVertiRatingValue = meal!.difficultyRating
                currentHoriRatingValue = meal!.timeRating
                currentTitle = "Bewerte Schwierigkeit und Zeit"
                vertiLabel = "hoch      Schwierigkeit         niedrig"
                horiLabel = "niedrig          Zeit            hoch"
            case "rateSugarVitamin":
                currentVertiRatingValue = meal!.sugarRating
                currentHoriRatingValue = meal!.vitaminRating
                currentTitle = "Bewerte Zucker und Vitamine"
                vertiLabel = "hoch          Zucker        niedrig"
                horiLabel = "niedrig          Vitamine          hoch"
            default: break
        }
    }
    
    func update() {
        navigationItem.title = meal?.name
        switch currentRatingContent {
            case "rateTasteHealth":
                meal!.tasteRating = currentVertiRatingValue
                meal!.healthRating = currentHoriRatingValue
                tasteLabel.text = String(format: ("%.0f %%"), meal!.tasteRating * 100)
                let tasteToValue : CGFloat = (CGFloat(meal!.tasteRating)) as CGFloat
                initCicle(tasteCircle)
                addCircleView(tasteCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: tasteToValue)
                healthLabel.text = String(format: ("%.0f %%"), meal!.healthRating * 100)
                let healthToValue : CGFloat = (CGFloat(meal!.healthRating)) as CGFloat
                initCicle(healthCircle)
                addCircleView(healthCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: healthToValue)
            case "rateCaloryEnergy":
                meal!.caloryRating = currentVertiRatingValue
                meal!.energyDensityRating = currentHoriRatingValue
                caloryLabel.text = String(format: ("%.0f %%"), meal!.caloryRating * 100)
                let caloryToValue : CGFloat = (CGFloat(meal!.caloryRating)) as CGFloat
                initCicle(caloryCircle)
                addCircleView(caloryCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: caloryToValue)
                
                energyDensityLabel.text = String(format: ("%.0f %%"), meal!.energyDensityRating * 100)
                let energyDensityToValue : CGFloat = (CGFloat(meal!.energyDensityRating)) as CGFloat
                initCicle(energyDensityCircle)
                addCircleView(energyDensityCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: energyDensityToValue)
            case "rateFatCarb":
                meal!.fatRating = currentVertiRatingValue
                meal!.carbRating = currentHoriRatingValue
                fatLabel.text = String(format: ("%.0f %%"), meal!.fatRating * 100)
                let fatToValue : CGFloat = (CGFloat(meal!.fatRating)) as CGFloat
                initCicle(fatCircle)
                addCircleView(fatCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: fatToValue)
                
                carbLabel.text = String(format: ("%.0f %%"), meal!.carbRating * 100)
                let carbToValue : CGFloat = (CGFloat(meal!.carbRating)) as CGFloat
                initCicle(carbCircle)
                addCircleView(carbCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: carbToValue)
            case "rateDifficultyTime":
                meal!.difficultyRating = currentVertiRatingValue
                meal!.timeRating = currentHoriRatingValue
                difficultyLabel.text = String(format: ("%.0f %%"), meal!.difficultyRating * 100)
                let difficultyToValue : CGFloat = (CGFloat(meal!.difficultyRating)) as CGFloat
                initCicle(difficultyCircle)
                addCircleView(difficultyCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: difficultyToValue)
                
                timeLabel.text = String(format: ("%.0f %%"), meal!.timeRating * 100)
                let timeToValue : CGFloat = (CGFloat(meal!.timeRating)) as CGFloat
                initCicle(timeCircle)
                addCircleView(timeCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: timeToValue)
            case "rateSugarVitamin":
                meal!.sugarRating = currentVertiRatingValue
                meal!.vitaminRating = currentHoriRatingValue
                sugarLabel.text = String(format: ("%.0f %%"), meal!.sugarRating * 100)
                let sugarToValue : CGFloat = (CGFloat(meal!.sugarRating)) as CGFloat
                initCicle(sugarCircle)
                addCircleView(sugarCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: sugarToValue)
                
                vitaminLabel.text = String(format: ("%.0f %%"), meal!.vitaminRating * 100)
                let vitaminToValue : CGFloat = (CGFloat(meal!.vitaminRating)) as CGFloat
                initCicle(vitaminCircle)
                addCircleView(vitaminCircle, isForeground: true, duration: 1.5, fromValue: 0.0,  toValue: vitaminToValue)
            default: break
        }
    }

    func initCicle(myView : UIView) {
        addCircleView(myView, isForeground: false, duration: 0.0, fromValue: 0.0, toValue: 1.0)
    }
    
    //MARK: Add Circle
    func addCircleView(myView : UIView, isForeground : Bool, duration : NSTimeInterval, fromValue: CGFloat, toValue : CGFloat) {
        let circleWidth = CGFloat(80)
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
    
    func didPressSaveButton(vertiRating: CGFloat, horiRating: CGFloat) -> Bool {
        self.currentVertiRatingValue = Float(vertiRating)
        self.currentHoriRatingValue = Float(horiRating)
        update()
        return true
    }
}
