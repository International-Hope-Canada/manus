class PrefillCategoriesAndSubcategories < ActiveRecord::Migration[8.1]
  def change
    data = <<~EOS
      Supplies	Apparel	$1.00	10	Mixed	Uniforms	Scrubs	Patient Pajamas	Aprons	Gowns/disposable		Gowns/cloth		Lab Coats
      Supplies	Bedding	$1.00	10	Fitted Sheets	Soakers	Flat Sheets	Pillowcases	sliders	towels	Mattress Cover		Pillows	Blankets
      Supplies	Cardiology	$1.00	2	Mixed									
      Supplies	Dialysis	$1.00	5	Mixed	extension sets	Povidone Iodine Minicaps	Assessories	Catheters kits					
      Supplies	Dental	$1.00		Mixed	Instruments								
      Supplies	Drapes	$1.00	10	Mixed	Table Covers	Shoe Covers	Laparotomy	Vaginal Packs	U-drapes	Converters	Thyroid	Mayo Stand Covers	
      Supplies	Dressings	$1.00	10	Mixed	Wound	Diabetic	Surgical	ulcer supplies	Burns	Coban			
      Supplies	Ear Nose Throat	$1.00	2	Mixed									
      Supplies	Fluids	$1.00	2	Irrigation									
      Supplies	Gastro Intestinal	$1.00	2	Feeding Bags	Feeding Tubes								
      Supplies	Gloves	$1.00	10	Small	Medium	Large	Surgical	Exam					
      Supplies	Gowns	$1.00	15	Mixed	Cloth	Disposable C							
      Supplies	IV	$1.00	5	Mixed	Solution Sets	Space pump	Y-Type	Adminstration Set	Catheters				
      Supplies	Lab	$1.00	5	Specimen Supplies	Blood Collection	GlassWare	Pipets	Petrie Dishes					
      Supplies	Masks	$1.00	10	Face Shields	Surgical 	Exam							
      Supplies	Needles-Syringes	$1.00	2	Various Sizes	Sharps Containers	3ml	10ml	30ml	50ml				
      Supplies	OBS-GYN	$1.00	2	Mixed	Speculum								
      Supplies	OR - Surgery	$1.00	2	Mixed	Biopsy Supplies	Anaesthesia Supplies	Endoscopy Suplies	PICC Kit	Sterilization Trays w/ Intruments	Instrument Trays	Wound Drainage	Biopsy Supplies	Ostomy Supplies
      Supplies	Optometry	$1.00	2	Mixed									
      Supplies	Orthopediacs	$1.00	1	Knee Brace	Ankle braces	Splints	Back Support	Boot	Orthotics				
      Supplies	Patient-Care	$1.00	2	Mixed	Slippers	incontinence supplies							
      Supplies	Pediatric	$1.00	5	Mixed	Feeding Supplies	Izzy Dolls	Diapers						
      Supplies	Respiratory	$1.00	5	Mixed	Suction Tubing	Nasal Prongs	Masks	Tracheotomy	Nebulizer	Oxygen Therapy	Endotrachial	Suction Catheter	Suction tubing&catheter
      Supplies	Urology	$1.00	5	Mixed	Irragation Trays	Foley Trays	Urethral Catheters	Self Catheters	Leg Bags				
      Supplies	Misc	$1.00	5										
      Equipment	Medical_Bed	 $ 10.00 	200	Electric	Manual	Electric/Manual	Birthing	Fixed					
      Equipment	Newborn_Bassinette	 $ 2.00 	33										
      Equipment	Bedside_Cabinet	 $ 2.00 	20										
      Equipment	Cane	 $ 1.00 	0.2										
      Equipment	Commode	 $ 1.00 	5	Stationary	Wheeled								
      Equipment	Crutches	 $ 1.00 	0.5	Underarm	Forearm	Gutter							
      Equipment	Exam_Table	 $ 10.00 	90										
      Equipment	Gurney	 $ 5.00 	25										
      Equipment	IV-Pole	 $ 2.00 	5	Wheeled	Bed								
      Equipment	Overbed_Table	 $ 2.00 	14										
      Equipment	Scale	 $ 2.00 	12	Adult Beam 	Adult Floor	Pediatric							
      Equipment	Walker	 $ 1.00 	3	4 Wheel	2 Wheel	Folding no wheels	Fixed						
      Equipment	Wheelchair	 $ 5.00 	15	Folding	Rigid	Transport							
      Equipment	Medicine_Cart	 $ 2.00 	20	Crash	Nursing	Medications	Other						
      Equipment	Physio-Table	 $ 5.00 	20										
      Equipment	Bath Seat	 $ 1.00 	4										
      Equipment	Medical_Chair*												
      Equipment	OR-Equipment*												
      Equipment	O2_Concentrator	 $ 10.00 	27										
      Equipment	Cart, Utility	 $ 1.00 	8										
      Equipment	Stool	 $ 1.00 	8										
      Equipment	Blood_Pressure_Monitor	 $ 2.00 	10	Manual	Electric								
      Equipment	Vital_Signs_Monitor												
      Equipment	Laundry_Cart	 $ 1.00 	6										
      Equipment	Pediatric			Infant Warmer									
      Equipment	Dental			Chair	Light	Xray							
      Equipment	Lifts, Patient												
      Equipment	UltraSound												
      Equipment	Ventilator												
      Equipment	Misc_Equipment												
    EOS

    data.split("\n").each do |row|
      row.split("\t").then do |classification, category_name, value, weight_kg, *subcategories|
        item_category = ItemCategory.find_or_create_by!(
          name: category_name,
          classification: classification == 'Supplies' ? :supply : :equipment,
          value: value&.delete_prefix('$')&.to_f,
          weight_kg: weight_kg&.to_f
        )

        subcategories.each do |subcategory_name|
          next if subcategory_name.blank?

          ItemSubcategory.find_or_create_by!(
            name: subcategory_name,
            item_category: item_category,
          )
        end
      end
    end
  end
end
