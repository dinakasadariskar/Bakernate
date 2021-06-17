//
//  SubstitutionViewController.swift
//  Bakernate
//
//  Created by Roshani Ayu Pranasti on 07/06/21.
//

import UIKit
import CoreData

class SubstitutionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK:- IBOutlet
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var substituteButton: UIButton!
    
    // MARK:- let & var
    
    var amount = ""
    var substituteIngredientName = ""
    var unitRow = 0
    var ingredientRow = 0
    var selectedUnit = ""
    
    var indexOf = 0
    var type:[String] = []
    
    var selectedIndex = 0
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let ingredientPickerView = UIPickerView()
    let unitPickerView = UIPickerView()
    var ingredientArr = [Any]()
    var ingredientCollection = [Ingredients]()
    var ingredientNameArray = ["Baking Soda", "Baking Powder", "Buttermilk", "Honey", "Molasses", "Maple Syrup", "Lemon Juice", "Lime Juice", "Vinegar", "White Wine", "Sour Cream", "Mayonnaise", "Coconut Milk", "Yogurt", "Egg", "Mashed Banana", "Chia Seed", "Agar-agar", "Unsalted Butter", "Vegetable Oil", "Heavy Cream", "Coconut Cream", "Cream Cheese", "Mascarpone", "Brown Sugar", "Coconut Sugar", "White Sugar", "Cornstarch", "All Purpose Flour", "Tapioca"]
    var ingredientDescArray = ["Baking soda is a leavening agent used in baked goods like cakes, muffins, and cookies. Baking soda becomes activated when it’s combined with both an acidic ingredient and a liquid. Upon activation, carbon dioxide is produced, which allows baked goods to rise and become light and fluffy. This is why recipes that include baking soda will also list an acidic ingredient, such as lemon juice or buttermilk.", "Baking powder is a mixture of sodium bicarbonate and cream of tartar. It basically takes the place of yeast in dishes and helps the pastry to rise quickly. This ingredient is able to help a recipe rise slightly because it reacts with the liquid and sugar put into the dough. The acid creates a bubbling form which helps the leavening of it. This in return can help the pastry to have a flaky crust and soft texture.", "Buttermilk is an important functional dairy product and can improve the nutrition, taste, appearance and texture of baked goods. Buttermilk is often thought of as sour milk and is a common ingredient in many recipes.", "Honey is a sweet substance made by honey bees. It has a distinct flavor depending on its origin and it can be a great additional flavor to baked goods. Its nutritional value is also good for health, as it contains antioxidants. It has a lower glycemic index, which makes it a healthier option for diebetics./n/nHoney emits a chewy and crispy texture in baked goods. It has a nice flavor which gives baked goods more taste. Although heating up honey is not recommended, it can still be used as toppings or combined in chilled desserts.", "Molasses is a thick syrup that people use as a sweetener. Nutritionists do not recommend that people start eating molasses for the nutrients because its sugar content is so high. The best way to get these nutrients is by eating whole foods. However, if you are going to eat sugar anyway, molasses is likely a more healthful alternative. Molasses contains several important nutrients and antioxidants, making it a more healthful option than refined sugar./n/nThe flavor of molasses is distinct, unique, and delicious. Often the secret ingredient in warm and nostalgic recipes such as gingerbread, baked beans, and brownies, bring a subtle comfort to your recipes with the molasses.", "Maple syrup is considered a healthier option than white sugar and certain other sweeteners in recipes, and it possesses a unique flavor that some people (including yours truly) simply prefer to the flavor of other sweeteners. Make sure you use a 100% natural maple syrup, as that matches the consistency of honey far better than the ones with more water content.", "Acidic ingredients play an important role in cake baking. They add and enhance flavors as well as contribute to leavening and tenderization of cakes. Batter acidity can come from a wide variety of sources including vinegar, lemon juice, chocolate, buttermilk, coffee, brown sugar, fruits and vegetables to name a few.", "A lime is a citrus fruit, which is  round, green in color, and contains acidic juice vesicles. Limes have higher contents of sugars and acids than lemons do. Lime juice may be squeezed from fresh limes, or purchased in bottles in both unsweetened and sweetened varieties.", "Vinegar is an acidic liquid produced through the fermentation of ethanol by acetic acid bacteria. It is used in cooking not only for its flavor qualities but also for its chemical properties. Vinegar is an essential component of most pickling brines, where the acetic acid also functions as a natural preservative. Vinegar is also used to stimulate chemical reactions that take place during cooking and baking. For example, when baking soda mixes with an acid, it produces gas trapped within a dough or batter that creates a light, fluffy texture when cooked.", "White wine is a wine that is fermented without skin contact. It is produced by the alcoholic fermentation of the non-coloured pulp of grapes, which may have a skin of any colour. White wine is mainly from white grapes, which are green or yellow in colour, such as the Chardonnay, Sauvignon blanc, and Riesling. Some white wine is also made from grapes with coloured skin, provided that the obtained wort is not stained. White wines are often considered more refreshing, and lighter in both style and taste than the majority of their red wine counterparts. In addition, due to their acidity, aroma, and ability to soften meat and deglaze cooking juices, white wines are often used in cooking.", "Sour Cream is made by mixing cream with a lactic acid culture; the bacteria thickens and sours it. It may also contain stabilizers, like gelatin or rennin, which aid in the thickening. Sour cream is less expensive than creme fraiche, and since it contains less fat and more protein, it will curdle if you simmer or boil it — so it’s best to use cold or room temperature, or to stir into a hot dish once it’s off the heat./n/nIn terms of baking chemistry, sour cream is a powerhouse combo of acid and fat. In fact, it's one of the fattiest dairy products you can use in your baking. Both of these elements of sour cream's character make it a truly special (not to mention, hardworking) ingredient in your pound cake. Sour cream is definitely adding moisture to your cakes, muffins, scones, and beyond, but there's a little more to it than that.", "Mayonnaise is an emulsion of oil, egg yolk, and an acid, either vinegar or lemon juice. There are many variants using additional flavorings. The color varies from near-white to pale yellow, and its texture from a light cream to a thick gel. Mayonnaise is used commonly around the world, and is also a base for many other chilled sauces and salad dressings.", "Coconut milk comes from the white flesh of mature brown coconuts, which are the fruit of the coconut tree. The milk has a thick consistency and a rich, creamy texture. Unlike coconut water, the milk does not occur naturally. Instead, solid coconut flesh is mixed with water to make coconut milk, which is about 50% water. It is used in many traditional cuisines around the world. Coconut milk is made by grating flesh from a brown coconut, soaking it in water and then straining it to produce a milk-like consistency.", "Yogurt starts as fresh milk or cream. It is often first pasteurized, then fermented with various live bacteria cultures, and incubated at a specific temperature to encourage bacteria growth.The culture ferments the lactose, the natural sugar found in milk. This produces lactic acid, which gives yogurt its distinctive flavor. Yogurts can be high in protein, calcium, vitamins, and live culture, or probiotics, which can enhance the gut microbiota. These can offer protection for bones and teeth and help prevent digestive problems./n/nIf a recipe calls for regular yogurt and you only have Greek, simply thin it with a little milk or water until it is the texture of regular-style yogurt. And if you need Greek yogurt but only have regular, simply strain off some of the whey.", "Eggs play an important role in everything from cakes and cookies to meringues and pastry cream — they create structure and stability within a batter, they help thicken and emulsify sauces and custards, they add moisture to cakes and other baked goods, and can even act as glue or glaze. Egg yolks make up about a third of the egg and provide shortening and tenderizing properties to your favorite dish. This adds depth as well as a great amount of color. Batters made with just yolks are usually rich in fatty acids and vitamins. Egg whites contain 86% water, with most of the volume of egg and none of the calories for those on the keto diet. This part of the egg has a unique drying effect on baked dishes since the water activates the gluten without the balancing effect of the fatty yolk. White cakes highly rely on the addition of egg whites since they lack color and flavor. This brings natural flavors to the forefront. However, you will still achieve a wonderful browning color due to the Maillard chemical reactions.", "Banana is fruit of the genus Musa, of the family Musaceae, one of the most important fruit crops of the world. The banana is grown in the tropics, and, though it is most widely consumed in those regions, it is valued worldwide for its flavour, nutritional value, and availability throughout the year. Cavendish, or dessert, bananas are most commonly eaten fresh, though they may be fried or mashed and chilled in pies or puddings. They may also be used to flavour muffins, cakes, or breads. A ripe banana contains as much as 22 percent of carbohydrate and is high in dietary fibre, potassium, manganese, and vitamins B6 and C.", "Chia seeds are the edible seeds of Salvia hispanica, a flowering plant in the mint family. Chia seeds are oval and gray with black and white spots. Chia seeds may be added to other foods as a topping or put into smoothies, breakfast cereals, energy bars, granola bars, yogurt, tortillas, and bread. They also may be made into a gelatin-like substance or consumed raw. The gel from ground seeds may be used to replace the egg content in cakes while providing other nutrients, and is a common substitute in vegan baking.", "Agar-agar is a gelatin derived from seaweed, typically red algae. It is commonly used as a thickening and a stabilizing agent in baking recipes. Agar-agar is usually sold in different forms; powder, flakes, bars, and strands. All of these forms have different kind of ways to process them, but its purpose is all the same. The most well-known method is to dissolve them in water and boiled before adding it with the other ingredients. Common baked goods made with agar-agar are puddings, mousses, cheesecakes, and ice cream. Depending on the baked goods, agar-agar might give a tougher result, but if used correctly can be a healthy vegan alternative.", "Unsalted butter contains no added salt. Think of it as butter in its purest form. As a result, unsalted butter has a shorter shelf life than salted butter (and many cooks will also tell you that it has a fresher taste). In terms of flavor, unsalted butter has a more pronounced mellow sweetness than salted butter. It's best used in baking, or in situations where straying from exact ingredient amounts can make or break a recipe.", "Vegetable oil is a type of oil extracted from seeds or from other parts of fruits. It has high fat content and is commonly used in baking./n/nVegetable oil remains liquid at room temperature, making the results of baked goods moist, rich, and tender. It has no added water content, so gluten from flour won't interact with any water, resulting in a tender and melt-in-your mouth texture.", "Heavy cream is a dairy product that contains very high fat percentage, which can be up to 40%. This ingredient is commonly used in baking, especially in making homemade butter, ice cream, and chilled cakes. The high fat percentage allows heavy cream to turn into whipped cream that tastes very creamy. This gives baking goods more creamy texture and flavor.", "Coconut cream is higher in fat than regular coconut milk. Despite coming from the same source, coconut cream is used differently in baking. It's thicker in texture, giving more body and creamier taste to baked goods./n/nAlthough it's a great vegan alternative for regular cream, coconut cream can have a strong coconut flavor, which can change the flavor of the final baking result.", "Evaporated milk is the result of partially removing water content from milk, up to 60%. It's known in some countries as unsweetened condensed milk because of its thick form. Used in baking, evaporated milk gives baked goods a slightly toasty and caramel taste. Depending on the recipes, it can be a good thing or a bad thing.", "Cream cheese is a cheese product that has a milder taste than most cheeses. It's made with milk and cream with added stabilizers. It's cheesy flavor gives more taste to any baked goods. It also has high fat content, which makes the result creamy and moist.", "Macarpone is made from whole cream, cultures, and acids. Originated from Italy, this ingredient is commonly used in making tiramisu, a classic Italian dessert. This ingredient has a very high fat content, which can be up to 75%. This results in very creamy and delicious baked goods, with a slight cheesy flavor.", "Brown sugar is a type of sugar that has more moisture component than regular white sugar. It's basically a mixture of white sugar and molasses, which combined can result in a chewy baked goods. There are two types of brown sugar; light and dark. Dark brown sugar has about 6.5% molasses while light brown sugar has 3.5%. Basically, dark brown sugar has more caramel flavor than light from its heavy molasses content, but both sugars can be used interchangeably.", "Coconut sugar is a palm sugar produced from the sap of the flower bud stem of the coconut palm. Different from regular sugar, coconut sugar has more nutritional value such as iron, zinc, calcium and potassium. It also has a lower glycemic index. Used in baking, coconut sugar gives a slight caramel flavor into desserts, making it richer and more delicious. Although it can overpower the flavor if used too much, it's still a good addition to baked goods if used accordingly.", "White sugar also known as Granulated Sugar (table sugar): This all-purpose sugar is the most common variety of white sugar. It is easily measured and dissolves well into beverages and other liquids./n/nBecause sugar is hydroscopic, or water-loving, it is important to keep sugar in an air-tight container. Moisture in the air can be absorbed by sugar, causing clumping and erroneous flavors. Once moisture is absorbed by sugar, it can not be extracted. Sugar does not support microbial growth and therefore has an indefinite shelf life if kept sealed in a cool, dry place.", "Cornstarch is a type of starch derived from corn. It's commonly used as a thickening agent. It results in a transparent and flavorless gel. The way to use cornstarch in baking is to mix it with water until it's dissolved before adding it with the other ingredients. It's recommended to let it fully boil before cooling it down, as not boiling it can give an illusion of the dessert thickening, but will eventually thin out once cooled.", "All-purpose flour combines hard and soft wheats and thus lives in the middle on the protein scale, at 10 to 12 percent. All-purpose flour is available bleached, which creates a softer texture, as well as unbleached, which is what we recommend because it provides more structure in baked goods and retains more of the nuance of the wheat. You can bake just about anything with it -- breads, biscuits, pizza dough, cookies, you name it. Be careful not to use self-rising flour, which is all-purpose flour with leavening added, unless the recipe specifically calls for it./n/nAll-purpose flour is essential for the structure of traditional baked goods such as:/nBread/nCakes and muffins/nCookies/nNoodles/nPancake and pastries/nPizza and pie crusts", "Tapioca flour is made from the crushed pulp of the cassava root, a woody shrub native to South America and the Caribbean. Even though they originate from the same plant, cassava flour and tapioca flour are in fact different. Cassava flour uses the whole root while tapioca flour only uses the starchy pulp. Like other starches, tapioca flour is a very fine, white powder that works well in gluten free baking. It can replace cornstarch as a thickener for pies, gravies, pudding, dough and sauces and aids in creating a crisp crust and chewy texture in baking. Tapioca flour is becoming increasingly common in paleo diet recipes, as well."]
    var ingredientVeganStatus = [true, true, false, false, true, true, true, true, true, false, false, false, true, false, false, true, true, true, false, true, false, true, false, false, false, true, true, true, true, true, true]
    var ingredientDairyStatus = [false, false, true, false, false, false, false, false, false, false, true, true, false, true, false, false, false, false, true, false, true, false, true, true, true, false, false, false, false, false, false]
    var ingredientEggsStatus = [false, false, false, false, false, false, false, false, false, false, false, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    var ingredientGlutenStatus = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false]
    var ingredientPeanutStatus = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    var ingredientSoyStatus = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    var ingredientTreeNutsStatus = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    var ingredientFavoritedStatus = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    var ingredientId = [["A1"], ["A1"], ["A6"], ["A3","A4"], ["A3", "A4"], ["A3", "A4"], ["A5"], ["A5"], ["A5"], ["A5"], ["A6", "A7"], ["A6"], ["A6"], ["A6", "A7"], ["A8"], ["A8"], ["A8"], ["A8"], ["A9"], ["A9"], ["A7"], ["A7"], ["A7"], ["A6", "A7"], ["A4"], ["A4"], ["A4"], ["B1"], ["B1"], ["B1"]]
    var ingredientAmountArray = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    var ingredientInitialUnitArray = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    var ingredientSubstituteUnitArray = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    var ingredientImageArray = ["Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Mashed Banana 1", "Chia Seed 1", "Agar-Agar 1", "Unsalted Butter 1", "vege oil 1", "heavy cream 1", "coconut cream 1", "Cream Cheese 1", "Mascarpone 1", "brown sugar 1", "coconut sugar 1", "white sugar 1", "Cornstarch 1", "all purpose flour 1", "tapioca 2"]
    var unitArray = ["Cups", "Tablespoon", "Teaspoon", "Ounce", "Gram"]
    
//    launchFrameImageView.animationImages = (1...11).map { UIImage(named: "frame \($0)")! }
    
    // MARK:- Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        amountTextField.keyboardType = .decimalPad
        
        setupInitialDataToCoreData()
        picker()
        createToolbar()
        checkAmout()
    }
    
    func setupInitialDataToCoreData() {
        retrieveData()
        if ingredientCollection.count == 0 {
            createData()
        }
        
        
        ingredientName()
    }
    
    func checkAmout() {
        substituteButton.layer.cornerRadius = 10
        substituteButton.backgroundColor = #colorLiteral(red: 0.6, green: 0.6784313725, blue: 0.6745098039, alpha: 1)
        substituteButton.tintColor = #colorLiteral(red: 0.4156862745, green: 0.4549019608, blue: 0.4705882353, alpha: 1)
        substituteButton.isEnabled = false
        [amountTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        guard let amount = amountTextField.text, !amount.isEmpty
        else {
            substituteButton.backgroundColor = #colorLiteral(red: 0.6, green: 0.6784313725, blue: 0.6745098039, alpha: 1)
            substituteButton.isEnabled = false
            
            return
        }
        
        substituteButton.backgroundColor = BakernateColor.green100
        substituteButton.tintColor = .white
        substituteButton.isEnabled = true
    }
    
    func picker() {
        ingredientPickerView.delegate = self
        ingredientPickerView.delegate?.pickerView?(ingredientPickerView, didSelectRow: 0, inComponent: 0)
        ingredientPickerView.backgroundColor = BakernateColor.backgroundGreen
        ingredientTextField.inputView = ingredientPickerView
        
        unitPickerView.delegate = self
        unitPickerView.delegate?.pickerView?(unitPickerView, didSelectRow: 0, inComponent: 0)
        unitPickerView.backgroundColor = BakernateColor.backgroundGreen
        unitTextField.inputView = unitPickerView
    }
    
    func createToolbar() {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.sizeToFit()
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.backgroundColor = BakernateColor.green10
        
        ingredientTextField.inputAccessoryView = toolbar
        unitTextField.inputAccessoryView = toolbar
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == ingredientPickerView {
            return ingredientCollection.count
        } else {
            return unitArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == ingredientPickerView {
            return ingredientCollection[row].ingredientName
        } else {
            return unitArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == ingredientPickerView {
            substituteIngredientName = ingredientCollection[row].ingredientName!
            ingredientTextField.text = substituteIngredientName
            
            type = ingredientCollection[row].ingredientId!
            
//            guard type == [ingredientCollection[row].ingredientId!]
//            else{
//                return
//            }
            
        } else {
            unitTextField.text =  unitArray[row]
            unitRow = row
            
        }
    }
    
    @objc func showInformation() {
        let slideVC = InformationView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    // MARK:- CoreData
    public func createData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        guard let ingredientEntity = NSEntityDescription.entity(forEntityName: "Ingredient", in: manageContext) else { return }
        
        for i in 1...ingredientNameArray.count {
            let ingredient = NSManagedObject(entity: ingredientEntity, insertInto: manageContext)
            ingredient.setValue(ingredientNameArray[i-1], forKey: "name")
            ingredient.setValue(ingredientDescArray[i-1], forKey: "descriptions")
            ingredient.setValue(ingredientVeganStatus[i-1], forKey: "isVegan")
            ingredient.setValue(ingredientDairyStatus[i-1], forKey: "isDairy")
            ingredient.setValue(ingredientEggsStatus[i-1], forKey: "isEggs")
            ingredient.setValue(ingredientGlutenStatus[i-1], forKey: "isGluten")
            ingredient.setValue(ingredientPeanutStatus[i-1], forKey: "isPeanut")
            ingredient.setValue(ingredientSoyStatus[i-1], forKey: "isSoy")
            ingredient.setValue(ingredientTreeNutsStatus[i-1], forKey: "isTreeNuts")
            ingredient.setValue(ingredientFavoritedStatus[i-1], forKey: "isFavorited")
            ingredient.setValue(ingredientImageArray[i-1], forKey: "image")
            ingredient.setValue(ingredientId[i-1], forKey: "id")
            ingredient.setValue(ingredientAmountArray[i-1], forKey: "amount")
            ingredient.setValue(ingredientInitialUnitArray[i-1], forKey: "initialUnit")
            ingredient.setValue(ingredientSubstituteUnitArray[i-1], forKey: "substituteUnit")
        }
    }
    
    func retrieveData() {
        ingredientCollection.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredient")
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
        do {
            let result = try manageContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                ingredientCollection.append(Ingredients(ingredientId: data.value(forKey: "id") as? [String] , ingredientName: data.value(forKey: "name") as? String , ingredientDesc: data.value(forKey: "descriptions") as? String , ingredientImage: data.value(forKey: "image") as? String , isDairy: data.value(forKey: "isDairy") as? Bool, isEggs: data.value(forKey: "isEggs") as? Bool, isGluten: data.value(forKey: "isGluten") as? Bool, isPeanut: data.value(forKey: "isPeanut") as? Bool, isSoy: data.value(forKey: "isSoy") as? Bool, isTreeNuts: data.value(forKey: "isTreeNuts") as? Bool, isVegan: data.value(forKey: "isVegan") as? Bool, isFavorited: data.value(forKey: "isFavorited") as? Bool, ingredientAmount: data.value(forKey: "amount") as? String, initialUnit: data.value(forKey: "initialUnit") as? String, substituteUnit: data.value(forKey: "substituteUnit") as? String
                ))
            }
        } catch let error as NSError {
            print("Error due to : \(error.localizedDescription)")
        }
    }
    
//    func updateFavoriteCoreData(name: String) {
//        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        
//        let manageContext = appDelegate.persistentContainer.viewContext
//
//        // 3. Prepare fetch dari entity coredata nya
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Ingredient")
//        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
//        
//        do {
//            let object = try manageContext.fetch(fetchRequest)
//            
//            let objectToUpdate = object[0] as! NSManagedObject
//            objectToUpdate.setValue(ingredientCollection[selectedIndex].isFavorited, forKey: "isFavorited")
//            
//            do {
//                try manageContext.save()
//            } catch {
//                print(error)
//            }
//        } catch let error as NSError {
//            print(error)
//        }
//    }
    
    func updateAmountCoreData(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Ingredient")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let object = try manageContext.fetch(fetchRequest)
            
            let objectToUpdate = object[0] as! NSManagedObject
            objectToUpdate.setValue(ingredientCollection[selectedIndex].ingredientAmount, forKey: "amount")
            
            do {
                try manageContext.save()
            } catch {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateInitialUnit(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Ingredient")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let object = try manageContext.fetch(fetchRequest)
            
            let objectToUpdate = object[0] as! NSManagedObject
            objectToUpdate.setValue(ingredientCollection[selectedIndex].initialUnit, forKey: "initialUnit")
            
            do {
                try manageContext.save()
            } catch {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateSubstituteUnit(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Ingredient")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let object = try manageContext.fetch(fetchRequest)
            
            let objectToUpdate = object[0] as! NSManagedObject
            objectToUpdate.setValue(ingredientCollection[selectedIndex].substituteUnit, forKey: "substituteUnit")
            
            do {
                try manageContext.save()
            } catch {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func ingredientName() {
        for ingredient in ingredientCollection {

            guard let name = ingredient.ingredientName, name != "" else { return }
            ingredientArr.append(name)
        }
    }
    
    func activityIndicator(_ title: String) {
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    // MARK:- IBAction
    @IBAction func clickInfoButton(_ sender: Any) {
        showInformation()
    }
    
    @IBAction func clickSubstituteButton(_ sender: UIButton) {
        activityIndicator("Substituting...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            self.effectView.removeFromSuperview()
            let storyboard = UIStoryboard(name: "Result", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "resultViewController") as! ResultViewController
            vc.initialAmount = self.amountTextField.text!
            vc.titleIngredient = self.substituteIngredientName
            vc.initialUnit = self.unitTextField.text!
            vc.unitRow = self.unitRow
            vc.type = self.type
            
//            ingredientCollection[selectedIndex].ingredientAmount = self.amountTextField.text!
//            ingredientCollection[selectedIndex].initialUnit = self.unitTextField.text!
            
            updateAmountCoreData(name: self.amountTextField.text!)
            updateInitialUnit(name: self.unitTextField.text!)
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}

// MARK:- Extension
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension SubstitutionViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}
